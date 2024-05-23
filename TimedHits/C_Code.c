#include "C_Code.h" // headers 

typedef struct {
    /* 00 */ PROC_HEADER;
	int timer; 
	u8 hitEarly; 
	u8 hitOnTime; 
	u8 roundId; 
	u8 didBonusDmg; 
	u8 currentUnitAIS;
	u8 broke; 
} SomeProc;
void LoopSomeProc(SomeProc* proc);
const struct ProcCmd SomeProcCmd[] =
{
	PROC_NAME("SomeProcName"), 
    PROC_YIELD,
	PROC_REPEAT(LoopSomeProc), 
    PROC_END,
};
extern void* Press_A_Image; 
extern u16 gPal_Press_A_Image[];
extern struct KeyStatusBuffer sKeyStatusBuffer; // 2024C78
void SomeC_Code(void) { 
	SomeProc* proc; 
	proc = Proc_Find(SomeProcCmd); 
	if (!proc) { 
	proc = Proc_Start(SomeProcCmd, (void*)3); 
	} 
	proc->broke = false; 
	proc->roundId = 0xFF; 
	proc->timer = 0; 
	proc->hitEarly = false; 
	proc->hitOnTime = false; 
	proc->didBonusDmg = false;
	proc->currentUnitAIS = 0;
	// load graphics into obj vram here 
	//LoadObjUIGfx(); // usually already loaded anyway 
	Copy2dChr(&Press_A_Image, (void*)0x06012000, 5, 4);

} 

//extern u16 EkrEfxIsUnitHittedNow(int pos); // 80522f4
//extern u16 gEkrHitEfxBool; // 0x2017780  [0x2017780..0x2017783]!!
// UpdateBanimFrame occurs once at start of battle 80599e8
// ekrGaugeMain 0x8051284 is called every frame 
//gpProcEkrGauge

// ekrBattle has anim* in +0x5C, as does efxHPBarColorChange 
// efxStatusUnit exists twice and has both anim* in respective +0x5C 

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
    OAM0_SHAPE_64x32, 
	OAM1_SIZE_64x32, 
	OAM2_CHR(0x0100) // tile number 
};
void BreakOnce(SomeProc* proc) { 
	if (proc->broke) { return; } 
	proc->broke = true; 
	asm("mov r11, r11");
} 

extern s16 GetAnimRoundType(struct Anim * anim);
extern const int EnemiesCanDoBonusDamage; 
extern struct BattleHit* GetCurrentRound(int roundID); 
void DoStuffIfHit(SomeProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct BattleHit* round, struct Anim* anim, struct Anim* anim2, u32 keys, int x, int y, int side);
void LoopSomeProc(SomeProc* proc) { 
	proc->timer++; 
	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	int x = 0; 
	int y = 8 * 5; 
	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	struct Anim* anim1 = NULL; 
	if (battleProc) { anim1 = battleProc->anim; } 
	else { return; } 
	struct Anim* anim2 = GetAnimAnotherSide(anim1);
	if (!anim2) { return; } 
	//struct Anim* anim = NULL; 
	

	int roundId = anim1->nextRoundId > anim2->nextRoundId ? anim1->nextRoundId-1 : anim2->nextRoundId-1; 
	if (proc->roundId != roundId) { 
		proc->broke = false; 
		proc->roundId = roundId; 
		proc->timer = 0; 
		proc->hitEarly = false; 
		proc->hitOnTime = false; 
		proc->didBonusDmg = false;
	} 
	struct BattleHit* currentRound = GetCurrentRound(roundId); 
	struct ProcEfxHPBar* HpProc = Proc_Find(ProcScr_efxHPBar); 
	int side = 0xFF; // side is only correct once the target is hit 
	if (EkrEfxIsUnitHittedNow(0)) { side = 0; } 
	if (EkrEfxIsUnitHittedNow(1)) { side = 1; } 


	//
	//DoStuffIfHit(proc, battleProc, HpProc, currentRound, anim, anim2, keys, x+((1^side)*12*8), y, side); 
	DoStuffIfHit(proc, battleProc, HpProc, currentRound, anim1, anim2, keys, x, y, side); 

	// hp display 203E1AC

} 
//#define AlwaysWork
void ApplyBonusDamage(struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, int side, struct BattleHit* round, struct Anim* anim, struct Anim* anim2);
void DoStuffIfHit(SomeProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct BattleHit* round, struct Anim* anim, struct Anim* anim2, u32 keys, int x, int y, int side) { 
	//side = 1 ^ side; 
	int hitTime = EkrEfxIsUnitHittedNow(side); 
	if (hitTime) { 
		struct BattleUnit* active_bunit = gpEkrBattleUnitLeft; 
		struct BattleUnit* opp_bunit = gpEkrBattleUnitRight; 
		if (!side) { 
			active_bunit = gpEkrBattleUnitRight; 
			opp_bunit = gpEkrBattleUnitLeft;
		} 
		if (!EnemiesCanDoBonusDamage && (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)) { return; } 
		
		x = x+((side ^ 1)*12*8);
		//BreakOnce(proc);
		if (keys & A_BUTTON) { 
			proc->hitOnTime = true; 
		} 
		
		#ifdef AlwaysWork
		if (!proc->didBonusDmg) { 
			proc->didBonusDmg = true; 
			//PlaySFX(int songid, int volume, int locate, int type)
			PlaySFX(0x13e, 0x100, 120, 1); // locate is side for stereo? 
			ApplyBonusDamage(HpProc, active_bunit, opp_bunit, side, round, anim, anim2); 
		} 
		#endif 
		if (proc->hitOnTime && (!proc->hitEarly)) { 
			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_HitInput, 0); 
			#ifndef AlwaysWork 
			if (!proc->didBonusDmg) { 
			proc->didBonusDmg = true; 
			//PlaySFX(int songid, int volume, int locate, int type)
			PlaySFX(0x13e, 0x100, 120, 1); // locate is side for stereo? 
			ApplyBonusDamage(HpProc, active_bunit, opp_bunit, side, round, anim, anim2); 
			} 
			#endif 
		} 
		else if (!proc->hitEarly) { 
			ApplyPalettes(gPal_Press_A_Image, 15+16, 0x10);
			int oam2 = OAM2_PAL(15) | OAM2_LAYER(0); //OAM2_CHR(0);
			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
		} 
	} 
	else { 
		if (proc->timer < 10) { proc->hitEarly = false; } // 10 frames after hitting where it's okay to have A held down 
		else if (keys & A_BUTTON) { 
			if (!proc->hitEarly) { 
				PlaySFX(0x13d, 0x100, 120, 1); 
			}
			proc->hitEarly = true; 
		} 
		
	}


} 

extern const int BonusDamage; 
int GetBonusDamageAmount(struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit) { 
	return BonusDamage; 
} 


void ApplyBonusDamage(struct ProcEfxHPBar* HpProc, struct BattleUnit* active_bunit, struct BattleUnit* opp_bunit, int side, struct BattleHit* round, struct Anim* anim, struct Anim* anim2) { 
	if (!HpProc->post) { return; } 
	int damage = GetBonusDamageAmount(active_bunit, opp_bunit); 
	int hp = round->hpChange + damage; 
	hp = gEkrGaugeHp[side] - hp; 
	//asm("mov r11, r11");
	//gBattleHitArray[0].attributes |= BATTLE_HIT_ATTR_SILENCER; // might need to end battle early? 
	if (hp > 0) { HpProc->post -= damage; opp_bunit->unit.curHP -= damage; round->hpChange += damage; } // used by Huichelaar's banim numbers 
	else { // they are dead 
		damage = HpProc->post; 
		round->hpChange += damage; // used by Huichelaar's banim numbers 
		opp_bunit->unit.curHP = 0; 
		HpProc->post = 0; 
		 
		gEkrGaugeHp[side ^ 1] = round->hpChange;
		gEkrGaugeHp[side] = round->hpChange;
		HpProc->death = true; 

		//gpProcEkrBattle->end = true; // does nothing 
		//gEkrBattleEndFlag = true; // immediately ends without waiting for anything 
		//NewEkrbattleending(); // crashes 

		anim2->nextRoundId = 8; // seems to work for now see GetAnimNextRoundType
		anim->nextRoundId = 8; // seems to work for now see GetAnimNextRoundType

		//gBanimDoneFlag[0] = true; 
		//gBanimDoneFlag[1] = true; // doesn't stop the counter attack 
		round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END; 
	} 
	
} 


