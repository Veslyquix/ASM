

#include "C_Code.h" // headers 
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;

struct SkillSysBattleHit { 
    /* 00:18 */ unsigned attributes : 19;
    /* 19:23 */ unsigned info       : 5;
    /* 24:31 */ signed   hpChange   : 8;
	u8 skillID; 
	s8 cappedDmg; 
	s16 overDmg; 
};

typedef struct {
    /* 00 */ PROC_HEADER;
	struct Anim* anim; 
	struct Anim* anim2; 
	int timer; 
	int timer2; 
	struct SkillSysBattleHit* currentRound;
	struct BattleUnit* active_bunit;
	struct BattleUnit* opp_bunit;
	u8 hitOnTime; 
	u8 roundId; 
	u8 adjustedDmg; 
	u8 broke; 
	u8 loadedImg;
	u8 side; 
	u8 frame;
	u8 code4frame;
	u8 codefframe;
	u8 roundEnd;
	u8 EkrEfxIsUnitHittedNowFrames;
	u16 buttonsToPress; 
} TimedHitsProc;
void LoopTimedHitsProc(TimedHitsProc* proc);
const struct ProcCmd TimedHitsProcCmd[] =
{
	PROC_NAME("TimedHitsProcName"), 
    PROC_YIELD,
	PROC_REPEAT(LoopTimedHitsProc), 
    PROC_END,
};
typedef struct { 
	PROC_HEADER; 
	u8 digits; //   +0x29, byte. Number of digits.
	s16 damage; //   +0x2A, short. Damage/heal value.
	u8 subjectId; //   +0x2C, byte. AISSubjectId. 0 if left, 1 if right.		
} BANIM_NumsProc; 
extern const struct ProcCmd* gProcScr_efxHPBar; 
extern const struct ProcCmd BAN_Proc_DelayDigits[]; 
extern const int AlwaysWork; 
extern const int MinFramesToDisplayGfx; 
extern const int LenienceFrames; 
extern const int BonusDamagePercent; 
extern const int ReducedDamagePercent; 
extern const int UsingSkillSys; 
extern void* Press_Image; 
extern void* BattleStar; 
extern void* A_Button; 
extern void* B_Button; 
extern void* Left_Button; 
extern void* Right_Button; 
extern void* Up_Button; 
extern void* Down_Button; 
//extern u16 gPal_Press_Image[];
//extern u16 gPal_BattleStar[];
// r0: AIS.
// r1: 0 if OverDamage or OverHeal (recipient). 1 otherwise.
// r2: X of previous damage display. 0 if there is none.
// r3: Digitcount of previous damage display. 0 if there is none.
extern int BAN_DisplayDamage(struct Anim* anim, int overdamage, int x, int prevDigitCount, int roundId); 
extern struct KeyStatusBuffer sKeyStatusBuffer; // 2024C78

void InitVariables(TimedHitsProc* proc) { 
	proc->anim = NULL; 
	proc->anim2 = NULL; 
	proc->broke = false; 
	proc->roundId = 0; 
	proc->timer = 0; 
	proc->timer2 = 99; 
	proc->hitOnTime = false; 
	proc->adjustedDmg = false;
	proc->loadedImg = false; // reload after each round 
	proc->side = 0xFF; 
	proc->currentRound = NULL; 
	proc->active_bunit = NULL; 
	proc->opp_bunit = NULL; 
	proc->frame = 0; 
	proc->roundEnd = true; 
	proc->buttonsToPress = 0; 
	proc->code4frame = 0xff;
	proc->codefframe = 0xff;
	proc->EkrEfxIsUnitHittedNowFrames = 0xff; 
} 

void StartTimedHitsProc(void) { 
	TimedHitsProc* proc; 
	proc = Proc_Find(TimedHitsProcCmd); 
	if (!proc) { 
		proc = Proc_Start(TimedHitsProcCmd, (void*)3); 
	} 

} 
extern struct SkillSysBattleHit* GetCurrentRound(int roundID); 
extern s16 GetAnimRoundType(struct Anim * anim);
void SetCurrentAnimInProc(struct Anim* anim) { 
	TimedHitsProc* proc; 
	proc = Proc_Find(TimedHitsProcCmd); 
	int timer2 = proc->timer2; 
	InitVariables(proc); 
	proc->roundEnd = false; 
	proc->timer2 = timer2; 
	proc->anim = anim; 
	proc->anim2 = GetAnimAnotherSide(anim); 
	//proc->roundId = anim->nextRoundId-1; 
	proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1; 
	proc->currentRound = GetCurrentRound(proc->roundId); 
	proc->side = GetAnimPosition(anim) ^ 1; 
	proc->active_bunit = gpEkrBattleUnitLeft; 
	proc->opp_bunit = gpEkrBattleUnitRight; 
	if (!proc->side) { 
		proc->active_bunit = gpEkrBattleUnitRight; 
		proc->opp_bunit = gpEkrBattleUnitLeft;
	} 
	if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange)) { return; } 
	if (!proc->loadedImg) {
		proc->timer2 = 0; 
		Copy2dChr(&Press_Image, (void*)0x06012000, 8, 2);
		Copy2dChr(&BattleStar, (void*)0x06012100, 2, 2); // 0x108 
		Copy2dChr(&A_Button, (void*)0x06012800, 2, 2); // 0x140
		Copy2dChr(&B_Button, (void*)0x06012840, 2, 2); // 0x142 
		Copy2dChr(&Left_Button, (void*)0x06012880, 2, 2); // 0x144
		Copy2dChr(&Right_Button, (void*)0x060128C0, 2, 2); // 0x146
		Copy2dChr(&Up_Button, (void*)0x06012900, 2, 2); // 0x148
		Copy2dChr(&Down_Button, (void*)0x06012940, 2, 2); // 0x14a
		proc->loadedImg = true;
	}
}


void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct SkillSysBattleHit* round);
void AdjustDamageByPercent(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent);
void AdjustDamageWithGetter(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round);
void CheckForDeath(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp); 

const u16 sSprite_HitInput[] = {
    1, // number of entries below (each entry has 3 lines) 
    0x0002, 
	0x4000, 
	0x01ca // tile number 
};
const u16 sSprite_MissedInput[] = {
    1,
    0x0000, 
	0x4000, 
	0x01cc // tile number 
};
const u16 sSprite_PressInput[] = {
    1,
    OAM0_SHAPE_32x16, 
	OAM1_SIZE_32x16, 
	OAM2_CHR(0x0100) // tile number 
};
const u16 sSprite_PressInput2[] = {
    1,
    OAM0_SHAPE_16x16, 
	OAM1_SIZE_16x16, 
	OAM2_CHR(0x0104) // tile number 
};
const u16 sSprite_Star[] = {
    1,
    OAM0_SHAPE_16x16, 
	OAM1_SIZE_16x16, 
	OAM2_CHR(0x0108) // tile number 
};
const u16 sSprite_A_Button[] = {
    1, OAM0_SHAPE_16x16, OAM1_SIZE_16x16, OAM2_CHR(0x0140) // tile number 
};
const u16 sSprite_B_Button[] = {
    1, OAM0_SHAPE_16x16, OAM1_SIZE_16x16, OAM2_CHR(0x0142) // tile number 
};
const u16 sSprite_Left_Button[] = {
    1, OAM0_SHAPE_16x16, OAM1_SIZE_16x16, OAM2_CHR(0x0144) // tile number 
};
const u16 sSprite_Right_Button[] = {
    1, OAM0_SHAPE_16x16, OAM1_SIZE_16x16, OAM2_CHR(0x0146) // tile number 
};
const u16 sSprite_Up_Button[] = {
    1, OAM0_SHAPE_16x16, OAM1_SIZE_16x16, OAM2_CHR(0x0148) // tile number 
};
const u16 sSprite_Down_Button[] = {
    1, OAM0_SHAPE_16x16, OAM1_SIZE_16x16, OAM2_CHR(0x014a) // tile number 
};




void BreakOnce(TimedHitsProc* proc) { 
	if (proc->broke) { return; } 
	proc->broke = true; 
	asm("mov r11, r11");
} 

void LoopTimedHitsProc(TimedHitsProc* proc) { 
	if (!proc->anim) { return; } 
	  
	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	//struct Anim* anim1 = proc->anim; 
	if (!battleProc) { return; } 
	if (!proc->anim2) { return; } 
	
	proc->timer++;
	proc->timer2++;

	struct SkillSysBattleHit* currentRound = proc->currentRound; 
	if ((currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!currentRound->hpChange)) { return; } 
	if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF) { 
		proc->EkrEfxIsUnitHittedNowFrames++; 
	} 
	else if (EkrEfxIsUnitHittedNow(proc->side)) { proc->EkrEfxIsUnitHittedNowFrames = 0; } 
	struct ProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBar); 
	DoStuffIfHit(proc, battleProc, HpProc, currentRound); 
} 

int HitNow(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc) {
	
	if (!HpProc) { return false; } // 
	//if (HpProc->pre != HpProc->cur) { return false; } 
	if (proc->EkrEfxIsUnitHittedNowFrames) { return false; } 
	return true;
} 


/*
#define A_BUTTON        0x0001
#define B_BUTTON        0x0002
#define SELECT_BUTTON   0x0004
#define START_BUTTON    0x0008
#define DPAD_RIGHT      0x0010
#define DPAD_LEFT       0x0020
#define DPAD_UP         0x0040
#define DPAD_DOWN       0x0080
*/
extern int NumberOfRandomButtons; 
extern int AlwaysA; 
int GetButtonsToPress(TimedHitsProc* proc) { 
	if (AlwaysA) { return A_BUTTON; } 
	int keys = proc->buttonsToPress;
	if (!keys) { 
		u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
		int button = 0; 
		int num = 0; 
		int oppDir = 0; 
		int size = 5; // -1 since we count from 0  
		for (int i = 0; i < NumberOfRandomButtons; ++i) { 
			num = NextRN_N(size); 
			button = KeysList[num];
			
			// remove the opposite direction from the pool 
			if (button & 0xF0) { // some dpad 
				if (button == DPAD_RIGHT) { oppDir = DPAD_LEFT; } 
				if (button == DPAD_LEFT) { oppDir = DPAD_RIGHT; } 
				if (button == DPAD_UP) { oppDir = DPAD_DOWN; } 
				if (button == DPAD_DOWN) { oppDir = DPAD_UP; } 
				for (int c = 0; c <= size; ++c) { 
					if (KeysList[c] == oppDir) { 
						KeysList[c] = KeysList[size]; 
						size--; 
						break; 
					} 
				}
			}
			
			
			keys |= button; 
		}
		proc->buttonsToPress = keys; 
	}
	return keys; 
} 

const u8 RomKeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN }; 
int CountKeysPressed(u32 keys) { 
	int c = 0; 
	for (int i = 0; i < 5; ++i) { 
		if (keys & RomKeysList[c]) { c++; } 
	} 
	return c; 

} 

int PressedSpecificKeys(TimedHitsProc* proc, u32 keys) { 
	int reqKeys = GetButtonsToPress(proc); 
	int count = CountKeysPressed(reqKeys); 
	if (ABS(count - CountKeysPressed(keys)) > 1) { return false; } // you pressed more than 1 extra key. Shame on you. 
	return (keys & reqKeys); 
} 
void SaveInputFrame(TimedHitsProc* proc, u32 keys) { 
	struct Anim* anim = proc->anim; 
	u32 instruction = *anim->pScrCurrent++; 
	if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND) {
		if (ANINS_COMMAND_GET_ID(instruction) == 4) {
			proc->code4frame = proc->timer; proc->timer2 = 0; 
		}
		if (ANINS_COMMAND_GET_ID(instruction) == 0xF) {
			proc->codefframe = proc->timer; proc->timer2 = 0; 
		}
	}
	instruction = *anim->pScrCurrent--; 
	if (PressedSpecificKeys(proc, keys)) { 
		if (!proc->frame) { 
			proc->frame = proc->timer; // locate is side for stereo? 
			PlaySFX(0x13e, 0x100, 120, 1); //PlaySFX(int songid, int volume, int locate, int type)
		}
	}
}  
void SaveIfWeHitOnTime(TimedHitsProc* proc) {
	int num = proc->codefframe; 
	if (num != 0xFF) { 
		if (ABS(num - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; }
	}
	else if (proc->code4frame != 0xFF) { if (ABS(proc->code4frame - proc->frame) < (LenienceFrames)) { proc->hitOnTime = true; } } 
	else if ((proc->timer - proc->frame) < LenienceFrames) { proc->hitOnTime = true; }
	
}

int DidWeHitOnTime(TimedHitsProc* proc) {
	if (AlwaysWork) { return true; } 
	return proc->hitOnTime;
}

void DrawButtonsToPress(TimedHitsProc* proc, int x, int y, int palID) { 
	int keys = GetButtonsToPress(proc); 


	//ApplyPalettes(gPal_Press_Image, 15+16, 0x10); // always pal 15 
	int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); //OAM2_CHR(0);
	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
	x += 32; 
	PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2); 
	y += 16; x -= 36; 
	if (keys & A_BUTTON) { 
		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2); x += 18; 
	}
	if (keys & B_BUTTON) { 
		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2); x += 18; 
	}
	if (keys & DPAD_LEFT) { 
		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2); x += 18; 
	}
	if (keys & DPAD_RIGHT) { 
		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2); x += 18; 
	}
	if (keys & DPAD_UP) { 
		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2); x += 18; 
	}
	if (keys & DPAD_DOWN) { 
		PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2); x += 18; 
	}




} 


void DoStuffIfHit(TimedHitsProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct SkillSysBattleHit* round) { 
	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	int side = proc->side; 
	int x = 12 * 8; 
	int y =  5 * 8;
	x = x+((side)*4*8);
	struct BattleUnit* active_bunit = proc->active_bunit; 
	struct BattleUnit* opp_bunit = proc->opp_bunit; 
	int hitTime = HitNow(proc, HpProc); 
	if (hitTime) { // 1 frame 
		SaveInputFrame(proc, keys); 
		SaveIfWeHitOnTime(proc);

		if (DidWeHitOnTime(proc)) { 
			if (!proc->adjustedDmg) { 
				proc->adjustedDmg = true; 
				AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round); 
			} 
		} 
		int x2 = BAN_DisplayDamage(proc->anim2, 0, 0, 0, proc->roundId); 
		x2 = BAN_DisplayDamage(proc->anim, 1, proc->anim->xPosition, x2, proc->roundId);  
		// kill off enemies for adjusted rounds if a timed hit was done previously 
		if (!proc->adjustedDmg) {
			CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, (-1)); 
		}
	}
	//if ((proc->timer2 < MinFramesToDisplayGfx) || EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
	if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF)) { 
		//BreakOnce(proc); 
		if (DidWeHitOnTime(proc)) { 
			//int clock = GetGameClock(); // proc->timer; 
			int clock = proc->timer2; 
			//ApplyPalettes(gPal_BattleStar, 14+16, 0x10);
			int oam2 = OAM2_PAL(14) | OAM2_LAYER(0); //OAM2_CHR(0);
			x += Mod(clock, 8) >> 1; 
			y -= clock; 
			//if (y < 40) { y = 40; } 
			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Star, oam2); 
		}
		else if (proc->timer2 < 20) { 
			DrawButtonsToPress(proc, x, y, 14); 
		}
		proc->roundEnd = true; 

	} 
	else { 
		if (proc->timer < 10) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down 
		else {
			SaveInputFrame(proc, keys); 
		} 
		if (!proc->roundEnd) { 
			DrawButtonsToPress(proc, x, y, 15); 
		} 
		
	}


} 

int GetDefaultDamagePercent(struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit) { 
	if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED) { return ReducedDamagePercent; } 
	return BonusDamagePercent; 
} 
int GetDamagePercent(struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit) { 
	// add more unique cases here 
	return GetDefaultDamagePercent(active_bunit, opp_bunit); 
} 

void AdjustAllRounds(int id, int difference, int damage) { 
	int hp;
	for (int i = id; i < 22; i += 2) {
		hp = gEfxHpLut[i]; 
		if (hp == 0xffff) { break; }
		if (difference < 0) { hp += difference; if (hp > 0) { gEfxHpLut[i] = hp; } else { gEfxHpLut[i] = 0; } }
		else if (hp >= difference) { gEfxHpLut[i] -= difference; }
		else { gEfxHpLut[i] = 0; }
		
	}
	//BANIM_NumsProc* banim_proc = Proc_Find((void*)&BAN_Proc_DelayDigits); 
	//if (banim_proc) { 
	//	damage = -39; 
	//	banim_proc->digits = 2;
	//	if (damage > 9) { banim_proc->digits = 2; } 
	//	if (damage > 99) { banim_proc->digits = 3; } 
	//	if (damage < (-9)) { banim_proc->digits = 2; } 
	//	if (damage < (-99)) { banim_proc->digits = 3; }
	//	banim_proc->damage = damage; 
	//} 
}

extern s16 gEfxHpLutOff[]; // 203e152 B gEfxHpLutOff

void AdjustDamageWithGetter(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round) { 
	AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, GetDamagePercent(active_bunit, opp_bunit)); 
} 

void CheckForDeath(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int hp) { 
	int side = proc->side; 
	//asm("mov r11, r11");
	//int damage = (round->hpChange * percent) / 100; 
	int id = (gEfxHpLutOff[side] * 2) + (side);
	if (hp < 0) { hp = GetEfxHp(id) - round->hpChange; } // + round->hpChange; 
	if (hp <= 0) { // they are dead 
		hp = 0; 
		//asm("mov r11, r11"); 
		//gEkrGaugeHp[side] += damage;
		//damage = opp_bunit->unit.curHP; //HpProc->post; 
		//round->hpChange = hp; // used by Huichelaar's banim numbers 
		opp_bunit->unit.curHP = 0; 
		HpProc->post = 0; 
		proc->code4frame = 0xff;
		//gEkrGaugeHp[side ^ 1] = round->hpChange;
		
		//gEkrGaugeHp[side ^ 1] = 22;//+= damage;
		HpProc->death = true; 

		//gpProcEkrBattle->end = true; // does nothing 
		//gEkrBattleEndFlag = true; // immediately ends without waiting for anything 
		//NewEkrbattleending(); // crashes 
		proc->anim->nextRoundId = 8; // seems to work for now see GetAnimNextRoundType
		proc->anim2->nextRoundId = 8; 

		gBanimDoneFlag[0] = true; // stop follow ups / counters 
		gBanimDoneFlag[1] = true; 
		//gBanimDoneFlag[1] = true; // doesn't stop the counter attack 
		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
		
		
		// now stop us from dying 
		side = 1 ^ side; 
		id = (gEfxHpLutOff[side] * 2) + (side);
		hp = GetEfxHp(id); 
		//hp = gEfxHpLut[proc->roundId - 1]; 
		active_bunit->unit.curHP = hp; 
		
	} 
	

	
	
}

void AdjustDamageByPercent(TimedHitsProc* proc, struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, struct SkillSysBattleHit* round, int percent) { 
	//if (!HpProc->post) { return; } 
	
	int side = proc->side; 
	int id = (gEfxHpLutOff[side] * 2) + (side);
	int hp = GetEfxHp(id); // + round->hpChange; 
	if (!hp) { return; } 
	if (hp == 0xFFFF) { return; } 
	int damage = (round->hpChange * percent) / 100; 
	if (damage > round->hpChange) { 
		hp -= damage;
		damage -= round->hpChange; 
		 
		if (hp < 0) { damage -= ABS(hp); } 
		//hp = HpProc->post; 
		//hp -= damage;
		//if (hp < 0) { damage -= ABS(hp); } 
		HpProc->post -= damage;
		opp_bunit->unit.curHP -= damage; 
		round->hpChange += damage; 
		if (UsingSkillSys) { round->overDmg -= damage; } // used by Huichelaar's banim numbers 
	} 
	else if (round->hpChange != hp) { 
		
		damage = round->hpChange - damage; 
		hp += damage; 
		HpProc->post += damage;
		opp_bunit->unit.curHP += damage; 
		round->hpChange -= damage; 
		if (UsingSkillSys) { round->overDmg += damage; } // used by Huichelaar's banim numbers 
		damage = 0 - damage;
		
	} 
	else if (round->hpChange == hp) { 
		if (hp == 1) { // deal lethal anyway 
			hp = 0; 
			damage = 1; 
			HpProc->post = 0;
			opp_bunit->unit.curHP = 0; 
			round->hpChange += damage; 
			if (UsingSkillSys) { round->overDmg -= damage; } 
			damage = 0 - damage;
		
		} 
		else { // leave alive with 1 hp 
			hp = 1; 
			damage = round->hpChange - 1; 
			HpProc->post += 1;
			opp_bunit->unit.curHP += 1; 
			round->hpChange -= 1; 
			if (UsingSkillSys) { round->overDmg += 1; } 
			damage = 0 - damage;
		} 
	
	
	} 
	AdjustAllRounds(id, damage, round->hpChange);
	if (hp < 0) { hp = 0; } 
	CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp); 
	//return;
	//damage -= round->hpChange; // damage is -5 
	//int hp = opp_bunit->unit.curHP - damage;
	//hp = gEkrGaugeHp[side] - hp; 

	//if (hp > 80) { asm("mov r11, r11"); } 
	//asm("mov r11, r11"); 
	//if (damage < 0) { hp += ABS(damage); } 
	//else { hp -= damage; }
	//damage = damage - round->hpChange; 
	//hp -= (damage); 
	//hp = HpProc->pre - hp; 

	
} 


