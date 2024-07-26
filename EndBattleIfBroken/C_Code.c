

#include "C_Code.h" // headers 
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;
extern const struct ProcCmd gProcScr_Talk[];
extern const struct ProcCmd* gProcScr_efxHPBar; 
extern const struct ProcCmd* gProcScr_efxHPBarResire; 

extern int MaxNumberOfFrames;

typedef struct {
    /* 00 */ PROC_HEADER;
	int timer;
    int hpBarTimer; 
    int roundId; 
} EndBrokenBattleProc;
void LoopEndBrokenBattleProc(EndBrokenBattleProc* proc);
const struct ProcCmd EndBrokenBattleProcCmd[] =
{
	PROC_NAME("EndBrokenBattleProcName"), 
    PROC_YIELD,
	PROC_REPEAT(LoopEndBrokenBattleProc), 
    PROC_END,
};

void StartEndBrokenBattleProc(void) { 
	EndBrokenBattleProc* proc; 
	proc = Proc_Find(EndBrokenBattleProcCmd); 
	if (!proc) { 
		proc = Proc_Start(EndBrokenBattleProcCmd, (void*)3); 
	} 
    proc->timer = 0; 
    proc->hpBarTimer = 0; 
    proc->roundId = 0xFF;
} 

int HitNow(EndBrokenBattleProc* proc, struct ProcEfxHPBar* HpProc) {
	if (!HpProc) { return false; } 
	return true;
} 


void EndBattle(EndBrokenBattleProc* proc) { 
    Proc_End(proc); 


    struct Anim * anim;
    gEkrBattleEndFlag = true; // immediately ends without waiting for anything 

    anim = gAnims[2];
    if (anim)
        EndEfxStatusUnits(anim);

    anim = gAnims[0];
    if (anim)
        EndEfxStatusUnits(anim);

    Proc_End(Proc_Find(ProcScr_efxWeaponIcon)); 
    Proc_End(Proc_Find(ProcScr_efxHPBarColorChange)); 
    DeleteEach6C_efxStatusUnit();
} 

void LoopEndBrokenBattleProc(EndBrokenBattleProc* proc) { 
    if (Proc_Find(gProcScr_Talk)) { return; } // wait for battle / death quotes 
    proc->timer++; 
    struct Anim *anim, *anim2;
    anim = gAnims[GetAnimPosition(anim) * 2];
    anim2 = gAnims[GetAnimPosition(anim) * 2 + 1];
    int roundId = proc->roundId; 
    proc->roundId = anim->nextRoundId > anim2->nextRoundId ? anim->nextRoundId-1 : anim2->nextRoundId-1; 
    if (roundId != proc->roundId) { proc->timer = 0; proc->hpBarTimer = 0; } 
    struct ProcEfxHPBar* HpProc = Proc_Find(gProcScr_efxHPBarResire); 
	if (!HpProc) { HpProc = Proc_Find(gProcScr_efxHPBar); } 
    if (HitNow(proc, HpProc)) { 
        if (proc->timer > 1) { proc->hpBarTimer = 0; } 
        proc->timer = 0; 
        proc->hpBarTimer++; 
    } 
    if ((proc->timer > MaxNumberOfFrames) || (proc->hpBarTimer > MaxNumberOfFrames)) { 
        EndBattle(proc); 
    } 
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









