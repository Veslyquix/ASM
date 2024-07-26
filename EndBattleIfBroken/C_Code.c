

#include "C_Code.h" // headers 
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;
extern const struct ProcCmd gProcScr_Talk[];
extern const struct ProcCmd* gProcScr_efxHPBar; 
extern const struct ProcCmd* gProcScr_efxHPBarResire; 
struct NewProcEfxHPBar {
    PROC_HEADER;

    /* 29 */ u8 death;
    /* 2A */ u8 _pad_2A[0x2C - 0x2A];
    /* 2C */ s16 pos;
    /* 2E */ s16 cur;
	/* 30 */ s16 curHpAtkrSS; 
    /* 32 */ u8 _pad_30[0x48 - 0x32];
    /* 48 */ s16 diff;
	/* 4a */ s16 diffHpAtkrSS; 
    /* 4C */ s16 pre;
	/* 4e */ s16 preHpAtkrSS; 
    /* 50 */ s16 post;
	/* 52 */ s16 postHpAtkrSS;  
    /* 54 */ int timer;
    /* 58 */ int finished;
    /* 5C */ struct Anim * anim5C;
    /* 60 */ struct Anim * anim60;
    /* 64 */ struct Anim * anim64;
};

extern int MaxNumberOfFrames;

typedef struct {
    /* 00 */ PROC_HEADER;
	int timer;
    int hpBarTimer; 
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
} 

int HitNow(EndBrokenBattleProc* proc, struct ProcEfxHPBar* HpProc) {
	if (!HpProc) { return false; } 
	return true;
} 

extern u16* GetAnimRoundData(void); // skillsys repoints gAnimRoundData 
struct SkillSysBattleHit { 
    /* 00:18 */ unsigned attributes : 19;
    /* 19:23 */ unsigned info       : 5;
    /* 24:31 */ signed   hpChange   : 8;
	u8 skillID; 
	s8 cappedDmg; 
	s16 overDmg; 
};
extern struct SkillSysBattleHit* GetCurrentRound(int roundID); 

void EndBattle(EndBrokenBattleProc* proc) { 
    Proc_End(proc); 

    // struct SkillSysBattleHit* nextRound;
    // for (int i = 0; i < 8; ++i) { 
        // nextRound = GetCurrentRound(i); 
        // nextRound->info = BATTLE_HIT_INFO_FINISHES |BATTLE_HIT_INFO_END; 
    // //nextRound->hpChange = 0; 
    // } 
    
    // // stop future animations from occurring 
    // u16* animRound = &GetAnimRoundData()[0]; 
    // for (int i = 0; i < 32; ++i) { 
        // if (animRound[i] == 0xFFFF) { break; } 
        // animRound[i] = 0xFFFF; 
    // } 
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









