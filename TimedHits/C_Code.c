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
	// if (!Proc_Find(updatebanimframe proc)) { Proc_Break(proc); } 
	struct ProcEfxHPBar* HpProc = Proc_Find(ProcScr_efxHPBar); 
	int side = 0xFF; //GetAnimPosition(anim1); 
	if (EkrEfxIsUnitHittedNow(0)) { side = 1; } // side is only correct once the target is hit 
	if (EkrEfxIsUnitHittedNow(1)) { side = 0; } 


	//
	//DoStuffIfHit(proc, battleProc, HpProc, currentRound, anim, anim2, keys, x+((1^side)*12*8), y, side); 
	DoStuffIfHit(proc, battleProc, HpProc, currentRound, anim1, anim2, keys, x, y, side); 

	// hp display 203E1AC

} 

void ApplyBonusDamage(struct ProcEfxHPBar* HpProc, int side, struct BattleHit* round, struct Anim* anim, struct Anim* anim2); 
void DoStuffIfHit(SomeProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct BattleHit* round, struct Anim* anim, struct Anim* anim2, u32 keys, int x, int y, int side) { 
	//BreakOnce(proc);
	//int side = 1 ^ battleProc->side; // we want to affect the opposite side 
	int hitTime = EkrEfxIsUnitHittedNow(1 ^ side); 
	if (hitTime) { 
		struct BattleUnit* active_bunit = gpEkrBattleUnitLeft; 
		struct BattleUnit* opp_bunit = gpEkrBattleUnitRight; 
		if (side) { //If GetAnimPosition returns 1, right unit is currently acting.
			active_bunit = gpEkrBattleUnitRight; 
			opp_bunit = gpEkrBattleUnitLeft;
		} 
		if (!EnemiesCanDoBonusDamage && (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)) { return; } 
		
		x = x+((1^side)*12*8);
		BreakOnce(proc);
		//PutSprite(0, x, y, sSprite_PressInput, oam2);
		if (!proc->didBonusDmg) { 
			proc->didBonusDmg = true; 
			//PlaySFX(int songid, int volume, int locate, int type)
			PlaySFX(0x13e, 0x100, 120, 1); // locate is side for stereo? 
			ApplyBonusDamage(HpProc, side, round, anim, anim2); 
		} 
		//if (proc->hitEarly) { 
			//PutSprite(int layer, int x, int y, const u16* object, int oam2) // oam2 is palette & other stuff 
			//PutSprite(2, x, y, sSprite_MissedInput, 0); return; 
		//} 
		if (keys & A_BUTTON) { 
			proc->hitOnTime = true; 
		} 
		
		if (proc->hitOnTime && (!proc->hitEarly)) { 
			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_HitInput, 0); 
		} 
		else if (!proc->hitEarly) { 
			ApplyPalettes(gPal_Press_A_Image, 15+16, 0x10);
			int oam2 = OAM2_PAL(15) | OAM2_LAYER(0); //OAM2_CHR(0);
			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2); 
		} 
	} 
	else { 
		if (keys & A_BUTTON) { proc->hitEarly = true; } 
		if (proc->timer < 10) { proc->hitEarly = false; } // 10 frames after hitting where it's okay to have A held down 
	}


} 

extern const int BonusDamage; 
void ApplyBonusDamage(struct ProcEfxHPBar* HpProc, int side, struct BattleHit* round, struct Anim* anim, struct Anim* anim2) { 
	struct BattleUnit* bunit = NULL; 
	if (!HpProc->post) { return; } 
	if (gEkrInitialPosition[side] == 0) { // actor is on the left 
		bunit = gpEkrBattleUnitLeft; 
	} 
	else { bunit = gpEkrBattleUnitRight; } 
	int damage = BonusDamage; 
	//gBattleHitArray[0].attributes |= BATTLE_HIT_ATTR_SILENCER; // might need to end battle early? 
	if (HpProc->post > damage) { HpProc->post -= damage; bunit->unit.curHP -= damage; round->hpChange += damage; } // used by Huichelaar's banim numbers 
	else { // they are dead 
		damage = HpProc->post; 
		round->hpChange += damage; // used by Huichelaar's banim numbers 
		bunit->unit.curHP = 0; 
		HpProc->post = 0; 
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


