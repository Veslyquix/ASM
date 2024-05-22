#include "C_Code.h" // headers 

typedef struct {
    /* 00 */ PROC_HEADER;
	int timer[2]; 
	struct Unit* unit[2];
	u8 hitEarly[2]; 
	u8 hitOnTime[2]; 
} SomeProc;
void LoopSomeProc(SomeProc* proc);
const struct ProcCmd SomeProcCmd[] =
{
	PROC_NAME("SomeProcName"), 
    PROC_YIELD,
	PROC_REPEAT(LoopSomeProc), 
    PROC_END,
};

extern struct KeyStatusBuffer sKeyStatusBuffer; // 2024C78
void SomeC_Code(void) { 
	SomeProc* proc; 
	proc = Proc_Find(SomeProcCmd); 
	if (!proc) { 
	proc = Proc_Start(SomeProcCmd, (void*)3); 
	} 
	proc->timer[0] = 0; 
	proc->timer[1] = 0; 
	proc->unit[0] = NULL; 
	proc->unit[1] = NULL; 
	proc->hitEarly[0] = false; 
	proc->hitEarly[1] = false; 
	proc->hitOnTime[0] = false; 
	proc->hitOnTime[1] = false; 

	// load graphics into obj vram here 
	//LoadObjUIGfx(); // usually already loaded anyway 



} 

//extern u16 EkrEfxIsUnitHittedNow(int pos); // 80522f4
//extern u16 gEkrHitEfxBool; // 0x2017780  [0x2017780..0x2017783]!!
// UpdateBanimFrame occurs once at start of battle 80599e8
// ekrGaugeMain 0x8051284 is called every frame 


const u16 sSprite_HitInput[] = {
    1,
    0x0002, 
	0x4000, 
	0x01ca // tile number 
};
const u16 sSprite_MissedInput[] = {
    1,
    0x0002, 
	0x4000, 
	0x01cc // tile number 
};
void DoStuffIfHit(SomeProc* proc, u32 keys, int x, int y, int side);
void LoopSomeProc(SomeProc* proc) { 
	proc->timer[0]++; 
	proc->timer[1]++; 
	u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys; 
	int x = 0; 
	int y = 0; 
	//PutSprite(int layer, int x, int y, const u16* object, int oam2) // oam2 is palette & other stuff 
	
	//struct Anim* anim = 
	
	//if (proc->timer > 50) { Proc_Break(proc); } 
	DoStuffIfHit(proc, keys, x+(5*8), y, 0); 
	//DoStuffIfHit(proc, keys, x, y, 1); 




} 
extern const int BonusDamage; 
void DoStuffIfHit(SomeProc* proc, u32 keys, int x, int y, int side) { 
	// wrong size for ss 
		gBattleHitArray[0].hpChange = 5; // used by Huichelaar's banim numbers 
		//gBattleHitArray[0].attributes |= BATTLE_HIT_ATTR_SILENCER; 
	int hitTime = EkrEfxIsUnitHittedNow(side); 
	if (hitTime) { 
		if (gBattleTarget.unit.curHP < BonusDamage) { gBattleTarget.unit.curHP = 0; } 
		else { gBattleTarget.unit.curHP -= BonusDamage; } 
		proc->timer[side] = 0; 
		if (proc->hitEarly[side]) { PutSprite(2, x, y, sSprite_MissedInput, 0); return; } 
		if (keys & A_BUTTON) { 
			proc->hitOnTime[side] = true; 
		} 
		if (proc->hitOnTime[side] && (!proc->hitEarly[side])) { 
			PutSprite(2, x, y, sSprite_HitInput, 0);
		} 
	} 
	else { 
		if (keys & A_BUTTON) { proc->hitEarly[side] = true; } 
		int otherSide = 0; 
		if (!side) { otherSide = 1; } 
		if ((proc->timer[side] && (proc->timer[side] < 10)) || (!proc->timer[otherSide])) { proc->hitEarly[side] = false; proc->hitEarly[otherSide] = false; } // 10 frames after hitting where it's okay to have A held down 
	}


} 




