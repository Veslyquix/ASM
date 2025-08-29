#include "C_Code.h"

#define brk asm("mov r11, r11");

enum PlaySt_AnimConfType
{
    PLAY_ANIMCONF_ON = 0,
    PLAY_ANIMCONF_OFF = 1,
    PLAY_ANIMCONF_SOLO_ANIM = 2,
    PLAY_ANIMCONF_ON_UNIQUE_BG = 3,
};
extern struct KeyStatusBuffer sKeyStatusBuffer;
extern u16 HeldButton_AnimOff;
extern u16 PlayerPhaseOnlyFlag;
extern u16 HeldButton_FastForwardAnims;
extern u16 SpeedupAnimsFlag;
extern struct TimedHitsDifficultyStruct * TimedHitsDifficultyRam_Link;
struct TimedHitsDifficultyStruct // 1 byte
{
    u8 difficulty : 5;
    u8 alwaysA : 1;
    u8 off : 1;
    u8 cheats : 1;
};

int ShouldReverseShowAnim(void)
{
    u16 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
    if (keys & HeldButton_AnimOff)
    {
        return true;
    }
    if (CheckFlag(PlayerPhaseOnlyFlag) && (!gPlaySt.faction))
    {
        return true;
    }
    return false;
}

int ShouldSpeedupAnims(void)
{
    u16 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
    if (TimedHitsDifficultyRam_Link)
    {
        if (TimedHitsDifficultyRam_Link->difficulty)
        {
            keys &= L_BUTTON | START_BUTTON | R_BUTTON |
                SELECT_BUTTON; // if timed hits are on, only these buttons are valid
        }
    }
    if (keys & HeldButton_FastForwardAnims)
    {
        return true;
    }
    if (CheckFlag(SpeedupAnimsFlag))
    {
        return true;
    }
    return false;
}

int GetSoloAnimPreconfType(struct Unit * unit)
{
    // TODO: battle anim type constants
    int type = PLAY_ANIMCONF_OFF;

    if (unit->state & US_SOLOANIM_1)
        type = PLAY_ANIMCONF_ON;

    if (unit->state & US_SOLOANIM_2)
        type = PLAY_ANIMCONF_ON_UNIQUE_BG;

    if (ShouldReverseShowAnim())
    {
        switch (type)
        {
            case PLAY_ANIMCONF_OFF:
            {
                type = PLAY_ANIMCONF_ON;
                break;
            }
            case PLAY_ANIMCONF_ON:
            {
                type = PLAY_ANIMCONF_OFF;
                break;
            }
            case PLAY_ANIMCONF_ON_UNIQUE_BG:
            {
                type = PLAY_ANIMCONF_OFF;
                break;
            }
            default:
        }
    }

    return type;
}

int GetBattleAnimPreconfType(void)
{
    int type = gPlaySt.config.animationType;

    // If not solo anim, return global type
    if (gPlaySt.config.animationType != PLAY_ANIMCONF_SOLO_ANIM)
    {
        if (ShouldReverseShowAnim())
        {
            switch (type)
            {
                case PLAY_ANIMCONF_OFF:
                {
                    type = PLAY_ANIMCONF_ON;
                    break;
                }
                case PLAY_ANIMCONF_ON:
                {
                    type = PLAY_ANIMCONF_OFF;
                    break;
                }
                case PLAY_ANIMCONF_ON_UNIQUE_BG:
                {
                    type = PLAY_ANIMCONF_OFF;
                    break;
                }
                default:
            }
        }
        return type;
    }

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

extern void IncrementGameClock(void);
#define INTR_CHECK (*(u16 *)0x3007FF8)
extern void VBlankIntrWait(void);
void FastForwardBattles(void)
{
    gBmSt.sync_hardware = true; // main_loop_ended
    gBmSt.prevVCount = REG_VCOUNT;
    if (!ShouldSpeedupAnims())
    {
        VBlankIntrWait();
        return;
    }

    INTR_CHECK = 1;
    IncrementGameClock();
    Proc_Run(*gProcTreeRootArray);
    // MainUpdateEkrBattle();
    SyncLoOam();
    if (!gBmSt.sync_hardware)
    {
        return;
    }
    gBmSt.sync_hardware = false;
    FlushLCDControl();
    FlushBackgrounds();
    FlushTiles();
    SyncHiOam();
}
