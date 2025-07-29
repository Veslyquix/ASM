

#include "C_Code.h" // headers
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;

struct SkillSysBattleHit
{
    /* 00:18 */ unsigned attributes : 19;
    /* 19:23 */ unsigned info : 5;
    /* 24:31 */ signed hpChange : 8;
    u8 skillID;
    s8 cappedDmg;
    s16 overDmg;
};

typedef struct
{
    /* 00 */ PROC_HEADER;
    struct Anim * anim;
    struct Anim * anim2;
    int timer;
    struct SkillSysBattleHit * currentRound;
    struct BattleUnit * active_bunit;
    struct BattleUnit * opp_bunit;
    u8 timer2;
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
void LoopTimedHitsProc(TimedHitsProc * proc);
const struct ProcCmd TimedHitsProcCmd[] = {
    PROC_NAME("TimedHitsProcName"),
    PROC_YIELD,
    PROC_REPEAT(LoopTimedHitsProc),
    PROC_END,
};
typedef struct
{
    PROC_HEADER;
    u8 digits;    //   +0x29, byte. Number of digits.
    s16 damage;   //   +0x2A, short. Damage/heal value.
    u8 subjectId; //   +0x2C, byte. AISSubjectId. 0 if left, 1 if right.
} BANIM_NumsProc;
extern const struct ProcCmd * gProcScr_efxHPBar;
extern const struct ProcCmd * gProcScr_efxHPBarResire;
extern const struct ProcCmd BAN_Proc_DelayDigits[];
extern const int AlwaysWork;
extern const int MinFramesToDisplayGfx;
extern const int LenienceFrames;
extern const int BonusDamagePercent;
extern const int BonusDamageRounding;
extern const int ReducedDamageRounding;
extern const int ReducedDamagePercent;
extern const int ReducedDamageSubtract;
extern const int FailedHitDamagePercent;
extern const int UsingSkillSys;
extern const int ProcSkillsStackWithTimedHits;
extern const int DisabledFlag;
extern const int BlockingEnabled;
extern const int BlockingCanPreventLethal;
extern const int DisplayPress;
extern const int ChangePaletteWhenButtonIsPressed;
extern const u8 SkillExceptionsTable[];
extern void * Press_Image;
extern void * BattleStar;
extern void * A_Button;
extern void * B_Button;
extern void * Left_Button;
extern void * Right_Button;
extern void * Up_Button;
extern void * Down_Button;
// extern u16 gPal_Press_Image[];
// extern u16 gPal_BattleStar[];

struct TimedHitsDifficultyStruct
{
    u8 difficulty : 5;
    u8 alwaysA : 1;
    u8 off : 1;
    u8 cheats : 1;
};
extern struct TimedHitsDifficultyStruct * TimedHitsDifficultyRam;

// r0: AIS.
// r1: 0 if OverDamage or OverHeal (recipient). 1 otherwise.
// r2: X of previous damage display. 0 if there is none.
// r3: Digitcount of previous damage display. 0 if there is none.
extern int DisplayDamage2(struct Anim * anim, int overdamage, int x, int prevDigitCount, int roundId);
extern struct KeyStatusBuffer sKeyStatusBuffer; // 2024C78

int AreTimedHitsEnabled(void)
{
    if (gBattleStats.config &
        (BATTLE_CONFIG_PROMOTION | BATTLE_CONFIG_ARENA | BATTLE_CONFIG_REFRESH | BATTLE_CONFIG_MAPANIMS |
         BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_DANCERING))
    {
        return false;
    }
    if (TimedHitsDifficultyRam->off)
    {
        return false;
    }
    return !CheckFlag(DisabledFlag);
}

void InitVariables(TimedHitsProc * proc)
{
    proc->anim = NULL;
    proc->anim2 = NULL;
    proc->broke = false;
    proc->roundId = 0xFF;
    proc->timer = 0;
    proc->timer2 = 0xFF;
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

void StartTimedHitsProc(void)
{
    TimedHitsProc * proc;
    proc = Proc_Find(TimedHitsProcCmd);
    if (!proc)
    {
        proc = Proc_Start(TimedHitsProcCmd, (void *)3);
        InitVariables(proc);
    }
}
extern struct SkillSysBattleHit * GetCurrentRound(int roundID);
extern s16 GetAnimRoundType(struct Anim * anim);
void SetCurrentAnimInProc(struct Anim * anim)
{
    TimedHitsProc * proc;
    proc = Proc_Find(TimedHitsProcCmd);
    if (!proc)
    {
        return;
    }
    int roundId = anim->nextRoundId - 1;
    if (proc->roundId == roundId)
    {
        return;
    }
    InitVariables(proc);
    proc->roundEnd = false;
    proc->anim = anim;
    proc->anim2 = GetAnimAnotherSide(anim);
    proc->roundId = roundId;
    // proc->roundId = anim->nextRoundId > proc->anim2->nextRoundId ? anim->nextRoundId-1 : proc->anim2->nextRoundId-1;

    proc->currentRound = GetCurrentRound(proc->roundId);
    proc->side = GetAnimPosition(anim) ^ 1;
    proc->active_bunit = gpEkrBattleUnitLeft;
    proc->opp_bunit = gpEkrBattleUnitRight;
    if (!proc->side)
    {
        proc->active_bunit = gpEkrBattleUnitRight;
        proc->opp_bunit = gpEkrBattleUnitLeft;
    }
    if (!proc->loadedImg)
    {
        Copy2dChr(&Press_Image, (void *)0x06012980, 6, 2);
        Copy2dChr(&BattleStar, (void *)0x06012a40, 2, 2);   // 0x108
        Copy2dChr(&A_Button, (void *)0x06012800, 2, 2);     // 0x140
        Copy2dChr(&B_Button, (void *)0x06012840, 2, 2);     // 0x142
        Copy2dChr(&Left_Button, (void *)0x06012880, 2, 2);  // 0x144
        Copy2dChr(&Right_Button, (void *)0x060128C0, 2, 2); // 0x146
        Copy2dChr(&Up_Button, (void *)0x06012900, 2, 2);    // 0x148
        Copy2dChr(&Down_Button, (void *)0x06012940, 2, 2);  // 0x14a
        proc->loadedImg = true;
    }
}

struct NewProcEfxHPBar
{
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

void DoStuffIfHit(
    TimedHitsProc * proc, struct ProcEkrBattle * battleProc, struct NewProcEfxHPBar * HpProc,
    struct SkillSysBattleHit * round);
void AdjustDamageByPercent(
    TimedHitsProc * proc, struct NewProcEfxHPBar * HpProc, struct BattleUnit * active_bunit,
    struct BattleUnit * opp_bunit, struct SkillSysBattleHit * round, int percent);
void AdjustDamageWithGetter(
    TimedHitsProc * proc, struct NewProcEfxHPBar * HpProc, struct BattleUnit * active_bunit,
    struct BattleUnit * opp_bunit, struct SkillSysBattleHit * round, int success);
void CheckForDeath(
    TimedHitsProc * proc, struct NewProcEfxHPBar * HpProc, struct BattleUnit * active_bunit,
    struct BattleUnit * opp_bunit, struct SkillSysBattleHit * round, int hp, int newDamage);

const u16 sSprite_HitInput[] = {
    1, // number of entries below (each entry has 3 lines)
    0x0002, 0x4000,
    0x01ca // tile number
};
const u16 sSprite_MissedInput[] = {
    1, 0x0000, 0x4000,
    0x01cc // tile number
};
const u16 sSprite_PressInput[] = {
    1, OAM0_SHAPE_32x16, OAM1_SIZE_32x16,
    OAM2_CHR(0x014c) // tile number
};
const u16 sSprite_PressInput2[] = {
    1, OAM0_SHAPE_16x16, OAM1_SIZE_16x16,
    OAM2_CHR(0x0150) // tile number
};
const u16 sSprite_Star[] = {
    1, OAM0_SHAPE_16x16, OAM1_SIZE_16x16,
    OAM2_CHR(0x0152) // tile number
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

void BreakOnce(TimedHitsProc * proc)
{
    if (proc->broke)
    {
        return;
    }
    proc->broke = true;
    asm("mov r11, r11");
}

int HitNow(TimedHitsProc * proc, struct NewProcEfxHPBar * HpProc)
{

    if (!HpProc)
    {
        return false;
    } //
    // if (HpProc->pre != HpProc->cur) { return false; }
    if (proc->EkrEfxIsUnitHittedNowFrames)
    {
        return false;
    }
    return true;
}

void LoopTimedHitsProc(TimedHitsProc * proc)
{
    if (!proc->anim)
    {
        return;
    }

    struct ProcEkrBattle * battleProc = gpProcEkrBattle;
    // struct Anim* anim1 = proc->anim;
    if (!battleProc)
    {
        return;
    } // 0 after suspend until battle start
    if (!proc->anim2)
    {
        return;
    }
    if (gEkrBattleEndFlag)
    {
        Proc_End(proc);
        return;
    } // 0 after suspend until battle done

    proc->timer++;
    if (proc->timer2 != 0xFF)
    {
        proc->timer2++;
    }

    struct SkillSysBattleHit * currentRound = proc->currentRound;

    if (proc->EkrEfxIsUnitHittedNowFrames != 0xFF)
    {
        proc->EkrEfxIsUnitHittedNowFrames++;
    }
    else if (EkrEfxIsUnitHittedNow(proc->side))
    {
        proc->EkrEfxIsUnitHittedNowFrames = 0;
    }
    // or if MissNow, set proc->EkrEfxIsUnitHittedNowFrames = 0;
    // this would allow the star to appear for misses
    struct NewProcEfxHPBar * HpProc = Proc_Find(gProcScr_efxHPBarResire);
    if (!HpProc)
    {
        HpProc = Proc_Find(gProcScr_efxHPBar);
    }
    DoStuffIfHit(proc, battleProc, HpProc, currentRound);

    if (HitNow(proc, HpProc))
    {
        int x = DisplayDamage2(proc->anim2, 0, 0, 0, proc->roundId);
        x = DisplayDamage2(proc->anim, 1, proc->anim->xPosition, x, proc->roundId);
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
int IsNotMagicAnimation(TimedHitsProc * proc)
{
    int wepType = GetItemType(proc->active_bunit->weaponBefore);
    if (wepType == 5)
    {
        return false;
    }
    if (wepType == 6)
    {
        return false;
    }
    if (wepType == 7)
    {
        return false;
    }
    return true;
}
extern int NumberOfRandomButtons;
extern int AlwaysA;
int GetButtonsToPress(TimedHitsProc * proc)
{
    if (AlwaysA || TimedHitsDifficultyRam->alwaysA)
    {
        return A_BUTTON;
    }
    int keys = proc->buttonsToPress;
    if (!keys)
    {
        u8 KeysList[] = { A_BUTTON, B_BUTTON, DPAD_RIGHT, DPAD_LEFT, DPAD_UP, DPAD_DOWN };
        int button = 0;
        int num = 0;
        int oppDir = 0;
        int size = 5; // -1 since we count from 0
        int numberOfRandomButtons = NumberOfRandomButtons;
        if (!numberOfRandomButtons)
        {
            numberOfRandomButtons = TimedHitsDifficultyRam->difficulty;
        }
        if (IsNotMagicAnimation(proc))
        {
            numberOfRandomButtons = numberOfRandomButtons / 2;
        }
        if (!numberOfRandomButtons)
        {
            numberOfRandomButtons = 1;
        }

        for (int i = 0; i < numberOfRandomButtons; ++i)
        {
            num = NextRN_N(size);
            button = KeysList[num];

            // remove the opposite direction from the pool
            if (button & 0xF0)
            { // some dpad
                if (button == DPAD_RIGHT)
                {
                    oppDir = DPAD_LEFT;
                }
                if (button == DPAD_LEFT)
                {
                    oppDir = DPAD_RIGHT;
                }
                if (button == DPAD_UP)
                {
                    oppDir = DPAD_DOWN;
                }
                if (button == DPAD_DOWN)
                {
                    oppDir = DPAD_UP;
                }
                for (int c = 0; c <= size; ++c)
                {
                    if (KeysList[c] == oppDir)
                    {
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
int CountKeysPressed(u32 keys)
{
    int c = 0;
    for (int i = 0; i < 6; ++i)
    {
        if (keys & RomKeysList[i])
        {
            c++;
        }
    }
    return c;
}

int PressedSpecificKeys(TimedHitsProc * proc, u32 keys)
{
    int reqKeys = GetButtonsToPress(proc);
    int count = CountKeysPressed(reqKeys);
    if (ABS(count - CountKeysPressed(keys)) > 1)
    {
        return false;
    } // you pressed more than 1 extra key. Shame on you.
    reqKeys &= ~keys; // only 0 if we hit all the correct keys (and possibly 1 extra)
    return (!reqKeys);
}
void SaveInputFrame(TimedHitsProc * proc, u32 keys)
{
    struct Anim * anim = proc->anim;
    u32 instruction = *anim->pScrCurrent++;
    if (ANINS_GET_TYPE(instruction) == ANIM_INS_TYPE_COMMAND)
    {
        if (ANINS_COMMAND_GET_ID(instruction) == 4)
        {
            proc->code4frame = proc->timer;
            proc->timer2 = 0;
        }
        if (ANINS_COMMAND_GET_ID(instruction) == 0xF)
        {
            proc->codefframe = proc->timer;
            proc->timer2 = 0;
        }
    }
    instruction = *anim->pScrCurrent--;
    if (PressedSpecificKeys(proc, keys))
    {
        if (!proc->frame)
        {
            proc->frame = proc->timer;     // locate is side for stereo?
            PlaySFX(0x13e, 0x100, 120, 1); // PlaySFX(int songid, int volume, int locate, int type)
        }
    }
}
void SaveIfWeHitOnTime(TimedHitsProc * proc)
{
    if (proc->frame)
    {
        if (proc->codefframe != 0xFF)
        {
            if (ABS(proc->codefframe - proc->frame) < (LenienceFrames))
            {
                proc->hitOnTime = true;
            }
        }
        else if (proc->code4frame != 0xFF)
        {
            if (ABS(proc->code4frame - proc->frame) < (LenienceFrames))
            {
                proc->hitOnTime = true;
            }
        }
        if ((proc->timer - proc->frame) < LenienceFrames)
        {
            proc->hitOnTime = true;
        }
    }
}

int CheatCodeOn(void)
{
    return (gPlaySt.unk1F & 0x80); // 202BD0F
}

int DidWeHitOnTime(TimedHitsProc * proc)
{
    if (CheatCodeOn())
    {
        return true;
    }
    if (AlwaysWork)
    {
        return true;
    }
    return proc->hitOnTime;
}

void DrawButtonsToPress(TimedHitsProc * proc, int x, int y, int palID)
{
    if (!DisplayPress)
    {
        return;
    }
    int keys = GetButtonsToPress(proc);

    if (ChangePaletteWhenButtonIsPressed && proc->frame)
    {
        palID = 14;
    }
    // ApplyPalettes(gPal_Press_Image, 15+16, 0x10); // always pal 15
    int oam2 = OAM2_PAL(palID) | OAM2_LAYER(0); // OAM2_CHR(0);
    PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput, oam2);
    x += 32;
    PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_PressInput2, oam2);
    y += 16;
    x -= 36;
    int count = CountKeysPressed(keys);

    if (count == 1)
    {
        x += 16;
    } // centering
    if (count == 2)
    {
        x += 8;
    }
    if (count == 3)
    {
        x += 0;
    }

    if (keys & A_BUTTON)
    {
        PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_A_Button, oam2);
        x += 18;
    }
    if (keys & B_BUTTON)
    {
        PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_B_Button, oam2);
        x += 18;
    }
    if (keys & DPAD_LEFT)
    {
        PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Left_Button, oam2);
        x += 18;
    }
    if (keys & DPAD_RIGHT)
    {
        PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Right_Button, oam2);
        x += 18;
    }
    if (keys & DPAD_UP)
    {
        PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Up_Button, oam2);
        x += 18;
    }
    if (keys & DPAD_DOWN)
    {
        PutSprite(2, OAM1_X(x + 0x200), OAM0_Y(y + 0x100), sSprite_Down_Button, oam2);
        x += 18;
    }
}

const u8 xPos[] = { 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1 };
void DoStuffIfHit(
    TimedHitsProc * proc, struct ProcEkrBattle * battleProc, struct NewProcEfxHPBar * HpProc,
    struct SkillSysBattleHit * round)
{
    if (!AreTimedHitsEnabled())
    {
        return;
    }
    if (round->hpChange < 0)
    {
        return;
    } // healing
    u32 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
    // int side = proc->side;
    // int x = 12 * 8;
    int y = 3 * 8;
    int x = proc->anim2->xPosition;
    if (x > 119)
    {
        x -= 40;
    }
    else if (x > 40)
    {
        x -= 20;
    }
    struct BattleUnit * active_bunit = proc->active_bunit;
    struct BattleUnit * opp_bunit = proc->opp_bunit;
    int hitTime = !proc->EkrEfxIsUnitHittedNowFrames;
    if (hitTime)
    { // 1 frame
        // BreakOnce(proc);
        if (proc->timer2 == 0xFF)
        {
            proc->timer2 = 0;
        }
        SaveInputFrame(proc, keys);
        SaveIfWeHitOnTime(proc);
        if (!proc->adjustedDmg)
        {
            if (DidWeHitOnTime(proc))
            {
                proc->adjustedDmg = true;
                AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, true);
            }
            else
            {
                proc->adjustedDmg = true;
                AdjustDamageWithGetter(proc, HpProc, active_bunit, opp_bunit, round, false);
            }

            // kill off enemies for adjusted rounds in case a timed hit was done previously

            // CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, (-1));
        }
    }
    // if ((proc->timer2 < MinFramesToDisplayGfx) || EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) ||
    // (proc->codefframe != 0xFF)) {
    if (EkrEfxIsUnitHittedNow(proc->side) || (proc->code4frame != 0xFF) || (proc->codefframe != 0xFF) ||
        (proc->timer2 != 0xFF))
    {
        if (DidWeHitOnTime(proc))
        {
            // BreakOnce(proc);
            // int clock = GetGameClock(); // proc->timer;
            int clock = proc->timer2;
            // ApplyPalettes(gPal_BattleStar, 14+16, 0x10);
            int oam2 = OAM2_PAL(14) | OAM2_LAYER(0); // OAM2_CHR(0);
            x += xPos[Mod(clock, sizeof(xPos) + 1)];
            x += 16;
            y = 8 * 6;
            y -= clock;
            if (((y > (-16)) && (y < (161))))
            {
                if (!gBanimDoneFlag[proc->side])
                { // doesn't seem to matter ?
                    PutSprite(0, OAM1_X(x + 0x200), OAM0_Y(y), sSprite_Star, oam2);
                }
            }
        }
        else if (proc->timer2 < 20)
        {
            if (ChangePaletteWhenButtonIsPressed)
            {
                DrawButtonsToPress(proc, x, y, 15);
            }
            else
            {
                DrawButtonsToPress(proc, x, y, 14);
            }
        }
        proc->roundEnd = true;
    }
    else
    {
        if (proc->timer < 1)
        {
            proc->frame = 0;
        } // 10 frames after hitting where it's okay to have A held down
        // if (1 == 0) { proc->frame = 0; } // 10 frames after hitting where it's okay to have A held down
        else
        {
            SaveInputFrame(proc, keys);
        }
        if (!proc->roundEnd)
        {
            DrawButtonsToPress(proc, x, y, 15);
        }
    }
}

extern int DifficultyThreshold;
extern int DifficultyBonusPercent;
int GetDefaultDamagePercent(struct BattleUnit * active_bunit, struct BattleUnit * opp_bunit, int success)
{

    if (success)
    {
        if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
        {
            if (BlockingEnabled)
            {
                return ReducedDamagePercent;
            }
            else
            {
                return 100;
            }
        }
        if (!TimedHitsDifficultyRam->alwaysA)
        {
            if ((TimedHitsDifficultyRam->difficulty >= DifficultyThreshold) ||
                (NumberOfRandomButtons >= DifficultyThreshold))
            {
                return BonusDamagePercent + DifficultyBonusPercent;
            }
        }
        return BonusDamagePercent;
    }
    if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
    {
        return 100;
    }
    return FailedHitDamagePercent;
}
int GetDamagePercent(struct BattleUnit * active_bunit, struct BattleUnit * opp_bunit, int success)
{
    // add more unique cases here
    return GetDefaultDamagePercent(active_bunit, opp_bunit, success);
}

void AdjustDamageWithGetter(
    TimedHitsProc * proc, struct NewProcEfxHPBar * HpProc, struct BattleUnit * active_bunit,
    struct BattleUnit * opp_bunit, struct SkillSysBattleHit * round, int success)
{
    int percent = GetDamagePercent(active_bunit, opp_bunit, success);
    AdjustDamageByPercent(proc, HpProc, active_bunit, opp_bunit, round, percent);
}

// skillsys repoints gEfxHpLut. This function is no longer used
extern s16 gEfxHpLutOff[]; // 203e152 B gEfxHpLutOff
void AdjustCurrentRound(int id, int difference, int damage)
{
    int hp;
    for (int i = id; i < 22; i += 2)
    {
        hp = gEfxHpLut[i];
        if (hp == 0xffff)
        {
            break;
        }
        if (difference < 0)
        {
            hp += difference;
            if (hp > 0)
            {
                gEfxHpLut[i] = hp;
            }
            else
            {
                gEfxHpLut[i] = 0;
            }
        }
        else if (hp >= difference)
        {
            gEfxHpLut[i] -= difference;
        }
        else
        {
            gEfxHpLut[i] = 0;
        }
    }
}

void UpdateHP(
    TimedHitsProc * proc, struct NewProcEfxHPBar * HpProc, struct BattleUnit * some_bunit, int newHp, int side,
    int newDamage)
{
    if (newHp < 0)
    {
        newHp = 0;
    }
    if (newHp > 127)
    {
        newHp = 127;
    }
    int hp = gEkrGaugeHp[side];
    some_bunit->unit.curHP = newHp;
    if (hp == newHp)
    {
        return;
    }
    int diff = newHp - hp;
    if (newDamage)
    {
        diff = 0 - newDamage;
    }

    if (proc->side == side)
    {
        HpProc->cur = hp;
        if (UsingSkillSys)
        { // uggggh
            HpProc->post = newHp;
        }
        else
        {
            HpProc->postHpAtkrSS = newHp >> 16;
            HpProc->post = newHp;
        }

        proc->currentRound->hpChange = ABS(diff);
        if (UsingSkillSys == 2)
        {
            proc->currentRound->overDmg = diff;
        } // used by Huichelaar's banim numbers
    }
}

extern s16 gBanimExpGain[2];
extern u16 * GetAnimRoundData(void); // skillsys repoints gAnimRoundData
void CheckForDeath(
    TimedHitsProc * proc, struct NewProcEfxHPBar * HpProc, struct BattleUnit * active_bunit,
    struct BattleUnit * opp_bunit, struct SkillSysBattleHit * round, int hp, int newDamage)
{
    int side = proc->side;
    // BattleUnwind();
    if (hp < 0)
    {
        hp = gEkrGaugeHp[side];
    }
    if (hp <= 0)
    { // they are dead
        hp = 0;
        UpdateHP(proc, HpProc, opp_bunit, hp, side, newDamage);

        proc->code4frame = 0xff;

        // gEkrGaugeHp[side ^ 1] = round->hpChange;

        // gEkrGaugeHp[side ^ 1] = 22;//+= damage;
        HpProc->death = true;

        // gpProcEkrBattle->end = true; // does nothing visible
        // gEkrBattleEndFlag = true; // immediately ends without waiting for anything
        // NewEkrbattleending(); // crashes sometimes
        // proc->anim->nextRoundId = 0; // seems to mostly work for now? see GetAnimNextRoundType
        // proc->anim2->nextRoundId = 0;

        // gBanimDoneFlag[0] = true; // stop counterattacks ?
        // gBanimDoneFlag[1] = true; // [201fb04..201fb07]!! - nothing else is writing to it. good.

        round->info |= BATTLE_HIT_INFO_FINISHES | BATTLE_HIT_INFO_KILLS_TARGET | BATTLE_HIT_INFO_END;

        struct SkillSysBattleHit * nextRound = GetCurrentRound(proc->roundId + 1);
        nextRound->info = BATTLE_HIT_INFO_END;
        nextRound->hpChange = 0;

        // stop future animations from occurring
        u16 * animRound = &GetAnimRoundData()[0];
        for (int i = proc->roundId; i < 32; ++i)
        {
            if (animRound[i] == 0xFFFF)
            {
                break;
            }
            animRound[i] = 0xFFFF;
        }

        // PidStatsRecordBattleRes(); // this is called in BattleGenerateRealInternal
        //  if we call it here, it will add to BWL an extra time, but it will know that we actually KO'd an enemy

        // now stop us from dying
        side = 1 ^ side;
        hp = gEkrGaugeHp[side];
        if (round->attributes & BATTLE_HIT_ATTR_HPSTEAL)
        {
            hp += newDamage;
        }
        // if (UsingSkillSys == 2) { if (HpProc->postHpAtkrSS > hp) { hp = HpProc->post; } }
        UpdateHP(proc, HpProc, active_bunit, hp, side, 0);
    }
    else
    {
        HpProc->death = false;
        // UpdateHP(proc, HpProc, opp_bunit, hp, side); // update hp is called before CheckForDeath already
    }

    // undo any exp / level gains because BattleApplyExpGains has already been called,
    // which calls CheckBattleUnitLevelUp, which adjusts the battle unit's exp / level
    struct Unit * unit = GetUnit(gBattleActor.unit.index);
    if (UNIT_IS_VALID(unit))
    {
        gBattleActor.unit.exp = unit->exp;
        gBattleActor.unit.level = unit->level;
    }

    unit = GetUnit(gBattleTarget.unit.index);
    if (UNIT_IS_VALID(unit))
    {
        gBattleTarget.unit.exp = unit->exp;
        gBattleTarget.unit.level = unit->level;
    }

    // now recalculate - a unit could've died due to timed hits
    BattleApplyExpGains(); // update exp
    gBanimExpGain[0] = gpEkrBattleUnitLeft->expGain;
    gBanimExpGain[1] = gpEkrBattleUnitRight->expGain;
}
extern s16 gEkrGaugeDmg[2];
void AdjustDamageByPercent(
    TimedHitsProc * proc, struct NewProcEfxHPBar * HpProc, struct BattleUnit * active_bunit,
    struct BattleUnit * opp_bunit, struct SkillSysBattleHit * round, int percent)
{
    // if (!HpProc->post) { return; }
    if ((proc->currentRound->attributes & BATTLE_HIT_ATTR_MISS) || (!proc->currentRound->hpChange))
    {
        return;
    }
    if (round->hpChange <= 0)
    {
        return;
    } // healing
    int side = proc->side;
    int hp = gEkrGaugeHp[proc->side];
    if (!hp)
    {
        CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, hp, 0);
        return;
    }
    if (hp == 0xFFFF)
    {
        return;
    }
    int oldDamage = round->hpChange;
    if (proc->currentRound->attributes & BATTLE_HIT_ATTR_CRIT)
    {
        if (gEkrGaugeDmg[side ^ 1] * 3 > oldDamage)
        {
            oldDamage = gEkrGaugeDmg[side ^ 1];
            oldDamage = oldDamage * 3;
        }
    }
    else if (gEkrGaugeDmg[side ^ 1] > oldDamage)
    {
        oldDamage = gEkrGaugeDmg[side ^ 1];
    }

    if (UsingSkillSys == 2)
    {
        oldDamage = ABS(round->overDmg);
    }

    // in case the round would've killed, use whichever is higher (displayed damage vs round damage)
    int newDamage = ((oldDamage * percent)) / 100;
    if (newDamage >= oldDamage)
    {
        newDamage = ((oldDamage * percent) + BonusDamageRounding) / 100;
    }
    else
    {
        newDamage = ((oldDamage * percent) + ReducedDamageRounding - ReducedDamageSubtract) / 100;
    }
    if (newDamage <= 0)
    {
        newDamage = 1;
    }
    int newHp = hp - newDamage;
    if (UNIT_FACTION(&active_bunit->unit) == FACTION_RED)
    {
        // if (newDamage < oldDamage) {
        // if (newHp <= 0) { if (((hp - oldDamage) > 0) && !BlockingCanPreventLethal) { newHp = hp - oldDamage; } }
        if ((hp - oldDamage) <= 0)
        {
            if (!BlockingCanPreventLethal)
            {
                newHp = hp - oldDamage;
                newDamage = oldDamage;
            }
        }
        if (!BlockingEnabled)
        {
            newHp = hp - oldDamage;
            newDamage = oldDamage;
        }
        //}
    }
    if (newHp <= 0)
    {
        newHp = 0;
    }

    if (UsingSkillSys && ((!ProcSkillsStackWithTimedHits) || SkillExceptionsTable[proc->currentRound->skillID]) &&
        (proc->currentRound->skillID))
    {
        // only update hp if no skill proc'd ?
        newDamage = round->hpChange; // actual oldDamage without choosing between displayed / round dmg
        newHp = hp - round->hpChange;
    }
    // else { if (percent != 100) { UpdateHP(proc, HpProc, opp_bunit, newHp, side, newDamage); } }
    // else { UpdateHP(proc, HpProc, opp_bunit, newHp, side, newDamage); }
    UpdateHP(proc, HpProc, opp_bunit, newHp, side, newDamage);

    CheckForDeath(proc, HpProc, active_bunit, opp_bunit, round, newHp, newDamage);
}

/*
extern int ForceAnimsOn;
enum PlaySt_AnimConfType
{
    PLAY_ANIMCONF_ON = 0,
    PLAY_ANIMCONF_OFF = 1,
    PLAY_ANIMCONF_SOLO_ANIM = 2,
    PLAY_ANIMCONF_ON_UNIQUE_BG = 3,
};
int GetSoloAnimPreconfType(struct Unit * unit);
int GetBattleAnimPreconfType(void)
{
    int result = gPlaySt.config.animationType;
    if (!CheatCodeOn())
    {
        if (ForceAnimsOn)
        {
            if (result == 2)
            {
                return 2;
            }
            else
            {
                return 1;
            }
        }
    }
    // If not solo anim, return global type
    if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
        return result;

    // If both units are players, use actor solo anim type
    if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
        if (UNIT_FACTION(&gBattleTarget.unit) == FACTION_BLUE)
            return GetSoloAnimPreconfType(&gBattleActor.unit);

    // If neither are players, return 1
    if (UNIT_FACTION(&gBattleActor.unit) != FACTION_BLUE)
        if (UNIT_FACTION(&gBattleTarget.unit) != FACTION_BLUE)
            return PLAY_ANIMCONF_OFF;

    // Return solo anim type for the one that is a player unit
    if (UNIT_FACTION(&gBattleActor.unit) == FACTION_BLUE)
        return GetSoloAnimPreconfType(&gBattleActor.unit);
    else
        return GetSoloAnimPreconfType(&gBattleTarget.unit);
}
*/
