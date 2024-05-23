#include "C_Code.h" // headers 

typedef struct {
    /* 00 */ PROC_HEADER;
	int timer; 
	u8 hitEarly; 
	u8 hitOnTime; 
	u8 roundId; 
	u8 didBonusDmg; 
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
	proc->roundId = 0xFF; 
	proc->timer = 0; 
	proc->hitEarly = false; 
	proc->hitOnTime = false; 
	proc->didBonusDmg = false;
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
extern const int EnemiesCanDoBonusDamage; 
extern struct BattleHit* GetCurrentRound(int roundID); 
void DoStuffIfHit(SomeProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct BattleHit* round, struct Anim* anim, struct Anim* anim2, u32 keys, int x, int y, int side);
void LoopSomeProc(SomeProc* proc) { 
	proc->timer++; 
	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	int x = 0; 
	int y = 8 * 5; 
	struct ProcEkrBattle* battleProc = gpProcEkrBattle; 
	struct Anim* anim = NULL; 
	if (battleProc) { anim = battleProc->anim; } 
	else { return; } 
	struct Anim* anim2 = GetAnimAnotherSide(anim);
	if (!anim2) { return; } 
	int roundId = anim->nextRoundId > anim2->nextRoundId ? anim->nextRoundId-1 : anim2->nextRoundId-1; 
	struct BattleHit* currentRound = GetCurrentRound(roundId); 
	// if (!Proc_Find(updatebanimframe proc)) { Proc_Break(proc); } 
	struct ProcEfxHPBar* HpProc = Proc_Find(ProcScr_efxHPBar); 
	
	int side; 
	//if (gEkrInitialHitSide) { 
	if (anim->nextRoundId > anim2->nextRoundId) { 
	side = GetAnimPosition(anim); 
	} 
	else { side = GetAnimPosition(anim2); } 
	// (gpEkrBattleUnitLeft
	
	//int side = gEkrInitialPosition[1]; 
	
	//if (gAnimRoundData[roundId] == gAnimRoundData[0]) { side = 1 ^ side; } 
	//if (6 == gAnimRoundData[0]) { side = 1 ^ side; } 
	//int side = anim->state & (ANIM_BIT_ENABLED | ANIM_BIT_HIDDEN | ANIM_BIT_2 | ANIM_BIT_FROZEN) ? 0 : 1; 
	//int side = anim->state2 & ANIM_BIT2_POS_RIGHT ? 0 : 1; 
	//int side = 1 ^ gEkrInitialPosition[(roundId-1)&1]; 
	if (proc->roundId != roundId) { 
		proc->roundId = roundId; 
		proc->timer = 0; 
		proc->hitEarly = false; 
		proc->hitOnTime = false; 
		proc->didBonusDmg = false;
	} 
	
	if (!EnemiesCanDoBonusDamage && side) { asm("mov r11, r11"); return; } 
	DoStuffIfHit(proc, battleProc, HpProc, currentRound, anim, anim2, keys, x+((1^side)*12*8), y, side); 

	// hp display 203E1AC


} 

void ApplyBonusDamage(struct ProcEfxHPBar* HpProc, int side, struct BattleHit* round, struct Anim* anim, struct Anim* anim2); 
void DoStuffIfHit(SomeProc* proc, struct ProcEkrBattle* battleProc, struct ProcEfxHPBar* HpProc, struct BattleHit* round, struct Anim* anim, struct Anim* anim2, u32 keys, int x, int y, int side) { 
	
	//int side = 1 ^ battleProc->side; // we want to affect the opposite side 
	int hitTime = EkrEfxIsUnitHittedNow(side); 
	if (hitTime) { 

		//PutSprite(0, x, y, sSprite_PressInput, oam2);
		if (!proc->didBonusDmg) { 
			asm("mov r11, r11"); 
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
		    //asm("mov r11, r11");
			PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_HitInput, 0); 
		} 
		else if (!proc->hitEarly) { 
			//asm("mov r11, r11");
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
		bunit = &gBattleActor; 
	} 
	else { bunit = &gBattleTarget; } 
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


