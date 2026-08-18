

#include "C_Code.h" // headers
#define FE8
#define PUREFUNC __attribute__((pure))
#define brk asm("mov r11, r11");
int Mod(int a, int b) PUREFUNC;
#define xTilesAmount 15
#define favTilesAmount 15
#define tmpSize 15

char * GetStringFromIndexSafe(int index)
{
    if ((index > 0x4000) || (index <= 0))
    {
        return GetStringFromIndex(1);
    }
    char * result = GetStringFromIndex(index);
    if (!result)
    {
        result = " ";
    }
    return result;
}

typedef struct
{
    /* 00 */ PROC_HEADER;
    s16 tileID;
    u16 lastTileHovered;
    s8 editing;
    u8 actionID;
    s8 id; // used by our custom menus
    s8 digit;
    u8 godMode;
    u8 autoplay;
    u16 bgmOverride;
    u8 page;
    s8 mainID; // by the main debugger menu
    u16 lastFlag;
    int gold;
    struct Unit * unit;
    s16 tmp[tmpSize]; // 0x64 out of 0x6c max
} DebuggerProc;

typedef struct
{
    /* 00 */ PROC_HEADER;
    int id;
} CheatCodeKeyListenerProc;

const u16 KonamiCodeSequence[] = { DPAD_UP,   DPAD_UP,    DPAD_DOWN, DPAD_DOWN, DPAD_LEFT, DPAD_RIGHT,
                                   DPAD_LEFT, DPAD_RIGHT, B_BUTTON,  A_BUTTON,  0,         0 };
extern int DebuggerTurnedOff_Flag;
extern int KeyComboToDisableFlag;
extern int KonamiCodeEnabled;
extern const EventListScr DebuggerFlagEvent[];

void ToggleFlag(int flag)
{
    if (CheckFlag(flag))
    {
        ClearFlag(flag);
    }
    else
    {
        SetFlag(flag);
    }
}

void CheckKeysForCheatCode(CheatCodeKeyListenerProc * proc)
{
    int keys = gKeyStatusPtr->newKeys;
    if (!keys)
    {
        return;
    }

    if (KonamiCodeEnabled)
    {
        if (KonamiCodeSequence[proc->id] & keys)
        {
            proc->id++;
        }
        else
        {
            if (keys & DPAD_UP)
            {
                proc->id = 2;
            }
            else
            {
                proc->id = 0;
            }
        }
        if (!KonamiCodeSequence[proc->id])
        {
            ToggleFlag(DebuggerTurnedOff_Flag);
            proc->id = 0;
        }
    }
    keys |= gKeyStatusPtr->heldKeys;
    if (KeyComboToDisableFlag)
    {
        if ((keys & KEYS_MASK) == KeyComboToDisableFlag)
        {
            ToggleFlag(DebuggerTurnedOff_Flag);
            CallEvent((u16 *)DebuggerFlagEvent, 1);
        }
    }
}

const struct ProcCmd CheatCodeKeyListenerCmd[] = {
    PROC_NAME("CheatCodeKeyListenerProc"),
    PROC_YIELD,
    PROC_REPEAT(CheckKeysForCheatCode),
    PROC_END,
};

int StartKeyListenerProc(void)
{
    int keys = gKeyStatusPtr->newKeys;
    if (!keys)
    {
        return 0;
    }
    CheatCodeKeyListenerProc * proc = Proc_Find(CheatCodeKeyListenerCmd);
    if (proc)
    {
        return 0;
    }
    proc = Proc_Start(CheatCodeKeyListenerCmd, PROC_TREE_3);
    proc->id = 0;
    return true;
}

void CopyProcVariables(DebuggerProc * dst, DebuggerProc * src)
{
    dst->tileID = src->tileID;
    dst->mainID = src->mainID;
    dst->lastTileHovered = src->lastTileHovered;
    dst->editing = src->editing;
    dst->actionID = src->actionID;
    dst->id = src->id;
    dst->digit = src->digit;
    dst->godMode = src->godMode;
    dst->page = src->page;
    dst->lastFlag = src->lastFlag;
    dst->gold = src->gold;
    dst->autoplay = src->autoplay;
    dst->bgmOverride = src->bgmOverride;
    for (int i = 0; i < tmpSize; ++i)
    {
        dst->tmp[i] = src->tmp[i];
    }
    dst->unit = src->unit;
}

void SetBootType(int id)
{
    struct GlobalSaveInfo info;
    ReadGlobalSaveInfo(&info);
    info.charKnownFlags[0x1F] = id;
    WriteGlobalSaveInfoNoChecksum(&info);
}

int GetBootType(void)
{
    struct GlobalSaveInfo info;
    ReadGlobalSaveInfo(&info);
    return info.charKnownFlags[0x1F];
}

void EventCallGameOverExt(ProcPtr proc)
{
    Proc_StartBlocking(ProcScr_BmGameOver, proc);
    SetBootType(4); // title screen after game over
}

void sub_8009C5C_edit(struct GameCtrlProc * proc)
{
    // if (proc->nextAction == GAME_ACTION_5)
    // {
    // Proc_Goto(proc, 5);
    // return;
    // }

    // InitPlayConfig(0, 0); gPlaySt stuff like difficulty
    //  gPlaySt.chapterStateBits |= PLAY_FLAG_TUTORIAL;
    ResetPermanentFlags();
    ResetChapterFlags();
    InitUnits();
    gPlaySt.chapterIndex = proc->nextChapter;
    ReadGameSave(ReadLastGameSaveId()); // added
}

#define LGAMECTRL_EXEC_BM_EXT 6 // Directly goto bmmap

// StartupDebugMenu_WorldMapEffect
// StartupDebugMenu_ChapterSelectEffect

void GameControl_CallEraseSaveEventWithKeyCombo(ProcPtr aproc)
{
    struct GameCtrlProc * proc = (void *)aproc;
    if (gKeyStatusPtr->heldKeys == (L_BUTTON | DPAD_RIGHT | SELECT_BUTTON))
    {
        Proc_Goto(proc, LGAMECTRL_ERASE_SAVE);
    }
    else
    {
        int var = GetBootType();
        switch (var)
        {
            case 1:
            {
                // GmDataInit();
                proc->unk_2E = 20;
                sub_8009C5C_edit(proc);
                Proc_Goto(proc, LGAMECTRL_EXEC_BM);
                break;
            }
            // case 2:
            // {
            // // GmDataInit();
            // proc->unk_2E = 20;
            // sub_8009C5C_edit(proc);
            // Proc_Goto(proc, LGAMECTRL_EXEC_BM_EXT);
            // break;
            // } // Directly goto bmmap / skirmish
            case 2:
            {
                if (IsValidSuspendSave(SAVE_ID_SUSPEND))
                {
                    ReadSuspendSave(3);
                    // SetNextGameActionId(GAME_ACTION_4);
                    Proc_Goto(proc, 8);
                    break;
                }
            } // Resume ch
            case 3:
            {
                if (IsValidSuspendSave(SAVE_ID_SUSPEND))
                {
                    ReadSuspendSave(3);
                    // SetNextGameActionId(GAME_ACTION_4);
                    Proc_Goto(proc, 8);
                    break;
                }
            } // Resume ch once
            default:
        }
    }

    // 8 = resume
    //
}
void BackPressSFX(void)
{
    int id;
#ifdef FE8
    id = 0x6B;
    m4aSongNumStart(id);
#endif
}
void ConfirmPressSFX(void)
{
    int id;
#ifdef FE8
    id = 0x6A;
    PlaySoundEffect(id);
#endif
}

extern int NumberOfPages;
void RestartDebuggerMenu(DebuggerProc * proc);
void ClearMainMenuGfx(DebuggerProc * proc);
int RestartNow(DebuggerProc * proc); // goto restart label
void LoopDebuggerProc(DebuggerProc * proc);
void PickupUnitIdle(DebuggerProc * proc);
void SetupUnitFunc(void);
int PromoAction(DebuggerProc * proc);
int ArenaAction(DebuggerProc * proc);
int LevelupAction(DebuggerProc * proc);
int UnitActionFunc(DebuggerProc * proc);
void CallPlayerPhase_FinishAction(DebuggerProc * proc);
int ClearActiveUnitStuff(DebuggerProc * proc);
void PlayerPhase_FinishActionNoCanto(ProcPtr proc);
int PlayerPhase_PrepareActionBasic(DebuggerProc * proc);
void PlayerPhase_ApplyUnitMovementWithoutMenu(DebuggerProc * proc);
void EditMapIdle(DebuggerProc * proc);
void StartPlayerPhaseTerrainWindow();
void EndAllMus(void);
void FixAndHandlePlayerCursorMovement(void);
void ChooseTileInit(DebuggerProc * proc);
void ChooseTileIdle(DebuggerProc * proc);
void RenderTilesetRowOnBg2(DebuggerProc * proc);
void DisplayTilesetTile(DebuggerProc * proc, u16 * bg, int xTileMap, int yTileMap, int xBmMap, int yBmMap);
void EditMapInit(DebuggerProc * proc);
void InitProc(DebuggerProc * proc);
void EditStatsInit(DebuggerProc * proc);
void EditStatsIdle(DebuggerProc * proc);
void EditItemsInit(DebuggerProc * proc);
void EditItemsIdle(DebuggerProc * proc);
void EditMiscInit(DebuggerProc * proc);
void EditMiscIdle(DebuggerProc * proc);
void EditAiInit(DebuggerProc * proc);
void EditAiIdle(DebuggerProc * proc);
void EditTrapInit(DebuggerProc * proc);
void EditTrapIdle(DebuggerProc * proc);
void EditBgmInit(DebuggerProc * proc);
void EditBgmIdle(DebuggerProc * proc);
void RedrawItemMenu(DebuggerProc * proc);
void LoadUnitsIdle(DebuggerProc * proc);
void RedrawLoadMenu(DebuggerProc * proc);
void LoadUnitsInit(DebuggerProc * proc);
void PutNumberHex(u16 * tm, int color, int number);
void StateInit(DebuggerProc * proc);
void StateIdle(DebuggerProc * proc);
void RedrawStateMenu(DebuggerProc * proc);
void ChStateInit(DebuggerProc * proc);
void ChStateIdle(DebuggerProc * proc);
void EditWExpInit(DebuggerProc * proc);
void EditWExpIdle(DebuggerProc * proc);
void EditSupportsInit(DebuggerProc * proc);
void EditSupportsIdle(DebuggerProc * proc);
void DebuggerListInit(DebuggerProc * proc);
void DebuggerListIdle(DebuggerProc * proc);
void GfxViewerInit(DebuggerProc * proc);
void GfxViewerLoop(DebuggerProc * proc);
void AnimViewerInit(DebuggerProc * proc);
void AnimViewerLoop(DebuggerProc * proc);
static void EndDebuggerBanimPreview(void);
void ClearSomeGfx(DebuggerProc * proc);
u8 CanActiveUnitPromote(void);

#define InitProcLabel 0
#define RestartLabel 1
#define PostActionLabel 2
// ClassChgMenuSelOnPressB 80CDC15 has Proc_Goto(proc, 2) in it, so we make
// this post action label 2
#define UnitActionLabel 3
#define PickupUnitLabel 4
#define ChooseTileLabel 5
#define EditMapLabel 6
#define EditTerrainLabel 7
#define EditTrapLabel 8
#define EditStatsLabel 9
#define EditItemsLabel 10
#define EditMiscLabel 11
#define LoadUnitsLabel 12
#define LevelupLabel 13
#define StateLabel 14
#define ChStateLabel 15
#define WExpLabel 16
#define SupportLabel 17
#define SupplyLabel 18
#define ListLabel 19
#define GfxViewerLabel 20
#define LoopLabel 21
#define EditAiLabel 22
#define EditBgmLabel 23
#define AnimViewerLabel 24
#define EndLabel 99

#define ActionID_Promo 1
#define ActionID_Arena 2
#define ActionID_Levelup 3
#define ActionID_DebugSkills 4

#ifndef PLAY_ANIMCONF_ON
#define PLAY_ANIMCONF_ON 0
#endif

const struct ProcCmd DebuggerProcCmdIdler[] = {
    PROC_NAME("DebuggerProcIdler"),
    PROC_YIELD,
    PROC_REPEAT(LoopDebuggerProc),
    PROC_END,
};
void SaveProcVarsToIdler(DebuggerProc * proc)
{
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    CopyProcVariables(procIdler, proc);
    Proc_End(proc);
}

void UnlockGameIfNeeded(void)
{
    int locked = GetGameLock();
    while (locked)
    {
        UnlockGame();
        locked = GetGameLock();
    }
}

extern struct ProcCmd * get_pProc_FromMiscActionProc[]; // 9A3604 (if value is 0x807A72D, then it is vanilla)

int TryCall_pProc_FromMiscActionProc(DebuggerProc * proc)
{
    if (!(int)*get_pProc_FromMiscActionProc)
    {
        UpdateActorFromBattle();
        return 1; // no address, so it's not a ProcCmd pointer
    }
    Proc_StartBlocking(*get_pProc_FromMiscActionProc, proc);
    return 0;
}
static void RestoreAnimViewerBMapGraphics(DebuggerProc * proc);
void ApplyUnitSpritePalettes(void); // 0x08026629
const struct ProcCmd DebuggerProcCmd[] = {
    PROC_NAME("DebuggerProcName"),
    PROC_YIELD,
    PROC_LABEL(InitProcLabel),
    // PROC_CALL(InitProc),
    PROC_LABEL(RestartLabel), // Menu

    PROC_CALL(UnlockGameIfNeeded), // failsafe
    PROC_CALL(EndPlayerPhaseSideWindows),
    PROC_SLEEP(1),
    PROC_WHILE(DoesBMXFADEExist),
    PROC_CALL(SetAllUnitNotBackSprite),
    PROC_CALL(RefreshUnitSprites),
    PROC_CALL_2(ClearActiveUnitStuff), // in case we didn't refresh units before restarting
    PROC_CALL(RestartDebuggerMenu),
    PROC_LABEL(LoopLabel), // Loop indefinitely
    PROC_REPEAT(LoopDebuggerProc),

    PROC_LABEL(UnitActionLabel),
    PROC_CALL(PlayerPhase_ApplyUnitMovementWithoutMenu),
    PROC_WHILE_EXISTS(gProcScr_CamMove),
    PROC_CALL_2(PlayerPhase_PrepareActionBasic),
    PROC_SLEEP(1),
    PROC_CALL_2(UnitActionFunc),

    PROC_LABEL(PostActionLabel), // after action
    PROC_CALL_2(HandlePostActionTraps),
    PROC_CALL_2(RunPotentialWaitEvents),
    PROC_CALL_2(EnsureCameraOntoActiveUnitPosition),
    PROC_CALL(CallPlayerPhase_FinishAction),
    PROC_GOTO(EndLabel),

    PROC_LABEL(PickupUnitLabel), // Pickup
    PROC_CALL(StartPlayerPhaseTerrainWindow),
    PROC_CALL(ResetUnitSpriteHover),
    PROC_REPEAT(PickupUnitIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(ChooseTileLabel), // Tile select
    PROC_CALL(ChooseTileInit),
    PROC_REPEAT(ChooseTileIdle),

    PROC_LABEL(EditMapLabel), // Map
    PROC_CALL(EditMapInit),
    PROC_REPEAT(EditMapIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(EditTrapLabel),
    PROC_CALL(EditTrapInit),
    PROC_REPEAT(EditTrapIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(EditStatsLabel), // Stats
    PROC_CALL(EditStatsInit),
    PROC_REPEAT(EditStatsIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(EditItemsLabel), // Items
    PROC_CALL(EditItemsInit),
    PROC_REPEAT(EditItemsIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(EditMiscLabel), // Class etc
    PROC_CALL(EditMiscInit),
    PROC_REPEAT(EditMiscIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(EditAiLabel),
    PROC_CALL(EditAiInit),
    PROC_REPEAT(EditAiIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(EditBgmLabel),
    PROC_CALL(EditBgmInit),
    PROC_REPEAT(EditBgmIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(LoadUnitsLabel), // Units
    PROC_CALL(LoadUnitsInit),
    PROC_REPEAT(LoadUnitsIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(LevelupLabel), // Levelup
    PROC_SLEEP(5),
    PROC_WHILE(BattleEventEngineExists),
    PROC_CALL(DeleteBattleAnimInfoThing),
    PROC_SLEEP(0x1),
    PROC_CALL(MapAnimProc_DisplayExpBar), // MapAnim_DisplayExpBar
    PROC_YIELD,
    PROC_CALL_2(TryCall_pProc_FromMiscActionProc), // to learn skills/moves from level up command
    PROC_YIELD,
    PROC_CALL(MapAnim_MoveCameraOntoSubject),
    PROC_SLEEP(0x2),
    // PROC_CALL(UpdateActorFromBattle),
    PROC_CALL(MapAnim_Cleanup),
    PROC_GOTO(RestartLabel),

    PROC_LABEL(StateLabel), // Unit state
    PROC_CALL(StateInit),
    PROC_REPEAT(StateIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(ChStateLabel), // Ch state
    PROC_CALL(ChStateInit),
    PROC_REPEAT(ChStateIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(WExpLabel), // Wexp
    PROC_CALL(EditWExpInit),
    PROC_REPEAT(EditWExpIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(SupportLabel), // Supports
    PROC_CALL(EditSupportsInit),
    PROC_REPEAT(EditSupportsIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(SupplyLabel), // Supply
    PROC_GOTO(EndLabel),

    PROC_LABEL(ListLabel), // List
    PROC_CALL(DebuggerListInit),
    PROC_SLEEP(1),
    PROC_CALL(ClearSomeGfx),
    PROC_GOTO(EndLabel),

    PROC_LABEL(GfxViewerLabel),
    PROC_CALL(GfxViewerInit),
    PROC_REPEAT(GfxViewerLoop),
    PROC_GOTO(EndLabel),

    PROC_LABEL(AnimViewerLabel),
    PROC_CALL(AnimViewerInit),
    PROC_REPEAT(AnimViewerLoop),
    PROC_CALL(RestoreAnimViewerBMapGraphics),
    PROC_GOTO(RestartLabel),

    PROC_LABEL(EndLabel),
    PROC_CALL_2(ClearActiveUnitStuff),
    PROC_CALL(SaveProcVarsToIdler),
    PROC_END,
};

extern void SetBlendConfig(u16 effect, u8 coeffA, u8 coeffB, u8 blendY);
extern u16 Pal_SpinningArrow[];
struct PrepItemSuppyText
{
    /* 00 */ struct Font font;
    /* 18 */ struct Text th[18];
};

int ShouldAIControlRemainingUnits(void)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmdIdler);
    if (!proc)
    {
        return false;
    }
    if (proc->autoplay)
    {
        return true;
    }
    return false;
}

void AiPhaseBerserkInit(struct Proc * proc)
{
    int i;

    gAiState.flags = AI_FLAG_BERSERKED;
    if (ShouldAIControlRemainingUnits())
    {
        gAiState.flags = AI_FLAG_0; // do not attack allies
    }
    gAiState.unk7E = -1;

    for (i = 0; i < 8; ++i)
        gAiState.unk86[i] = 0; // cmd_result

    gAiState.specialItemFlags = gAiItemConfigTable[gPlaySt.chapterIndex];

    UpdateAllPhaseHealingAIStatus();
    SetupUnitInventoryAIFlags();

    Proc_StartBlocking(gProcScr_BerserkCpOrder, proc);
}

void CpOrderBerserkInit(ProcPtr proc)
{
    int i, aiNum = 0;

    u32 faction = gPlaySt.faction;
    int AIControl = ShouldAIControlRemainingUnits();

    int factionUnitCountLut[3] = { 62, 20, 50 }; // TODO: named constant for those

    for (i = 0; i < factionUnitCountLut[faction >> 6]; ++i)
    {
        struct Unit * unit = GetUnit(faction + i + 1);

        if (!unit->pCharacterData)
            continue;

        if (!AIControl) // all units act this way, even if not berserked
        {
            if (unit->statusIndex != UNIT_STATUS_BERSERK)
            {
                continue;
            }
        }

        if (unit->state & (US_HIDDEN | US_UNSELECTABLE | US_DEAD | US_RESCUED | US_HAS_MOVED_AI))
            continue;

        gAiState.units[aiNum++] = faction + i + 1;
    }

    if (aiNum != 0)
    {
        gAiState.units[aiNum] = 0;
        gAiState.unitIt = gAiState.units;

        AiDecideMainFunc = AiDecideMain;

        Proc_StartBlocking(gProcScr_CpDecide, proc);
    }
}

extern struct PrepItemSuppyText PrepItemSuppyTexts;
#define _PrepItemSuppyTexts ((struct Unknown02013648 *)&PrepItemSuppyTexts)

// extern void RefreshBMapGraphics(void); // 80292dd 802E368
void ClearSomeGfx(DebuggerProc * proc)
{
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_Fill(gBG1TilemapBuffer, 0);
    BG_Fill(gBG2TilemapBuffer, 0);
    BG_Fill(gBG3TilemapBuffer, 0);

    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT | BG3_SYNC_BIT);
    SetupBackgrounds(0);
    BMapDispResume();
    RefreshBMapGraphics();
}

void Debugger_PrepItemList_Init(struct PrepItemListProc * proc)
{
    int i;

    proc->unk_36 = 0;
    proc->unk_34 = 0xff;
    proc->currentPage = 0;

    proc->scrollAmount = 4;
    proc->unitInvIdx = 0;

    for (i = 0; i < 9; i++)
    {
        proc->idxPerPage[i] = 0;
        proc->yOffsetPerPage[i] = 0;
    }

    return;
}

void Debugger_PrepItemList_OnEnd(struct PrepItemListProc * proc)
{
    EndAllProcChildren(proc);
    EndFaceById(0);
    EndMuralBackground_();

    return;
}

struct ProcCmd const DebuggerProcScr_PrepItemListScreen[] = {
    PROC_SLEEP(0),
    PROC_CALL(BMapDispSuspend),
    PROC_CALL(Debugger_PrepItemList_Init),
    PROC_LABEL(0),
    PROC_CALL(StartFastFadeToBlack),
    PROC_REPEAT(WaitForFade),
    PROC_CALL(PrepItemList_InitGfx),

    // fallthrough

    PROC_LABEL(1),
    PROC_CALL(sub_809F5F4),

    // fallthrough

    PROC_LABEL(2),
    PROC_REPEAT(PrepItemList_Loop_MainKeyHandler),

    // fallthrough

    PROC_LABEL(6),
    PROC_CALL_ARG(NewFadeOut, 16),
    PROC_WHILE(FadeOutExists),

    PROC_CALL(Debugger_PrepItemList_OnEnd),
    PROC_CALL(PrepItemList_StartTradeScreen),
    PROC_SLEEP(0),

    PROC_GOTO(0),

    PROC_LABEL(7),
    PROC_CALL(PrepItemList_SwitchToUnitInventory),
    PROC_REPEAT(PrepItemList_Loop_UnitInvKeyHandler),

    PROC_GOTO(1),

    PROC_LABEL(3),
    PROC_REPEAT(PrepItemList_SwitchPageLeft),

    // fallthrough

    PROC_LABEL(4),
    PROC_REPEAT(PrepItemList_SwitchPageRight),

    // fallthrough

    PROC_LABEL(8),
    PROC_CALL_ARG(NewFadeOut, 16),
    PROC_WHILE(FadeOutExists),

    // fallthrough

    PROC_LABEL(9),
    PROC_CALL(Debugger_PrepItemList_OnEnd),

    PROC_END,
};

void DebuggerListInit(DebuggerProc * parent)
{
    MU_EndAll();

    struct PrepItemListProc * proc = Proc_StartBlocking(DebuggerProcScr_PrepItemListScreen, parent);
    proc->unit = gActiveUnit;
}
void DebuggerListIdle(DebuggerProc * proc)
{
    return;
}

// const char* UnitStats
#define NumberOfOptions 9
#define NumberOfItems 5
#define START_X 19
#define Y_HAND 2
#define NUMBER_X 17
typedef const struct
{
    u32 x;
    u32 y;
} LocationTable;
static LocationTable CursorLocationTable[] = {
    //{(NUMBER_X*8) - (0 * 8) - 4, Y_HAND*8},
    { (START_X * 8) - (1 * 8) + 4, Y_HAND * 8 }, { (START_X * 8) - (2 * 8) + 4, Y_HAND * 8 },
    { (START_X * 8) - (3 * 8) + 4, Y_HAND * 8 }, { (START_X * 8) - (4 * 8) + 4, Y_HAND * 8 },
    { (START_X * 8) - (5 * 8) + 4, Y_HAND * 8 }, { (START_X * 8) - (6 * 8) + 4, Y_HAND * 8 },
    { (START_X * 8) - (7 * 8) + 4, Y_HAND * 8 }, { (START_X * 8) - (8 * 8) + 4, Y_HAND * 8 },
};

#define NumberOfState 32
#define StateWidth 7
static LocationTable StateCursorLocationTable[] = {
    //{(NUMBER_X*8) - (0 * 8) - 4, Y_HAND*8},
    { 8, 16 },
    { 8, 32 },
    { 8, 48 },
    { 8, 64 },
    { 8, 80 },
    { 8, 96 },
    { 8, 112 },
    { 8, 128 },
    { 8 + (8 * StateWidth), 16 },
    { 8 + (8 * StateWidth), 32 },
    { 8 + (8 * StateWidth), 48 },
    { 8 + (8 * StateWidth), 64 },
    { 8 + (8 * StateWidth), 80 },
    { 8 + (8 * StateWidth), 96 },
    { 8 + (8 * StateWidth), 112 },
    { 8 + (8 * StateWidth), 128 },
    { 8 + (16 * StateWidth), 16 },
    { 8 + (16 * StateWidth), 32 },
    { 8 + (16 * StateWidth), 48 },
    { 8 + (16 * StateWidth), 64 },
    { 8 + (16 * StateWidth), 80 },
    { 8 + (16 * StateWidth), 96 },
    { 8 + (16 * StateWidth), 112 },
    { 8 + (16 * StateWidth), 128 },
    { 8 + (24 * StateWidth), 16 },
    { 8 + (24 * StateWidth), 32 },
    { 8 + (24 * StateWidth), 48 },
    { 8 + (24 * StateWidth), 64 },
    { 8 + (24 * StateWidth), 80 },
    { 8 + (24 * StateWidth), 96 },
    { 8 + (24 * StateWidth), 112 },
    { 8 + (24 * StateWidth), 128 },
};

static const int DigitDecimalTable[] = { 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000 };

static const int DigitHexTable[] = { 0x1, 0x10, 0x100, 0x1000, 0x10000, 0x100000, 0x1000000, 0x10000000, 0x7fffffff };

static const int * pDigitTable[2] = { DigitDecimalTable, DigitHexTable };

static int GetMaxDigits(int number, int type)
{
    int result = 1;
    while (number > pDigitTable[type][result])
    {
        result++;
    }
    if (result > 9)
    {
        result = 9;
    }
    return result;
}

int GetMostSignificantDigit(int val, int type)
{
    int result = 0;
    while (val >= pDigitTable[type][result + 1])
    {
        result++;
    }
    if (result > 9)
    {
        result = 9;
    }
    return result;
}

#define StatWidth 4
void RedrawUnitStatsMenu(DebuggerProc * proc);

void FixCursorOverflow(void)
{
    int x = gBmSt.playerCursor.x;
    int y = gBmSt.playerCursor.y;
    if (x < 0)
    {
        gBmSt.playerCursor.x = 0;
        gActiveUnitMoveOrigin.x = 0;
    }
    if (y < 0)
    {
        gBmSt.playerCursor.y = 0;
        gActiveUnitMoveOrigin.y = 0;
    }
    if (x >= gBmMapSize.x)
    {
        x = gBmMapSize.x - 1;
        gBmSt.playerCursor.x = x;
        gActiveUnitMoveOrigin.x = x;
        gActiveUnit->xPos = x;
    }
    if (y >= gBmMapSize.y)
    {
        y = gBmMapSize.y - 1;
        gBmSt.playerCursor.y = y;
        gActiveUnitMoveOrigin.x = y;
        gActiveUnit->yPos = y;
    }
}

int IsCoordinateValid(int x, int y)
{
    if (x < 0)
    {
        return false;
    }
    if (y < 0)
    {
        return false;
    }
    if (x >= gBmMapSize.x)
    {
        return false;
    }
    if (y >= gBmMapSize.y)
    {
        return false;
    }
    return true;
}

s8 EnsureCameraOntoPositionIfValid(ProcPtr proc, int x, int y)
{
    if (!IsCoordinateValid(x, y))
    {
        return 0;
    }
    return EnsureCameraOntoPosition(proc, x, y);
}
void SetCursorMapPositionIfValid(int x, int y)
{
    if (!IsCoordinateValid(x, y))
    {
        return;
    }
    SetCursorMapPosition(x, y);
}

void SomeMenuInit(DebuggerProc * proc)
{
    ResetTextFont();
    SetTextFontGlyphs(0);
    //		ChapterStatus_SetupFont((void*)proc);

    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    ResetTextFont();
    SetTextFontGlyphs(0);
    SetTextFont(0);
    ClearBg0Bg1();
    ResetText();
}

void EditStatsInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    struct Unit * unit = proc->unit;
    proc->tmp[0] = unit->maxHP;
    proc->tmp[1] = unit->curHP;
    proc->tmp[2] = unit->pow;
    proc->tmp[3] = unit->skl;
    proc->tmp[4] = unit->spd;
    proc->tmp[5] = unit->def;
    proc->tmp[6] = unit->res;
    proc->tmp[7] = unit->lck;
    proc->tmp[8] = unit->_u3A;

    int x = NUMBER_X - StatWidth - 1;
    int y = Y_HAND - 2;
    int w = StatWidth + (START_X - NUMBER_X) + 3;
    int h = (NumberOfOptions * 2) + 2;

    DrawUiFrame(
        BG_GetMapBuffer(1),            // back BG
        x, y, w, h, TILEREF(0, 0), 0); // style as 0 ?

    // ClearUiFrame(
    //     BG_GetMapBuffer(1), // front BG
    //     x, y, w, h);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < 15; ++i)
    {
        InitText(&th[i], StatWidth);
    }
    int c = 0;
    Text_DrawString(&th[c], "Max HP");
    c++;
    Text_DrawString(&th[c], GetStringFromIndexSafe(0x4E9));
    c++;
    Text_DrawString(&th[c], GetStringFromIndexSafe(0x4FE));
    c++;
    Text_DrawString(&th[c], GetStringFromIndexSafe(0x4EC));
    c++;
    Text_DrawString(&th[c], GetStringFromIndexSafe(0x4ED));
    c++;
    Text_DrawString(&th[c], GetStringFromIndexSafe(0x4EF));
    c++;
    Text_DrawString(&th[c], GetStringFromIndexSafe(0x4F0));
    c++;
    Text_DrawString(&th[c], GetStringFromIndexSafe(0x4EE));
    c++;
    Text_DrawString(&th[c], GetStringFromIndexSafe(0x4FF));
    c++;

    RedrawUnitStatsMenu(proc);
}

void RedrawUnitStatsMenu(DebuggerProc * proc)
{
    TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X - 2, Y_HAND), 9, 2 * NumberOfOptions, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    // ResetText();
    struct Text * th = gStatScreen.text;
    int x = NUMBER_X - StatWidth;
    for (int i = 0; i < NumberOfOptions; ++i)
    {
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, (Y_HAND - 1) + (i * 2)));
    }

    for (int i = 0; i < NumberOfOptions; ++i)
    {
        PutNumber(
            gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND - 1 + (i * 2)), TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
    }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

static const u16 sSprite_VertHand[] = { 1, 0x0002, 0x4000, 0x0006 };
static const u8 sHandVOffsetLookup[] = {
    0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 3, 3, 2, 2, 2, 1, 1, 1, 1,
};
extern int sPrevHandClockFrame;
extern struct Vec2 sPrevHandScreenPosition;
static void DisplayVertUiHand(int x, int y)
{
    if ((int)(GetGameClock() - 1) == sPrevHandClockFrame)
    {
        x = (x + sPrevHandScreenPosition.x) >> 1;
        y = (y + sPrevHandScreenPosition.y) >> 1;
    }

    sPrevHandScreenPosition.x = x;
    sPrevHandScreenPosition.y = y;
    sPrevHandClockFrame = GetGameClock();

    y += (sHandVOffsetLookup[Mod(GetGameClock(), ARRAY_COUNT(sHandVOffsetLookup))] - 14);
    PutSprite(2, x, y, sSprite_VertHand, 0);
}

const s8 StatCapLookup[] = {
    99, 99, 63, 63, 63, 63, 63, 63, 63,
};

void SaveStats(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit;
    // int hpDiff = proc->tmp[0] - unit->maxHP;
    unit->maxHP = proc->tmp[0];
    // if (hpDiff) { unit->curHP += hpDiff; }
    unit->curHP = proc->tmp[1];
    unit->pow = proc->tmp[2];
    unit->skl = proc->tmp[3];
    unit->spd = proc->tmp[4];
    unit->def = proc->tmp[5];
    unit->res = proc->tmp[6];
    unit->lck = proc->tmp[7];
    unit->_u3A = proc->tmp[8];
}

void SaveItems(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit;
    for (int i = 0; i < NumberOfItems; ++i)
    {
        unit->items[i] = proc->tmp[i];
    }

    UnitRemoveInvalidItems(unit);
}

extern struct KeyStatusBuffer sKeyStatusBuffer;
void EditStatsIdle(DebuggerProc * proc)
{
    // DisplayVertUiHand(CursorLocationTable[proc->digit].x,
    // CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if (keys & B_BUTTON)
    { // press B to not save stats
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update stats and continue
        SaveStats(proc);
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if (proc->editing)
    {
        DisplayVertUiHand(CursorLocationTable[proc->digit].x, (Y_HAND - 1 + (proc->id * 2)) * 8);
        int max = StatCapLookup[proc->id];
        int min = 0;
        int max_digits = GetMaxDigits(max, 0);

        if (keys & DPAD_RIGHT)
        {
            if (proc->digit > 0)
            {
                proc->digit--;
            }
            else
            {
                proc->digit = max_digits - 1;
                proc->editing = false;
            }
            RedrawUnitStatsMenu(proc);
        }
        if (keys & DPAD_LEFT)
        {
            if (proc->digit < (max_digits - 1))
            {
                proc->digit++;
            }
            else
            {
                proc->digit = 0;
                proc->editing = false;
            }
            RedrawUnitStatsMenu(proc);
        }

        if (keys & DPAD_UP)
        {
            if (proc->tmp[proc->id] == max)
            {
                proc->tmp[proc->id] = min;
            }
            else
            {
                proc->tmp[proc->id] += DigitDecimalTable[proc->digit];
                if (proc->tmp[proc->id] > max)
                {
                    proc->tmp[proc->id] = max;
                }
            }
            RedrawUnitStatsMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {

            if (proc->tmp[proc->id] == min)
            {
                proc->tmp[proc->id] = max;
            }
            else
            {
                proc->tmp[proc->id] -= DigitDecimalTable[proc->digit];
                if (proc->tmp[proc->id] < min)
                {
                    proc->tmp[proc->id] = min;
                }
            }

            RedrawUnitStatsMenu(proc);
        }
    }
    else
    {
        DisplayUiHand(CursorLocationTable[0].x - ((StatWidth + 2) * 8), (Y_HAND - 1 + (proc->id * 2)) * 8);
        if (keys & DPAD_RIGHT)
        {
            proc->digit = 1;
            proc->editing = true;
        }
        if (keys & DPAD_LEFT)
        {
            proc->digit = 0;
            proc->editing = true;
        }

        if (keys & DPAD_UP)
        {
            proc->id--;
            if (proc->id < 0)
            {
                proc->id = NumberOfOptions - 1;
            }
            RedrawUnitStatsMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            proc->id++;
            if (proc->id >= NumberOfOptions)
            {
                proc->id = 0;
            }

            RedrawUnitStatsMenu(proc);
        }
    }
}

#define WExpWidth 11
#define WExpOptions 8
void RedrawUnitWExpMenu(DebuggerProc * proc);
void EditWExpInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    struct Unit * unit = proc->unit;
    for (int i = 0; i < WExpOptions; ++i)
    {
        proc->tmp[i] = unit->ranks[i];
    }

    int x = NUMBER_X - WExpWidth - 1;
    int y = Y_HAND - 1;
    int w = WExpWidth + (START_X - NUMBER_X) + 3;
    int h = (WExpOptions * 2) + 2;

    DrawUiFrame(
        BG_GetMapBuffer(1),            // back BG
        x, y, w, h, TILEREF(0, 0), 0); // style as 0 ?
    BG_EnableSyncByMask(BG2_SYNC_BIT);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < 15; ++i)
    {
        InitText(&th[i], WExpWidth);
    }
    for (int i = 0; i < WExpOptions; ++i)
    {
        x = Text_GetCursor(&th[i]);
        x++;
        Text_SetCursor(&th[i], x);
        Text_DrawString(&th[i], GetStringFromIndexSafe(0x505 + i));
    }
    RedrawUnitWExpMenu(proc);
}
extern int POKEMBLEM_EXISTS;
void DebuggerDisplayWeaponExp(int num, int x, int y, int wtype, int wexp)
{
    int progress, progressMax, color;

    // int wexp = gStatScreen.unit->ranks[wtype];

    if (POKEMBLEM_EXISTS)
    {

        DrawIcon(gBG0TilemapBuffer + TILEMAP_INDEX(x, y), GetItemIconId(wexp), TILEREF(0, 4));
    }

    else
    {
        // Display weapon type icon
        DrawIcon(
            gBG0TilemapBuffer + TILEMAP_INDEX(x, y),
            0x70 + wtype, // TODO: icon id definitions
            TILEREF(0, 5));
    }

    x += 4;

    color = wexp >= WPN_EXP_S ? TEXT_COLOR_SYSTEM_GREEN : TEXT_COLOR_SYSTEM_BLUE;

    // Display rank letter
    PutSpecialChar(gBG0TilemapBuffer + TILEMAP_INDEX(x + 4, y), color, GetDisplayRankStringFromExp(wexp));

    GetWeaponExpProgressState(wexp, &progress, &progressMax);

    DrawStatBarGfx(
        0x180 + num * 6, 5, gBG2TilemapBuffer + TILEMAP_INDEX(x + 2, y + 1), TILEREF(0, 1), 0x22,
        (progress * 34) / (progressMax - 1), 0);
}

void RedrawUnitWExpMenu(DebuggerProc * proc)
{
    LoadIconPalettes(4);
    TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X - 2, Y_HAND), 9, 2 * WExpOptions, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
    gLCDControlBuffer.bg1cnt.priority = 1;
    gLCDControlBuffer.bg2cnt.priority = 0;
    // ResetText();
    int c = 0;
    struct Text * th = gStatScreen.text;

    if (POKEMBLEM_EXISTS)
    {
        for (int i = 0; i < 5; ++i)
        {
            // x = Text_GetCursor(&th[i]);
            // x++;
            // Text_SetCursor(&th[i], x);
            ClearText(&th[i]);
            Text_DrawString(&th[i], GetItemName(proc->tmp[i]));
        }
    }

    c = 0;
    int x = (NUMBER_X - WExpWidth) + 2;
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c * 2)));
    c++;
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c * 2)));
    c++;
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c * 2)));
    c++;
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c * 2)));
    c++;
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c * 2)));
    c++;
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c * 2)));
    c++;
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c * 2)));
    c++;
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c * 2)));
    c++;

    for (int i = 0; i < WExpOptions; ++i)
    {
        // DisplayWeaponExp(i, x - 2, Y_HAND + (i * 2),
        // proc->tmp[i]); // first i is bar ID, second i is wep type ID
        DebuggerDisplayWeaponExp(
            i, x - 2, Y_HAND + (i * 2), i,
            proc->tmp[i]); // first i is bar ID, second i is wep type ID
        PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i * 2)), TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
    }

    SetBlendTargetA(0, 1, 0, 0, 0); // transparent ui
    SetBlendBackdropA(1);
    SetBlendAlpha(11, 5);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
}

void SaveWExp(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit;
    for (int i = 0; i < WExpOptions; ++i)
    {
        unit->ranks[i] = proc->tmp[i];
    }
}

void ClearTilesetRow(DebuggerProc * proc);
void EditWExpIdle(DebuggerProc * proc)
{
    // DisplayVertUiHand(CursorLocationTable[proc->digit].x,
    // CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if (keys & B_BUTTON)
    { // press B to not save WExp
        ClearTilesetRow(proc);
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update WExp and continue
        SaveWExp(proc);
        ClearTilesetRow(proc);
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if (proc->editing)
    {
        DisplayVertUiHand(CursorLocationTable[proc->digit].x, (Y_HAND + (proc->id * 2)) * 8);
        int max = 251;
        int min = 0;
        int max_digits = GetMaxDigits(max, 0);

        if (keys & DPAD_RIGHT)
        {
            if (proc->digit > 0)
            {
                proc->digit--;
            }
            else
            {
                proc->digit = max_digits - 1;
                proc->editing = false;
            }
            RedrawUnitWExpMenu(proc);
        }
        if (keys & DPAD_LEFT)
        {
            if (proc->digit < (max_digits - 1))
            {
                proc->digit++;
            }
            else
            {
                proc->digit = 0;
                proc->editing = false;
            }
            RedrawUnitWExpMenu(proc);
        }

        if (keys & DPAD_UP)
        {
            if (proc->tmp[proc->id] == max)
            {
                proc->tmp[proc->id] = min;
            }
            else
            {
                proc->tmp[proc->id] += DigitDecimalTable[proc->digit];
                if (proc->tmp[proc->id] > max)
                {
                    proc->tmp[proc->id] = max;
                }
            }
            RedrawUnitWExpMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {

            if (proc->tmp[proc->id] == min)
            {
                proc->tmp[proc->id] = max;
            }
            else
            {
                proc->tmp[proc->id] -= DigitDecimalTable[proc->digit];
                if (proc->tmp[proc->id] < min)
                {
                    proc->tmp[proc->id] = min;
                }
            }

            RedrawUnitWExpMenu(proc);
        }
    }
    else
    {
        DisplayUiHand(CursorLocationTable[0].x - ((WExpWidth + 2) * 8), (Y_HAND + (proc->id * 2)) * 8);
        if (keys & DPAD_RIGHT)
        {
            proc->digit = 1;
            proc->editing = true;
        }
        if (keys & DPAD_LEFT)
        {
            proc->digit = 0;
            proc->editing = true;
        }

        if (keys & DPAD_UP)
        {
            proc->id--;
            if (proc->id < 0)
            {
                proc->id = WExpOptions - 1;
            }
            RedrawUnitWExpMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            proc->id++;
            if (proc->id >= WExpOptions)
            {
                proc->id = 0;
            }

            RedrawUnitWExpMenu(proc);
        }
    }
}

#define SupportWidth 5
#define SupportOptions 7
void RedrawUnitSupportsMenu(DebuggerProc * proc);
void EditSupportsInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    struct Unit * unit = proc->unit;
    for (int i = 0; i < SupportOptions; ++i)
    {
        proc->tmp[i] = unit->supports[i];
    }

    int x = NUMBER_X - SupportWidth - 1;
    int y = Y_HAND - 1;
    int w = SupportWidth + (START_X - NUMBER_X) + 3;
    int h = (SupportOptions * 2) + 2;

    DrawUiFrame(
        BG_GetMapBuffer(1),            // back BG
        x, y, w, h, TILEREF(0, 0), 0); // style as 0 ?

    // ClearUiFrame(
    //     BG_GetMapBuffer(1), // front BG
    //     x, y, w, h);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < 15; ++i)
    {
        InitText(&th[i], SupportWidth);
        Text_DrawString(&th[i], "");
    }

    if (unit->pCharacterData->pSupportData)
    {
        int uid;
        for (int i = 0; i < SupportOptions; ++i)
        {
            uid = unit->pCharacterData->pSupportData->characters[i];
            if (uid)
            {
                Text_DrawString(&th[i], GetStringFromIndexSafe(GetCharacterData(uid)->nameTextId));
            }
        }
    }
    RedrawUnitSupportsMenu(proc);
}

void RedrawUnitSupportsMenu(DebuggerProc * proc)
{
    TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X - 2, Y_HAND), 9, 2 * SupportOptions, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    // ResetText();
    struct Text * th = gStatScreen.text;
    int x = NUMBER_X - SupportWidth;
    for (int i = 0; i < SupportOptions; ++i)
    {
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (i * 2)));
    }

    for (int i = 0; i < SupportOptions; ++i)
    {
        PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i * 2)), TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
    }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

void SaveSupports(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit;
    for (int i = 0; i < SupportOptions; ++i)
    {
        unit->supports[i] = proc->tmp[i];
    }
}

void EditSupportsIdle(DebuggerProc * proc)
{
    // DisplayVertUiHand(CursorLocationTable[proc->digit].x,
    // CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if (keys & B_BUTTON)
    { // press B to not save Supports
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update Supports and continue
        SaveSupports(proc);
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if (proc->editing)
    {
        DisplayVertUiHand(CursorLocationTable[proc->digit].x, (Y_HAND + (proc->id * 2)) * 8);
        int max = 255;
        int min = 0;
        int max_digits = GetMaxDigits(max, 0);

        if (keys & DPAD_RIGHT)
        {
            if (proc->digit > 0)
            {
                proc->digit--;
            }
            else
            {
                proc->digit = max_digits - 1;
                proc->editing = false;
            }
            RedrawUnitSupportsMenu(proc);
        }
        if (keys & DPAD_LEFT)
        {
            if (proc->digit < (max_digits - 1))
            {
                proc->digit++;
            }
            else
            {
                proc->digit = 0;
                proc->editing = false;
            }
            RedrawUnitSupportsMenu(proc);
        }

        if (keys & DPAD_UP)
        {
            if (proc->tmp[proc->id] == max)
            {
                proc->tmp[proc->id] = min;
            }
            else
            {
                proc->tmp[proc->id] += DigitDecimalTable[proc->digit];
                if (proc->tmp[proc->id] > max)
                {
                    proc->tmp[proc->id] = max;
                }
            }
            RedrawUnitSupportsMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {

            if (proc->tmp[proc->id] == min)
            {
                proc->tmp[proc->id] = max;
            }
            else
            {
                proc->tmp[proc->id] -= DigitDecimalTable[proc->digit];
                if (proc->tmp[proc->id] < min)
                {
                    proc->tmp[proc->id] = min;
                }
            }

            RedrawUnitSupportsMenu(proc);
        }
    }
    else
    {
        DisplayUiHand(CursorLocationTable[0].x - ((SupportWidth + 2) * 8), (Y_HAND + (proc->id * 2)) * 8);
        if (keys & DPAD_RIGHT)
        {
            proc->digit = 1;
            proc->editing = true;
        }
        if (keys & DPAD_LEFT)
        {
            proc->digit = 0;
            proc->editing = true;
        }

        if (keys & DPAD_UP)
        {
            proc->id--;
            if (proc->id < 0)
            {
                proc->id = SupportOptions - 1;
            }
            RedrawUnitSupportsMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            proc->id++;
            if (proc->id >= SupportOptions)
            {
                proc->id = 0;
            }

            RedrawUnitSupportsMenu(proc);
        }
    }
}

static const char states[32][16] = {
    "Acting",  "Acted",        "Dead",       "Undeployed",  "Rescuing",  "Rescued",     "Cantoed",    "Under roof",
    "Spotted", "Concealed",    "AI decided", "In ballista", "Drop item", "Afa's drops", "Solo anim1", "Solo anim2",
    "Escaped", "Arena 1",      "Arena 2",    "Super arena", "Unk 25",    "Benched",     "Scene unit", "Portrait+1",
    "Shake",   "Can't deploy", "Departed",   "4th palette", "Unk 35",    "Unk 36",      "Capture",    "Unk 38",
};

void StateInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    struct Unit * unit = proc->unit;
    proc->tmp[0] = unit->state;
    proc->tmp[1] = unit->state >> 16;

    int x = 1;
    int y = 1;
    int w = 29; // StatWidth + (START_X - NUMBER_X) + 3;
    int h = 18; //(NumberOfOptions * 2) + 2;

    DrawUiFrame(
        BG_GetMapBuffer(1),            // back BG
        x, y, w, h, TILEREF(0, 0), 0); // style as 0 ?

    // ClearUiFrame(
    //     BG_GetMapBuffer(1), // front BG
    //     x, y, w, h);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < NumberOfState; ++i)
    {
        InitText(&th[i], StateWidth);
        Text_DrawString(&th[i], states[i]);
    }
    StartGreenText(proc);
    RedrawStateMenu(proc);
}

void RedrawStateMenu(DebuggerProc * proc)
{
    TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X - 2, Y_HAND), 9, 2 * NumberOfOptions, 0);
    // BG_EnableSyncByMask(BG0_SYNC_BIT);
    // ResetText();
    int c = 0;
    struct Text * th = gStatScreen.text;

    u32 state = proc->tmp[0] | (proc->tmp[1] << 16);

    for (int i = 0; i < NumberOfState; ++i)
    {
        c = state & (1 << i);
        if (c)
        {
            c = TEXT_COLOR_SYSTEM_GOLD;
        }

        if (Text_GetColor(&th[i]) != c)
        {
            ClearText(&th[i]);
            Text_SetColor(&th[i], c);
            Text_DrawString(&th[i], states[i]);
        }
    }
    c = 0;
    int x = 2;
    int y = 2;
    for (int i = 0; i < 8; ++i)
    {
        PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, y + (i * 2)));
        c++;
    }
    x += StateWidth;
    for (int i = 0; i < 8; ++i)
    {
        PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, y + (i * 2)));
        c++;
    }
    x += StateWidth;
    for (int i = 0; i < 8; ++i)
    {
        PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, y + (i * 2)));
        c++;
    }
    x += StateWidth;
    for (int i = 0; i < 8; ++i)
    {
        PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, y + (i * 2)));
        c++;
    }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}
void SaveState(DebuggerProc * proc)
{
    u32 state = proc->tmp[0] | (proc->tmp[1] << 16);
    proc->unit->state = state;
}

void StateIdle(DebuggerProc * proc)
{
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if ((keys & START_BUTTON) || (keys & B_BUTTON))
    { // press B or Start to update state and continue

        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    }
    u32 id = proc->id;
    if ((keys & A_BUTTON))
    { // press B or Start to update state and continue
        u32 state = proc->tmp[0] | (proc->tmp[1] << 16);
        state ^= (1 << id);
        // state = (state & (1 << id)) | ~(state & (1 << id));

        proc->tmp[0] = state & 0xffff;
        proc->tmp[1] = state >> 16;
        SaveState(proc);
        RedrawStateMenu(proc);
    }

    DisplayUiHand(StateCursorLocationTable[id].x, StateCursorLocationTable[id].y);

    if (keys & DPAD_RIGHT)
    {
        id += 8;
    }
    if (keys & DPAD_LEFT)
    {
        id -= 8;
    }
    if (keys & DPAD_UP)
    {
        if (!(id % 8))
        {
            id += 8;
        }
        id--;
    }
    if (keys & DPAD_DOWN)
    {

        id++;
        if (!(id % 8))
        {
            id -= 8;
        }
    }

    if (id != (int)proc->id)
    {
        id %= 32;
        proc->id = id;
        RedrawStateMenu(proc);
    }
}

#define ItemNameWidth 8
void EditItemsInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    LoadIconPalettes(4);
    struct Unit * unit = proc->unit;
    for (int i = 0; i < NumberOfItems; ++i)
    {
        proc->tmp[i] = unit->items[i];
    }

    int x = NUMBER_X - ItemNameWidth - 3;
    int y = Y_HAND - 1;
    int w = ItemNameWidth + (START_X - NUMBER_X) + 8;
    int h = (NumberOfItems * 2) + 2;

    DrawUiFrame(
        BG_GetMapBuffer(1),            // back BG
        x, y, w, h, TILEREF(0, 0), 0); // style as 0 ?

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < NumberOfItems; ++i)
    {
        InitText(&th[i], ItemNameWidth);
    }

    RedrawItemMenu(proc);
}

void RedrawItemMenu(DebuggerProc * proc)
{
    // TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-2, Y_HAND), 9,
    // 2 * NumberOfItems, 0);
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    ResetIconGraphics();
    // ResetText();
    const struct ItemData * itemData[5];
    struct Text * th = gStatScreen.text;
    for (int i = 0; i < NumberOfItems; ++i)
    {
        itemData[i] = GetItemData(proc->tmp[i] & 0xFF);
    }
    char * str;
    for (int i = 0; i < NumberOfItems; ++i)
    {
        ClearText(&th[i]);
        if (proc->tmp[i])
        {
            // Text_DrawString(&th[i], GetStringFromIndexSafe(itemData[i]->nameTextId));
            if (GetItemDescId(proc->tmp[i] & 0xFFFF) < 0x4000) // safety check to try and avoid crashing
            {
                str = GetItemName(proc->tmp[i] & 0xFFFF);
                if (str && *str)
                {
                    Text_DrawString(&th[i], str); // fix for durability based item names
                }
            }
        }
    }

    int x = NUMBER_X - (ItemNameWidth);
    for (int i = 0; i < NumberOfItems; ++i)
    {
        if (proc->tmp[i])
        {
            PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (i * 2)));
        }
    }
    int n = 0;
    for (int i = 0; i < NumberOfItems; ++i)
    { // item id
        if (proc->tmp[i])
        {
            n = itemData[i]->number;
        }
        else
        {
            n = 0;
        }
        PutNumberHex(gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i * 2)), TEXT_COLOR_SYSTEM_GOLD, n);
    }

    for (int i = 0; i < NumberOfItems; ++i)
    { // uses
        if (proc->tmp[i])
        {
            n = (proc->tmp[i] & 0xFF00) >> 8;
        }
        else
        {
            n = 0;
        }
        PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 3, Y_HAND + (i * 2)), TEXT_COLOR_SYSTEM_GOLD, n);
    }

    int icon;

    for (int i = 0; i < NumberOfItems; ++i)
    {

        icon =
            GetItemIconId(proc->tmp[i] & 0xFFFF); // 0xFFFF because Durability based items expects short, not word fsr
        if (icon >= 0)
        {
            if (proc->tmp[i])
            {
                DrawIcon(TILEMAP_LOCATED(gBG0TilemapBuffer, x - 2, Y_HAND + (i * 2)), icon, 0x4000);
            }
        }
    }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

static int GetMaxItems(void);
void EditItemsIdle(DebuggerProc * proc)
{
    // DisplayVertUiHand(CursorLocationTable[proc->digit].x,
    // CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if (keys & B_BUTTON)
    { // press B to not save stats
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update stats and continue
        SaveItems(proc);
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if (proc->editing)
    {
        if (proc->editing == 1)
        {
            DisplayVertUiHand(CursorLocationTable[proc->digit].x, (Y_HAND + (proc->id * 2)) * 8);
            int max = GetMaxItems();
            int min = 0;
            int max_digits = GetMaxDigits(max, 1);
            int val = 0;

            if (keys & DPAD_RIGHT)
            {
                if (proc->digit > 0)
                {
                    proc->digit--;
                }
                else
                {
                    proc->digit = max_digits - 1;
                    proc->editing = 2;
                    proc->digit = 1;
                }
                RedrawItemMenu(proc);
            }
            if (keys & DPAD_LEFT)
            {
                if (proc->digit < (max_digits - 1))
                {
                    proc->digit++;
                }
                else
                {
                    proc->digit = 0;
                    proc->editing = false;
                }
                RedrawItemMenu(proc);
            }

            if (keys & DPAD_UP)
            {
                if ((proc->tmp[proc->id] & 0xFF) == max)
                {
                    proc->tmp[proc->id] = min | (proc->tmp[proc->id] & 0xFF00);
                }
                else
                {
                    proc->tmp[proc->id] += pDigitTable[1][proc->digit];
                    if ((proc->tmp[proc->id] & 0xFF) > max)
                    {
                        proc->tmp[proc->id] = max | (proc->tmp[proc->id] & 0xFF00);
                    }
                }
                proc->tmp[proc->id] = MakeNewItem(proc->tmp[proc->id] & 0xFF);
                RedrawItemMenu(proc);
            }
            if (keys & DPAD_DOWN)
            {
                if ((proc->tmp[proc->id] & 0xFF) == min)
                {
                    proc->tmp[proc->id] = max | (proc->tmp[proc->id] & 0xFF00);
                }
                else
                {
                    val = (proc->tmp[proc->id] & 0xFF) - pDigitTable[1][proc->digit];
                    if (val < min)
                    {
                        proc->tmp[proc->id] = min | (proc->tmp[proc->id] & 0xFF00);
                    }
                    else
                    {
                        proc->tmp[proc->id] = val | (proc->tmp[proc->id] & 0xFF00);
                    }
                }
                proc->tmp[proc->id] = MakeNewItem(proc->tmp[proc->id] & 0xFF);
                RedrawItemMenu(proc);
            }
        }
        else
        {
            DisplayVertUiHand(CursorLocationTable[proc->digit].x + (3 * 8), (Y_HAND + (proc->id * 2)) * 8);
            int max = 255 << 8; // skill scrolls
            int min = 0 << 8;
            int max_digits = GetMaxDigits(max >> 8, 0);

            if (keys & DPAD_RIGHT)
            {
                if (proc->digit > 0)
                {
                    proc->digit--;
                }
                else
                {
                    proc->digit = max_digits - 1;
                    proc->editing = false;
                }
                RedrawItemMenu(proc);
            }
            if (keys & DPAD_LEFT)
            {
                if (proc->digit < (max_digits - 1))
                {
                    proc->digit++;
                }
                else
                {
                    proc->digit = 0;
                    proc->editing = 1;
                    proc->digit = 0;
                }
                RedrawItemMenu(proc);
            }

            if (keys & DPAD_UP)
            {
                if ((proc->tmp[proc->id] & 0xFF00) == max)
                {
                    proc->tmp[proc->id] = min | (proc->tmp[proc->id] & 0xFF);
                }
                else
                {
                    proc->tmp[proc->id] += DigitDecimalTable[proc->digit] << 8;
                    if ((proc->tmp[proc->id] & 0xFF00) > max)
                    {
                        proc->tmp[proc->id] = max | (proc->tmp[proc->id] & 0xFF);
                    }
                }
                RedrawItemMenu(proc);
            }
            if (keys & DPAD_DOWN)
            {

                if ((proc->tmp[proc->id] & 0xFF00) == min)
                {
                    proc->tmp[proc->id] = max | (proc->tmp[proc->id] & 0xFF);
                }
                else
                {
                    proc->tmp[proc->id] -= DigitDecimalTable[proc->digit] << 8;
                    if ((proc->tmp[proc->id] & 0xFF00) < min)
                    {
                        proc->tmp[proc->id] = min | (proc->tmp[proc->id] & 0xFF);
                    }
                }

                RedrawItemMenu(proc);
            }
        }
    }
    else
    {
        DisplayUiHand(CursorLocationTable[0].x - ((ItemNameWidth + 4) * 8), (Y_HAND + (proc->id * 2)) * 8);
        if (keys & DPAD_RIGHT)
        {
            proc->digit = 1;
            proc->editing = true;
        }
        if (keys & DPAD_LEFT)
        {
            proc->digit = 0;
            proc->editing = 2;
        }

        if (keys & DPAD_UP)
        {
            proc->id--;
            if (proc->id < 0)
            {
                proc->id = NumberOfItems - 1;
            }
            RedrawItemMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            proc->id++;
            if (proc->id >= NumberOfItems)
            {
                proc->id = 0;
            }

            RedrawItemMenu(proc);
        }
    }
}

#define NumberOfChState 8
#define ChStateNameWidth 11

void GotoChapter(int id)
{
    SetNextChapterId(id);
    gPlaySt.save_menu_type = 2;
    SetNextGameActionId(GAME_ACTION_USR_SKIPPED);

    DeleteAll6CWaitMusicRelated();
    Sound_FadeOutBGM(4);
    SetTextFont(NULL);
    InitSystemTextFont();
    LoadUiFrameGraphics();
    ReadGameSaveCoreGfx();
    UnpackChapterMapPalette();
    // ChangeUnitSpritePalette(proc->mapSpritePalIdOverride);
    MU_EndAll();
    EndBMapMain();
    // memset((u8*)(gEventCallQueue), 0, 0x80);
}

void LomaChapter(int id)
{
    gPlaySt.chapterIndex = id;
    RestartBattleMap();
    int x = 0;
    int y = 0;
    gBmSt.camera.x = GetCameraCenteredX(x * 16);
    gBmSt.camera.y = GetCameraCenteredY(y * 16);

    RefreshEntityBmMaps();
    RenderBmMap();
    RefreshUnitSprites();
    RefreshBMapGraphics();

    // ChangeUnitSpritePalette(proc->mapSpritePalIdOverride);

    BG_Fill(gBG0TilemapBuffer, 0);
    BG_Fill(gBG1TilemapBuffer, 0);

    BG_EnableSyncByMask(BG0_SYNC_BIT);
    BG_EnableSyncByMask(BG1_SYNC_BIT);
    FixCursorOverflow();
}

extern void WfxInit(void);
void SaveChState(DebuggerProc * proc)
{
    gPlaySt.partyGoldAmount = proc->gold;
    gPlaySt.chapterTurnNumber = proc->tmp[5];
    if (gPlaySt.chapterWeatherId != proc->tmp[1])
    {
        gPlaySt.chapterWeatherId = 0;
        WfxInit(); // WfxNone_Init();
        SetWeather(proc->tmp[1]);
        InitBmBgLayers();
        UnpackChapterMapGraphics(gPlaySt.chapterIndex);
        RenderBmMap();
        RefreshUnitSprites();
    }

    if (gPlaySt.chapterVisionRange != proc->tmp[2])
    { // fix?
        gPlaySt.chapterVisionRange = proc->tmp[2];
        RefreshEntityBmMaps();
        RefreshUnitSprites();
        RenderBmMap();
    }
    if (proc->id == 3)
    { // mnc 2
        GotoChapter(proc->tmp[3]);
        Proc_End(proc);
        return;
    }
    if (proc->id == 4)
    {
        LomaChapter(proc->tmp[4]); // loma
    }

    proc->lastFlag = proc->tmp[6];
    if (proc->id == 7)
    { // save & restart ch
        GotoChapter(gPlaySt.chapterIndex);
        Proc_End(proc);
        return;
    }

    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    procIdler->lastFlag = proc->lastFlag;
}

static const char chStates[][24] = {
    "Gold",  "Weather",           "Fog", "Jump to ch.", "Loma to ch.", "Turn",
    "Flags", "Save & restart ch."
    // clear ch
    // Preparations
};

static const char weatherStates[][16] = {
    "Clear", "Snowy", "Blizzard", "Night", "Rainy", "Volcano", "Sandstorm", "Cloudy",
};

void RedrawChStateMenu(DebuggerProc * proc);
void ChStateInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    LoadIconPalettes(4);
    // struct Unit* unit = proc->unit;
    for (int i = 0; i < NumberOfChState; ++i)
    {
        proc->tmp[i] = 0;
    }
    proc->gold = gPlaySt.partyGoldAmount; // gold can be bigger than u16
    proc->tmp[1] = gPlaySt.chapterWeatherId;
    proc->tmp[2] = gPlaySt.chapterVisionRange;
    proc->tmp[3] = gPlaySt.chapterIndex;
    proc->tmp[4] = gPlaySt.chapterIndex;
    proc->tmp[5] = gPlaySt.chapterTurnNumber;
    proc->tmp[6] = proc->lastFlag;
    proc->tmp[7] = proc->lastFlag; // unused

    int x = 2;
    int y = Y_HAND - 1;
    int w = ChStateNameWidth + (START_X - NUMBER_X) + 10;
    int h = (NumberOfChState * 2) + 2;

    DrawUiFrame(
        BG_GetMapBuffer(1),            // back BG
        x, y, w, h, TILEREF(0, 0), 0); // style as 0 ?

    struct Text * th = gStatScreen.text;
    int i = 0;
    for (i = 0; i < (NumberOfChState); ++i)
    {
        InitText(&th[i], ChStateNameWidth);
    }
    InitText(&th[i], ChStateNameWidth);
    i++;
    InitText(&th[i], ChStateNameWidth + 4);
    i++;
    InitText(&th[i], ChStateNameWidth + 4);
    i++;

    RedrawChStateMenu(proc);
    // StartGreenText(proc);
}

//"Gold",
//"Weather",
//"Fog",
//"Jump to ch.", // hex
//"Loma to ch.", //hex
//"Turn",
//"Flags", //hex
//"Save & restart" //n/a
static const s8 chStateHexOrDecimal[] = { 0, 0, 0, 1, 1, 0, 1, -1 };
static const int chStateMax[] = { 999999, 7, 4, 0x4E, 0x4E, 999, 0x12C, 0 };
static const int chStateMin[] = { 0, 0, 0, 0, 0, 0, 0, 0 };

// Because users repoint these tables, use pointers to them instead of the vanilla address of tables
extern struct ROMChapterData const * const sChapterDataTable;
inline static struct ROMChapterData const * GetRomChData(int id)
{
    return sChapterDataTable + id;
}
int CountMaxCh(void)
{
    const struct ROMChapterData * data;
    int i = 0;
    int tmp;
    for (; i < 255; ++i)
    {
        data = GetRomChData(i);
        tmp = (int)data->internalName;
        if (!tmp || (tmp == (-1)))
        {
            i--;
            break;
        }
    }
    return i;
}

int GetChStateMax(int id)
{
    switch (id)
    {
        case 3:
        case 4:
        {
            return CountMaxCh();
        }
        default:
    }
    return chStateMax[id];
}
int GetChStateMin(int id)
{
    return chStateMin[id];
}

void RedrawChStateMenu(DebuggerProc * proc)
{
    // TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-2, Y_HAND), 9,
    // 2 * NumberOfMisc, 0);
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    ResetIconGraphics();
    // ResetText();
    // struct Unit* unit = proc->unit;
    struct Text * th = gStatScreen.text;
    int i = 0;
    for (i = 0; i < (NumberOfChState); ++i)
    {
        ClearText(&th[i]);
        Text_DrawString(&th[i], chStates[i]);
    }
    ClearText(&th[i]);
    Text_DrawString(&th[i], weatherStates[proc->tmp[1]]);
    i++;
    ClearText(&th[i]);
    Text_DrawString(&th[i], GetStringFromIndexSafe(GetROMChapterStruct(proc->tmp[3])->chapTitleTextId));
    i++;
    ClearText(&th[i]);
    Text_DrawString(&th[i], GetStringFromIndexSafe(GetROMChapterStruct(proc->tmp[4])->chapTitleTextId));
    i++;

    int x = 3;
    for (i = 0; i < NumberOfChState; ++i)
    {
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (i * 2)));
    }

    x += ChStateNameWidth - 4;
    PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (2)));
    i++; // weather type
    PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (6)));
    i++; // ch
    PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (8)));
    i++; // ch

    PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 4, Y_HAND), TEXT_COLOR_SYSTEM_GOLD, proc->gold);

    int hexOrDec = 0;
    int col = TEXT_COLOR_SYSTEM_WHITE;
    for (i = 1; i < NumberOfChState; ++i)
    {
        col = TEXT_COLOR_SYSTEM_WHITE;
        if (i == 6)
        { // flags
            col = CheckFlag(proc->tmp[i]);
            if (col)
            {
                col = TEXT_COLOR_SYSTEM_GOLD;
            }
            else
            {
                col = TEXT_COLOR_SYSTEM_WHITE;
            }
        }
        hexOrDec = chStateHexOrDecimal[i];
        if (hexOrDec < 0)
        {
            continue;
        }
        if (hexOrDec)
        {
            PutNumberHex(gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 4, Y_HAND + (i * 2)), col, proc->tmp[i]);
        }
        else
        {
            PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 4, Y_HAND + (i * 2)), col, proc->tmp[i]);
        }
    }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

void ChStateIdle(DebuggerProc * proc)
{
    // DisplayVertUiHand(CursorLocationTable[proc->digit].x,
    // CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if (keys & B_BUTTON)
    { // press B to not save ch state
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update ch state and continue
        SaveChState(proc);
        if (proc->id != 6)
        {
            Proc_Goto(proc, RestartLabel);
            BackPressSFX();
        }
        else
        { // flags
            int flag = proc->tmp[6];
            if (CheckFlag(flag))
            {
                ClearFlag(flag);
            }
            else
            {
                SetFlag(flag);
            }
            RedrawChStateMenu(proc);
        }
    };
    int id = proc->id;
    int type = chStateHexOrDecimal[id];
    int val = proc->tmp[id];
    if (!id)
    {
        val = proc->gold;
    }

    if (proc->editing && (type >= 0))
    {
        DisplayVertUiHand(CursorLocationTable[proc->digit].x + 32, (Y_HAND + (id * 2)) * 8);
        int max = GetChStateMax(id);
        int min = GetChStateMin(id);
        int max_digits = GetMaxDigits(max, type);

        if (keys & DPAD_RIGHT)
        {
            if (proc->digit > 0)
            {
                proc->digit--;
            }
            else
            {
                proc->digit = max_digits - 1;
                proc->editing = false;
            }
            RedrawChStateMenu(proc);
        }
        if (keys & DPAD_LEFT)
        {
            if (proc->digit < (max_digits - 1))
            {
                proc->digit++;
            }
            else
            {
                proc->digit = 0;
                proc->editing = false;
            }
            RedrawChStateMenu(proc);
        }

        if (keys & DPAD_UP)
        {
            if (!id)
            { // gold
                if ((proc->gold) == max)
                {
                    proc->gold = min;
                }
                else
                {
                    proc->gold += pDigitTable[type][proc->digit];
                    if ((proc->gold) > max)
                    {
                        proc->gold = max;
                    }
                }
            }
            else
            {
                if ((proc->tmp[id]) == max)
                {
                    proc->tmp[id] = min;
                }
                else
                {
                    proc->tmp[id] += pDigitTable[type][proc->digit];
                    if ((proc->tmp[id]) > max)
                    {
                        proc->tmp[id] = max;
                    }
                }
            }
            RedrawChStateMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            if (!id)
            { // gold
                if ((proc->gold) == min)
                {
                    proc->gold = max;
                }
                else
                {
                    val = (proc->gold) - pDigitTable[type][proc->digit];
                    if (val < min)
                    {
                        proc->gold = min;
                    }
                    else
                    {
                        proc->gold = val;
                    }
                }
            }
            else
            { // not gold
                if ((proc->tmp[id]) == min)
                {
                    proc->tmp[id] = max;
                }
                else
                {
                    val = (proc->tmp[id]) - pDigitTable[type][proc->digit];
                    if (val < min)
                    {
                        proc->tmp[id] = min;
                    }
                    else
                    {
                        proc->tmp[id] = val;
                    }
                }
            }
            RedrawChStateMenu(proc);
        }
    }
    else
    {
        DisplayUiHand(CursorLocationTable[0].x - ((ChStateNameWidth + 5) * 8), (Y_HAND + (id * 2)) * 8);
        if (keys & DPAD_RIGHT)
        {
            proc->digit = GetMostSignificantDigit(val, type);
            proc->editing = true;
        }
        if (keys & DPAD_LEFT)
        {
            proc->digit = 0;
            proc->editing = true;
        }

        if (keys & DPAD_UP)
        {
            proc->id--;
            if (proc->id < 0)
            {
                proc->id = NumberOfChState - 1;
            }
            RedrawChStateMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            proc->id++;
            if (proc->id >= NumberOfChState)
            {
                proc->id = 0;
            }

            RedrawChStateMenu(proc);
        }
    }
}

#define NumberOfMisc 8
#define MiscNameWidth 6

void AdjustWEXPForClass(struct Unit * unit, int classID)
{
    if (unit->pClassData->number == classID)
    {
        return;
    }
    const struct ClassData * table = GetClassData(classID);
    unit->pClassData = table;
    int classRank;
    int charRank;
    for (int i = 0; i < 8; ++i)
    {
        classRank = table->baseRanks[i];
        if (!classRank) // new class has no rank
        {
            // if (unit->pCharacterData->baseRanks[i] >= unit->ranks[i])
            // {
            // unit->ranks[i] = unit->pCharacterData->baseRanks[i]; // set to character wexp if higher than current
            // }
            // else
            // {
            unit->ranks[i] = 0; // zero out wexp
            // }
        }
        else if (classRank > unit->ranks[i])
        {
            unit->ranks[i] = classRank;
            charRank = unit->pCharacterData->baseRanks[i];
            if (charRank > unit->ranks[i])
            {
                unit->ranks[i] = charRank;
            }
        }
    }
}

struct Unit * GetFreeUnitByFaction(int faction)
{
    int i = faction, last = faction + 0x40;
    if (!i)
        i = 1;

    for (; i < last; ++i)
    {
        struct Unit * unit = GetUnit(i);

        if (unit->pCharacterData == NULL)
            return unit;
    }

    return NULL;
}

void UnitBeginActionInit(struct Unit * unit);
// void memcpy(const void * src, void * dst, int size);
#include <string.h>                        // for memcpy
extern void ClearUnit(struct Unit * unit); // 17508 17394
void SaveMisc(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit;

    unit->pCharacterData = GetCharacterData(proc->tmp[0]);
    AdjustWEXPForClass(unit, proc->tmp[1]);

    unit->level = proc->tmp[2];
    unit->exp = proc->tmp[3] & 0xFF;
    unit->conBonus = proc->tmp[4];
    unit->movBonus = proc->tmp[5];
    if (UNIT_MOV(unit) > 15)
    {
        unit->movBonus = 15 - UNIT_MOV_BASE(unit);
    }
    unit->statusIndex = proc->tmp[6] & 0xF;
    unit->statusDuration = proc->tmp[8];
    if (unit->statusIndex && !unit->statusDuration)
    {
        unit->statusDuration = 5;
    }
    if (!unit->statusIndex)
    {
        unit->statusDuration = 0;
    }

    if (proc->tmp[7] != (unit->index & 0xC0))
    {
        struct Unit * newUnit = GetFreeUnitByFaction(proc->tmp[7] << 6);
        if (!newUnit)
        {
            return;
        }
        int deploymentID = newUnit->index;
        memcpy((void *)newUnit, (void *)unit, sizeof(struct Unit));
        ClearUnit(unit);

        newUnit->index = deploymentID; // copy unit into a free slot in unit struct ram

        UnitBeginActionInit(newUnit);
        proc->unit = newUnit;
        // PlayerPhase_FinishActionNoCanto(proc);
    }
}

void RedrawMiscMenu(DebuggerProc * proc);
void EditMiscInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    LoadIconPalettes(4);
    struct Unit * unit = proc->unit;
    for (int i = 0; i < NumberOfMisc; ++i)
    {
        proc->tmp[i] = 0;
    }
    proc->tmp[0] = unit->pCharacterData->number;
    proc->tmp[1] = unit->pClassData->number;
    proc->tmp[2] = unit->level;
    proc->tmp[3] = unit->exp;
    proc->tmp[4] = unit->conBonus;
    proc->tmp[5] = unit->movBonus;
    proc->tmp[6] = unit->statusIndex;
    proc->tmp[8] = unit->statusDuration;
    proc->tmp[7] = (unit->index & 0xC0) >> 6;

    int x = NUMBER_X - MiscNameWidth - 2;
    int y = Y_HAND - 1;
    int w = MiscNameWidth + (START_X - NUMBER_X) + 4;
    int h = (NumberOfMisc * 2) + 2;

    DrawUiFrame(
        BG_GetMapBuffer(1),            // back BG
        x, y, w, h, TILEREF(0, 0), 0); // style as 0 ?

    struct Text * th = gStatScreen.text;

    for (int i = 0; i <= NumberOfMisc; ++i)
    {
        InitText(&th[i], MiscNameWidth);
    }

    RedrawMiscMenu(proc);
}

extern int sStatusNameTextIdLookup[];
void RedrawMiscMenu(DebuggerProc * proc)
{
    // TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-2, Y_HAND), 9,
    // 2 * NumberOfMisc, 0);
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    ResetIconGraphics();
    // ResetText();
    // struct Unit* unit = proc->unit;
    struct Text * th = gStatScreen.text;
    int i = 0;
    for (i = 0; i <= NumberOfMisc; ++i)
    {
        ClearText(&th[i]);
    }

    i = 0;

    Text_DrawString(&th[i], GetStringFromIndexSafe(GetCharacterData(proc->tmp[0])->nameTextId));
    i++;
    Text_DrawString(&th[i], GetStringFromIndexSafe(GetClassData(proc->tmp[1])->nameTextId));
    i++;
    Text_DrawString(&th[i], "Level");
    i++;
    Text_DrawString(&th[i], "Exp");
    i++;
    Text_DrawString(&th[i], "Bonus Con");
    i++;
    Text_DrawString(&th[i], "Bonus Mov");
    i++;
    if (!proc->tmp[6])
    {
        Text_DrawString(&th[i], "Status");
        i++;
    }
    else
    {

        Text_DrawString(&th[i], GetStringFromIndexSafe(sStatusNameTextIdLookup[proc->tmp[6]]));
        i++;
    }
    Text_DrawString(&th[i], "Allegiance");
    // i++;

    int x = NUMBER_X - (MiscNameWidth)-1;

    if (proc->tmp[7] == 0)
    {

        Text_DrawString(&th[8], "  Player");
    }
    else if (proc->tmp[7] == 1)
    {
        Text_DrawString(&th[8], "  NPC");
    }
    else if (proc->tmp[7] == 2)
    {
        Text_DrawString(&th[8], "  Enemy");
    }
    PutText(&th[8], gBG0TilemapBuffer + TILEMAP_INDEX(START_X - 3, Y_HAND + (i * 2)));

    for (i = 0; i < NumberOfMisc; ++i)
    {
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (i * 2)));
    }

    for (i = 0; i < NumberOfMisc; ++i)
    {
        //
        if (i == 7)
        {
            continue;
        }

        else if (i < 2)
        {
            PutNumberHex(
                gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i * 2)), TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
        }
        else
        {
            PutNumber(
                gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i * 2)), TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
        }
    }

    // for (i = 0; i < NumberOfMisc; ++i) { // uses
    //     if (proc->tmp[i]) { n = (proc->tmp[i] & 0xFF00) >> 8; } else { n = 0; }
    //     PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 3, Y_HAND +
    //     (i*2)), TEXT_COLOR_SYSTEM_GOLD, n);
    // }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

int GetMiscMin(int id)
{
    int result = 0;
    switch (id)
    {
        case 0:
        {
            result = 1;
            break;
        } // unitID
        case 1:
        {
            result = 1;
            break;
        } // classID
        case 2:
        {
            result = 1;
            break;
        } // level
        case 3:
        {
            result = 0;
            break;
        } // exp  -1 ?
        case 4:
        {
            result = 0;
            break;
        } // + con
        case 5:
        {
            result = 0;
            break;
        } // + mov
        case 6:
        {
            result = 0;
            break;
        } // status
        case 7:
        {
            result = 0;
            break;
        }
        default:
    }
    return result;
}

static int GetMaxItems(void)
{
    const struct ItemData * table = GetItemData(1);
    int c = 256;
    for (int i = 1; i <= 256; i++)
    {
        if (table->number != i)
        {
            table--;
            break;
        }
        table++;
    }
    c = table->number;
    if (c > 255)
    {
        c = 255;
    }
    if (c < 1)
    {
        c = 1;
    }
    return c;
}

static int GetMaxClasses(void)
{
    const struct ClassData * table = GetClassData(1);
    int c = 256;
    for (int i = 1; i <= c; i++)
    {
        if (table->number != i)
        {
            table--;
            break;
        }
        table++;
    }
    c = table->number;
    if (c > 255)
    {
        c = 255;
    }
    if (c < 1)
    {
        c = 1;
    }
    return c;
}

int GetMiscMax(int id)
{
    int result = 0;
    switch (id)
    {
        case 0:
        {
            result = 255;
            break;
        } // unitID
        case 1:
        {
            result = GetMaxClasses();
            break;
        } // classID
        case 2:
        {
            result = 255;
            break;
        } // level
        case 3:
        {
            result = 100;
            break;
        } // exp
        case 4:
        {
            result = 15;
            break;
        } // + con
        case 5:
        {
            result = 15;
            break;
        } // + mov
        case 6:
        {
            result = 15;
            break;
        } // status
        case 7:
        {
            result = 2;
            break;
        }
        default:
    }
    return result;
}

void EditMiscIdle(DebuggerProc * proc)
{
    // DisplayVertUiHand(CursorLocationTable[proc->digit].x,
    // CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if (keys & B_BUTTON)
    { // press B to not save stats
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update stats and continue
        SaveMisc(proc);
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };

    if (proc->editing)
    {
        DisplayVertUiHand(CursorLocationTable[proc->digit].x, (Y_HAND + (proc->id * 2)) * 8);
        int max = GetMiscMax(proc->id);
        int min = GetMiscMin(proc->id);
        int type = (proc->id < 2);
        int max_digits = GetMaxDigits(max, type);
        int val = 0;

        if (keys & DPAD_RIGHT)
        {
            if (proc->digit > 0)
            {
                proc->digit--;
            }
            else
            {
                proc->digit = max_digits - 1;
                proc->editing = false;
            }
            RedrawMiscMenu(proc);
        }
        if (keys & DPAD_LEFT)
        {
            if (proc->digit < (max_digits - 1))
            {
                proc->digit++;
            }
            else
            {
                proc->digit = 0;
                proc->editing = false;
            }
            RedrawMiscMenu(proc);
        }

        if (keys & DPAD_UP)
        {
            if ((proc->tmp[proc->id]) == max)
            {
                proc->tmp[proc->id] = min;
            }
            else
            {
                proc->tmp[proc->id] += pDigitTable[type][proc->digit];
                if ((proc->tmp[proc->id]) > max)
                {
                    proc->tmp[proc->id] = max;
                }
            }
            // proc->tmp[proc->id] = GetPrevMisc(proc->tmp[proc->id], proc->id, min,
            // max);
            RedrawMiscMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            if ((proc->tmp[proc->id]) == min)
            {
                proc->tmp[proc->id] = max;
            }
            else
            {
                val = (proc->tmp[proc->id]) - pDigitTable[type][proc->digit];
                if (val < min)
                {
                    proc->tmp[proc->id] = min;
                }
                else
                {
                    proc->tmp[proc->id] = val;
                }
            }
            // proc->tmp[proc->id] = GetNextMisc(proc->tmp[proc->id], proc->id, min,
            // max);
            RedrawMiscMenu(proc);
        }
    }
    else
    {
        DisplayUiHand(CursorLocationTable[0].x - ((MiscNameWidth + 3) * 8), (Y_HAND + (proc->id * 2)) * 8);
        if (proc->id == (NumberOfMisc - 1))
        {
            int val = proc->tmp[proc->id];
            if (keys & DPAD_RIGHT)
            {
                val++;
            }
            else if (keys & DPAD_LEFT)
            {
                val--;
            }
            if (val < 0)
            {
                val = 2;
            }
            if (val > 2)
            {
                val = 0;
            }
            if (val != proc->tmp[proc->id])
            {
                proc->tmp[proc->id] = val;
                RedrawMiscMenu(proc);
            }
        }
        else
        {
            if (keys & DPAD_RIGHT)
            {
                proc->digit = 1;
                proc->editing = true;
            }
            if (keys & DPAD_LEFT)
            {
                proc->digit = 0;
                proc->editing = true;
            }
        }

        if (keys & DPAD_UP)
        {
            proc->id--;
            if (proc->id < 0)
            {
                proc->id = NumberOfMisc - 1;
            }
            RedrawMiscMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            proc->id++;
            if (proc->id >= NumberOfMisc)
            {
                proc->id = 0;
            }

            RedrawMiscMenu(proc);
        }
    }
}

#define NumberOfAiOptions 8
#define AiNameWidth 14
#define AiApplyMaskTmp (AiMenuOption_ApplyScope + 1)

enum AiMenuOption
{
    AiMenuOption_Ai1,
    AiMenuOption_Ai2,
    AiMenuOption_Recovery,
    AiMenuOption_TargetPriority,
    AiMenuOption_Group,
    AiMenuOption_BossStay,
    AiMenuOption_Unused,
    AiMenuOption_ApplyScope,
};

enum AiApplyScope
{
    AiApplyScope_Unit,
    AiApplyScope_EveryoneExceptBosses,
    AiApplyScope_Bosses,
    AiApplyScope_Everyone,
    AiApplyScope_Group,
    AiApplyScope_Character,
    AiApplyScope_Class,
};

typedef struct
{
    u16 recoveryMode : 3;
    u16 targetPriority : 5;
    u16 group : 5;
    u16 bossAi : 1;
    u16 unused : 2;
} AiConfig;

typedef union
{
    u16 raw;
    AiConfig config;
} AiConfigWord;

static int GetAiApplyBit(int id)
{
    return 1 << id;
}

static int IsAiOptionEnabled(DebuggerProc * proc, int id)
{
    return proc->tmp[AiApplyMaskTmp] & GetAiApplyBit(id);
}

static void ToggleAiOption(DebuggerProc * proc, int id)
{
    proc->tmp[AiApplyMaskTmp] ^= GetAiApplyBit(id);
}

static char * sAiMenuLabels[] = {
    "AI1", "AI2", "Recovery", "Target Pref.", "Group", "Boss AI", "Unused", "Apply To",
};

static char * sAi1Names[] = {
    "ActionInRange", "ActionRange80",     "ActionRange50",  "ActionStand",        "ActionStand80", "ActionStand50",
    "DoNothing",     "AttNotNatasha",     "AttNotCivilian", "AttNotNoOne",        "AttOnlyNoOne",  "ActionInRange",
    "ActHalfRange",  "ActCommanderRange", "Heal <50%",      "Alternate Heal/Att", "Steal",         "WaitForDoor",
    "AttNotNoOne",   "AttNotNoOne",       "Summon",
};

static char * GetAi1Name(int id)
{
    if ((id < 0) || (id >= (int)ARRAY_COUNT(sAi1Names)))
    {
        return "Unknown";
    }
    return sAi1Names[id];
}

static char * sAi2Names[] = {
    "MoveToEnemy",
    "MoveEnemyXcept1",
    "MoveEnemyXcept2",
    "DoNotPursue",
    "PillagePursue",
    "PillageEscape",
    "IfRangex2, Pursue",
    "IfRangex2, PursueX",
    "Unknown85A85D0",
    "Random",
    "PursueEirika",
    "PursueEphraim",
    "Escape",
    "TargetThroneGate",
    "AttackSnagsWalls",
    "PursueEvenIfBlocked",
    "GuardEscortLocation",
    "PillageAfter1",
    "MoveEnemyAfter1",
};
static char * GetAi2Name(int id)
{
    if ((id < 0) || (id >= (int)ARRAY_COUNT(sAi2Names)))
    {
        return "Unknown";
    }
    return sAi2Names[id];
}

static char * sAiRecoveryNames[] = {
    "Flee<=50%, Return100%", "Flee<=30%, Return80%", "Flee<=10%, Return50%", "Flee<=80%, Return100%", "No Recovery AI",
};
static char * GetAiRecoveryName(int id)
{
    if ((id < 0) || (id >= (int)ARRAY_COUNT(sAiRecoveryNames)))
    {
        return "Invalid";
    }
    return sAiRecoveryNames[id];
}

static char * sAiTargetNames[] = {
    "Position", "Damage", "Jaffar", "Defense", "Dmg/Hitrate", "Archers", "Defense2", "Defense3",
};
static char * GetAiTargetName(int id)
{
    if ((id < 0) || (id >= (int)ARRAY_COUNT(sAiTargetNames)))
    {
        return "Invalid";
    }
    return sAiTargetNames[id];
}

static char * sAiGroupNames[] = {
    "None",         "One",         "Two",          "Three",       "Four",        "Five",       "Six",
    "Seven",        "Eight",       "Nine",         "Ten",         "Eleven",      "Twelve",     "Thirteen",
    "Fourteen",     "Fifteen",     "Sixteen",      "Seventeen",   "Eighteen",    "Nineteen",   "Twenty",
    "Twenty one",   "Twenty two",  "Twenty three", "Twenty four", "Twenty five", "Twenty six", "Twenty seven",
    "Twenty eight", "Twenty nine", "Thirty",       "Thirty one",
};
static char * GetAiGroupName(int id)
{
    if ((id < 0) || (id >= (int)ARRAY_COUNT(sAiGroupNames)))
    {
        return "Invalid";
    }
    return sAiGroupNames[id];
}

static char * sAiApplyScopeNames[] = {
    "Unit", "Everyone Except Bosses", "Only Bosses", "Everyone", "Group", "Matching Character ID", "Matching Class ID",
};
static char * GetAiApplyScopeName(int id)
{
    if ((id < 0) || (id >= (int)ARRAY_COUNT(sAiApplyScopeNames)))
    {
        return "Invalid";
    }
    return sAiApplyScopeNames[id];
}

#define AiScriptScanLimit 0x100

static int IsReadableAiScriptPointer(struct AiScr * script)
{
    int addr = (int)script;

    if ((addr >= 0x02000000) && (addr < 0x02040000))
    {
        return true;
    }
    if ((addr >= 0x03000000) && (addr < 0x03008000))
    {
        return true;
    }
    if ((addr >= 0x08000000) && (addr < 0x0A000000))
    {
        return true;
    }

    return false;
}

static int IsNullAiScript(struct AiScr * script)
{
    return !script->cmd && !script->unk_01 && !script->unk_02 && !script->unk_03 && !script->unk_04 &&
        !script->unk_08 && !script->unk_0C;
}

static int GetAiScriptTableMax(struct AiScr ** table, struct AiScr * nextTableFirstScript, struct AiScr ** nextTable)
{
    for (int i = 0; i < AiScriptScanLimit; ++i)
    {
        struct AiScr * script = table[i];

        if (!script)
        {
            return i ? i - 1 : 0;
        }

        if (i && ((script == nextTableFirstScript) || (script == (struct AiScr *)nextTable)))
        {
            return i - 1;
        }

        if (!IsReadableAiScriptPointer(script) || IsNullAiScript(script))
        {
            return i ? i - 1 : 0;
        }
    }

    return AiScriptScanLimit - 1;
}

static int GetAi1Max(void)
{
    return GetAiScriptTableMax(gpAi1Table[0], gpAi2Table[0][0], gpAi2Table[0]);
}

static int GetAi2Max(void)
{
    return GetAiScriptTableMax(gpAi2Table[0], gpAi1Table[0][0], gpAi1Table[0]);
}

static int GetAiConfigFromMenu(struct Unit * unit, DebuggerProc * proc)
{
    AiConfigWord ai = { unit->ai3And4 };

    if (IsAiOptionEnabled(proc, AiMenuOption_Recovery))
    {
        ai.config.recoveryMode = proc->tmp[AiMenuOption_Recovery];
    }
    if (IsAiOptionEnabled(proc, AiMenuOption_TargetPriority))
    {
        ai.config.targetPriority = proc->tmp[AiMenuOption_TargetPriority];
    }
    if (IsAiOptionEnabled(proc, AiMenuOption_Group))
    {
        ai.config.group = proc->tmp[AiMenuOption_Group];
    }
    if (IsAiOptionEnabled(proc, AiMenuOption_BossStay))
    {
        ai.config.bossAi = proc->tmp[AiMenuOption_BossStay];
    }
    if (IsAiOptionEnabled(proc, AiMenuOption_Unused))
    {
        ai.config.unused = proc->tmp[AiMenuOption_Unused];
    }

    return ai.raw;
}

static void ApplyAiToUnit(struct Unit * unit, DebuggerProc * proc)
{
    int aiConfig = GetAiConfigFromMenu(unit, proc);
    if (IsAiOptionEnabled(proc, AiMenuOption_Ai1) && (unit->ai1 != proc->tmp[AiMenuOption_Ai1]))
    {
        unit->ai1data = 0;
        unit->ai1 = proc->tmp[AiMenuOption_Ai1];
    }
    if (IsAiOptionEnabled(proc, AiMenuOption_Ai2) && (unit->ai2 != proc->tmp[AiMenuOption_Ai2]))
    {
        unit->ai2data = 0;
        unit->ai2 = proc->tmp[AiMenuOption_Ai2];
    }

    if (unit->ai3And4 != aiConfig)
    {
        unit->_u46 = 0;
        unit->ai3And4 = aiConfig;
    }
}

static int GetUnitAiGroup(struct Unit * unit)
{
    AiConfigWord ai = { unit->ai3And4 };

    return ai.config.group;
}

static int IsAiBossUnit(struct Unit * unit)
{
    return UNIT_CATTRIBUTES(unit) & CA_BOSS;
}

static int ShouldApplyAiToUnit(struct Unit * unit, DebuggerProc * proc, int group, int charId, int classId)
{
    switch (proc->tmp[AiMenuOption_ApplyScope])
    {
        case AiApplyScope_EveryoneExceptBosses:
            return !IsAiBossUnit(unit);

        case AiApplyScope_Bosses:
            return IsAiBossUnit(unit);

        case AiApplyScope_Everyone:
            return true;

        case AiApplyScope_Group:
            return group && (GetUnitAiGroup(unit) == group);

        case AiApplyScope_Character:
            return UNIT_CHAR_ID(unit) == charId;

        case AiApplyScope_Class:
            return UNIT_CLASS_ID(unit) == classId;

        default:
            return false;
    }
}

void SaveAi(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit;
    int group = GetUnitAiGroup(unit);
    int charId = UNIT_CHAR_ID(unit);
    int classId = UNIT_CLASS_ID(unit);

    if (proc->tmp[AiMenuOption_ApplyScope] == AiApplyScope_Unit)
    {
        ApplyAiToUnit(unit, proc);
        return;
    }

    for (int i = UNIT_FACTION(unit) + 1; i < UNIT_FACTION(unit) + 0x40; ++i)
    {
        struct Unit * unit2 = GetUnit(i);
        if (UNIT_IS_VALID(unit2) && ShouldApplyAiToUnit(unit2, proc, group, charId, classId))
        {
            ApplyAiToUnit(unit2, proc);
        }
    }
}

void RedrawAiMenu(DebuggerProc * proc);
void EditAiInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    struct Unit * unit = proc->unit;

    proc->id = 0;
    proc->digit = 0;
    proc->editing = false;

    proc->tmp[AiMenuOption_Ai1] = unit->ai1;
    proc->tmp[AiMenuOption_Ai2] = unit->ai2;

    AiConfigWord ai = { unit->ai3And4 };
    proc->tmp[AiMenuOption_Recovery] = ai.config.recoveryMode;
    proc->tmp[AiMenuOption_TargetPriority] = ai.config.targetPriority;
    proc->tmp[AiMenuOption_Group] = ai.config.group;
    proc->tmp[AiMenuOption_BossStay] = ai.config.bossAi;
    proc->tmp[AiMenuOption_Unused] = ai.config.unused;
    proc->tmp[AiMenuOption_ApplyScope] = AiApplyScope_Unit;
    proc->tmp[AiApplyMaskTmp] = 0;

    int x = NUMBER_X - AiNameWidth - 1;
    int y = Y_HAND - 1;
    int w = AiNameWidth + (START_X - NUMBER_X) + 11;
    int h = NumberOfAiOptions * 2 + 2;

    DrawUiFrame(BG_GetMapBuffer(1), x, y, w, h, TILEREF(0, 0), 0);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < NumberOfAiOptions * 2; ++i)
    {
        InitText(&th[i], AiNameWidth);
    }

    StartGreenText(proc);
    RedrawAiMenu(proc);
}

static char * GetAiOptionDetail(DebuggerProc * proc, int id)
{
    switch (id)
    {
        case AiMenuOption_Ai1:
            return GetAi1Name(proc->tmp[id]);

        case AiMenuOption_Ai2:
            return GetAi2Name(proc->tmp[id]);

        case AiMenuOption_Recovery:
            return GetAiRecoveryName(proc->tmp[id]);

        case AiMenuOption_TargetPriority:
            return GetAiTargetName(proc->tmp[id]);

        case AiMenuOption_Group:
            return GetAiGroupName(proc->tmp[id]);

        case AiMenuOption_Unused:
            return "N/A";

        case AiMenuOption_BossStay:
            return proc->tmp[id] ? "Stationary" : "Can move";

        case AiMenuOption_ApplyScope:
            return GetAiApplyScopeName(proc->tmp[id]);

        default:
            return "";
    }
}

void RedrawAiMenu(DebuggerProc * proc)
{
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < NumberOfAiOptions * 2; ++i)
    {
        ClearText(&th[i]);
    }

    for (int i = 0; i < NumberOfAiOptions; ++i)
    {
        int color = (i != AiMenuOption_ApplyScope) && IsAiOptionEnabled(proc, i) ? TEXT_COLOR_SYSTEM_GREEN
                                                                                 : TEXT_COLOR_SYSTEM_WHITE;
        Text_SetColor(&th[i], color);
        Text_DrawString(&th[i], sAiMenuLabels[i]);
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X - AiNameWidth, Y_HAND + i * 2));

        if ((i == AiMenuOption_Ai1) || (i == AiMenuOption_Ai2))
        {
            PutNumberHex(
                gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 8, Y_HAND + i * 2), TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
        }
        else if (i != AiMenuOption_ApplyScope)
        {
            PutNumber(
                gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 8, Y_HAND + i * 2), TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
        }
        if (i == AiMenuOption_BossStay)
        {
            if (proc->tmp[i])
            {
                PutNumberHex(
                    gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 8, Y_HAND + i * 2), TEXT_COLOR_SYSTEM_GOLD, 32);
            }
            else
            {
                PutNumberHex(gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 8, Y_HAND + i * 2), TEXT_COLOR_SYSTEM_GOLD, 0);
            }
        }

        char * detail = GetAiOptionDetail(proc, i);
        if (detail[0])
        {
            Text_SetColor(&th[i + NumberOfAiOptions], color);
            Text_DrawString(&th[i + NumberOfAiOptions], detail);
            PutText(&th[i + NumberOfAiOptions], gBG0TilemapBuffer + TILEMAP_INDEX(START_X - 7, Y_HAND + i * 2));
        }
    }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

int GetAiMin(int id)
{
    return 0;
}

int GetAiMax(int id)
{
    switch (id)
    {
        case AiMenuOption_Ai1:
            return GetAi1Max();

        case AiMenuOption_Ai2:
            return GetAi2Max();

        case AiMenuOption_Recovery:
            return 7;

        case AiMenuOption_TargetPriority:
        case AiMenuOption_Group:
            return 0x1F;

        case AiMenuOption_BossStay:
            return 1;

        case AiMenuOption_Unused:
            return 3;

        case AiMenuOption_ApplyScope:
            return ARRAY_COUNT(sAiApplyScopeNames) - 1;

        default:
            return 0;
    }
}

void EditAiIdle(DebuggerProc * proc)
{
    u16 keys = gKeyStatusPtr->repeatedKeys;
    u16 newKeys = gKeyStatusPtr->newKeys;
    if (keys & B_BUTTON)
    {
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if (newKeys & START_BUTTON)
    {
        SaveAi(proc);
        Proc_Goto(proc, RestartLabel);
        ConfirmPressSFX();
    };
    if (newKeys & A_BUTTON)
    {
        if (proc->id == AiMenuOption_ApplyScope)
        {
            SaveAi(proc);
            Proc_Goto(proc, RestartLabel);
            ConfirmPressSFX();
            return;
        }
        else
        {
            ToggleAiOption(proc, proc->id);
            ConfirmPressSFX();
            RedrawAiMenu(proc);
        }
    }

    if (proc->editing)
    {
        DisplayVertUiHand(CursorLocationTable[proc->digit].x + (8 * 8), (Y_HAND + (proc->id * 2)) * 8);
        int max = GetAiMax(proc->id);
        int min = GetAiMin(proc->id);
        int type = (proc->id < AiMenuOption_Recovery);
        int max_digits = GetMaxDigits(max, type);
        int val = 0;

        if (keys & DPAD_RIGHT)
        {
            if (proc->digit > 0)
            {
                proc->digit--;
            }
            else
            {
                proc->digit = max_digits - 1;
                proc->editing = false;
            }
            RedrawAiMenu(proc);
        }
        if (keys & DPAD_LEFT)
        {
            if (proc->digit < (max_digits - 1))
            {
                proc->digit++;
            }
            else
            {
                proc->digit = 0;
                proc->editing = false;
            }
            RedrawAiMenu(proc);
        }

        if (keys & DPAD_UP)
        {
            if (proc->tmp[proc->id] == max)
            {
                proc->tmp[proc->id] = min;
            }
            else
            {
                proc->tmp[proc->id] += pDigitTable[type][proc->digit];
                if (proc->tmp[proc->id] > max)
                {
                    proc->tmp[proc->id] = max;
                }
            }
            RedrawAiMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            if (proc->tmp[proc->id] == min)
            {
                proc->tmp[proc->id] = max;
            }
            else
            {
                val = proc->tmp[proc->id] - pDigitTable[type][proc->digit];
                if (val < min)
                {
                    proc->tmp[proc->id] = min;
                }
                else
                {
                    proc->tmp[proc->id] = val;
                }
            }
            RedrawAiMenu(proc);
        }
    }
    else
    {
        DisplayUiHand(CursorLocationTable[0].x - ((AiNameWidth + 2) * 8), (Y_HAND + (proc->id * 2)) * 8);

        if (proc->id == AiMenuOption_ApplyScope)
        {
            int val = proc->tmp[proc->id];
            int max = GetAiMax(proc->id);
            if (keys & DPAD_RIGHT)
            {
                val++;
            }
            else if (keys & DPAD_LEFT)
            {
                val--;
            }
            if (val < 0)
            {
                val = max;
            }
            if (val > max)
            {
                val = 0;
            }
            if (val != proc->tmp[proc->id])
            {
                proc->tmp[proc->id] = val;
                RedrawAiMenu(proc);
            }
        }
        else
        {
            if (keys & DPAD_RIGHT)
            {
                proc->digit = (proc->id < AiMenuOption_Recovery) ? 1 : 0;
                proc->editing = true;
            }
            if (keys & DPAD_LEFT)
            {
                proc->digit = 0;
                proc->editing = true;
            }
        }

        if (keys & DPAD_UP)
        {
            proc->id--;
            if (proc->id < 0)
            {
                proc->id = NumberOfAiOptions - 1;
            }
            // RedrawAiMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            proc->id++;
            if (proc->id >= NumberOfAiOptions)
            {
                proc->id = 0;
            }
            // RedrawAiMenu(proc);
        }
    }
}

#define NumberOfBgmOptions 1
#define BgmNameWidth 16
#define BgmMenuXOffset 2
#define DebugBgmMax 0x5FF

enum BgmMenuOption
{
    BgmMenuOption_Track,
    BgmAppliedTrackTmp = NumberOfBgmOptions,
};

static char * sBgmMenuLabels[] = {
    "Track",
};

static int GetSoundRoomIndexFromTrack(int id)
{
    int i = 0;

    if ((id > 0) && (gSoundRoomTable[id - 1].bgmId == id))
    {
        return id - 1;
    }

    while (gSoundRoomTable[i].bgmId >= 0)
    {
        if (gSoundRoomTable[i].bgmId == id)
        {
            return i;
        }
        i++;
    }

    return -1;
}

static char * GetBgmMenuLabel(DebuggerProc * proc)
{
    int id = GetSoundRoomIndexFromTrack(proc->tmp[BgmMenuOption_Track]);

    if (proc->tmp[BgmMenuOption_Track] == 0)
    {
        return "Map Song";
    }

    if (id >= 0)
    {
        return GetStringFromIndexSafe(gSoundRoomTable[id].nameTextId);
    }

    return sBgmMenuLabels[BgmMenuOption_Track];
}

static int GetDebuggerBgmOverride(void)
{
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);

    if (!procIdler)
    {
        return 0;
    }

    return procIdler->bgmOverride;
}

static void SetDebuggerBgmOverride(DebuggerProc * proc, int track)
{
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);

    proc->bgmOverride = track;

    if (procIdler)
    {
        procIdler->bgmOverride = track;
    }
}

extern int GetBGMTrack();

void sub_80328B0(void)
{
    int override = GetDebuggerBgmOverride();
    int bgmIdx = GetBGMTrack();
    int curBgm = GetCurrentBgmSong();

    if ((curBgm != bgmIdx) && (override != curBgm))
    {
        StartBgmExt(bgmIdx, 6, NULL); // 80038AC, 800322C
    }

    return;
}
struct PhaseIntroSubProc
{
    PROC_HEADER;
    /* 29 */ u8 _pad_29[0x4C - 0x29];
    /* 4C */ s16 timer;
    /* 4E */ s16 stat_index;
};
void PhaseIntroInitText(struct PhaseIntroSubProc * proc)
{
    int override = GetDebuggerBgmOverride();
    int bgmIdx = GetBGMTrack();
    int curBgm = GetCurrentBgmSong();
    if ((curBgm != bgmIdx) && (override != curBgm))
    {                        // 80034DC, 8002F68
        Sound_FadeOutBGM(4); // 80035EC, 8003064
    }

#ifdef FE8
    PlaySoundEffect(0x73); // 803DD98, 8036D08
#endif
#ifdef FE7
    PlaySoundEffect(0x393); // 803DD98, 8036D08
#endif
#ifdef FE6
    PlaySoundEffect(0x73); // 73 as well apparently
#endif

    proc->timer = 15;
}

void StartMapSongBgm(void)
{
    int override = GetDebuggerBgmOverride();
    if (override)
    {
        StartBgm(override, 0);
    }
    else
    {
        // 8015F84, 80163E4
        StartBgm(GetBGMTrack(), 0); // 8003890, 8003210
    }
    return;
}

static void StartDebuggerBgm(int track)
{
    if (track == 0)
    {
        StartMapSongBgm();
        return;
    }

    StartBgm(track, 0);
}

static void PlayBgmFromMenu(DebuggerProc * proc)
{
    SetDebuggerBgmOverride(proc, proc->tmp[BgmMenuOption_Track]);
    StartDebuggerBgm(proc->bgmOverride);
    proc->tmp[BgmAppliedTrackTmp] = proc->tmp[BgmMenuOption_Track];
}

void RedrawBgmMenu(DebuggerProc * proc)
{
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < NumberOfBgmOptions; ++i)
    {
        ClearText(&th[i]);
    }

    for (int i = 0; i < NumberOfBgmOptions; ++i)
    {
        int color = (proc->tmp[i] == proc->tmp[BgmAppliedTrackTmp]) ? TEXT_COLOR_SYSTEM_GREEN : TEXT_COLOR_SYSTEM_WHITE;
        Text_SetColor(&th[i], color);
        Text_DrawString(&th[i], GetBgmMenuLabel(proc));
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X - BgmNameWidth + BgmMenuXOffset, Y_HAND + i * 2));
        PutNumberHex(
            gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 4 + BgmMenuXOffset, Y_HAND + i * 2), TEXT_COLOR_SYSTEM_GOLD,
            proc->tmp[i]);
    }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

void EditBgmInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);

    proc->id = 0;
    proc->digit = 0;
    proc->editing = false;
    proc->bgmOverride = GetDebuggerBgmOverride();
    proc->tmp[BgmMenuOption_Track] = proc->bgmOverride ? proc->bgmOverride : GetCurrentBgmSong();
    proc->tmp[BgmAppliedTrackTmp] = proc->tmp[BgmMenuOption_Track];

    int x = NUMBER_X - BgmNameWidth - 1 + BgmMenuXOffset;
    int y = Y_HAND - 1;
    int w = BgmNameWidth + (START_X - NUMBER_X) + 7;
    int h = NumberOfBgmOptions * 2 + 2;

    DrawUiFrame(BG_GetMapBuffer(1), x, y, w, h, TILEREF(0, 0), 0);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < NumberOfBgmOptions; ++i)
    {
        InitText(&th[i], 22);
    }

    StartGreenText(proc);
    RedrawBgmMenu(proc);
}

void EditBgmIdle(DebuggerProc * proc)
{
    u16 keys = gKeyStatusPtr->repeatedKeys;
    u16 newKeys = gKeyStatusPtr->newKeys;

    if (keys & B_BUTTON)
    {
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
        return;
    }

    if (newKeys & A_BUTTON)
    {
        PlayBgmFromMenu(proc);
        ConfirmPressSFX();
        RedrawBgmMenu(proc);
        return;
    }

    if (proc->editing)
    {
        int type = 1;
        int max_digits = GetMaxDigits(DebugBgmMax, type);
        int val = 0;

        DisplayVertUiHand(
            CursorLocationTable[proc->digit].x + ((4 + BgmMenuXOffset) * 8), (Y_HAND + (proc->id * 2)) * 8);

        if (keys & DPAD_RIGHT)
        {
            if (proc->digit > 0)
            {
                proc->digit--;
            }
            else
            {
                proc->digit = max_digits - 1;
                proc->editing = false;
            }
            RedrawBgmMenu(proc);
        }
        if (keys & DPAD_LEFT)
        {
            if (proc->digit < (max_digits - 1))
            {
                proc->digit++;
            }
            else
            {
                proc->digit = 0;
                proc->editing = false;
            }
            RedrawBgmMenu(proc);
        }

        if (keys & DPAD_UP)
        {
            if (proc->tmp[proc->id] == DebugBgmMax)
            {
                proc->tmp[proc->id] = 0;
            }
            else
            {
                proc->tmp[proc->id] += pDigitTable[type][proc->digit];
                if (proc->tmp[proc->id] > DebugBgmMax)
                {
                    proc->tmp[proc->id] = DebugBgmMax;
                }
            }
            RedrawBgmMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            if (proc->tmp[proc->id] == 0)
            {
                proc->tmp[proc->id] = DebugBgmMax;
            }
            else
            {
                val = proc->tmp[proc->id] - pDigitTable[type][proc->digit];
                if (val < 0)
                {
                    proc->tmp[proc->id] = 0;
                }
                else
                {
                    proc->tmp[proc->id] = val;
                }
            }
            RedrawBgmMenu(proc);
        }
    }
    else
    {
        DisplayUiHand(
            CursorLocationTable[0].x - ((BgmNameWidth + 2 - BgmMenuXOffset) * 8), (Y_HAND + (proc->id * 2)) * 8);

        if (keys & DPAD_RIGHT)
        {
            proc->digit = GetMostSignificantDigit(proc->tmp[proc->id], 1);
            proc->editing = true;
        }
        if (keys & DPAD_LEFT)
        {
            proc->digit = 0;
            proc->editing = true;
        }
    }
}

#define NumberOfTrapOptions 9
#define TrapNameWidth 10
#define DebugTrapTypeMax 0xFF
#define TrapCoordExistingTmp NumberOfTrapOptions
#define TrapCoordLastBTmp (TrapCoordExistingTmp + 1)

enum TrapEditMode
{
    TrapEditMode_None,
    TrapEditMode_Digit,
    TrapEditMode_Coords,
};

enum TrapMenuOption
{
    TrapMenuOption_Slot,
    TrapMenuOption_X,
    TrapMenuOption_Y,
    TrapMenuOption_Type,
    TrapMenuOption_Extra,
    TrapMenuOption_Data0,
    TrapMenuOption_Data1,
    TrapMenuOption_Data2,
    TrapMenuOption_Data3,
};

static char * sTrapMenuLabels[] = {
    "Slot", "X", "Y", "Type", "Extra", "Data 0", "Data 1", "Data 2", "Data 3",
};

static char * sTrapTypeNames[] = {
    "None",   "Ballista",   "Obstacle", "Mapchange",  "Firetile",   "Gas",     "Mapchange2", "Lightarrow",    "Trap 8",
    "Trap 9", "Torchlight", "Mine",     "Gorgon Egg", "Light Rune", "Trap 14", "Fire Thief", "Mine Assassin",
};

static char * GetTrapTypeName(int id)
{
    if ((id < 0) || (id >= (int)ARRAY_COUNT(sTrapTypeNames)))
    {
        return "Unknown";
    }
    return sTrapTypeNames[id];
}

static int GetTrapOptionType(int id)
{
    switch (id)
    {
        case TrapMenuOption_X:
        case TrapMenuOption_Y:
            return 0;

        default:
            return 1;
    }
}

static int GetTrapMax(int id)
{
    switch (id)
    {
        case TrapMenuOption_Slot:
            return TRAP_MAX_COUNT - 1;

        case TrapMenuOption_X:
            return gBmMapSize.x > 0 ? gBmMapSize.x - 1 : 0;

        case TrapMenuOption_Y:
            return gBmMapSize.y > 0 ? gBmMapSize.y - 1 : 0;

        case TrapMenuOption_Type:
            return DebugTrapTypeMax;

        default:
            return 0xFF;
    }
}

static int IsTrapEmpty(struct Trap * trap)
{
    return !trap->type;
    // !trap->xPos && !trap->yPos && !trap->type && !trap->extra && !trap->data[0] && !trap->data[1] &&
    // !trap->data[2] && !trap->data[3];
}

static void DrawTrapMenuFrame(void)
{
    int x = NUMBER_X - TrapNameWidth - 1;
    int y = Y_HAND - 2;
    int w = TrapNameWidth + (START_X - NUMBER_X) + 9;
    int h = (NumberOfTrapOptions * 2) + 2;

    DrawUiFrame(BG_GetMapBuffer(1), x, y, w, h, TILEREF(0, 0), 0);
    BG_EnableSyncByMask(BG1_SYNC_BIT);
}

static void ClearTrapMenu(void)
{
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_Fill(gBG1TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
}

static void LoadTrapMenuFromSlot(DebuggerProc * proc)
{
    struct Trap * trap = GetTrap(proc->tmp[TrapMenuOption_Slot]);

    proc->tmp[TrapMenuOption_X] = trap->xPos;
    proc->tmp[TrapMenuOption_Y] = trap->yPos;
    proc->tmp[TrapMenuOption_Type] = trap->type;
    proc->tmp[TrapMenuOption_Extra] = trap->extra;
    proc->tmp[TrapMenuOption_Data0] = trap->data[0] & 0xFF;
    proc->tmp[TrapMenuOption_Data1] = trap->data[1] & 0xFF;
    proc->tmp[TrapMenuOption_Data2] = trap->data[2] & 0xFF;
    proc->tmp[TrapMenuOption_Data3] = trap->data[3] & 0xFF;
}

static void SaveTrap(DebuggerProc * proc)
{
    struct Trap * trap = GetTrap(proc->tmp[TrapMenuOption_Slot]);

    trap->xPos = proc->tmp[TrapMenuOption_X];
    trap->yPos = proc->tmp[TrapMenuOption_Y];
    trap->type = proc->tmp[TrapMenuOption_Type];
    trap->extra = proc->tmp[TrapMenuOption_Extra];
    trap->data[0] = proc->tmp[TrapMenuOption_Data0];
    trap->data[1] = proc->tmp[TrapMenuOption_Data1];
    trap->data[2] = proc->tmp[TrapMenuOption_Data2];
    trap->data[3] = proc->tmp[TrapMenuOption_Data3];
}

static void RefreshTrapsAndTerrain(void)
{
    ApplyEnabledMapChanges();
    RefreshTerrainBmMap();
    RefreshAllLightRunes();
    UpdateRoofedUnits();
    RefreshUnitSprites();
    RenderBmMap();
}

static void SetTrapEditorCursorCamera(DebuggerProc * proc)
{
    if (proc->tmp[TrapMenuOption_Type])
    {
        int x = proc->tmp[TrapMenuOption_X];
        int y = proc->tmp[TrapMenuOption_Y];

        if (!IsCoordinateValid(x, y))
        {
            return;
        }

        SetCursorMapPosition(x, y);
        // gBmSt.camera.x = GetCameraCenteredX(x * 16);
        // gBmSt.camera.y = GetCameraCenteredY(y * 16);
        EnsureCameraOntoPositionIfValid(proc, x, y);
        RenderBmMap();
    }
}

static void PutTrapEditorMapCursor(DebuggerProc * proc)
{
    if (proc->tmp[TrapMenuOption_Type])
    {
        PutMapCursor(gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y, 0);
    }
}

static void WriteTrapDataFromMenu(struct Trap * trap, DebuggerProc * proc, int x, int y)
{
    trap->xPos = x;
    trap->yPos = y;
    trap->type = proc->tmp[TrapMenuOption_Type];
    trap->extra = proc->tmp[TrapMenuOption_Extra];
    trap->data[0] = proc->tmp[TrapMenuOption_Data0];
    trap->data[1] = proc->tmp[TrapMenuOption_Data1];
    trap->data[2] = proc->tmp[TrapMenuOption_Data2];
    trap->data[3] = proc->tmp[TrapMenuOption_Data3];
}

static int GetFirstFreeTrapSlot(void)
{
    for (int i = 0; i < TRAP_MAX_COUNT; ++i)
    {
        if (GetTrap(i)->type == TRAP_NONE)
        {
            return i;
        }
    }

    return -1;
}

static int AddTrapFromMenuAtCursor(DebuggerProc * proc)
{
    int slot = GetFirstFreeTrapSlot();

    if (slot < 0)
    {
        return FALSE;
    }

    struct Trap * trap = GetTrap(slot);

    WriteTrapDataFromMenu(trap, proc, gBmSt.playerCursor.x, gBmSt.playerCursor.y);
    proc->tmp[TrapMenuOption_Slot] = slot;
    RefreshTrapsAndTerrain();

    return TRUE;
}

static int CopyTrapAtCursorIntoNewSlot(DebuggerProc * proc)
{
    struct Trap * src = GetTrapAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y);

    if (!src)
    {
        return FALSE;
    }

    int slot = GetFirstFreeTrapSlot();

    if (slot < 0)
    {
        return FALSE;
    }

    struct Trap * dst = GetTrap(slot);
    *dst = *src;
    proc->tmp[TrapMenuOption_Slot] = slot;
    LoadTrapMenuFromSlot(proc);
    RefreshTrapsAndTerrain();

    return TRUE;
}

void RedrawTrapMenu(DebuggerProc * proc);

static void StartTrapCoordPick(DebuggerProc * proc)
{
    proc->editing = TrapEditMode_Coords;
    proc->tmp[TrapCoordExistingTmp] = !IsTrapEmpty(GetTrap(proc->tmp[TrapMenuOption_Slot]));
    proc->tmp[TrapCoordLastBTmp] = FALSE;

    if (proc->tmp[TrapCoordExistingTmp])
    {
        SaveTrap(proc);
        RefreshTrapsAndTerrain();
    }

    SetTrapEditorCursorCamera(proc);
    ClearTrapMenu();
}

static void EndTrapCoordPick(DebuggerProc * proc)
{
    proc->editing = TrapEditMode_None;
    proc->tmp[TrapCoordLastBTmp] = FALSE;
    SetCursorMapPosition(proc->tmp[TrapMenuOption_X], proc->tmp[TrapMenuOption_Y]);

    DrawTrapMenuFrame();
    RedrawTrapMenu(proc);
}

static void TrapCoordPickIdle(DebuggerProc * proc)
{
    FixAndHandlePlayerCursorMovement();

    if (gKeyStatusPtr->repeatedKeys & (DPAD_LEFT | DPAD_RIGHT | DPAD_UP | DPAD_DOWN))
    {
        proc->tmp[TrapCoordLastBTmp] = FALSE;
    }

    if (gKeyStatusPtr->newKeys & B_BUTTON)
    {
        if (proc->tmp[TrapCoordLastBTmp] || !CopyTrapAtCursorIntoNewSlot(proc))
        {
            EndTrapCoordPick(proc);
            BackPressSFX();
        }
        else
        {
            proc->tmp[TrapCoordExistingTmp] = FALSE;
            proc->tmp[TrapCoordLastBTmp] = TRUE;
            ConfirmPressSFX();
        }

        return;
    }

    if (gKeyStatusPtr->newKeys & A_BUTTON)
    {
        proc->tmp[TrapCoordLastBTmp] = FALSE;
        proc->tmp[TrapMenuOption_X] = gBmSt.playerCursor.x;
        proc->tmp[TrapMenuOption_Y] = gBmSt.playerCursor.y;

        if (proc->tmp[TrapCoordExistingTmp])
        {
            SaveTrap(proc);
            RefreshTrapsAndTerrain();
        }
        else
        {
            AddTrapFromMenuAtCursor(proc);
        }

        ConfirmPressSFX();
        return;
    }

    PutMapCursor(
        gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y,
        IsUnitSpriteHoverEnabledAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y) ? 3 : 0);
}

static void ExitTrapEditor(DebuggerProc * proc)
{
    if ((int)proc->unit != (-1))
    {
        Proc_Goto(proc, RestartLabel);
    }
    else
    {
        ClearSomeGfx(proc);
        Proc_Goto(proc, EndLabel);
    }
}

void EditTrapInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);

    proc->id = 0;
    proc->digit = 0;
    proc->editing = TrapEditMode_None;

    struct Trap * trap = GetTrapAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y);
    proc->tmp[TrapMenuOption_Slot] = trap ? TRAP_INDEX(trap) : 0;

    LoadTrapMenuFromSlot(proc);
    SetTrapEditorCursorCamera(proc);

    DrawTrapMenuFrame();

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < NumberOfTrapOptions * 2; ++i)
    {
        InitText(&th[i], TrapNameWidth);
    }

    RedrawTrapMenu(proc);
}

void RedrawTrapMenu(DebuggerProc * proc)
{
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < NumberOfTrapOptions * 2; ++i)
    {
        ClearText(&th[i]);
    }

    for (int i = 0; i < NumberOfTrapOptions; ++i)
    {
        Text_DrawString(&th[i], sTrapMenuLabels[i]);
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X - TrapNameWidth, (Y_HAND - 1) + (i * 2)));

        if (GetTrapOptionType(i))
        {
            PutNumberHex(
                gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 6, (Y_HAND - 1) + (i * 2)), TEXT_COLOR_SYSTEM_GOLD,
                proc->tmp[i]);
        }
        else
        {
            PutNumber(
                gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 6, (Y_HAND - 1) + (i * 2)), TEXT_COLOR_SYSTEM_GOLD,
                proc->tmp[i]);
        }

        if (i == TrapMenuOption_Type)
        {
            Text_DrawString(&th[i + NumberOfTrapOptions], GetTrapTypeName(proc->tmp[i]));
            PutText(
                &th[i + NumberOfTrapOptions], gBG0TilemapBuffer + TILEMAP_INDEX(START_X - 6, (Y_HAND - 1) + (i * 2)));
        }
    }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

void EditTrapIdle(DebuggerProc * proc)
{
    u16 keys = gKeyStatusPtr->repeatedKeys;
    u16 newKeys = gKeyStatusPtr->newKeys;

    if (proc->editing == TrapEditMode_Coords)
    {
        TrapCoordPickIdle(proc);
        return;
    }

    if (keys & B_BUTTON)
    {
        ExitTrapEditor(proc);
        BackPressSFX();
        return;
    };
    if (newKeys & A_BUTTON)
    {
        StartTrapCoordPick(proc);
        ConfirmPressSFX();
        return;
    }
    if ((newKeys & START_BUTTON) || (newKeys & A_BUTTON))
    {
        SaveTrap(proc);
        RefreshTrapsAndTerrain();
        ExitTrapEditor(proc);
        ConfirmPressSFX();
        return;
    };

    if (proc->editing)
    {
        int type = GetTrapOptionType(proc->id);
        int max = GetTrapMax(proc->id);
        int min = 0;
        int max_digits = GetMaxDigits(max, type);
        int val = 0;

        DisplayVertUiHand(CursorLocationTable[proc->digit].x + (6 * 8), ((Y_HAND - 1) + (proc->id * 2)) * 8);

        if (keys & DPAD_RIGHT)
        {
            if (proc->digit > 0)
            {
                proc->digit--;
            }
            else
            {
                proc->digit = max_digits - 1;
                proc->editing = TrapEditMode_None;
            }
            RedrawTrapMenu(proc);
        }
        if (keys & DPAD_LEFT)
        {
            if (proc->digit < (max_digits - 1))
            {
                proc->digit++;
            }
            else
            {
                proc->digit = 0;
                proc->editing = TrapEditMode_None;
            }
            RedrawTrapMenu(proc);
        }

        if (keys & DPAD_UP)
        {
            if (proc->tmp[proc->id] == max)
            {
                proc->tmp[proc->id] = min;
            }
            else
            {
                proc->tmp[proc->id] += pDigitTable[type][proc->digit];
                if (proc->tmp[proc->id] > max)
                {
                    proc->tmp[proc->id] = max;
                }
            }
            if (proc->id == TrapMenuOption_Slot)
            {
                LoadTrapMenuFromSlot(proc);
                SetTrapEditorCursorCamera(proc);
            }
            if ((proc->id == TrapMenuOption_X) || (proc->id == TrapMenuOption_Y))
            {
                SaveTrap(proc);
                RefreshTrapsAndTerrain();
                SetTrapEditorCursorCamera(proc);
            }
            RedrawTrapMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            if (proc->tmp[proc->id] == min)
            {
                proc->tmp[proc->id] = max;
            }
            else
            {
                val = proc->tmp[proc->id] - pDigitTable[type][proc->digit];
                if (val < min)
                {
                    proc->tmp[proc->id] = min;
                }
                else
                {
                    proc->tmp[proc->id] = val;
                }
            }
            if (proc->id == TrapMenuOption_Slot)
            {
                LoadTrapMenuFromSlot(proc);
                SetTrapEditorCursorCamera(proc);
            }
            if ((proc->id == TrapMenuOption_X) || (proc->id == TrapMenuOption_Y))
            {
                SaveTrap(proc);
                RefreshTrapsAndTerrain();
                SetTrapEditorCursorCamera(proc);
            }
            RedrawTrapMenu(proc);
        }
    }
    else
    {
        DisplayUiHand(CursorLocationTable[0].x - ((TrapNameWidth + 2) * 8), ((Y_HAND - 1) + (proc->id * 2)) * 8);
        if (keys & DPAD_RIGHT)
        {
            proc->digit = GetMostSignificantDigit(proc->tmp[proc->id], GetTrapOptionType(proc->id));
            proc->editing = TrapEditMode_Digit;
        }
        if (keys & DPAD_LEFT)
        {
            proc->digit = 0;
            proc->editing = TrapEditMode_Digit;
        }

        if (keys & DPAD_UP)
        {
            proc->id--;
            if (proc->id < 0)
            {
                proc->id = NumberOfTrapOptions - 1;
            }
            RedrawTrapMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            proc->id++;
            if (proc->id >= NumberOfTrapOptions)
            {
                proc->id = 0;
            }
            RedrawTrapMenu(proc);
        }
    }

    PutTrapEditorMapCursor(proc);
}

#define NumberOfLoad 6
#define LoadNameWidth 12

extern struct Unit * LoadUnit(const struct UnitDefinition * uDef); // 17788 17598
static void InitUnitDef(struct UnitDefinition * uDef, struct Unit * unit, const struct CharacterData * data)
{
    uDef->charIndex = data->number;
    // uDef->classIndex = data->defaultClass;
    uDef->classIndex = 0;
    uDef->leaderCharIndex = unit->supports[UNIT_SUPPORT_MAX_COUNT - 1];
    uDef->autolevel = true;
    uDef->allegiance = UNIT_FACTION(unit) >> 6;
    uDef->level = data->baseLevel;
    if (!uDef->level)
    {
        uDef->level = 1;
    }
    uDef->xPosition = unit->xPos;
    uDef->yPosition = unit->yPos;
    uDef->genMonster = false;
    uDef->itemDrop = (unit->state & US_DROP_ITEM) != 0;
    uDef->sumFlag = 0;
    uDef->unk_05_7 = 0;
    uDef->extraData = 0;
    uDef->redaCount = 0;
    uDef->redas = NULL;
    uDef->items[0] = unit->items[0];
    uDef->items[1] = unit->items[1];
    uDef->items[2] = unit->items[2];
    uDef->items[3] = unit->items[3];
    uDef->ai[0] = unit->ai1;
    uDef->ai[1] = unit->ai2;
    uDef->ai[2] = unit->ai3And4 & 0xFF;
    uDef->ai[3] = (unit->ai3And4 >> 8);
}

static void ReinitUnitDef(struct UnitDefinition * uDef, struct Unit * unit)
{
    uDef->charIndex = unit->pCharacterData->number;
    uDef->classIndex = unit->pCharacterData->defaultClass;
    uDef->leaderCharIndex = unit->supports[UNIT_SUPPORT_MAX_COUNT - 1];
    uDef->autolevel = true;
    uDef->allegiance = UNIT_FACTION(unit) >> 6;
    uDef->level = unit->pCharacterData->baseLevel;
    uDef->xPosition = unit->xPos;
    uDef->yPosition = unit->yPos;
    uDef->genMonster = false;
    uDef->itemDrop = (unit->state & US_DROP_ITEM) != 0;
    uDef->sumFlag = 0;
    uDef->unk_05_7 = 0;
    uDef->extraData = 0;
    uDef->redaCount = 0;
    uDef->redas = NULL;
    uDef->items[0] = unit->items[0];
    uDef->items[1] = unit->items[1];
    uDef->items[2] = unit->items[2];
    uDef->items[3] = unit->items[3];
    uDef->ai[0] = unit->ai1;
    uDef->ai[1] = unit->ai2;
    uDef->ai[2] = unit->ai3And4 & 0xFF;
    uDef->ai[3] = (unit->ai3And4 >> 8);
}

#define SinglePlayer 0
#define SingleNPC 1
#define SingleEnemy 2
#define PlayerUnits 3
#define BossUnits 4
#define ExistingUnits 5

int FindNextBoss(int c)
{
    const struct CharacterData * data;
    for (; c < 256; ++c)
    {
        data = GetCharacterData(c);
        if (data->attributes & CA_BOSS)
        {
            return c;
        }
    }
    return 0;
}

const u8 BasicWeaponsByType[] = { ITEM_SWORD_IRON,        ITEM_LANCE_IRON, ITEM_AXE_IRON,        ITEM_BOW_IRON,
                                  ITEM_STAFF_HEAL,        ITEM_ANIMA_FIRE, ITEM_LIGHT_LIGHTNING, ITEM_DARK_FLUX,
                                  ITEM_MONSTER_ROTTENCLW, ITEM_LOCKPICK,   ITEM_ELIXIR,          ITEM_VULNERARY };
static void SilentTryAddItem(struct Unit * unit, int itemType)
{
    for (int i = 0; i < 5; ++i)
    {
        if (!unit->items[i])
        {
            unit->items[i] = MakeNewItem(BasicWeaponsByType[itemType]);
            break;
        }
    }
}

void GrantWeapons(struct Unit * unit)
{
    if (unit->items[0])
    {
        return;
    }

    for (int i = 0; i < 8; ++i)
    {
        if (unit->ranks[i])
        {
            SilentTryAddItem(unit, i);
        }
    }
    if (UNIT_CATTRIBUTES(unit) & CA_LOCK_3)
    {
        SilentTryAddItem(unit, 8);
    }
    if (UNIT_CATTRIBUTES(unit) & CA_THIEF)
    {
        SilentTryAddItem(unit, 9);
    }
    if (UNIT_FACTION(unit) == FACTION_RED)
    {
        return;
    }
    if (UNIT_CATTRIBUTES(unit) & CA_PROMOTED)
    {
        SilentTryAddItem(unit, 10); // elixir
    }
    else
    {
        SilentTryAddItem(unit, 11); // vuln
    }
}

inline s8 CanUnitCrossTerrain2(struct Unit * unit, int terrain)
{
    const s8 * lookup = GetUnitMovementCost(unit);
    return (lookup[terrain] > 0) ? TRUE : FALSE;
}

void FindNearestTile(struct Unit * unit)
{
    if (unit->state & (US_DEAD | US_NOT_DEPLOYED | US_BIT16))
    {
        return;
    }
    int xOut = -1;
    int yOut = -1;
    int iy, ix, minDistance = 9999;

    unit->xPos = gActiveUnit->xPos;
    unit->yPos = gActiveUnit->yPos;
    // Fill the movement map
    GenerateExtendedMovementMap(unit->xPos, unit->yPos, TerrainTable_MovCost_FlyNormal);

    // Put the active unit on the unit map (kinda, just marking its spot)
    // // gBmMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;

    // Remove the actor unit from the unit map (why?)
    // // gBmMapUnit[unit->yPos][unit->xPos] = 0;

    for (iy = gBmMapSize.y - 1; iy >= 0; --iy)
    {
        for (ix = gBmMapSize.x - 1; ix >= 0; --ix)
        {
            int distance;

            if (gBmMapMovement[iy][ix] > MAP_MOVEMENT_MAX)
                continue;

            if (gBmMapUnit[iy][ix] != 0)
                continue;

            if (gBmMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
                continue;

            if (!CanUnitCrossTerrain2(unit, gBmMapTerrain[iy][ix]))
                continue;

            distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);

            if (minDistance >= distance)
            {
                minDistance = distance;

                xOut = ix;
                yOut = iy;
            }
        }
    }

    // Remove the active unit from the unit map again
    // gBmMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
    if (xOut >= 0)
    {
        unit->xPos = xOut;
    }
    else
    {
        unit->xPos = 0;
    }
    if (yOut >= 0)
    {
        unit->yPos = yOut;
    }
    else
    {
        unit->yPos = 0;
    }
    gBmMapUnit[unit->yPos][unit->xPos] = unit->index;
}

void LoadAllUnits(int type, int uid)
{
    struct UnitDefinition uDef;
    struct Unit * unit;

    int i = 1;
    int end = 0xC0;
    u32 attr = 0;
    int c = 1;        // char id
    int c_end = 0xFD; // last BWL is 0x45
    if (type == BossUnits)
    {
        i = 0x80;
        attr = CA_BOSS;
        c_end = 0xFD;
    }
    if (type == PlayerUnits)
    {
        end = 0x80;
        c_end = 50;
    }
    if (type == SinglePlayer)
    {
        c = uid;
        c_end = uid + 1;
    }
    if (type == SingleNPC)
    {
        c = uid;
        c_end = uid + 1;
        i = 0x40;
    }
    if (type == SingleEnemy)
    {
        c = uid;
        c_end = uid + 1;
        i = 0x80;
    }

    int deployedPlayers = 0;
    int deployedNPCs = 0;
    int deployedEnemies = 0;

    u32 charIDsToIgnore[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
    int i_copy = i;

    int tmp = 0;
    if (type != ExistingUnits)
    {
        for (; i < end; ++i)
        {
            unit = GetUnit(i);
            if (!UNIT_IS_VALID(unit))
            {
                continue;
            }
            tmp = (UNIT_FACTION(unit) >> 6) + 1;
            deployedPlayers += tmp & 1;
            deployedNPCs += (tmp & 2) >> 1;
            deployedEnemies += tmp >> 2;

            tmp = unit->pCharacterData->number;

            charIDsToIgnore[tmp >> 5] |= 1 << (tmp & 0x1F); // make 8 bitfields of unitIDs to ignore
                                                            // 8 words * 32 bits = 256 characters
        }
    }
    i = i_copy;

    for (; i < end; ++i)
    {
        if (attr)
        {
            c = FindNextBoss(c);
            if (!c)
            {
                break;
            }
        }
        if (c >= c_end)
        {
            break;
        }
        if (charIDsToIgnore[c >> 5] & (1 << (c & 0x1F)))
        {
            c++;
            continue;
        }
        unit = GetUnit(i);
        if (!unit)
        {
            continue;
        }
        if (!(unit->pCharacterData) && (type == ExistingUnits))
        {
            continue;
        }
        if ((unit->pCharacterData) && (type != ExistingUnits))
        {
            continue;
        }
        if (type == ExistingUnits)
        {
            c = unit->pCharacterData->number;
        }
        u32 state = unit->state;
        tmp = (UNIT_FACTION(unit) >> 6) + 1;
        deployedPlayers += tmp & 1;
        deployedNPCs += (tmp & 2) >> 1;
        deployedEnemies += tmp >> 2;
        switch (tmp)
        {
            case 1:
            {
                if (deployedPlayers > 50)
                {
                    state |= US_NOT_DEPLOYED;
                    continue;
                }
                break;
            }
            case 2:
            {
                if (deployedNPCs > 20)
                {
                    state |= US_NOT_DEPLOYED;
                    continue;
                }
                break;
            }
            case 3:
            {
                if (deployedEnemies > 50)
                {
                    state |= US_NOT_DEPLOYED;
                    continue;
                }
                break;
            }
            default:
        }

        if (type == ExistingUnits)
        {
            ReinitUnitDef(&uDef, unit);
            ClearUnit(unit);
        }
        else
        {
            ClearUnit(unit);
            InitUnitDef(&uDef, unit, GetCharacterData(c));
        }
        LoadUnit(&uDef);
        GrantWeapons(unit);
        unit->state = state;
        FindNearestTile(unit);
        c++;
    }
}

void SaveLoadUnits(DebuggerProc * proc)
{
    int id = proc->id;
    LoadAllUnits(id, proc->tmp[id]);
}

int GetLoadMax(int val)
{
    return 0xFF;
}
int GetLoadMin(int val)
{
    return 0x1;
}

void RedrawLoadMenu(DebuggerProc * proc);
void LoadUnitsInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    LoadIconPalettes(4);
    // struct Unit* unit = proc->unit;
    for (int i = 0; i < NumberOfLoad; ++i)
    {
        proc->tmp[i] = 0;
    }

    proc->tmp[0] = 1;    // Eirika default
    proc->tmp[1] = 0xCC; // Messenger
    proc->tmp[2] = 0x68; // O'Neil
    // proc->tmp[0] = unit->pCharacterData->number;
    // proc->tmp[1] = unit->pClassData->number;
    // proc->tmp[2] = unit->level;
    // proc->tmp[3] = unit->exp;
    // proc->tmp[4] = unit->conBonus;
    // proc->tmp[5] = unit->movBonus;
    // proc->tmp[6] = unit->statusIndex;

    int x = NUMBER_X - LoadNameWidth - 1;
    int y = Y_HAND - 1;
    int w = LoadNameWidth + (START_X - NUMBER_X) + 3;
    int h = (NumberOfLoad * 2) + 2;

    DrawUiFrame(
        BG_GetMapBuffer(1),            // back BG
        x, y, w, h, TILEREF(0, 0), 0); // style as 0 ?

    struct Text * th = gStatScreen.text;

    for (int i = 0; i <= NumberOfLoad + 3; ++i)
    {
        InitText(&th[i], LoadNameWidth);
    }

    RedrawLoadMenu(proc);
}

extern int sStatusNameTextIdLookup[];
void RedrawLoadMenu(DebuggerProc * proc)
{
    // TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-2, Y_HAND), 9,
    // 2 * NumberOfLoad, 0);
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    ResetIconGraphics();
    // ResetText();
    // struct Unit* unit = proc->unit;
    struct Text * th = gStatScreen.text;
    int i = 0;
    for (i = 0; i <= NumberOfLoad + 3; ++i)
    {
        ClearText(&th[i]);
    }

    i = 0;

    Text_DrawString(&th[i], "Load Player");
    i++;
    Text_DrawString(&th[i], "Load NPC");
    i++;
    Text_DrawString(&th[i], "Load Enemy");
    i++;
    Text_DrawString(&th[i], "Load all players");
    i++;
    Text_DrawString(&th[i], "Load all bosses");
    i++;
    Text_DrawString(&th[i], "Reload units");
    i++;
    // Text_DrawString(&th[i], "Preparations menu"); i++;
    Text_DrawString(&th[i], GetStringFromIndexSafe(GetCharacterData(proc->tmp[0])->nameTextId));
    i++;
    Text_DrawString(&th[i], GetStringFromIndexSafe(GetCharacterData(proc->tmp[1])->nameTextId));
    i++;
    Text_DrawString(&th[i], GetStringFromIndexSafe(GetCharacterData(proc->tmp[2])->nameTextId));
    i++;

    int x = NUMBER_X - (LoadNameWidth);
    for (i = 0; i < NumberOfLoad; ++i)
    {
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (i * 2)));
    }
    PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x + 7, Y_HAND));
    i++;
    PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x + 7, Y_HAND + 2));
    i++;
    PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x + 7, Y_HAND + 4));
    i++;
    for (i = 0; i < 3; ++i)
    {
        // PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i*2)),
        // TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
        PutNumberHex(
            gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i * 2)), TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
    }

    // for (i = 0; i < NumberOfLoad; ++i) { // uses
    //     if (proc->tmp[i]) { n = (proc->tmp[i] & 0xFF00) >> 8; } else { n = 0; }
    //     PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 3, Y_HAND +
    //     (i*2)), TEXT_COLOR_SYSTEM_GOLD, n);
    // }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

void LoadUnitsIdle(DebuggerProc * proc)
{
    // DisplayVertUiHand(CursorLocationTable[proc->digit].x,
    // CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if (keys & B_BUTTON)
    { // press B to not save stats
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update stats and continue
        SaveLoadUnits(proc);
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
    };
    if (proc->editing)
    {
        DisplayVertUiHand(CursorLocationTable[proc->digit].x, (Y_HAND + (proc->id * 2)) * 8);
        int max = GetLoadMax(proc->id);
        int min = GetLoadMin(proc->id);
        int max_digits = GetMaxDigits(max, 1);
        int val = 0;

        if (keys & DPAD_RIGHT)
        {
            if (proc->digit > 0)
            {
                proc->digit--;
            }
            else
            {
                proc->digit = max_digits - 1;
                proc->editing = false;
            }
            RedrawLoadMenu(proc);
        }
        if (keys & DPAD_LEFT)
        {
            if (proc->digit < (max_digits - 1))
            {
                proc->digit++;
            }
            else
            {
                proc->digit = 0;
                proc->editing = false;
            }
            RedrawLoadMenu(proc);
        }

        if (keys & DPAD_UP)
        {
            if ((proc->tmp[proc->id]) == max)
            {
                proc->tmp[proc->id] = min;
            }
            else
            {
                proc->tmp[proc->id] += DigitHexTable[proc->digit];
                if ((proc->tmp[proc->id]) > max)
                {
                    proc->tmp[proc->id] = max;
                }
            }
            // proc->tmp[proc->id] = GetPrevLoad(proc->tmp[proc->id], proc->id, min,
            // max);
            RedrawLoadMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            if ((proc->tmp[proc->id]) == min)
            {
                proc->tmp[proc->id] = max;
            }
            else
            {
                val = (proc->tmp[proc->id]) - DigitHexTable[proc->digit];
                if (val < min)
                {
                    proc->tmp[proc->id] = min;
                }
                else
                {
                    proc->tmp[proc->id] = val;
                }
            }
            // proc->tmp[proc->id] = GetNextLoad(proc->tmp[proc->id], proc->id, min,
            // max);
            RedrawLoadMenu(proc);
        }
    }
    else
    {
        DisplayUiHand(CursorLocationTable[0].x - ((LoadNameWidth + 2) * 8), (Y_HAND + (proc->id * 2)) * 8);
        if (keys & DPAD_RIGHT)
        {
            proc->digit = 1;
            proc->editing = true;
            if (proc->id > 2)
            {
                proc->id = 2;
            }
        }
        if (keys & DPAD_LEFT)
        {
            proc->digit = 0;
            proc->editing = true;
            if (proc->id > 2)
            {
                proc->id = 2;
            }
        }

        if (keys & DPAD_UP)
        {
            proc->id--;
            if (proc->id < 0)
            {
                proc->id = NumberOfLoad - 1;
            }
            RedrawLoadMenu(proc);
        }
        if (keys & DPAD_DOWN)
        {
            proc->id++;
            if (proc->id >= NumberOfLoad)
            {
                proc->id = 0;
            }

            RedrawLoadMenu(proc);
        }
    }
}

void ChooseTileInit(DebuggerProc * proc)
{ // if need to load gfx
    EndPlayerPhaseSideWindows();
    int lastTile = proc->lastTileHovered;
    for (int i = 0; i < xTilesAmount; ++i)
    {
        proc->tmp[i] = (lastTile + i) & 0x3FF;
    }
    RenderTilesetRowOnBg2(proc);
}

void OffsetTileset(DebuggerProc * proc, int amount)
{
    int newVal = 0;
    if (amount < 0)
    {
        for (int i = 0; i < xTilesAmount; ++i)
        {
            newVal = proc->tmp[i] & 0x3FF;
            proc->tmp[i] = (newVal - ABS(amount)) & 0x3FF;
        }
    }
    else
    {
        for (int i = 0; i < xTilesAmount; ++i)
        {
            newVal = proc->tmp[i] & 0x3FF;
            proc->tmp[i] = (newVal + amount) & 0x3FF;
        }
    }
    proc->lastTileHovered = proc->tmp[0];
    RenderTilesetRowOnBg2(proc);
}

void ClearTilesetRow(DebuggerProc * proc)
{
    gLCDControlBuffer.bg1cnt.priority = 1;
    gLCDControlBuffer.bg2cnt.priority = 2;
    SetBackgroundTileDataOffset(2, 0);
    SetBlendTargetA(0, 1, 0, 0, 0);
    SetBlendBackdropA(1);
    SetBlendAlpha(11, 5);
    BG_Fill(gBG2TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT);
}

// bg0 text, bg1 menu bgs, bg2 blank, bg3 map
void ChooseTileIdle(DebuggerProc * proc)
{
    int x = (gBmSt.camera.x >> 4) + 7;
    int y = (gBmSt.camera.y >> 4) + 9;
    u16 keys = gKeyStatusPtr->newKeys | gKeyStatusPtr->repeatedKeys;
    if (keys & A_BUTTON)
    {
        proc->tileID = proc->tmp[7];
        Proc_Goto(proc, EditMapLabel);
    }
    if (keys & B_BUTTON)
    {
        gActionData.xMove = gActiveUnitMoveOrigin.x;
        gActionData.yMove = gActiveUnitMoveOrigin.y;
        PlayerPhase_ApplyUnitMovementWithoutMenu(proc);
        ClearTilesetRow(proc);
        BackPressSFX();
        Proc_Goto(proc, RestartLabel);
    }
    if (keys & DPAD_LEFT)
    {
        OffsetTileset(proc, -1);
    }
    if (keys & DPAD_RIGHT)
    {
        OffsetTileset(proc, 1);
    }
    if (keys & DPAD_UP)
    {
        OffsetTileset(proc, -16);
    }
    if (keys & DPAD_DOWN)
    {
        OffsetTileset(proc, 16);
    }

    PutMapCursor(x << 4, y << 4, 0);
}

extern u16 sTilesetConfig[];
void RenderTilesetRowOnBg2(DebuggerProc * proc)
{
    int ix, iy;
    // RegisterBlankTile(0x400);
    // BG_Fill(gBG0TilemapBuffer, 0);
    // BG_Fill(gBG1TilemapBuffer, 0);
    // SetBackgroundTileDataOffset(2, 0);
    // BG_Fill(gBG2TilemapBuffer, 0);
    //
    // BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT);

    RenderBmMapOnBg2();

    SetBackgroundTileDataOffset(2, 0x8000);

    gBmSt.mapRenderOrigin.x = gBmSt.camera.x >> 4;
    gBmSt.mapRenderOrigin.y = gBmSt.camera.y >> 4;

    for (iy = (10 - 1); iy >= 9; --iy) // 9 so only bottom row
        for (ix = (15 - 1); ix >= 0; --ix)
            DisplayTilesetTile(
                proc, gBG2TilemapBuffer, ix, iy, (short)gBmSt.mapRenderOrigin.x + ix,
                (short)gBmSt.mapRenderOrigin.y + iy);

    BG_EnableSyncByMask(1 << 2);
    BG_SetPosition(2, 0, 0);
}

void DisplayTilesetTile(DebuggerProc * proc, u16 * bg, int xTileMap, int yTileMap, int xBmMap, int yBmMap)
{
    u16 * out = bg + yTileMap * 0x40 + xTileMap * 2; // TODO: BG_LOCATED_TILE?
    // u16* tile = sTilesetConfig + gBmMapBaseTiles[yBmMap][xBmMap];

    u16 * tile = sTilesetConfig + (proc->tmp[xTileMap] << 2);

    // TODO: palette id constants
    u16 base = gBmMapFog[yBmMap][xBmMap] ? (6 << 12) : (11 << 12);

    out[0x00 + 0] = base + *tile++;
    out[0x00 + 1] = base + *tile++;
    out[0x20 + 0] = base + *tile++;
    out[0x20 + 1] = base + *tile++;
}

void EditMapInit(DebuggerProc * proc)
{
    ClearTilesetRow(proc);
    StartPlayerPhaseTerrainWindow();
}

void FixAndHandlePlayerCursorMovement(void)
{
    FixCursorOverflow();
    HandlePlayerCursorMovement();
}

extern const struct ProcCmd gProcScr_TerrainDisplay[];
void EditMapIdle(DebuggerProc * proc)
{
    FixAndHandlePlayerCursorMovement();
    int x = gBmSt.playerCursor.x;
    int y = gBmSt.playerCursor.y;
    if (gKeyStatusPtr->newKeys & A_BUTTON)
    { // see
      // https://github.com/FireEmblemUniverse/fireemblem8u/blob/a608c6c4b6bc0cdf15f14292c99657cae73f6bdb/src/bmmap.c#L271
        gBmMapBaseTiles[y][x] = proc->tileID << 2;
        RefreshTerrainBmMap();
        UpdateRoofedUnits();
        RenderBmMap();
        ProcPtr terrainDispProc = Proc_Find(gProcScr_TerrainDisplay);
        Proc_Goto(terrainDispProc, 0); // new terrain
        // ConfirmPressSFX();
        return;
    }

    if (gKeyStatusPtr->newKeys & B_BUTTON)
    {
        ConfirmPressSFX();
        Proc_Goto(proc, ChooseTileLabel);
        return;
    }
    if (gKeyStatusPtr->newKeys & (R_BUTTON | START_BUTTON))
    {
        ConfirmPressSFX();
        Proc_Goto(proc, ChooseTileLabel);
        return;
    }
    PutMapCursor(gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y, IsUnitSpriteHoverEnabledAt(x, y) ? 3 : 0);
}

void PickupUnitIdle(DebuggerProc * proc)
{
    FixAndHandlePlayerCursorMovement();
    if (gKeyStatusPtr->newKeys & A_BUTTON)
    {
        gActionData.xMove = gBmSt.playerCursor.x;
        gActionData.yMove = gBmSt.playerCursor.y;
        gActiveUnitMoveOrigin.x = gBmSt.playerCursor.x;
        gActiveUnitMoveOrigin.y = gBmSt.playerCursor.y;
        PlayerPhase_ApplyUnitMovementWithoutMenu(proc);
        PlaySoundEffect(0x6B);
        Proc_Goto(proc, RestartLabel);
        return;
    }

    if (gKeyStatusPtr->newKeys & B_BUTTON)
    {
        gActionData.xMove = gActiveUnitMoveOrigin.x;
        gActionData.yMove = gActiveUnitMoveOrigin.y;
        PlayerPhase_ApplyUnitMovementWithoutMenu(proc);
        PlaySoundEffect(0x6B);
        Proc_Goto(proc, RestartLabel);
        return;
    }
    PutMapCursor(
        gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y,
        IsUnitSpriteHoverEnabledAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y) ? 3 : 0);
}

int ClearActiveUnitStuff(DebuggerProc * proc)
{
    MU_EndAll();
    if (gActiveUnit)
    {
        if (!(gActiveUnit->state & (US_DEAD | US_NOT_DEPLOYED | US_BIT16)))
        {
            // if (UNIT_FACTION(gActiveUnit) == gPlaySt.faction) { // if turn of the
            // actor, refresh EndAllMus();
            gActiveUnit->state &= ~(US_HIDDEN | US_UNSELECTABLE | US_CANTOING);
            //}
        }
    }
    s8 cameraReturn = EnsureCameraOntoPositionIfValid(proc, gActiveUnitMoveOrigin.x, gActiveUnitMoveOrigin.y);
    cameraReturn ^= 1;
    SetCursorMapPositionIfValid(gActiveUnitMoveOrigin.x, gActiveUnitMoveOrigin.y);
    gBmSt.gameStateBits &= ~BM_FLAG_3;

    HideMoveRangeGraphics();

    RefreshEntityBmMaps();
    RefreshUnitSprites();
    RenderBmMap();
    return cameraReturn;
}

void PlayerPhase_ApplyUnitMovementWithoutMenu(DebuggerProc * proc)
{
    gActiveUnit->xPos = gActionData.xMove;
    gActiveUnit->yPos = gActionData.yMove;
    UnitFinalizeMovement(gActiveUnit);
    ResetTextFont();
}

int PlayerPhase_PrepareActionBasic(DebuggerProc * proc)
{
    s8 cameraReturn;
    SetupUnitFunc();

    cameraReturn = EnsureCameraOntoPositionIfValid(
        proc, GetUnit(gActionData.subjectIndex)->xPos, GetUnit(gActionData.subjectIndex)->yPos);
    cameraReturn ^= 1;
    // if ((gActionData.unitActionType != UNIT_ACTION_WAIT) &&
    // !gBmSt.just_resumed)
    //{
    //     gActionData.suspendPointType = SUSPEND_POINT_DURINGACTION;
    //     WriteSuspendSave(SAVE_ID_SUSPEND);
    // }

    return cameraReturn;
}

void CallPlayerPhase_FinishAction(DebuggerProc * proc)
{
    PlayerPhase_FinishActionNoCanto(proc);
    ProcPtr playerPhaseProc = Proc_Find(gProcScr_PlayerPhase);
    Proc_Goto(playerPhaseProc, 0);
}

extern void SkillDebugCommand_OnSelect(DebuggerProc * proc);
int UnitActionFunc(DebuggerProc * proc)
{
    switch (proc->actionID)
    {
        case ActionID_Promo:
        {
            PromoAction(proc);
            break;
        }
        case ActionID_Arena:
        {
            ArenaAction(proc);
            break;
        }
        case ActionID_Levelup:
        {
            LevelupAction(proc);
            break;
        }
        case ActionID_DebugSkills:
        {
            SkillDebugCommand_OnSelect(proc);
            break;
        }

        default:
    }
    proc->actionID = 0;
    return 0;
}

int PromoAction(DebuggerProc * proc)
{
    StartBmPromotion(proc);
    Proc_Goto(proc, PostActionLabel);
    return 0;
}
int ArenaAction(DebuggerProc * proc)
{
    StartArenaScreen();
    Proc_Goto(proc, PostActionLabel);
    return 0;
}
extern const struct ProcCmd sProcScr_BattleAnimSimpleLock[];
int LevelupAction(DebuggerProc * proc)
{
    gActiveUnit->exp = 99;
    InitBattleUnit(&gBattleActor, gActiveUnit);
    // if (UNIT_FACTION(&gBattleActor.unit) != FACTION_BLUE)
    // return;

    if (CanBattleUnitGainLevels(&gBattleActor))
    { // see BattleApplyMiscAction
        if (!(gPlaySt.chapterStateBits & PLAY_FLAG_EXTRA_MAP))
        {

            gBattleActor.expGain = 1;
            gBattleActor.unit.exp += 1;

            CheckBattleUnitLevelUp(&gBattleActor);

            // Proc_StartBlocking(sProcScr_BattleAnimSimpleLock, proc);
            MU_EndAll();
            ResetText();

            gBattleActor.weaponBefore = 1; // see BeginMapAnimForSummon

            gManimSt.hp_changing = 0;
            gManimSt.u62 = 0;
            gManimSt.actorCount_maybe = 1;

            gManimSt.subjectActorId = 0;
            gManimSt.targetActorId = 1;

            SetupMapBattleAnim(&gBattleActor, &gBattleTarget, gBattleHitArray);
            // Proc_Start(ProcScr_MapAnimSummon, PROC_TREE_3);
            Proc_Goto(proc, LevelupLabel);
            return 0;
        }
    }
    Proc_Goto(proc, PostActionLabel);

    return 0;
}

u8 StartPromotionNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    if (CanActiveUnitPromote() != 1)
    {
        return MENU_ACT_SKIPCURSOR | MENU_ACT_SND6B;
    }
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    proc->actionID = ActionID_Promo;
    Proc_Goto(proc, UnitActionLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 StartArenaNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    proc->actionID = ActionID_Arena;
    Proc_Goto(proc, UnitActionLabel); // 0xb7
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 LevelupNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    proc->actionID = ActionID_Levelup;
    Proc_Goto(proc, UnitActionLabel); // 0xb7
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 ChStateNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, ChStateLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 StartGodmodeNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    proc->actionID = 0;
    Proc_Goto(proc, RestartLabel); // 0xb7
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    if (procIdler->godMode)
    {
        procIdler->godMode = false;
        proc->godMode = false;
    }
    else
    {
        procIdler->godMode = true;
        proc->godMode = true;
    }
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 ToggleBootNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    proc->actionID = 0;
    Proc_Goto(proc, RestartLabel); // 0xb7
    int boot = GetBootType();
    boot++;
    boot = Mod(boot, 3);
    SetBootType(boot);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 ControlAiNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    proc->actionID = 0;
    Proc_Goto(proc, RestartLabel); // 0xb7
    // DebuggerProc* procIdler = Proc_Find(DebuggerProcCmdIdler);
    if (gPlaySt.config.debugControlRed)
    {
        gPlaySt.config.debugControlRed = 0;
    }
    else
    {
        gPlaySt.config.debugControlRed = 2;
    }
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 PageIncrementNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    proc->actionID = 0;
    Proc_Goto(proc, RestartLabel); // 0xb7
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    proc->page++;
    if (proc->page > (NumberOfPages - 1))
    {
        proc->page = 0;
    }
    procIdler->page = proc->page;
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

void ComputeBattleUnitEffectiveStats(struct BattleUnit * attacker, struct BattleUnit * defender)
{
    ComputeBattleUnitEffectiveHitRate(attacker, defender);
    ComputeBattleUnitEffectiveCritRate(attacker, defender);
    ComputeBattleUnitSilencerRate(attacker, defender);
    ComputeBattleUnitSpecialWeaponStats(attacker, defender);
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmdIdler);
    if (!proc)
    {
        return;
    }
#define MaxStat 99
    if (proc->godMode)
    {
        struct BattleUnit * bunitA = attacker;
        struct BattleUnit * bunitB = defender;
        if (UNIT_FACTION(&attacker->unit) == FACTION_RED)
        {
            bunitA = defender;
            bunitB = attacker;
        }
        bunitA->battleAttack = bunitB->unit.maxHP;
        bunitA->battleDefense = MaxStat;
        bunitA->battleSpeed = MaxStat;
        bunitA->battleHitRate = MaxStat * 2;
        bunitA->battleAvoidRate = MaxStat;
        bunitA->battleEffectiveHitRate = 100;
        bunitA->battleCritRate = MaxStat * 2;
        bunitA->battleDodgeRate = 100;
        bunitA->battleEffectiveCritRate = 100;

        bunitB->hpInitial = 1;
        bunitB->battleAttack = 0;
        bunitB->battleDefense = 0;
        bunitB->battleSpeed = 0;
        bunitB->battleHitRate = 0;
        bunitB->battleAvoidRate = 0;
        bunitB->battleEffectiveHitRate = 0;
        bunitB->battleCritRate = 0;
        bunitB->battleDodgeRate = 0;
        bunitB->battleEffectiveCritRate = 0;
    }
}

u8 PickupUnitNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, PickupUnitLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 EditMapNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, ChooseTileLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 EditTrapNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, EditTrapLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 EditStatsNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, EditStatsLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditItemsNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, EditItemsLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditMiscNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, EditMiscLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 EditAiNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, EditAiLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 EditBgmNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, EditBgmLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 LoadUnitsNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, LoadUnitsLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditStateNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, StateLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditWExpNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, WExpLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditSupportNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, SupportLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 SupplyNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, SupplyLabel);
    // gActionData.unitActionType = UNIT_ACTION_TRADED_1D;
    StartBmSupply(gActiveUnit, NULL);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 ListNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, ListLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 DebugSkillsNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    proc->actionID = ActionID_DebugSkills;
    Proc_Goto(proc, UnitActionLabel); // 0xb7
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 AiControlRemainingUnitsNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    proc->actionID = 0;
    Proc_Goto(proc, RestartLabel); // 0xb7
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    if (procIdler->autoplay)
    {
        procIdler->autoplay = false;
        proc->autoplay = false;
    }
    else
    {
        procIdler->autoplay = true;
        proc->autoplay = true;
    }
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 GfxViewerNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, GfxViewerLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 AnimViewerNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    EndDebuggerBanimPreview();
    BMapDispResume();
    Proc_Goto(proc, AnimViewerLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

int ShouldStartDebugger(void)
{
    if (CheckFlag(DebuggerTurnedOff_Flag))
    {
        return false;
    }
    return true;
}

void SetupUnitFunc(void)
{
    gBattleActor.weaponBefore = gBattleTarget.weaponBefore =
        GetUnit(gActionData.subjectIndex)->items[gActionData.itemSlotIndex];

    gBattleActor.weapon = gBattleTarget.weapon = GetUnitEquippedWeapon(GetUnit(gActionData.subjectIndex));
    gBattleActor.hasItemEffectTarget = 0;
    gBattleTarget.statusOut = -1;
    gActionData.unitActionType = 1;
    UnitBeginAction(gActiveUnit);
}

extern u8 * pPromoJidLut;
extern int GetPromoTable(int classNumber, int aOrB);
u8 CanActiveUnitPromote(void)
{
    if (UNIT_FACTION(gActiveUnit) != gPlaySt.faction)
    {
        return 2;
    }
    u8 * promoTable = pPromoJidLut;
    int classNumber = gActiveUnit->pClassData->number;
    if ((!promoTable[classNumber * 2]) && (!promoTable[(classNumber * 2) + 1]))
    {             // gPromoJidLut[classNumber][0];
        return 2; // greyed out
    }

    return 1;
}
u8 CanActiveUnitPromoteMenu(const struct MenuItemDef * def, int number)
{
    return CanActiveUnitPromote();
}

u8 CallArenaIsUnitAllowed(const struct MenuItemDef * def, int number)
{
    return ArenaIsUnitAllowed(gActiveUnit);
}

u8 CallEndEventNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, EndLabel);
    CallEndEvent();
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

extern const struct MenuItemDef gDebuggerMenuItems[];
extern const struct MenuItemDef gDebuggerMenuItemsPage2[];
extern const struct MenuItemDef gDebuggerMenuItemsPage3[];
extern const struct MenuItemDef gDebuggerMenuItemsPage4[];
extern char * gDebuggerMenuText[];

extern const struct MenuItemDef * ggDebuggerMenuItems[];

int CountDebuggerMenuItems(int page)
{
    int result = 0;
    for (int i = 0; i < page; ++i)
    {
        for (int c = 0; c < 255; ++c)
        {
            if (!ggDebuggerMenuItems[i][c].name)
            {
                break;
            }
            result++;
        }
    }
    return result + page; // avoid the word 0 terminator offset
}

char * GetDebuggerMenuText(DebuggerProc * procIdler, int index)
{
    // index += procIdler->page * NumberOfOptions;
    index += CountDebuggerMenuItems(procIdler->page);
    return gDebuggerMenuText[index * 2];
}
char * GetDebuggerMenuDesc(DebuggerProc * procIdler, int index)
{
    index += CountDebuggerMenuItems(procIdler->page);
    return gDebuggerMenuText[(index * 2) + 1];
}

int DebuggerMenuItemDraw(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);

    Text_DrawString(&menuItem->text, GetDebuggerMenuText(procIdler, menuItem->itemNumber));
    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
    return 0;
}
int GodmodeDrawText(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    if (procIdler->godMode)
    {
        Text_DrawString(&menuItem->text, " Godmode on");
    }
    else
    {
        Text_DrawString(&menuItem->text, GetDebuggerMenuText(procIdler, menuItem->itemNumber));
    }
    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
    return 0;
}

int BootmodeDrawText(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    int boot = GetBootType();

    if (boot == 1)
    {
        Text_DrawString(&menuItem->text, " Restart");
    }
    // else if (boot == 2)
    // {
    // Text_DrawString(&menuItem->text, " Restart2");
    // }
    else if (boot == 2)
    {
        Text_DrawString(&menuItem->text, " Resume");
    }
    else
    {
        Text_DrawString(&menuItem->text, " Boot title");
    }
    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
    return 0;
}

int ControlAiDrawText(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    // DebuggerProc* procIdler = Proc_Find(DebuggerProcCmdIdler);
    if (gPlaySt.config.debugControlRed)
    {
        Text_DrawString(&menuItem->text, " Enemy Ctrl on");
    }
    else
    {
        DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
        Text_DrawString(&menuItem->text, GetDebuggerMenuText(procIdler, menuItem->itemNumber));
    }
    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
    return 0;
}

int AiControlRemainingUnitsDrawText(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    if (procIdler->autoplay)
    {
        Text_DrawString(&menuItem->text, " Autoplay on");
    }
    else
    {
        Text_DrawString(&menuItem->text, GetDebuggerMenuText(procIdler, menuItem->itemNumber));
    }
    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
    return 0;
}
void DebuggerUpdateMouthFrames(DebuggerProc * proc);
void PageMenuItemDrawSprites(struct MenuProc * menu)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    DebuggerUpdateMouthFrames(proc);
    int chr = 0x289;
    int x = (menu->menuItems[menu->itemCount - 1]->xTile * 8) + 6 + (8 * 3);
    int y = (menu->menuItems[menu->itemCount - 1]->yTile * 8) + 4;

    PutSprite(0, x, y, gObject_8x8, TILEREF(chr, 0) + OAM2_LAYER(0) + proc->page + 1);
    x += 8;
    PutSprite(0, x, y, gObject_8x8, TILEREF(chr, 0) + OAM2_LAYER(0));
    x += 8;
    PutSprite(0, x, y, gObject_8x8, TILEREF(chr, 0) + OAM2_LAYER(0) + NumberOfPages);
    x += 8;
}

int PageMenuItemDraw(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    Text_DrawString(&menuItem->text, GetDebuggerMenuText(procIdler, menuItem->itemNumber));
    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
    return 0;
}

struct Unit * GetNextUnit(int deployId, int allegiance)
{
    struct Unit * unit;
    // deployId++;
    for (int i = deployId + 1; i < ((allegiance & 0xC0) + 0x40); ++i)
    {
        unit = GetUnit(i);
        if (UNIT_IS_VALID(unit))
        {
            return unit;
        }
    }
    for (int i = allegiance; i < deployId; ++i)
    {
        unit = GetUnit(i);
        if (UNIT_IS_VALID(unit))
        {
            return unit;
        }
    }
    return NULL;
}

struct Unit * GetPrevUnit(int deployId, int allegiance)
{
    struct Unit * unit;
    // deployId--;
    // if (!deployId) { deployId = ((allegiance & 0xC0) + 0x3F); }
    for (int i = deployId - 1; i >= allegiance; --i) // should loop back to itself I guess
    {
        unit = GetUnit(i);
        if (UNIT_IS_VALID(unit))
        {
            return unit;
        }
    }
    for (int i = ((allegiance & 0xC0) + 0x3F); i > deployId; --i) // should loop back to itself I guess
    {
        unit = GetUnit(i);
        if (UNIT_IS_VALID(unit))
        {
            return unit;
        }
    }
    return NULL;
}

void SwapToPreviousUnit(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit;
    int deployId = unit->index & 0xFF;
    int allegiance = UNIT_FACTION(unit); // 0x00, 0x40, or 0x80
    if (!allegiance)
    {
        allegiance = 1;
    } // start GetUnit(i) at 1, not 0.
    unit = GetPrevUnit(deployId, allegiance);
    if (unit)
    {
        proc->unit = unit;
        ClearMainMenuGfx(proc);
    }
}
void SwapToNextUnit(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit;
    int deployId = unit->index & 0xFF;
    int allegiance = UNIT_FACTION(unit);
    unit = GetNextUnit(deployId, allegiance);
    if (unit)
    {
        proc->unit = unit;
        ClearMainMenuGfx(proc);
    }
}

u8 PageIdler(struct MenuProc * menu, struct MenuItemProc * command)
{
    u16 keys = gKeyStatusPtr->repeatedKeys;
    PageMenuItemDrawSprites(menu);
    if (!keys)
    {
        return MENU_ITEM_NONE;
    }
    DebuggerProc * proc = Proc_Find(DebuggerProcCmd);
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    proc->mainID = menu->itemCurrent;
    procIdler->mainID = menu->itemCurrent;
    int page = proc->page;

    if (keys & L_BUTTON)
    {
        SwapToPreviousUnit(proc);
        gActiveUnitMoveOrigin.x = proc->unit->xPos;
        gActiveUnitMoveOrigin.y = proc->unit->yPos;
        Proc_Goto(proc, RestartLabel);
        return MENU_ACT_SKIPCURSOR | MENU_ACT_CLEAR | MENU_ACT_END | MENU_ACT_SND6A;
    }
    if (keys & R_BUTTON)
    {
        SwapToNextUnit(proc);
        gActiveUnitMoveOrigin.x = proc->unit->xPos;
        gActiveUnitMoveOrigin.y = proc->unit->yPos;
        Proc_Goto(proc, RestartLabel);
        return MENU_ACT_SKIPCURSOR | MENU_ACT_CLEAR | MENU_ACT_END | MENU_ACT_SND6A;
    }

    if (keys & DPAD_LEFT)
    {
        page--;
    }
    if (keys & DPAD_RIGHT)
    {
        page++;
    }
    if (proc->page != page)
    {
        if (page < 0)
        {
            page = NumberOfPages - 1;
        }
        if (page >= NumberOfPages)
        {
            page = 0;
        }
        proc->page = page;
        procIdler->page = page;
        Proc_Goto(proc, RestartLabel);
        return MENU_ACT_SKIPCURSOR | MENU_ACT_CLEAR | MENU_ACT_END | MENU_ACT_SND6A;
    }
    return MENU_ITEM_NONE;
}

u8 MenuCancelSelectResumePlayerPhase(struct MenuProc * menu, struct MenuItemProc * item)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    ClearMainMenuGfx(proc);
    Proc_Goto(proc, EndLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_CLEAR | MENU_ACT_END | MENU_ACT_SND6B;
}

u8 DebuggerHelpBox(struct MenuProc * menu, struct MenuItemProc * item);
const struct MenuDef gDebuggerMenuDef = { { 1, 0, 10, 0 }, // { s8 x, y, w, h; };
                                          0,
                                          gDebuggerMenuItems,
                                          0,
                                          0,
                                          0,
                                          MenuCancelSelectResumePlayerPhase,
                                          MenuAutoHelpBoxSelect,
                                          DebuggerHelpBox };

const struct MenuDef gDebuggerMenuDefPage2 = { { 1, 0, 10, 0 }, // { s8 x, y, w, h; };
                                               0,
                                               gDebuggerMenuItemsPage2,
                                               0,
                                               0,
                                               0,
                                               MenuCancelSelectResumePlayerPhase,
                                               MenuAutoHelpBoxSelect,
                                               DebuggerHelpBox };
const struct MenuDef gDebuggerMenuDefPage3 = { { 1, 0, 10, 0 }, // { s8 x, y, w, h; };
                                               0,
                                               gDebuggerMenuItemsPage3,
                                               0,
                                               0,
                                               0,
                                               MenuCancelSelectResumePlayerPhase,
                                               MenuAutoHelpBoxSelect,
                                               DebuggerHelpBox };
const struct MenuDef gDebuggerMenuDefPage4 = { { 1, 0, 10, 0 }, // { s8 x, y, w, h; };
                                               0,
                                               gDebuggerMenuItemsPage4,
                                               0,
                                               0,
                                               0,
                                               MenuCancelSelectResumePlayerPhase,
                                               MenuAutoHelpBoxSelect,
                                               DebuggerHelpBox };

void UnitBeginActionInit(struct Unit * unit)
{
    if (!unit)
    {
        return;
    }
    gActiveUnit = unit;
    gActiveUnitId = unit->index;
    InitBattleUnit(&gBattleActor, unit);
    ClearUnit(&gBattleTarget.unit); // so a previous unit isn't affected
    gBattleTarget.unit.index = 0;   // (fixed bug of promote -> levelup with another char)

    gActiveUnitMoveOrigin.x = unit->xPos;
    gActiveUnitMoveOrigin.y = unit->yPos;
    gActionData.xMove = unit->xPos;
    gActionData.yMove = unit->yPos;

    gActionData.subjectIndex = unit->index;
    gActionData.targetIndex = 0;
    gActionData.itemSlotIndex = -1;
    gActionData.unitActionType = 0;
    gActionData.moveCount = 0;

    gBmSt.taken_action = 0;
    gBmSt.unk3F = 0xFF;

    sub_802C334(); // zeroes out a few bits of unknown ram

    // gActiveUnit->state |= US_HIDDEN;
    // gBmMapUnit[unit->yPos][unit->xPos] = 0;
}

int RestartNow(DebuggerProc * proc)
{
    Proc_Goto(proc, RestartLabel);
    return 0; // yield
}

void StartDebuggerProc(ProcPtr playerPhaseProc)
{ // based on PlayerPhase_MainIdle
    if (!ShouldStartDebugger())
    {
        return;
    }
    struct Unit * unit = GetUnit(gBmMapUnit[gBmSt.playerCursor.y][gBmSt.playerCursor.x]);
    struct Trap * trap = GetTrapAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y);

    if (!unit && !trap)
    {
        return;
    }

    if (unit)
    {
        gActiveUnitMoveOrigin.x = unit->xPos;
        gActiveUnitMoveOrigin.y = unit->yPos;
        UnitBeginActionInit(unit);
    }
    else
    {
        gActiveUnit = NULL;
        gActiveUnitId = 0;
        gActiveUnitMoveOrigin.x = gBmSt.playerCursor.x;
        gActiveUnitMoveOrigin.y = gBmSt.playerCursor.y;
    }
    if (!unit && trap)
    {
        unit = (struct Unit *)(-1);
    }

    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    if (!procIdler)
    {
        procIdler = Proc_Start(DebuggerProcCmdIdler, (void *)3);
        InitProc(procIdler);
    }
    procIdler->unit = unit;

    DebuggerProc * proc = Proc_Find(DebuggerProcCmd);
    if (!proc)
    {
        // proc = Proc_Start(DebuggerProcCmd, (void*)3);
        // ProcPtr playerPhaseProc = Proc_Find(gProcScr_PlayerPhase);
        proc = Proc_StartBlocking(DebuggerProcCmd, playerPhaseProc);
        InitProc(proc);
        CopyProcVariables(proc, procIdler);
    }
    // RestartDebuggerMenu(proc);
    // Proc_Goto(proc, RestartLabel);
}
void MakeMoveunitForAnyActiveUnit(void)
{
    if (!MU_Exists())
    {
        MU_Create(gActiveUnit);
        HideUnitSprite(gActiveUnit);
    }
    MU_SetDefaultFacing_Auto();
}
void InitProc(DebuggerProc * proc)
{
    proc->mainID = 0;
    proc->page = 0;
    proc->editing = false;
    proc->actionID = 0;
    proc->godMode = 0;
    proc->autoplay = 0;
    proc->bgmOverride = 0;
    proc->lastFlag = 1;
    proc->tileID = 1;
    proc->id = 0;
    proc->lastTileHovered = 0;
    for (int i = 0; i < tmpSize; ++i)
    {
        proc->tmp[i] = 0;
    }
}

//! FE8U = 0x08015450
void BmMain_StartPhase(ProcPtr proc)
{
    int phaseControl = gPlaySt.faction;
    if (gPlaySt.faction == FACTION_RED)
    {
        if (gPlaySt.config.debugControlRed)
        {
            phaseControl = FACTION_BLUE;
        }
    }
    if (gPlaySt.faction == FACTION_GREEN)
    {
        if (gPlaySt.config.debugControlGreen)
        {
            phaseControl = FACTION_BLUE;
        }
    }
    switch (phaseControl)
    {
        case FACTION_BLUE:
            Proc_StartBlocking(gProcScr_PlayerPhase, proc);
            break;

        case FACTION_RED:
            Proc_StartBlocking(gProcScr_CpPhase, proc);
            break;

        case FACTION_GREEN:
            Proc_StartBlocking(gProcScr_CpPhase, proc);
            break;
    }

    Proc_Break(proc);
}
void DebuggerStartNameFace(DebuggerProc * proc);
void RestartDebuggerMenu(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit; // GetUnit(gBmMapUnit[gBmSt.playerCursor.y][gBmSt.playerCursor.x]);

    if (!unit)
    {

        Proc_Goto(proc, EndLabel);
        return;
    }
    EndAllMenus();
    ResetText();
    ProcPtr playerPhaseProc = Proc_Find(gProcScr_PlayerPhase);
    Proc_Goto(playerPhaseProc, 9); // wait for menu?
    UnitBeginActionInit(unit);
    proc->actionID = 0;
    proc->editing = false;
    proc->actionID = 0;
    proc->id = 0;
    for (int i = 0; i < tmpSize; ++i)
    {
        proc->tmp[i] = 0;
    }
    if ((int)unit == (-1))
    {

        Proc_Goto(proc, EditTrapLabel);
        return;
    }
    SetBlendTargetA(0, 1, 0, 0, 0); // transparent ui
    SetBlendBackdropA(1);
    SetBlendAlpha(11, 5);
    gPlaySt.xCursor = gBmSt.playerCursor.x;
    gPlaySt.yCursor = gBmSt.playerCursor.y;
    // MU_EndAll();
    // ShowUnitSprite(unit);
    // UnitSpriteHoverUpdate();

    // gBmMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
    gActiveUnit->state |= US_HIDDEN;
    HideUnitSprite(gActiveUnit);
    MakeMoveunitForAnyActiveUnit();

    gBmSt.gameStateBits &= ~(BM_FLAG_0 | BM_FLAG_1);
    gBmSt.gameStateBits &= ~BM_FLAG_3;
    // PutMapCursor(
    // gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y,
    // IsUnitSpriteHoverEnabledAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y) ? 3 : 0);
    SetCursorMapPositionIfValid(gActiveUnitMoveOrigin.x, gActiveUnitMoveOrigin.y);
    // gActiveUnitMoveOrigin.x
    DebuggerStartNameFace(proc);
    struct MenuProc * menu = NULL;
    switch (proc->page)
    {
        case 0:
        {
            menu = StartOrphanMenuAdjusted(&gDebuggerMenuDef, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x14);
            break;
        }
        case 1:
        {
            menu = StartOrphanMenuAdjusted(&gDebuggerMenuDefPage2, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x14);
            break;
        }
        case 2:
        {
            menu = StartOrphanMenuAdjusted(&gDebuggerMenuDefPage3, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x14);
            break;
        }
        case 3:
        {
            menu = StartOrphanMenuAdjusted(&gDebuggerMenuDefPage4, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x14);
            break;
        }
        default:
    }
    if (menu)
    {
        menu->itemCurrent = proc->mainID;
        int count = menu->itemCount - 1;
        if (menu->itemCurrent >= count)
        {
            menu->itemCurrent = count;
        }
    }

    // page number graphic ?
    Decompress(gUnknown_08A02274, (void *)(VRAM + 0x10000 + 0x240 * 0x20));
}

void LoopDebuggerProc(DebuggerProc * proc)
{
    return;
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

void PlayerPhase_FinishActionNoCanto(ProcPtr proc)
{
    if (gPlaySt.chapterVisionRange != 0)
    {
        RenderBmMapOnBg2();

        MoveActiveUnit(gActionData.xMove, gActionData.yMove);

        RefreshEntityBmMaps();
        RenderBmMap();

        NewBMXFADE(0);

        RefreshUnitSprites();
    }
    else
    {
        MoveActiveUnit(gActionData.xMove, gActionData.yMove);

        RefreshEntityBmMaps();
        RenderBmMap();
    }

    SetCursorMapPositionIfValid(gActiveUnit->xPos, gActiveUnit->yPos);

    gPlaySt.xCursor = gBmSt.playerCursor.x;
    gPlaySt.yCursor = gBmSt.playerCursor.y;

    // if (TryMakeCantoUnit(proc)) // has PROC_GOTO in it
    //{
    //     HideUnitSprite(gActiveUnit);
    //     return;
    // }

    // if (ShouldCallEndEvent())
    // {
    // MU_EndAll();

    // RefreshEntityBmMaps();
    // RenderBmMap();
    // RefreshUnitSprites();

    // MaybeCallEndEvent_();

    // Proc_Goto(proc, 8);

    // return;
    // }

    MU_EndAll();

    return;
}

extern void SetBlendConfig(u16 effect, u8 coeffA, u8 coeffB, u8 blendY);
extern const struct ProcCmd gProcScr_TerrainDisplay[];
extern const struct ProcCmd gProcScr_PrepMap_MenuButtonDisplay[];
void InitPlayerPhaseTerrainWindow();
struct ProcCmd const gProcScr_TerrainWindowMaker[] = {
    PROC_WHILE(DoesBMXFADEExist),

    PROC_CALL(InitPlayerPhaseTerrainWindow),

    PROC_END,
};
void InitPlayerPhaseTerrainWindow()
{
    gLCDControlBuffer.dispcnt.win0_on = 0;
    gLCDControlBuffer.dispcnt.win1_on = 0;
    gLCDControlBuffer.dispcnt.objWin_on = 0;

    gLCDControlBuffer.wincnt.wout_enableBg0 = 1;
    gLCDControlBuffer.wincnt.wout_enableBg1 = 1;
    gLCDControlBuffer.wincnt.wout_enableBg2 = 1;
    gLCDControlBuffer.wincnt.wout_enableBg3 = 1;
    gLCDControlBuffer.wincnt.wout_enableObj = 1;
    gLCDControlBuffer.wincnt.wout_enableBlend = 1;

    BG_SetPosition(0, 0, 0);
    BG_SetPosition(1, 0, 0);
    BG_SetPosition(2, 0, 0);

    SetBlendConfig(1, 0xD, 3, 0);

    SetBlendTargetA(0, 1, 0, 0, 0);

    SetBlendBackdropA(0);

    SetBlendTargetB(0, 0, 1, 1, 1);

    Decompress(gGfx_PlayerInterfaceFontTiles, (void *)(VRAM + 0x2000));
    Decompress(gGfx_PlayerInterfaceNumbers, (void *)(VRAM + 0x15C00));

    CpuFastSet((void *)(VRAM + 0x2EA0), (void *)(VRAM + 0x15D40), 8);

    ApplyPalette(gPaletteBuffer, 0x18);

    LoadIconPalette(1, 2);

    ResetTextFont();

    if (gPlaySt.config.disableTerrainDisplay == 0)
    {
        Proc_Start(gProcScr_TerrainDisplay, PROC_TREE_3);
    }

    return;
}

void StartPlayerPhaseTerrainWindow()
{
    Proc_Start(gProcScr_TerrainWindowMaker, PROC_TREE_3);
    return;
}

extern signed char sMsgString[0x1000];

struct ProcHelpBoxIntroString
{
    /* 00 */ PROC_HEADER;

    /* 29 */ u8 _pad[0x54 - 0x29];
    /* 54 */ char * string;

    /* 58 */ int item;
    /* 5C */ int msg;
    /* 60 */ int unk_60;
    /* 64 */ s16 pretext_lines; /* lines for  prefix */
};

extern void HelpBoxSetupstringLines(struct ProcHelpBoxIntro * proc);
extern void HelpBoxDrawstring(struct ProcHelpBoxIntro * proc);
void HelpBoxIntroDrawTextsString(struct ProcHelpBoxIntroString * proc);

struct ProcCmd const ProcScr_HelpBoxIntroString[] = {
    PROC_SLEEP(6),

    PROC_REPEAT(HelpBoxSetupstringLines),
    PROC_REPEAT(HelpBoxDrawstring),

    PROC_CALL(HelpBoxIntroDrawTextsString),

    PROC_END,
};

void ClearHelpBoxText2(void)
{ //
    SetTextFont(&gHelpBoxSt.font);

    SpriteText_DrawBackground(&gHelpBoxSt.text[0]);
    SpriteText_DrawBackground(&gHelpBoxSt.text[1]);
    SpriteText_DrawBackground(&gHelpBoxSt.text[2]);

    Proc_EndEach(gProcScr_HelpBoxTextScroll);
    Proc_EndEach(ProcScr_HelpBoxIntro);
    Proc_EndEach(ProcScr_HelpBoxIntroString);

    SetTextFont(0);

    return;
}

void StartHelpBoxTextInitWithString(int item, int msgId, char * string)
{
    struct ProcHelpBoxIntroString * proc = Proc_Start(ProcScr_HelpBoxIntroString, PROC_TREE_3);

    proc->item = item;
    proc->msg = msgId;
    proc->string = string;
}

extern int sActiveMsg;
void LoadStringIntoBuffer(char * a)
{
    sActiveMsg = 0;
    for (int i = 0; i < 50; ++i)
    {
        sMsgString[i] = a[i];
        if (!a[i])
        {
            break;
        }
    }
    SetMsgTerminator(sMsgString);
}

void HelpBoxIntroDrawTextsString(struct ProcHelpBoxIntroString * proc)
{
    struct HelpBoxScrollProc * otherProc;
    int textSpeed;

    SetTextFont(&gHelpBoxSt.font);

    SetTextFontGlyphs(1);

    Text_SetColor(&gHelpBoxSt.text[0], 6);
    Text_SetColor(&gHelpBoxSt.text[1], 6);
    Text_SetColor(&gHelpBoxSt.text[2], 6);

    SetTextFont(0);

    Proc_EndEach(gProcScr_HelpBoxTextScroll);

    otherProc = Proc_Start(gProcScr_HelpBoxTextScroll, PROC_TREE_3);
    otherProc->font = &gHelpBoxSt.font;

    otherProc->texts[0] = &gHelpBoxSt.text[0];
    otherProc->texts[1] = &gHelpBoxSt.text[1];
    otherProc->texts[2] = &gHelpBoxSt.text[2];

    otherProc->pretext_lines = proc->pretext_lines;

    // GetStringFromIndexSafe(proc->msg);
    LoadStringIntoBuffer(proc->string);

    otherProc->string = StringInsertSpecialPrefixByCtrl();
    otherProc->chars_per_step = 1;
    otherProc->step = 0;

    textSpeed = gPlaySt.config.textSpeed;
    switch (gPlaySt.config.textSpeed)
    {
        case 0: /* default speed */
            otherProc->speed = 2;
            break;

        case 1: /* slow */
            otherProc->speed = textSpeed;
            break;

        case 2: /* fast */
            otherProc->speed = 1;
            otherProc->chars_per_step = textSpeed;
            break;

        case 3: /* draw all at once */
            otherProc->speed = 0;
            otherProc->chars_per_step = 0x7f;
            break;
    }
}

void ApplyHelpBoxContentSizeString(struct HelpBoxProc * proc, int width, int height, char * string)
{
    width = 0xF0 & (width + 15); // align to 16 pixel multiple

    switch (GetHelpBoxItemInfoKind(proc->item))
    {

        case 1: // weapon
            if (width < 0x90)
                width = 0x90;

            if (GetStringTextLen(string) > 8)
                height += 0x20;
            else
                height += 0x10;

            break;

        case 2: // staff
            if (width < 0x60)
                width = 0x60;

            height += 0x10;

            break;

        case 3: // save stuff
            width = 0x80;
            height += 0x10;

            break;

    } // switch (GetHelpBoxItemInfoKind(proc->item))

    proc->wBoxFinal = width;
    proc->hBoxFinal = height;
}

void StartHelpBoxString(int x, int y, char * string)
{
    sMutableHbi.adjUp = NULL;
    sMutableHbi.adjDown = NULL;
    sMutableHbi.adjLeft = NULL;
    sMutableHbi.adjRight = NULL;

    sMutableHbi.xDisplay = x;
    sMutableHbi.yDisplay = y;
    sMutableHbi.mid = 0x505; // default text ID

    sMutableHbi.redirect = NULL;
    sMutableHbi.populate = NULL;

    sHbOrigin.x = 0;
    sHbOrigin.y = 0;

    const struct HelpBoxInfo * info = &sMutableHbi;
    struct HelpBoxProc * proc;
    int wContent, hContent;
    LoadStringIntoBuffer(string);

    proc = (void *)Proc_Find(gProcScr_HelpBox);

    if (!proc)
    {
        proc = (void *)Proc_Start(gProcScr_HelpBox, PROC_TREE_3);

        proc->unk52 = false;

        SetHelpBoxInitPosition(proc, info->xDisplay, info->yDisplay);
        ResetHelpBoxInitSize(proc);
    }
    else
    {
        proc->xBoxInit = proc->xBox;
        proc->yBoxInit = proc->yBox;

        proc->wBoxInit = proc->wBox;
        proc->hBoxInit = proc->hBox;
    }

    proc->info = info;

    proc->timer = 0;
    proc->timerMax = 12;

    proc->item = 0;
    proc->mid = info->mid;

    if (proc->info->populate)
        proc->info->populate(proc);

    SetTextFontGlyphs(1);
    GetStringTextBox(string, &wContent, &hContent);
    SetTextFontGlyphs(0);

    ApplyHelpBoxContentSizeString(proc, wContent, hContent, string);
    ApplyHelpBoxPosition(proc, info->xDisplay, info->yDisplay);

    ClearHelpBoxText2();
    StartHelpBoxTextInitWithString(proc->item, proc->mid, string);

    sLastHbi = info;
}

u8 DebuggerHelpBox(struct MenuProc * menu, struct MenuItemProc * item)
{
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    StartHelpBoxString(item->xTile * 8, item->yTile * 8, GetDebuggerMenuDesc(procIdler, item->itemNumber));
    return 0;
}

struct SpecialCharSt
{
    s8 color;
    s8 id;
    s16 chr_position;
};
extern struct SpecialCharSt sSpecialCharStList[];
extern int AddSpecialChar(struct SpecialCharSt * st, int color, int id);
extern void DrawSpecialCharGlyph(int a, int b, struct Glyph * glyph);
extern struct Font * gActiveFont;
int CustomAddSpecialChar(struct SpecialCharSt * st, int color, int id)
{
    st->color = color;
    st->id = id;
    st->chr_position = gActiveFont->chr_counter++;

    (st + 1)->color = -1;

    DrawSpecialCharGlyph(st->chr_position, color, TextGlyphs_System[id]);
    // DrawSpecialCharGlyph(st->chr_position, color, &gUnknown_0858FC14);

    return st->chr_position;
}

int CustomGetSpecialCharChr(int color, int id)
{
    struct SpecialCharSt * it = sSpecialCharStList;

    while (1)
    {
        if (it->color < 0)
            return CustomAddSpecialChar(it, color, id);

        if (it->color == color && it->id == id)
            return it->chr_position;

        it++;
    }
}

void CustomPutSpecialChar(u16 * tm, int color, int id)
{
    int chr;

    if (id == TEXT_SPECIAL_NOTHING)
    {
        tm[0x00] = 0;
        tm[0x20] = 0;

        return;
    }

    chr = CustomGetSpecialCharChr(color, id) * 2 + gActiveFont->tileref;

    tm[0x00] = chr;
    tm[0x20] = chr + 1;
}

void PutNumberHex(u16 * tm, int color, int number)
{
    if (number == 0)
    {
        PutSpecialChar(tm, color, TEXT_SPECIAL_BIGNUM_0);
        return;
    }

    int tmp;
    while (number != 0)
    {
        tmp = number % 16;
        if (tmp > 9)
        {
            tmp -= 10;
            CustomPutSpecialChar(tm, color, 65 + tmp);
            // if (tmp >= 5) { CustomPutSpecialChar(tm, color, TEXT_SPECIAL_S ); }
            // else {
            //     PutSpecialChar(tm, color, tmp + TEXT_SPECIAL_A);
            // }
        }
        else
        {
            // PutSpecialChar(tm, color, number % 16 + TEXT_SPECIAL_BIGNUM_0);
            CustomPutSpecialChar(tm, color, 48 + tmp);
        }
        number >>= 4;

        tm--;
    }
}

void efxDarkGradoOBJ02piece_Loop(struct ProcEfxOBJ * proc) // fix Gleipnir crash
{
    proc->unk48 += proc->unk44;

    if (GetAnimPosition(proc->anim) == 0)
    {
        proc->anim2->xPosition = proc->unk32 - (proc->unk48 >> 8);
    }
    else
    {
        proc->anim2->xPosition = (proc->unk48 >> 8) + proc->unk32;
    }

    proc->anim2->yPosition = (proc->unk48 >> 8) + proc->unk3A;

    proc->timer++;

    if ((proc->timer == proc->terminator) || (proc->timer > 30))
    {
        gEfxBgSemaphore--;
        AnimDelete(proc->anim2);
        Proc_Break(proc);
    }

    return;
}

#define GfxViewerOptions 6 // 6
static const char gfxViewerOpts[6][16] = { "Portrait", "Class Sprites", "BG", "CG", "Anim", "Wpn" };
#define GfxViewerOption_ClassAnim 4
#define GfxViewerOption_Weapon 5
#define GfxViewerTmp_MenuHidden 14
#define GfxViewerText_WeaponName GfxViewerOptions
#define GfxViewerText_ClassName (GfxViewerOptions + 1)
#define GfxViewerMaxWeaponItem ITEM_GOLDGEM

static bool HasDebuggerBanimForClass(int classId);
static int GetDebuggerDefaultPreviewWeapon(int classId);
static int GetNextDebuggerPreviewWeapon(int item, int direction);
static const char * GetDebuggerPreviewWeaponName(int item);
static void StartDebuggerBanimPreview(int classId, struct Unit * unit, int weapon);

// Was: shifted right & narrowed vs. the generic support-list geometry
// (NUMBER_X/START_X/SupportWidth) to leave room on the left for the mms row shown by
// the Class Sprites option. Now: shifted LEFT instead, so the box starts at x=1
// (NUMBER_X - SupportWidth + 2 + XShift = 17 - 5 + 2 - 13 = 1). Width is untouched -
// GfxViewerMenuWidthShrink only affects w, not the box's x - so this one constant
// moves the box, its label column and its value column together; nothing else in
// ClearGfxViewerMenuGfx/RedrawGfxViewerMenu/GfxViewerInitMenuGfx needs to change.
// The portrait, the per-frame SMS class badge and the four MMS facing sprites all
// used to sit clear of the box on the right side (which is now where the box moved
// away FROM) - see DebuggerStartFace's side argument in DrawGfxFromIDs, the
// PutUnitSpriteForClassId call in RedrawGfxFromIDs, and the MU_CreateForUI x values in
// DebuggerUpdateMMS - all shifted to keep clear of the box's new position instead.
// The battle anim preview (DEBUGGER_BANIM_X/Y in SetupDebuggerBanimAnim) is unrelated
// to any of these constants and was left alone.
#define GfxViewerMenuXShift -13
#define GfxViewerMenuWidthShrink 2

static void ClearGfxViewerMenuGfx(void)
{
    int x = NUMBER_X - SupportWidth + 2 + GfxViewerMenuXShift;
    int y = Y_HAND - 1;
    int w = SupportWidth + (START_X - NUMBER_X) + 7 - GfxViewerMenuWidthShrink;
    int h = (GfxViewerOptions * 2) + 2;

    TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(x, y), w, h, 0);
    TileMap_FillRect(BG_GetMapBuffer(2) + TILEMAP_INDEX(x, y), w, h, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG2_SYNC_BIT);
}

void RedrawGfxViewerMenu(DebuggerProc * proc)
{
    struct Text * th;
    int clearX;
    int clearY;
    int clearW;
    int clearH;
    int labelX;
    int valueX;
    bool weaponEnabled;

    if (proc->tmp[GfxViewerTmp_MenuHidden])
        return;

    clearX = NUMBER_X - SupportWidth + 2 + GfxViewerMenuXShift;
    clearY = Y_HAND - 1;
    clearW = SupportWidth + (START_X - NUMBER_X) + 7 - GfxViewerMenuWidthShrink;
    clearH = (GfxViewerOptions * 2) + 2;

    TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(clearX, clearY), clearW, clearH, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    // ResetText();
    th = gStatScreen.text;
    labelX = NUMBER_X - SupportWidth + 3 + GfxViewerMenuXShift;
    valueX = START_X + 7 + GfxViewerMenuXShift - GfxViewerMenuWidthShrink;
    weaponEnabled = HasDebuggerBanimForClass(proc->tmp[GfxViewerOption_ClassAnim]);
    SetTextFont(&gHelpBoxSt.font);
    for (int i = 0; i < GfxViewerOptions; ++i)
    {
        int color = (i == GfxViewerOption_Weapon && !weaponEnabled) ? TEXT_COLOR_SYSTEM_GRAY : TEXT_COLOR_SYSTEM_WHITE;

        ClearText(&th[i]);
        Text_SetColor(&th[i], color);
        Text_DrawString(&th[i], gfxViewerOpts[i]);
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(labelX, Y_HAND + (i * 2)));
    }
    SetTextFont(NULL);
    for (int i = 0; i < GfxViewerOptions; ++i)
    {
        int color = (i == GfxViewerOption_Weapon && !weaponEnabled) ? TEXT_COLOR_SYSTEM_GRAY : TEXT_COLOR_SYSTEM_GOLD;

        if ((i == GfxViewerOption_Weapon) || (i == GfxViewerOption_ClassAnim))
            continue;

        // PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i*2)),
        // TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]);
        PutNumberHex(gBG0TilemapBuffer + TILEMAP_INDEX(valueX, Y_HAND + (i * 2)), color, proc->tmp[i]);
    }
    SetTextFont(&gHelpBoxSt.font);
    ClearText(&th[GfxViewerText_ClassName]);
    // TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(valueX, Y_HAND + (GfxViewerText_ClassName * 2)), 14, 1, 0);
    Text_SetColor(&th[GfxViewerText_ClassName], weaponEnabled ? TEXT_COLOR_SYSTEM_GOLD : TEXT_COLOR_SYSTEM_GRAY);
    if (proc->tmp[GfxViewerOption_ClassAnim])
    {
        Text_DrawString(
            &th[GfxViewerText_ClassName],
            GetStringFromIndexSafe(GetClassData(proc->tmp[GfxViewerOption_ClassAnim])->nameTextId));
        PutText(
            &th[GfxViewerText_ClassName],
            gBG0TilemapBuffer + TILEMAP_INDEX(valueX - 6, Y_HAND + (GfxViewerOption_ClassAnim * 2)));
    }

    ClearText(&th[GfxViewerText_WeaponName]);
    // TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(valueX, Y_HAND + (GfxViewerOption_Weapon * 2)), 14, 1, 0);
    Text_SetColor(&th[GfxViewerText_WeaponName], weaponEnabled ? TEXT_COLOR_SYSTEM_GOLD : TEXT_COLOR_SYSTEM_GRAY);
    Text_DrawString(&th[GfxViewerText_WeaponName], GetDebuggerPreviewWeaponName(proc->tmp[GfxViewerOption_Weapon]));
    PutText(
        &th[GfxViewerText_WeaponName],
        gBG0TilemapBuffer + TILEMAP_INDEX(valueX - 6, Y_HAND + (GfxViewerOption_Weapon * 2)));
    SetTextFont(NULL);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

void GfxViewerInitMenuGfx(DebuggerProc * proc)
{
    if (proc->tmp[GfxViewerTmp_MenuHidden])
        return;

    int x = NUMBER_X - SupportWidth + 2 + GfxViewerMenuXShift;
    int y = Y_HAND - 1;
    int w = SupportWidth + (START_X - NUMBER_X) + 7 - GfxViewerMenuWidthShrink;
    int h = (GfxViewerOptions * 2) + 2;

    UnpackUiFramePalette(2);
    // drawn on bg2 rather than bg1 - the Class Sprites battle anim preview owns bg1
    // for its own background effects, which would otherwise stomp this frame
    DrawUiFrame(
        BG_GetMapBuffer(2),            // back BG
        x, y, w, h, TILEREF(0, 1), 0); // style as 0 ?
    BG_EnableSyncByMask(BG2_SYNC_BIT);
}

void GfxViewerInit(DebuggerProc * proc)
{
    SomeMenuInit(proc);
    MU_EndAll();
    EndDebuggerBanimPreview();
    BMapDispResume();
    gLCDControlBuffer.bg2cnt.priority = 0;
    InitTextFont(&gHelpBoxSt.font, (void *)(VRAM + 0x4000), 0x200, 0);
    SetTextFont(&gHelpBoxSt.font);
    // struct Unit * unit = proc->unit;
    for (int i = 0; i < GfxViewerOptions; ++i)
    {
        proc->tmp[i] = 0;
    }
    proc->tmp[4] = 0;
    proc->tmp[GfxViewerTmp_MenuHidden] = FALSE;

    proc->tmp[GfxViewerOption_Weapon] = GetUnitEquippedWeapon(proc->unit);
    proc->tmp[GfxViewerOption_ClassAnim] = proc->unit->pClassData->number;

    GfxViewerInitMenuGfx(proc);

    // ClearUiFrame(
    //     BG_GetMapBuffer(1), // front BG
    //     x, y, w, h);

    struct Text * th = gStatScreen.text;

    for (int i = 0; i < 15; ++i)
    {
        InitText(&th[i], SupportWidth + 4); //+4
    }

    RedrawGfxViewerMenu(proc);
}

// Because users repoint these tables, use pointers to them instead of the vanilla address of tables
extern struct FaceData const * const sPortrait_data;
static struct FaceData const * GetMugData(int id)
{
    return sPortrait_data + id;
}

struct UnitIconWait
{
    unsigned short pattern; // unknown, seems to be useless
    unsigned short size;    // icon size
    char * sheet;           // animation sheet
};
extern struct UnitIconWait const * const sUnit_icon_wait_table; // 27bb0
static struct UnitIconWait const * GetSMSData(int id)
{
    return sUnit_icon_wait_table + id; // 27bb0
}

struct MuInfo
{
    const void * img;
    const void * anim;
};

extern struct MuInfo const * const sUnit_icon_move_table; // struct MuInfo
static struct MuInfo const * GetMMSData(int id)
{
    return sUnit_icon_move_table + id - 1; // 27bb0
}
extern struct gfx_set const * const sConvoBackgroundData;
static struct gfx_set const * GetBGData(int id)
{
    return sConvoBackgroundData + id;
}

struct CGDataEnt
{
    u8 ** img; // CG images have 10 parts
    u8 * tsa;
    u16 * pal;
};
extern struct CGDataEnt const * const sCGDataTable; // pointer to gCGDataTable
static struct CGDataEnt const * GetCGData(int id)
{
    return sCGDataTable + id;
}

int IsImgValid(const void * data, const u8 * imgData)
{
    if (!data || !imgData)
    {
        return false;
    }
    if ((u32)data < 0x8000000 || (u32)data > 0x9FFFFFF || (u32)imgData < 0x8000000 || (u32)imgData > 0x9FFFFFF)
    {
        return false;
    }
    return true;
}

int IsImgValidLZ77(const void * data, const u8 * imgData)
{
    if (!IsImgValid(data, imgData))
    {
        return false;
    }

    // Check LZ77 header magic byte
    if (imgData[0] != 0x10)
        return false;

    // Check decompressed size (should be > 0)
    u32 decompressedSize = imgData[1] | (imgData[2] << 8) | (imgData[3] << 16);
    if (decompressedSize == 0)
        return false;

    return true;
}

int CanDisplayPortrait(int id)
{
    const struct FaceData * data = GetMugData(id);
    if ((int)data->img == 0x8070605) // data immediately after for vanilla
    {
        return false;
    }
    return IsImgValid(data, data->img);
    // hack portraits might be uncompressed, so don't worry about checking for lz77 compression
    // const struct FaceData * data = GetMugData(id);
    // return IsImgValidLZ77(data, (const u8 *)data->img);
}
int CanDisplaySMS(int id)
{
    struct UnitIconWait * const data = (void *)GetSMSData(id);
    return IsImgValidLZ77(data, (const u8 *)data->sheet);
}
int CanDisplayMMS(int id)
{
    struct MuInfo * const data = (void *)GetMMSData(id);
    return IsImgValidLZ77(data, (const u8 *)data->img);
}
int CanDisplayBG(int id)
{
    struct gfx_set * const data = (void *)GetBGData(id);
    return IsImgValidLZ77(data, (const u8 *)data->gfx);
}
int CanDisplayCG(int id)
{
    struct CGDataEnt * const data = (void *)GetCGData(id);

    return IsImgValidLZ77(data, (const u8 *)*data->img);
}

extern struct TalkState sTalkStateCore;
struct TalkState * const pTalkState = &sTalkStateCore;
int GetMenuSide(DebuggerProc * proc)
{ // StartOrphanMenuAdjusted
    // StartSemiCenteredOrphanMenu(&gUnitActionMenuDef, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 22)
    // int result = ((gActiveUnitMoveOrigin.x * 16) - gBmSt.camera.x) >= 120;
    int result = (gBmSt.cursorTarget.x - gBmSt.camera.x) >= 120;
    if (result)
    {
        return 1;
    }
    return 0;
    // return (gBmSt.cursorTarget.x - gBmSt.camera.x) >= 120;
}
void DrawNameGfx(DebuggerProc * proc, int side);
extern struct Font gDefaultFont;
void DebuggerStartName(DebuggerProc * proc, int side)
{
    SomeMenuInit(proc);
    LoadIconPalettes(4);

    int x = 0 + (15 * side);
    int y = 0;
    int w = 12;
    int h = 6;

    DrawUiFrame(
        BG_GetMapBuffer(1),            // back BG
        x, y, w, h, TILEREF(0, 0), 0); // style as 0 ?

    struct Text * th = gStatScreen.text;

    for (int i = 0; i <= 2; ++i)
    {
        InitText(&th[i], 8);
    }

    DrawNameGfx(proc, side);
}

void DrawNameGfx(DebuggerProc * proc, int side)
{
    struct Unit * unit = proc->unit;
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    ResetIconGraphics();
    struct Text * th = gStatScreen.text;
    int i = 0;
    int x = 1 + (15 * side);
    int y = 1;
    for (i = 0; i <= 2; ++i)
    {
        ClearText(&th[i]);
    }

    i = 0;

    Text_DrawString(&th[i], GetStringFromIndexSafe(GetCharacterData(unit->pCharacterData->number)->nameTextId));
    i++;
    Text_DrawString(&th[i], GetStringFromIndexSafe(GetClassData(unit->pClassData->number)->nameTextId));
    i++;

    for (i = 0; i < 2; ++i)
    {
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, y + (i * 2)));
    }

    PutNumberHex(
        gBG0TilemapBuffer + TILEMAP_INDEX(x + 9, y + (0)), TEXT_COLOR_SYSTEM_GOLD, unit->pCharacterData->number);
    PutNumberHex(gBG0TilemapBuffer + TILEMAP_INDEX(x + 9, y + (2)), TEXT_COLOR_SYSTEM_GOLD, unit->pClassData->number);

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

void DebuggerStartFace(int id, int side)
{
    EndFaceById(0);

    const struct FaceData * info = GetPortraitData(id);
    if (info->img == 0 && info->imgCard)
    {
        // class card, so handled differently.
        DrawUiFrame(
            BG_GetMapBuffer(1),                        // back BG
            (side * 15), 6, 12, 11, TILEREF(0, 0), 2); // white bg style
        PutFace80x72_Core(gBG0TilemapBuffer + TILEMAP_INDEX((side * 15) + 1, 7), id, 0x240, 0xB);
        BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);

        return;
    }

    int faceDisp = FACE_DISP_KIND(FACE_96x80_FLIPPED) | FACE_DISP_HLAYER(1);
    if (side)
    {
        faceDisp = FACE_DISP_KIND(FACE_96x80) | FACE_DISP_HLAYER(1);
    }
    DrawUiFrame(
        BG_GetMapBuffer(1),                        // back BG
        (side * 15), 6, 14, 12, TILEREF(0, 0), 2); // white bg style
    // gLCDControlBuffer.bg1cnt.priority = 2;
    BG_EnableSyncByMask(BG1_SYNC_BIT);
    pTalkState->activeFaceSlot = 0;

    if (id < 0)
    {
        id = 0;
    }
    if (CanDisplayPortrait(id))
    {
        pTalkState->faces[pTalkState->activeFaceSlot] = StartFace(
            0, id, 56 + (side * 15 * 8), 7 * 8,
            faceDisp); // blink
        // SetFaceBlinkControlById(0, 0);
        StartFaceFadeIn(pTalkState->faces[pTalkState->activeFaceSlot]);

        // SetTalkFaceLayer(pTalkState->activeFaceSlot, CheckTalkFlag(TALK_FLAG_4));
        SetTalkFaceLayer(pTalkState->activeFaceSlot, 0);
        // StartFace(0, id, 48, 16, 0);
    }
} // 859133c T sTalkState

void ClearMainMenuGfx(DebuggerProc * proc)
{
    EndFaceById(0);
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_Fill(gBG1TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
}
extern struct FaceVramEntry sFaceConfig[4];
void DebuggerStartNameFace(DebuggerProc * proc)
{
    int side = GetMenuSide(proc);

    DebuggerStartName(proc, side);
    int fid = GetUnitPortraitId(proc->unit);
    if (fid)
    {
        DebuggerStartFace(fid, side);
    }
}

void DebuggerStartSMS()
{
    // sub_8027DB4(int layer, int x, int y, u16 oam2base, int classId, int id);
    ResetUnitSprites();
    RefreshUnitSprites();
    // if (CanDisplaySMS(GetClassData(id)->SMSId) && (GetClassData(id) != 0))
    // {
    // SMS_80266F0(GetClassData(id)->SMSId, 16);
    // }
}
struct MuProc * StartUiMu(struct Unit * unit, int x, int y);
// void MU_SetFacing(struct MuProc *, int dir);
void DebuggerUpdateMMS(int id, struct Unit * unit)
{
    MU_EndAll(); // EndAllMus();
    // int facing = (GetGameClock() % 512) > 256;
    int facing = 0;

    // return;
    if (id && (GetClassData(id) != 0) && CanDisplayMMS(id))
    {
        const struct ClassData * classData = unit->pClassData;
        unit->pClassData = GetClassData(id);

        struct MUProc * muProc1 = MU_CreateForUI(unit, 80, 144); // StartUiMu - was x=48
        MU_SetFacing(muProc1, 0 + facing);
        struct MUProc * muProc2 = MU_CreateForUI(unit, 120, 144); // StartUiMu - was x=88
        MU_SetFacing(muProc2, 1 + facing);
        struct MUProc * muProc3 = MU_CreateForUI(unit, 160, 144); // StartUiMu - was x=128
        MU_SetFacing(muProc3, 2 + facing);
        struct MUProc * muProc4 = MU_CreateForUI(unit, 200, 144); // StartUiMu - was x=168
        MU_SetFacing(muProc4, 3 + facing);
        unit->pClassData = classData;
    }
}
extern struct FaceProc * gFaces[];
void DebuggerUpdateMouthFrames(DebuggerProc * proc)
{
    if (!pTalkState->faces[0] || !gFaces[0])
    {
        return;
    }
    int time = GetGameClock();
    int faceDisp = GetFaceDisplayBitsById(0) & ~(FACE_DISP_SMILE | FACE_DISP_TALK_1 | FACE_DISP_TALK_2);
    switch ((time & 0x1FF) >> 7)
    {

        case 0:
        {
            SetTalkFaceDisp(0, faceDisp | FACE_DISP_TALK_1);
            break;
        }
        case 2:
        {
            SetTalkFaceDisp(0, faceDisp | FACE_DISP_TALK_2);
            break;
        }
        case 1:
        {
            SetTalkFaceDisp(0, faceDisp | FACE_DISP_SMILE);
            break;
        }
        case 3:
        {
            SetTalkFaceDisp(0, faceDisp); // neutral
            break;
        }
    }
}

void RedrawGfxFromIDs(int id, DebuggerProc * proc)
{
    DebuggerUpdateMouthFrames(proc);

    // if (((time % 256) == 0) && CanDisplayMMS(GetClassData(id)->SMSId) && (GetClassData(id) != 0))
    // {
    // DebuggerUpdateMMS(id, proc->unit);
    // }
    // id += 1;
    // sub_8027DB4(int layer, int x, int y, u16 oam2base, int classId, int id);
    if (id && (GetClassData(id) != 0) && CanDisplaySMS(GetClassData(id)->SMSId))
    {
        // SMS_SomethingGmapUnit(id, 1, 16);
        PutUnitSpriteForClassId(0, 40, 128, 0xC800, id); // was x=8; +120px to match the portrait's side 0->1 move
    }
    // UseUnitSprite(12);
}

void DebuggerStartBG(int id)
{
    SetBackgroundTileDataOffset(BG_3, 0x8000); // restore to default just in case it's after 256 cols
    gLCDControlBuffer.bg3cnt.colorMode = 0;    // no 256-col mode.
    gLCDControlBuffer.bldcnt.target2_bd_on = false;

    if (CanDisplayBG(id))
    {
        BMapDispResume();
        BMapDispSuspend();
        EventShowTextBgDirect(1, id);
    }
    else
    {
        RegisterBlankTile(0x400);
        BG_Fill(gBG3TilemapBuffer, 0);
        BG_EnableSyncByMask(BG3_SYNC_BIT);
    }
}
void DebuggerStartCG(int id)
{
    SetBackgroundTileDataOffset(BG_3, 0x8000); // restore to default just in case it's after 256 cols
    gLCDControlBuffer.bg3cnt.colorMode = 0;    // no 256-col mode.
    gLCDControlBuffer.bldcnt.target2_bd_on = false;
    if (CanDisplayCG(id))
    {
        BMapDispResume();
        BMapDispSuspend();
        EventShowTextBgDirect(2, id);
    }
    else
    {
        RegisterBlankTile(0x400);
        BG_Fill(gBG3TilemapBuffer, 0);
        BG_EnableSyncByMask(BG3_SYNC_BIT);
    }
}

void EndBanimTerrain(struct BanimUnkStructComm * buf);
void InitBanimTerrain(struct BanimUnkStructComm * buf);
void SetBanimTerrainPos(struct BanimUnkStructComm * buf, s16 x1, s16 y1, s16 x2, s16 y2);
enum ClassReelScrOpCode
{
    CLASS_REEL_OP_0,
    CLASS_REEL_OP_1,
    CLASS_REEL_OP_2,
    CLASS_REEL_OP_3,
    CLASS_REEL_OP_4,
    CLASS_REEL_OP_5,
    CLASS_REEL_OP_6,
    CLASS_REEL_OP_7,
    CLASS_REEL_OP_8,
};

struct ClassReelAnimScr
{
    u16 opCode : 8;
    u16 extra : 8;
} __attribute__((packed));

struct ClassReelEnt
{
    u32 descTextId;
    s8 paletteId;
    u8 classId;
    u8 unk_06;
    u8 banimId;
    u8 magicFx;
    u8 unk_09;
    u8 unk_0A;
    u8 unk_0B;
    u8 unk_0C;
    u8 unk_0D; // terrain L
    u8 unk_0E; // terrain R
    u8 unk_0F;
    struct ClassReelAnimScr * script;
};

struct AnimMagicFxBuffer
{
    u16 magicFuncIdx;
    s16 xOffsetBg;
    s16 yOffsetBg;
    u16 xOffsetObj;
    u16 yOffsetObj;
    u16 bgChr;
    u16 bgPalId;
    u16 objChr;
    u16 objPalId;
    u16 bg;
    u16 * bgTmBuf;
    void * bgImgBuf;
    void * bgTsaBuf;
    void * objImgBuf;
    void (*resetCallback)(void);
};

struct OpInfoClassDisplayProc
{
    PROC_HEADER;
    u16 unk_2a;
    u16 unk_2c;
    ProcPtr unk_30;
    struct ClassReelEnt * classReelEnt;
    struct ClassReelAnimScr * script;
    ProcPtr unk_3c;
    u8 unk_40[6];
    u8 unk_46;

    // Debugger-only fields for DebuggerBanimPreview_ResetScript()'s melee/ranged
    // alternation - not real ROM ABI. The vanilla struct (also used by classchg-sel.c's
    // promotion reel) ends at unk_46; every proc is allocated from the same
    // fixed-size pool slot regardless of which proc type occupies it (see
    // DebuggerProc.tmp's own "0x64 out of 0x6c max" note), and OpInfoClassDisplayProc
    // is well short of that, so this tail is genuinely unused rather than borrowed
    // from something else. Not file-scope statics: this preview's .c/.o gets hooked
    // into the ROM by lyn, which has nowhere to allocate fresh static RAM for new
    // globals - only existing, already-mapped storage (an extern'd address, or here,
    // slack inside a struct that is already allocated for other reasons) works.
    bool useRanged;
    s16 weapon;
    s16 naturalSpellId;
};

extern struct ClassReelEnt gClassReelData[65]; // dat 0x08A2F6C0 - already in fe8.s

#define CR_END() { CLASS_REEL_OP_0, 0 }
#define CR_ANIM_ROUND_HIT_CLOSE() { CLASS_REEL_OP_1, 0 }
#define CR_ANIM_ROUND_CRIT_CLOSE() { CLASS_REEL_OP_2, 0 }
#define CR_RETURN_TO_STANDING() { CLASS_REEL_OP_3, 0 }
#define CR_ANIM_ROUND_NONCRIT_FAR() { CLASS_REEL_OP_4, 0 }
#define CR_WAIT(frames) { CLASS_REEL_OP_5, frames }
#define CR_ANIM_ROUND_TAKING_MISS_CLOSE() { CLASS_REEL_OP_6, 0 }
#define CR_RETURN_TO_STANDING_ALT() { CLASS_REEL_OP_7, 0 }
#define CR_WAIT_ROUND_END() { CLASS_REEL_OP_8, 0 }
#define CLASS_REEL_WAIT_SPELL 9
#define CLASS_REEL_CRIT_FAR 10
#define CR_ANIM_ROUND_CRIT_FAR() { CLASS_REEL_CRIT_FAR, 0 }
#define CR_WAIT_SPELL() { CLASS_REEL_WAIT_SPELL, 0 }

/*
struct ClassReelAnimScr const sCRScr_MeleeHit[] = {
    CR_WAIT(30),     CR_ANIM_ROUND_NONCRIT_FAR(), CR_WAIT_ROUND_END(), CR_WAIT(40),
    CR_WAIT_SPELL(), CR_RETURN_TO_STANDING(),

    CR_WAIT(40),     CR_ANIM_ROUND_HIT_CLOSE(),   CR_WAIT_ROUND_END(),
    CR_WAIT(30), // normally this would be wait for hp to deplete here
    CR_WAIT_SPELL(), CR_RETURN_TO_STANDING(),

    CR_WAIT(40),     CR_ANIM_ROUND_CRIT_FAR(),    CR_WAIT_ROUND_END(), CR_WAIT(45),
    CR_WAIT_SPELL(), CR_RETURN_TO_STANDING(),

    CR_WAIT(40),     CR_ANIM_ROUND_CRIT_CLOSE(),  CR_WAIT_ROUND_END(), CR_WAIT(45),
    CR_WAIT_SPELL(), CR_RETURN_TO_STANDING(),     CR_WAIT(45),         CR_END(),
};
*/

struct ClassReelAnimScr const sCRScr_MeleeHit[] = {
    CR_WAIT(40),     CR_ANIM_ROUND_HIT_CLOSE(),  CR_WAIT_ROUND_END(),
    CR_WAIT(30), // normally this would be wait for hp to deplete here
    CR_WAIT_SPELL(), CR_RETURN_TO_STANDING(),

    CR_WAIT(40),     CR_ANIM_ROUND_CRIT_CLOSE(), CR_WAIT_ROUND_END(), CR_WAIT(45),
    CR_WAIT_SPELL(), CR_RETURN_TO_STANDING(),    CR_WAIT(45),         CR_END(),
};

struct ClassReelAnimScr const sCRScr_RangedHit[] = {
    CR_WAIT(30),     CR_ANIM_ROUND_NONCRIT_FAR(), CR_WAIT_ROUND_END(), CR_WAIT(40),
    CR_WAIT_SPELL(), CR_RETURN_TO_STANDING(),

    CR_WAIT(40),     CR_ANIM_ROUND_CRIT_FAR(),    CR_WAIT_ROUND_END(), CR_WAIT(45),
    CR_WAIT_SPELL(), CR_RETURN_TO_STANDING(),

    CR_END(),
};

extern struct AnimBuffer gOpInfoData; // dat 0x02000000 - moved up from below so ExecScript/LoopScript can see it

void ClassInfoDisplay_ExecScript(struct OpInfoClassDisplayProc * proc)
{
    switch (proc->script->opCode)
    {
        case CLASS_REEL_OP_0:
            Proc_Goto(proc, 10);

            break;

        case CLASS_REEL_OP_1:
            gOpInfoData.roundType = ANIM_ROUND_HIT_CLOSE;
            sub_805A7B4(&gOpInfoData);

            break;

        case CLASS_REEL_OP_2:
            gOpInfoData.roundType = ANIM_ROUND_CRIT_CLOSE;
            sub_805A7B4(&gOpInfoData);

            break;

        case CLASS_REEL_OP_3:
        case CLASS_REEL_OP_7:
            sub_805A990(&gOpInfoData);

            break;

        case CLASS_REEL_OP_4:
            gOpInfoData.roundType = ANIM_ROUND_NONCRIT_FAR;
            sub_805A7B4(&gOpInfoData);

            break;

        case CLASS_REEL_OP_6:
            gOpInfoData.roundType = ANIM_ROUND_TAKING_MISS_CLOSE;
            sub_805A7B4(&gOpInfoData);

            break;

        case CLASS_REEL_CRIT_FAR:
            gOpInfoData.roundType = ANIM_ROUND_CRIT_FAR;
            sub_805A7B4(&gOpInfoData);

            break;

        case CLASS_REEL_OP_5:
        case CLASS_REEL_OP_8:
        case CLASS_REEL_WAIT_SPELL:
            // Nothing to kick off here - CLASS_REEL_WAIT_SPELL is a pure wait, same
            // shape as OP_5 (wait N frames) and OP_8 (wait for round end). The actual
            // "is it still going" check lives in ClassInfoDisplay_LoopScript, which is
            // what decides when to advance past this script entry.
            break;
    }

    proc->unk_2a = 0;

    return;
}

/**
 * Same shape as vanilla's ClassInfoDisplay_LoopScript, plus CLASS_REEL_CRIT_FAR
 * (grouped with the other one-shot "start this round type" ops - 1/2/3/4/6/7 - since
 * like them it has nothing left to do after ClassInfoDisplay_ExecScript() already
 * kicked off the round) and CLASS_REEL_WAIT_SPELL (a genuine wait, alongside OP_5's
 * fixed-frame wait and OP_8's wait-for-round-end: holds this script entry until
 * gEfxSpellAnimExists goes false, i.e. until whatever spell effect the mini anim's own
 * AIS script triggered (command 5/0x0E) has actually finished playing.
 *
 * gEfxSpellAnimExists, not gpActiveClassReelSpellProc/"gpProcefxopCur" (the tracking
 * pointer behind EndActiveClassReelSpell() in banim-efxop.c) - that one belongs to a
 * different code path. Vanilla's own EkrMainMini_AnimUpdateFrameGfx command interpreter
 * calls StartClassReelSpellAnim() (which sets gpActiveClassReelSpellProc), but the
 * debugger's own command interpreter here (DebuggerEkrUnitMainMini_UpdateAnim) does not
 * reuse that function - it calls StartDebuggerBanimSpellAnimation() on command 5/0x0E,
 * which goes straight to StartSpellAnimation(), the same gEkrSpellAnimLut dispatch the
 * real battle system uses. Every one of those individual spell effects (efxFire,
 * efxThunder, ...) brackets itself with SpellFx_Begin()/SpellFx_Finish(), i.e.
 * gEfxSpellAnimExists - so that is the flag that actually reflects what is on screen
 * here, and gpActiveClassReelSpellProc is never touched by anything this preview does.
 */
void ClassInfoDisplay_LoopScript(struct OpInfoClassDisplayProc * proc)
{
    switch (proc->script->opCode)
    {
        case CLASS_REEL_OP_1:
        case CLASS_REEL_OP_2:
        case CLASS_REEL_OP_3:
        case CLASS_REEL_OP_4:
        case CLASS_REEL_OP_6:
        case CLASS_REEL_OP_7:
        case CLASS_REEL_CRIT_FAR:
            proc->script++;
            Proc_Break(proc);

            break;

        case CLASS_REEL_OP_5:
            proc->unk_2a++;

            if (proc->unk_2a < proc->script->extra)
            {
                return;
            }

            proc->script++;
            Proc_Break(proc);

            break;

        case CLASS_REEL_OP_8:
            if (sub_805A96C(&gOpInfoData) != 0)
            {
                proc->script++;
                Proc_Break(proc);
            }

            break;

        case CLASS_REEL_WAIT_SPELL:
            if (!gEfxSpellAnimExists)
            {
                proc->script++;
                Proc_Break(proc);
            }

            break;
    }

    return;
}

struct ClassReelEnt const DefaultClassReelData[1] = {
    [0x00] = { 0x0, 0xFF, 0xA7, 0, 0x02, 0, 0, 0, 0, 0, 0x14, 0x14, 0, (void *)sCRScr_MeleeHit },
};

extern struct BanimUnkStructComm gUnk_Opinfo_0; // dat 0x0201DB00 (aka gUnknown_0201DB00)
extern struct AnimMagicFxBuffer gUnk_4;         // dat 0x0200A2D8
extern s16 gEkrSpellAnimIndex[2];               // dat 0x0203E118

// ClassChgSel_SetBlendWindowConfig
static void DebuggerBanimBlendWindowConfig(void)
{
    SetBlendConfig(1, 16, 16, 0);
}

extern u16 gBanimPaletteLeft[];     // dat 0x02004088 - add to fe8.s
extern u8 gSpellAnimBgfx[];         // dat 0x02017790 - add to fe8.s
extern u8 gBuf_Banim[];             // dat 0x0201A790 - add to fe8.s
extern u8 gUnk_Banim_Ekrbattle_0[]; // dat 0x020145C8 - add to fe8.s

void EndEkrUnitMainMini(struct AnimBuffer * pAnimBuf);                  // 0x0805AA29
void ResetClassReelSpell(void);                                         // 0x0806E8F1
void EndActiveClassReelSpell(void);                                     // 0x0806E905
void EndActiveClassReelBgColorProc(void);                               // 0x0806E921
void ClassInfoDisplay_ExecScript(struct OpInfoClassDisplayProc * proc); // 0x080B3D85
void ClassInfoDisplay_LoopScript(struct OpInfoClassDisplayProc * proc); // 0x080B3E19
void StartSpellAnimation(struct Anim * anim);                           // 0x0805B3CD
void EkrMainMini_AnimMarkRoundEnd(struct Anim * anim);                  // 0x0805A581
void EkrMainMini_AnimUpdateFrameGfx(struct Anim * anim);                // 0x0805A5A9
void InitMainMiniAnim(struct AnimBuffer * animBuf);                     // 0x0805A249
int Get0201FAC8(void);                                                  // 0x08055A29
void Set0201FAC8(int value);                                            // 0x08055A35

struct DebuggerProcEkrUnitMainMini
{
    PROC_HEADER;
    u8 _pad_29[0x5C - 0x29];
    struct AnimBuffer * animBuf;
};

static bool IsValidLz77DecompressionData(const void * data)
{
    (void)data;
    return true;
}

#define DEBUGGER_BANIM_TERRAIN 0x3F
// #define DEBUGGER_BANIM_X 160
// #define DEBUGGER_BANIM_Y 132
// #define DEBUGGER_BANIM_BG_X 72
// #define DEBUGGER_BANIM_BG_Y 138

#define DEBUGGER_BANIM_X 148
#define DEBUGGER_BANIM_Y 88
#define DEBUGGER_BANIM_BG_X 72
#define DEBUGGER_BANIM_BG_Y 104

static const struct ProcCmd sProc_DebuggerBanimPreview[];

// Picks a plausible tome/staff for classes previewed without a matching real
// weapon equipped, matching vanilla's own per-class defaults: anima->Fire
// (Elfire once promoted), light->Lightning (Shine), dark->Flux (Luna),
// staff->Heal (Mend). Whichever the class's actual rank array grants first.
static int GetDebuggerDefaultSpellItem(const struct ClassData * class)
{
    bool promoted = (class->attributes & CA_PROMOTED) != 0;

    if (class->baseRanks[ITYPE_ANIMA])
        return promoted ? ITEM_ANIMA_ELFIRE : ITEM_ANIMA_FIRE;
    if (class->baseRanks[ITYPE_LIGHT])
        return promoted ? ITEM_LIGHT_SHINE : ITEM_LIGHT_LIGHTNING;
    if (class->baseRanks[ITYPE_DARK])
        return promoted ? ITEM_DARK_LUNA : ITEM_DARK_FLUX;
    if (class->baseRanks[ITYPE_STAFF])
        return promoted ? ITEM_STAFF_MEND : ITEM_STAFF_HEAL;

    return ITEM_NONE;
}

static bool HasDebuggerBanimForClass(int classId)
{
    const struct ClassData * class = GetClassData(classId);

    return classId != 0 && class != NULL && class->pBattleAnimDef != NULL;
}

static int GetDebuggerDefaultPreviewWeapon(int classId)
{
    const struct ClassData * class = GetClassData(classId);

    if (class == NULL)
        return ITEM_NONE;

    if (classId == CLASS_MANAKETE || classId == CLASS_MANAKETE_2)
        return ITEM_DEMONSTONE;
    if (classId == CLASS_MANAKETE_MYRRH)
        return ITEM_DIVINESTONE;
    if (classId == CLASS_DEMON_KING)
        return ITEM_RAVAGER;
    if (classId == CLASS_DRACO_ZOMBIE)
        return ITEM_MONSTER_WRETCHAIR;
    /* mogalls carry an A rank in dark, but CA_LOCK_3 below would hand them a claw */
    if (classId == CLASS_MOGALL || classId == CLASS_ARCH_MOGALL)
        return ITEM_DARK_FLUX;

    if (class->baseRanks[ITYPE_SWORD])
        return ITEM_SWORD_IRON;
    if (class->baseRanks[ITYPE_LANCE])
        return ITEM_LANCE_IRON;
    if (class->baseRanks[ITYPE_AXE])
        return ITEM_AXE_IRON;
    if (class->baseRanks[ITYPE_BOW])
        return ITEM_BOW_IRON;
    if (class->attributes & CA_LOCK_3)
        return ITEM_MONSTER_ROTTENCLW;
    if (class->baseRanks[ITYPE_ANIMA] || class->baseRanks[ITYPE_LIGHT] || class->baseRanks[ITYPE_DARK])
        return GetDebuggerDefaultSpellItem(class);
    if (class->baseRanks[ITYPE_STAFF])
        return ITEM_STAFF_HEAL;

    return ITEM_NONE;
}

static bool IsDebuggerPreviewWeapon(int item)
{
    int attributes;

    if (item == ITEM_NONE)
        return true;

    if (item < 0 || item > GfxViewerMaxWeaponItem)
        return false;

    attributes = GetItemAttributes(item);

    if (!(attributes & IA_WEAPON))
        return false;

    if ((attributes & IA_STAFF) || GetItemType(item) == ITYPE_STAFF)
        return false;

    return true;
}

static int GetNextDebuggerPreviewWeapon(int item, int direction)
{
    int i;

    for (i = 0; i <= GfxViewerMaxWeaponItem; ++i)
    {
        item += direction;

        if (item < 0)
            item = GfxViewerMaxWeaponItem;
        else if (item > GfxViewerMaxWeaponItem)
            item = 0;

        if (IsDebuggerPreviewWeapon(item))
            return item;
    }

    return ITEM_NONE;
}

static const char * GetDebuggerPreviewWeaponName(int item)
{
    const char * name;

    if (item == ITEM_NONE)
        return "None";

    name = GetItemName(item);
    return name != NULL ? name : "???";
}
/*
static int GetDebuggerDefaultMagicFx(const struct ClassData * class)
{
    if (class->baseRanks[ITYPE_ANIMA])
        return 1;
    if (class->baseRanks[ITYPE_LIGHT])
        return 4;
    if (class->baseRanks[ITYPE_DARK])
        return 5;
    if (class->baseRanks[ITYPE_STAFF])
        return 3;

    return 0;
}
*/
static int GetDebuggerBanimId(int classId, struct Unit * unit, int weapon)
{
    const struct ClassData * class;
    const struct BattleAnimDef * animDef;
    int i;
    int expectedType;

    (void)unit;

    class = GetClassData(classId);
    if (class == NULL || class->pBattleAnimDef == NULL)
        return 0;

    animDef = class->pBattleAnimDef;

    expectedType = weapon != ITEM_NONE ? (GetItemType(weapon) + 0x100) : SPECIAL_BANIM_WTYPE;

    for (i = 0; animDef[i].index != 0; ++i)
    {
        if (animDef[i].wtype == expectedType)
            return animDef[i].index - 1;
    }

    for (i = 0; animDef[i].index != 0; ++i)
    {
        if (animDef[i].wtype == SPECIAL_BANIM_WTYPE)
            return animDef[i].index - 1;
    }

    return 0;
}

static struct ClassReelEnt * GetDebuggerBanimReelEntry(int classId)
{

    return NULL;
    // int i;
    // for (i = 0; i < 65; i++)
    // {
    // if (gClassReelData[i].classId == classId)
    // return &gClassReelData[i];
    // }

    // return NULL;
}

static int GetDebuggerSpellAnimId(int classId, int weapon)
{
    int result = GetSpellAnimId(classId, weapon);
    if (result < 0)
    {
        result = 0;
    }
    return result;
}

static void FillDebuggerBanimFallbackEntry(struct ClassReelEnt * out, int classId, struct Unit * unit, int weapon)
{
    out->descTextId = 0;
    out->paletteId = -1;
    out->classId = classId;
    out->unk_06 = 0;
    out->banimId = GetDebuggerBanimId(classId, unit, weapon); // unused I think
    out->magicFx = 0;                                         // unused
    out->unk_09 = 0;
    out->unk_0A = 0;
    out->unk_0B = 0;
    out->unk_0C = 0;
    out->unk_0D = DEBUGGER_BANIM_TERRAIN;
    out->unk_0E = DEBUGGER_BANIM_TERRAIN;
    out->unk_0F = 0;
    out->script = (void *)sCRScr_MeleeHit;
}

static bool IsDebuggerBanimSafe(struct ClassReelEnt * entry, int classId, struct Unit * unit, int weapon)
{
    struct BattleAnim * anim;
    int paletteId;

    if (entry == NULL)
        return false;

    anim = &banim_data[GetDebuggerBanimId(classId, unit, weapon)];

    if (!IsValidLz77DecompressionData(anim->script) || !IsValidLz77DecompressionData(anim->oam_r) ||
        !IsValidLz77DecompressionData(anim->oam_l) || !IsValidLz77DecompressionData(anim->pal))
        return false;

    paletteId = entry->paletteId;

    if (paletteId != -1)
    {
        if (paletteId < 0)
            return false;

        if (!IsValidLz77DecompressionData(character_battle_animation_palette_table[paletteId].pal))
            return false;
    }

    return true;
}

static void SetDebuggerBanimLayer(u16 layer)
{
    if (gOpInfoData.anim1 != NULL)
    {
        gOpInfoData.anim1->oam2Base &= ~OAM2_LAYER(3);
        gOpInfoData.anim1->oam2Base |= OAM2_LAYER(layer);
    }

    if (gOpInfoData.anim2 != NULL)
    {
        gOpInfoData.anim2->oam2Base &= ~OAM2_LAYER(3);
        gOpInfoData.anim2->oam2Base |= OAM2_LAYER(layer);
    }
}

static void StartDebuggerBanimSpellAnimation(struct Anim * anim)
{
    if (anim == NULL)
        return;

    StartSpellAnimation(anim);

    if (Get0201FAC8())
        Set0201FAC8(2);
}

static void DebuggerEkrUnitMainMini_UpdateAnim(struct AnimBuffer * animBuf, struct Anim * anim)
{
    int animState2;

    if (anim == NULL)
        return;

    animState2 = anim->state2 & 0xF000;
    if (animState2 == 0)
        return;

    if (animState2 & ANIM_BIT2_COMMAND)
    {
        while (anim->commandQueueSize != 0)
        {
            int command = anim->commandQueue[anim->commandQueueSize - 1];

            switch (command)
            {
                case ANIM_CMD_WAIT_01:
                case ANIM_CMD_WAIT_02:
                    EkrMainMini_AnimMarkRoundEnd(anim);
                    break;

                case ANIM_CMD_WAIT_05:
                    if (GetAISLayerId(anim) == 0)
                        StartDebuggerBanimSpellAnimation(anim);

                    // fallthrough

                case ANIM_CMD_WAIT_03:
                case ANIM_CMD_WAIT_04:
                    anim->pScrCurrent++;
                    break;

                case ANIM_CMD_WAIT_13:
                    EkrMainMini_AnimUpdateFrameGfx(anim);
                    break;

                case 0x0E:
                    StartDebuggerBanimSpellAnimation(anim);
                    break;

                case ANIM_CMD_WAIT_18:
                    EkrMainMini_AnimMarkRoundEnd(anim);
                    break;

                default:
                    break;
            }

            anim->commandQueueSize--;
        }

        anim->state2 &= 0xE700;
    }

    if (animState2 & ANIM_BIT2_FRAME)
    {
        if (GetAISLayerId(anim) == 0 && animBuf->unk_2C != anim->pImgSheet)
        {
            RegisterAISSheetGraphics(anim);
            animBuf->unk_2C = anim->pImgSheet;
        }

        anim->state2 &= 0xD700;
    }

    if (animState2 & ANIM_BIT2_STOP)
        anim->nextRoundId = -1;
}

static void DebuggerEkrUnitMainMiniMain(struct DebuggerProcEkrUnitMainMini * proc)
{
    struct AnimBuffer * animBuf = proc->animBuf;

    DebuggerEkrUnitMainMini_UpdateAnim(animBuf, animBuf->anim1);
    DebuggerEkrUnitMainMini_UpdateAnim(animBuf, animBuf->anim2);
}

static const struct ProcCmd sProc_DebuggerEkrUnitMainMini[] = {
    PROC_NAME("DebuggerEkrUnitMainMini"),
    PROC_REPEAT(DebuggerEkrUnitMainMiniMain),
    PROC_END,
};

static void NewDebuggerEkrUnitMainMini(struct AnimBuffer * animBuf)
{
    struct DebuggerProcEkrUnitMainMini * proc = Proc_Start(sProc_DebuggerEkrUnitMainMini, PROC_TREE_4);

    InitMainMiniAnim(animBuf);

    proc->animBuf = animBuf;

    animBuf->unk_34 = proc;
    animBuf->unk_00 = 1;
}

// A pure melee weapon (sword/lance/axe) has nothing sensible to show for
// ANIM_ROUND_NONCRIT_FAR/CLASS_REEL_CRIT_FAR - no spell, no bow - so sCRScr_RangedHit
// would otherwise just be the character swinging at empty air. See
// DebuggerBanimPreview_ResetScript for what stands in for it instead.
static bool IsDebuggerPreviewWeaponMelee(int weapon)
{
    if (!weapon)
        return false;

    // int range = GetItemMinRange(weapon);
    int type = GetItemType(weapon);
    u32 attr = GetItemAttributes(weapon);
    if (type == ITYPE_SWORD && !(attr & IA_MAGICDAMAGE))
    {
        return true;
    }
    // non-magic swords default to showing Nosferatu animation for ranged

    return false;
}

/**
 * Picks which half of the reel plays next and, since which half is playing can change
 * on every call (not just the first), re-derives the spell id to go with it.
 *
 * Called twice over: once from SetupDebuggerBanimAnim() for the initial script (which
 * resets proc->useRanged to melee-first - see there), and repeatedly from this proc's
 * own PROC_LABEL(10) step every time a reel reaches CR_END() and loops back around -
 * that second case is what makes the melee/ranged choice actually alternate over time.
 *
 * ITEM_DARK_NOSFERATU's spell effect id is 0x1E (SPELL_ASSOC_DATA_WPN_MAGIC entry in
 * spellassoc-data.c) - borrowed here to give melee-only classes some ranged-looking
 * effect to show during their sCRScr_RangedHit pass, since they have no spell or bow
 * animation of their own to fall back on for a "far" round type.
 */
static void DebuggerBanimPreview_ResetScript(struct OpInfoClassDisplayProc * proc)
{
    proc->script = (void *)(proc->useRanged ? sCRScr_RangedHit : sCRScr_MeleeHit);

    if (proc->useRanged && IsDebuggerPreviewWeaponMelee(proc->weapon))
        gEkrSpellAnimIndex[EKR_POS_L] = 0x1E; // ITEM_DARK_NOSFERATU
    else
        gEkrSpellAnimIndex[EKR_POS_L] = proc->naturalSpellId;

    gEkrSpellAnimIndex[EKR_POS_R] = gEkrSpellAnimIndex[EKR_POS_L];

    proc->useRanged = !proc->useRanged;
}

// entry is only read here, for this one call - persistentEntry is what
// proc->classReelEnt keeps for later script resets, and is NULL for a
// fallback/custom-class entry (whose backing storage is the caller's stack).
static void SetupDebuggerBanimAnim(
    struct OpInfoClassDisplayProc * proc, struct ClassReelEnt * entry, struct ClassReelEnt * persistentEntry,
    int weapon)
{
    NewEfxAnimeDrvProc();

    gOpInfoData.charPalId = entry->paletteId;
    gOpInfoData.xPos = DEBUGGER_BANIM_X;
    gOpInfoData.yPos = DEBUGGER_BANIM_Y;
    gOpInfoData.animId = GetDebuggerBanimId(entry->classId, gActiveUnit, weapon);
    gOpInfoData.roundType = ANIM_ROUND_TAKING_HIT_CLOSE;
    gOpInfoData.genericPalId = entry->unk_06;
    gOpInfoData.state2 = 1;
    gOpInfoData.oam2Tile = 0x200;
    gOpInfoData.oam2Pal = 0xA;
    gOpInfoData.pImgSheetBuf = gBanimLeftImgSheetBuf;
    gOpInfoData.unk_24 = gBanimOaml;
    gOpInfoData.unk_20 = gBanimPaletteLeft;
    gOpInfoData.unk_28 = gBanimScrLeft;
    gOpInfoData.unk_30 = &gUnk_4;

    gUnk_4.magicFuncIdx = 0;
    gUnk_4.xOffsetBg = entry->unk_09;
    gUnk_4.yOffsetBg = entry->unk_0A;
    gUnk_4.xOffsetObj = entry->unk_0B;
    gUnk_4.yOffsetObj = entry->unk_0C;
    gUnk_4.objChr = 0x300;
    gUnk_4.objPalId = 0xD;
    gUnk_4.bgChr = 0x1E0;
    gUnk_4.bgPalId = 0xD;
    gUnk_4.bg = 1;
    gUnk_4.bgTmBuf = gBG1TilemapBuffer;
    gUnk_4.bgImgBuf = gSpellAnimBgfx;
    gUnk_4.bgTsaBuf = gEkrTsaBuffer;
    gUnk_4.objImgBuf = gBuf_Banim;
    gUnk_4.resetCallback = DebuggerBanimBlendWindowConfig;

    // gEkrSpellAnimIndex is (re)assigned per reel half in DebuggerBanimPreview_ResetScript
    // below, off these two - not set directly here, since which half is playing (and
    // therefore which spell id is correct) keeps changing for as long as this preview
    // stays open, not just once at setup.
    proc->weapon = weapon;
    proc->naturalSpellId = GetDebuggerSpellAnimId(entry->classId, weapon);

    ResetClassReelSpell();
    NewDebuggerEkrUnitMainMini(&gOpInfoData);
    SetDebuggerBanimLayer(0);

    gUnk_Opinfo_0.unk00 = DEBUGGER_BANIM_TERRAIN; // terrain_l
    gUnk_Opinfo_0.unk02 = 0xE;                    // pal_l
    gUnk_Opinfo_0.unk04 = 0x180;                  // chr_l - 0x380 is OBCHR_MU_380, the default MMS obj tile base -
                                                  // would overlap the map sprites shown alongside this preview
    gUnk_Opinfo_0.unk06 = DEBUGGER_BANIM_TERRAIN; // terrain_r
    gUnk_Opinfo_0.unk08 = 0xF;                    // pal_r
    gUnk_Opinfo_0.unk0A = 0x1C0;                  // chr_r
    gUnk_Opinfo_0.unk0C = 0;                      // distance
    gUnk_Opinfo_0.unk0E = -1;
    gUnk_Opinfo_0.unk1C = (void *)0x06010000;
    gUnk_Opinfo_0.unk20 = gUnk_Banim_Ekrbattle_0;

    InitBanimTerrain(&gUnk_Opinfo_0);
    SetBanimTerrainPos(
        &gUnk_Opinfo_0, DEBUGGER_BANIM_BG_X, DEBUGGER_BANIM_BG_Y, DEBUGGER_BANIM_BG_X + 0x60, DEBUGGER_BANIM_BG_Y);

    // proc->classReelEnt = entry;
    proc->classReelEnt = (void *)&DefaultClassReelData[0];

    // Always start a freshly-selected class/weapon on the melee half - otherwise which
    // half you see first would depend on how many times the reel happened to have
    // looped while browsing previous selections, which would look like a bug rather
    // than the intentional alternation DebuggerBanimPreview_ResetScript does on loop.
    proc->useRanged = FALSE;
    DebuggerBanimPreview_ResetScript(proc);
}

static void EndDebuggerBanimPreview(void)
{
    Proc_EndEach(sProc_DebuggerBanimPreview);
}

static void StartDebuggerBanimPreview(int classId, struct Unit * unit, int weapon)
{
    struct OpInfoClassDisplayProc * proc;
    struct ClassReelEnt * vanillaEntry;
    struct ClassReelEnt fallbackEntry;
    struct ClassReelEnt * entry;

    BMapDispResume();
    EndDebuggerBanimPreview();

    if (classId == 0 || GetClassData(classId) == NULL)
        return;

    vanillaEntry = GetDebuggerBanimReelEntry(classId);

    if (vanillaEntry != NULL)
    {
        entry = vanillaEntry;
    }
    else
    {
        FillDebuggerBanimFallbackEntry(&fallbackEntry, classId, unit, weapon);
        entry = &fallbackEntry;
    }

    if (!IsDebuggerBanimSafe(entry, classId, unit, weapon))
        return;

    BMapDispSuspend();
    proc = Proc_Start(sProc_DebuggerBanimPreview, PROC_TREE_3);
    SetupDebuggerBanimAnim(proc, entry, vanillaEntry, weapon);
}

static void DebuggerBanimPreview_ExecScript(struct OpInfoClassDisplayProc * proc)
{
    ClassInfoDisplay_ExecScript(proc);
    SetDebuggerBanimLayer(0);
}

static void DebuggerBanimPreview_LoopScript(struct OpInfoClassDisplayProc * proc)
{
    ClassInfoDisplay_LoopScript(proc);
    SetDebuggerBanimLayer(0);
}

static void DebuggerBanimPreview_OnEnd(struct OpInfoClassDisplayProc * proc)
{
    // Does NOT call BMapDispResume() - see the comment on StartDebuggerBanimPreview().
    (void)proc;

    EndActiveClassReelSpell();
    EndActiveClassReelBgColorProc();

    // SetupDebuggerBanimAnim (the only way this proc ever starts) always
    // calls NewEkrUnitMainMini, so this always has a mini anim to end
    EndEkrUnitMainMini(&gOpInfoData);

    EndBanimTerrain(&gUnk_Opinfo_0);
    EndEfxAnimeDrvProc();
    ApplyUnitSpritePalettes();
}

static const struct ProcCmd sProc_DebuggerBanimPreview[] = {
    PROC_NAME("DebuggerBanimPreview"),
    PROC_SET_END_CB(DebuggerBanimPreview_OnEnd),
    PROC_YIELD,
    PROC_LABEL(0),
    PROC_CALL(DebuggerBanimPreview_ExecScript),
    PROC_REPEAT(DebuggerBanimPreview_LoopScript),
    PROC_GOTO(0),

    PROC_LABEL(10),
    PROC_CALL(DebuggerBanimPreview_ResetScript),
    PROC_GOTO(0),

    PROC_END,
};

#define AnimViewerOption_Class 0
#define AnimViewerOption_Item 1
#define AnimViewerOption_Selected 2
#define AnimViewerTmp_Restart 3
#define AnimViewerTmp_Exit 4
#define AnimViewerTmp_BattleLive 5
#define AnimViewerTmp_OldAnimType 6
#define AnimViewerTmp_Redraw 7
#define AnimViewerTmp_TextChr 8
#define AnimViewerTmp_UnhideAnims 9
#define AnimViewerTmp_Rebuild 10
#define AnimViewerTmp_OldStateBits 11
#define AnimViewerTmp_HpBarBusy 12
#define AnimViewerTmp_RetryTimer 13
#define AnimViewerTmp_Restored 14
#define AnimViewerRetryFrames 30
#define AnimViewerMaxClass CLASS_PUPIL_T1
#define AnimViewerMaxItem ITEM_GOLDGEM
#define AnimViewerPreviewHp 61
#define AnimViewerPreviewDamage 20
#define AnimViewerPreviewCrit 50
#define AnimViewerLeftItemChr 7
#define AnimViewerRightItemChr 22

/**
 * Toggle for ForceAnimViewerArenaRoundSwap(): whether a scroll input has to wait for
 * the round currently on screen to finish (CheckEkrHitDone(): gEkrHpBarCount == 0 &&
 * gEfxSpellAnimExists == 0) before cutting over to the new class/item, versus swapping
 * on the very next frame regardless of what is still mid-animation.
 *
 * Defined = wait. This is what an earlier pass here already did (deferring the swap
 * behind CheckEkrHitDone(), with a timeout so a wedged effect layer could not freeze
 * the viewer forever) before it was replaced with the instant-swap approach + the
 * ResetAnimViewerRoundEffects()/AnimClearAll() proc-and-field cleanup that followed.
 * That cleanup runs either way below - this only controls the timing of the swap
 * relative to the outgoing round's effects, not whether they get cleaned up.
 *
 * Undefine to go back to swapping immediately, to compare.
 */
#define AnimViewerWaitForRoundFinish

extern u8 gGenericBuffer[0x2000];
extern struct Proc sProcArray[];
/**
 * animedrv.c's own anim pool/list head, not otherwise exposed. AnimClearAll() below
 * is a real hook (its name matches the ROM symbol at 0x08004EB8, so lyn wires this
 * definition in for the WHOLE game, not just the AnimViewer) and needs direct access.
 */
extern struct Anim sAnimPool[ANIM_MAX_COUNT];
extern struct Anim * sFirstAnim;
/* gUnknown_02000010 is gEkrbattle_0 in the decomp - see ResetAnimViewerSubstituteAnims */
#define gEkrSubstituteAnims ((struct Anim **)gUnknown_02000010)
extern s16 gBanimExpGain[2];
extern s16 gEfxHpLutOff[2];
extern struct Font * gActiveFont;

typedef struct
{
    /* 00 */ PROC_HEADER;
    DebuggerProc * debugger;
} AnimViewerControlProc;

static void AnimViewerControlLoop(AnimViewerControlProc * proc);
static void ResetAnimViewerBattleHp(void);

static const struct ProcCmd sProc_AnimViewerControl[] = {
    PROC_NAME("DebuggerAnimViewerControl"),
    PROC_REPEAT(AnimViewerControlLoop),
    PROC_END,
};

static struct Unit * GetAnimViewerActor(void)
{
    return (struct Unit *)gGenericBuffer;
}

static struct Unit * GetAnimViewerTarget(void)
{
    return (struct Unit *)(gGenericBuffer + sizeof(struct Unit));
}

static bool IsAnimViewerClass(int classId)
{
    const struct ClassData * class = GetClassData(classId);

    return classId != 0 && class != NULL && class->pBattleAnimDef != NULL;
}

static int GetNextAnimViewerClass(int classId, int direction)
{
    int i;

    for (i = 0; i <= AnimViewerMaxClass; ++i)
    {
        classId += direction;

        if (classId <= 0)
            classId = AnimViewerMaxClass;
        else if (classId > AnimViewerMaxClass)
            classId = 1;

        if (IsAnimViewerClass(classId))
            return classId;
    }

    return CLASS_EPHRAIM_LORD;
}

static bool IsAnimViewerItem(int item)
{
    int attributes;

    if (item == ITEM_NONE)
        return true;

    if (item < 0 || item > AnimViewerMaxItem)
        return false;

    attributes = GetItemAttributes(item);

    return (attributes & IA_REQUIRES_WEXP) != 0;
}

static bool IsAnimViewerSpecialClassItem(int classId, int item)
{
    switch (classId)
    {
        case CLASS_MANAKETE:
        case CLASS_MANAKETE_2:
            return item == ITEM_DEMONSTONE;

        case CLASS_MANAKETE_MYRRH:
            return item == ITEM_DIVINESTONE;

        case CLASS_DEMON_KING:
            return item == ITEM_RAVAGER;

        case CLASS_DRACO_ZOMBIE:
            return item == ITEM_MONSTER_WRETCHAIR;

        case CLASS_MOGALL:
        case CLASS_ARCH_MOGALL:
            return item == ITEM_DARK_FLUX;
    }

    return false;
}

static bool DoesAnimViewerClassHaveItemRank(int classId, int item)
{
    int type;
    const struct ClassData * class = GetClassData(classId);

    if (item == ITEM_NONE)
        return true;

    if (class == NULL)
        return false;

    if (IsAnimViewerSpecialClassItem(classId, item))
        return true;

    if ((class->attributes & CA_LOCK_3) && item == GetDebuggerDefaultPreviewWeapon(classId))
        return true;

    type = GetItemType(item);

    if (type < ITYPE_SWORD || type > ITYPE_DARK)
        return false;

    return class->baseRanks[type] != 0;
}

static bool IsAnimViewerItemValidForClass(int classId, int item)
{
    u32 animId = 0;
    s16 spellAnimId;
    const struct ClassData * class = GetClassData(classId);

    if (class == NULL || class->pBattleAnimDef == NULL)
        return false;

    if (!IsAnimViewerItem(item))
        return false;

    if (!DoesAnimViewerClassHaveItemRank(classId, item))
        return false;

    if (GetBattleAnimationId(NULL, class->pBattleAnimDef, item, &animId) == (u16)-1)
        return false;

    spellAnimId = GetSpellAnimId(classId, item);
    UnsetMapStaffAnim(&spellAnimId, 0, item);

    return spellAnimId != -2;
}

static int GetAnimViewerFallbackItem(int classId)
{
    int i;
    int item = GetDebuggerDefaultPreviewWeapon(classId);

    if (IsAnimViewerItemValidForClass(classId, item))
        return item;

    for (i = 1; i <= AnimViewerMaxItem; ++i)
        if (IsAnimViewerItemValidForClass(classId, i))
            return i;

    if (IsAnimViewerItemValidForClass(classId, ITEM_NONE))
        return ITEM_NONE;

    return ITEM_NONE;
}

static int NormalizeAnimViewerItemForClass(int classId, int item)
{
    if (IsAnimViewerItemValidForClass(classId, item))
        return item;

    return GetAnimViewerFallbackItem(classId);
}

static int GetAnimViewerItemAfterClassChange(int classId, int item)
{
    if (item == ITEM_NONE)
        return GetAnimViewerFallbackItem(classId);

    return NormalizeAnimViewerItemForClass(classId, item);
}

static int GetNextAnimViewerItem(int classId, int item, int direction)
{
    int i;

    for (i = 0; i <= AnimViewerMaxItem; ++i)
    {
        item += direction;

        if (item < 0)
            item = AnimViewerMaxItem;
        else if (item > AnimViewerMaxItem)
            item = 0;

        if (IsAnimViewerItemValidForClass(classId, item))
            return item;
    }

    return GetAnimViewerFallbackItem(classId);
}

static const char * GetAnimViewerItemName(int item)
{
    if (item == ITEM_NONE)
        return "None";

    return GetDebuggerPreviewWeaponName(item);
}

static int GetAnimViewerBattleRange(int item)
{
    if (item == ITEM_NONE)
        return 1;

    if (GetItemMinRange(item) > 1)
        return GetItemMinRange(item);

    if (GetItemType(item) == ITYPE_BOW)
        return 2;

    return 1;
}

static void SaveAnimViewerTextChr(DebuggerProc * proc)
{
    if (gActiveFont != NULL)
        proc->tmp[AnimViewerTmp_TextChr] = gActiveFont->chr_counter;
}

static void RestoreAnimViewerTextChr(DebuggerProc * proc)
{
    // SetTextFont(0);
    // SetTextFontGlyphs(0);
    // ResetText();

    // if (gActiveFont != NULL)
    // gActiveFont->chr_counter = proc->tmp[AnimViewerTmp_TextChr];
}

/**
 * The viewer keeps a real arena battle alive so the animation loops forever.
 * Every time the arena rolls into its next round, banim calls ArenaContinueBattle(),
 * which calls WriteSuspendSave(3) - a full suspend save (several KB of byte-wide
 * SRAM writes, each chunk verified and retried up to 3 times) in a single frame.
 * On top of the stall, WriteSuspendSave packs the unit arrays through gGenericBuffer,
 * which is exactly where GetAnimViewerActor()/GetAnimViewerTarget() live, so every
 * loop also shredded our two units (and overwrote the player's real suspend save).
 *
 * WriteSuspendSave() and the pid-stat SRAM writes both bail out early on
 * PLAY_FLAG_TUTORIAL, so borrow that flag for as long as the viewer is open.
 */
static void SuppressAnimViewerSuspendSave(DebuggerProc * proc)
{
    proc->tmp[AnimViewerTmp_OldStateBits] = gPlaySt.chapterStateBits;
    gPlaySt.chapterStateBits |= PLAY_FLAG_TUTORIAL;
}

static void RestoreAnimViewerSuspendSave(DebuggerProc * proc)
{
    gPlaySt.chapterStateBits = proc->tmp[AnimViewerTmp_OldStateBits];
}

static void SuppressAnimViewerBattleProgress(void)
{
    gBanimExpGain[0] = 0;
    gBanimExpGain[1] = 0;
    gBattleActor.expGain = 0;
    gBattleTarget.expGain = 0;
    gBattleActor.wexpMultiplier = 0;
    gBattleTarget.wexpMultiplier = 0;
    gBattleActor.weaponBroke = FALSE;
    gBattleTarget.weaponBroke = FALSE;
}

static void SetupAnimViewerBattleRounds(void)
{
    int actorWeapon = gBattleActor.weaponBefore;
    int targetWeapon = gBattleTarget.weaponBefore;

    gBattleActor.battleHitRate = 100;
    gBattleActor.battleEffectiveHitRate = 100;

    /**
     * BattleUnwind() rolls the crit for each hit off battleEffectiveCritRate
     * (BattleUpdateBattleStats copies it into gBattleStats.critRate), so the rate has
     * to be live *here* - setting it after the unwind only changes the number the UI
     * prints. This used to zero it and never put it back, so once a class change had
     * gone through ForceAnimViewerArenaRoundSwap the actor sat at 0% crit for good.
     *
     * The silencer rate stays off: a killer weapon rolling a silencer instead of a
     * crit deals BATTLE_MAX_DAMAGE, which would drop the target to 0 and kick off the
     * death animation. A plain crit is 3x20 = 60 against 61 HP, so it always survives.
     */
    gBattleActor.battleCritRate = AnimViewerPreviewCrit;
    gBattleActor.battleEffectiveCritRate = AnimViewerPreviewCrit;
    gBattleActor.battleSilencerRate = 0;
    gBattleTarget.battleSilencerRate = 0;
    gBattleActor.battleSpeed = 0;
    gBattleTarget.battleSpeed = 0;
    gBattleTarget.weapon = ITEM_NONE;
    gBattleTarget.weaponBefore = ITEM_NONE;
    gBattleTarget.canCounter = FALSE;

    BattleUnwind();

    gBattleActor.weapon = actorWeapon;
    gBattleActor.weaponBefore = actorWeapon;
    gBattleActor.unit.items[0] = actorWeapon;
    gBattleActor.weaponBroke = FALSE;
    gBattleTarget.weapon = targetWeapon;
    gBattleTarget.weaponBefore = targetWeapon;
    gBattleTarget.unit.items[0] = targetWeapon;
    ResetAnimViewerBattleHp();
}

static void ApplyAnimViewerPreviewBattleStats(void)
{
    gBattleTarget.battleDefense = 0;
    gBattleActor.battleAttack = AnimViewerPreviewDamage;
    gBattleActor.battleCritRate = AnimViewerPreviewCrit;
    gBattleActor.battleEffectiveCritRate = AnimViewerPreviewCrit;
    gBattleTarget.battleAttack = 0;
    gBattleTarget.battleCritRate = 0;
    gBattleTarget.battleEffectiveCritRate = 0;
    gBattleStats.damage = AnimViewerPreviewDamage;

    SetupAnimViewerBattleRounds();

    gBattleActor.battleAttack = AnimViewerPreviewDamage;
    gBattleTarget.battleDefense = 0;
    gBattleActor.battleCritRate = AnimViewerPreviewCrit;
    gBattleActor.battleEffectiveCritRate = AnimViewerPreviewCrit;
    gBattleStats.attack = AnimViewerPreviewDamage;
    gBattleStats.defense = 0;
    gBattleStats.damage = AnimViewerPreviewDamage;
    gBattleStats.critRate = AnimViewerPreviewCrit;
}

static void SetAnimViewerBattleUnitWeapon(struct BattleUnit * bu, int item)
{
    int weapon = item != ITEM_NONE ? MakeNewItem(item) : ITEM_NONE;

    bu->unit.items[0] = weapon;
    bu->weaponSlotIndex = 0;
    bu->weapon = weapon;
    bu->weaponBefore = weapon;
    bu->weaponAttributes = GetItemAttributes(weapon);
    bu->weaponType = GetItemType(weapon);
    bu->canCounter = FALSE;
    bu->weaponBroke = FALSE;
}

static void RestoreAnimViewerBattleWeapons(int item)
{
    struct Unit * actor = GetAnimViewerActor();
    struct Unit * target = GetAnimViewerTarget();
    int weapon = item != ITEM_NONE ? MakeNewItem(item) : ITEM_NONE;

    actor->items[0] = weapon;
    target->items[0] = ITEM_NONE;

    gArenaState.playerWeapon = weapon;
    gArenaState.opponentWeapon = ITEM_NONE;

    SetAnimViewerBattleUnitWeapon(&gBattleActor, item);
    SetAnimViewerBattleUnitWeapon(&gBattleTarget, ITEM_NONE);
}

/**
 * Everything the battle engine needs pinned so nobody ever actually dies.
 * Safe to call every frame - it does not touch the on-screen gauge.
 */
static void ResetAnimViewerUnitHp(void)
{
    struct Unit * actor = GetAnimViewerActor();
    struct Unit * target = GetAnimViewerTarget();

    actor->maxHP = AnimViewerPreviewHp;
    actor->curHP = AnimViewerPreviewHp;
    target->maxHP = AnimViewerPreviewHp;
    target->curHP = AnimViewerPreviewHp;

    gBattleActor.unit.maxHP = AnimViewerPreviewHp;
    gBattleActor.unit.curHP = AnimViewerPreviewHp;
    gBattleActor.hpInitial = AnimViewerPreviewHp;
    gBattleTarget.unit.maxHP = AnimViewerPreviewHp;
    gBattleTarget.unit.curHP = AnimViewerPreviewHp;
    gBattleTarget.hpInitial = AnimViewerPreviewHp;

    gEkrPairMaxHP[0] = AnimViewerPreviewHp;
    gEkrPairMaxHP[1] = AnimViewerPreviewHp;
    gActionData.trapType = 0;

    SuppressAnimViewerBattleProgress();
}

/**
 * The displayed gauge only. gBanimSomeHp is EkrGauge's "last drawn" cache, so it
 * gets invalidated rather than set to the new value - writing both the value and
 * the cache in the same frame is what makes the gauge skip its redraw.
 */
static void ResetAnimViewerGaugeHp(void)
{
    gEkrGaugeHp[0] = AnimViewerPreviewHp;
    gEkrGaugeHp[1] = AnimViewerPreviewHp;
    gBanimSomeHp[0] = -1;
    gBanimSomeHp[1] = -1;
}

static void ResetAnimViewerBattleHp(void)
{
    ResetAnimViewerUnitHp();
    ResetAnimViewerGaugeHp();
}

static void ResetAnimViewerBattleAnimHp(void)
{
    int i;

    gEfxHpLutOff[0] = 0;
    gEfxHpLutOff[1] = 0;

    for (i = 0; i < 22; ++i)
        gEfxHpLut[i] = AnimViewerPreviewHp;
}

static void SetAnimViewerAnimsHidden(bool hidden)
{
    int i;

    for (i = 0; i < 4; ++i)
    {
        if (gAnims[i] == NULL)
            continue;

        if (hidden)
            gAnims[i]->state |= ANIM_BIT_HIDDEN;
        else
            gAnims[i]->state &= ~ANIM_BIT_HIDDEN;
    }
}

static void QueueAnimViewerAnimsHidden(DebuggerProc * proc, int frames)
{
    SetAnimViewerAnimsHidden(TRUE);

    if (proc->tmp[AnimViewerTmp_UnhideAnims] < frames)
        proc->tmp[AnimViewerTmp_UnhideAnims] = frames;
}

#define AnimViewerProcCount 64

static bool AnimViewerProcNameIs(const char * name, const char * prefix)
{
    while (*prefix != 0)
        if (*name++ != *prefix++)
            return false;

    return true;
}

/**
 * Read a proc's name back out of its own script rather than off Proc::proc_name.
 * Proc_Start() never resets proc_name, and 135 of the 260 proc scripts in the ROM
 * carry no PROC_NAME at all, so those procs inherit whatever name the previous tenant
 * of their slot left behind. A script with no PROC_NAME is not one we can identify.
 */
static const char * GetAnimViewerProcScriptName(const struct ProcCmd * script)
{
    int i;

    for (i = 0; i < 8; ++i)
    {
        if (script[i].opcode == 0x00) /* PROC_END */
            break;

        if (script[i].opcode == 0x01) /* PROC_NAME */
            return script[i].dataPtr;
    }

    return NULL;
}

/**
 * Clear the floating damage/heal digits left over from the round we are cutting short.
 *
 * They are two procs: efxDamageMojiEffectOBJ, which is just a 50-frame timer, and the
 * ekrsubAnimeEmulator it parks at +0x60, which is what actually pushes the sprites.
 * The emulator is type 2, so it never breaks on its own - the owner is the only thing
 * that ends it. End both, which is exactly what the battle-numbers hack's own kill
 * routine does when a fresh hit effect starts.
 *
 * The emulator draws through a stack-local struct Anim rather than a pool slot, so
 * there is nothing to clean up in sAnimPool for these.
 *
 * Identify the emulators by root tree rather than by owner so this holds whoever
 * started them: the digit ones are rooted on tree 3, while the mini unit sprites
 * (tree 4) and the level-up effects (tree 5) are not ours to touch. Root procs keep
 * the tree index in proc_parent instead of a pointer.
 *
 * Deliberately narrow. Sweeping every "efx" proc also caught efxMantBatabata (the
 * cape flutter, C47) and efxChillAnime, and those call SetAnimStateHidden() on the
 * main anims when they start and are the only things that ever call
 * SetAnimStateUnHidden() again - killing them mid-flight is what left the battle
 * animation invisible after a class change.
 */
static void ResetAnimViewerBattleDigits(void)
{
    int i;

    for (i = 0; i < AnimViewerProcCount; ++i)
    {
        struct Proc * it = &sProcArray[i];
        const char * name;

        /* DeleteProcessRecursive() nulls proc_script, so this skips free slots */
        if (it->proc_script == NULL)
            continue;

        name = GetAnimViewerProcScriptName(it->proc_script);

        if (name == NULL)
            continue;

        if (AnimViewerProcNameIs(name, "efxDamageMojiEffectOBJ") ||
            (AnimViewerProcNameIs(name, "ekrsubAnimeEmulator") && (int)it->proc_parent == 3))
            Proc_End(it);
    }
}

/**
 * Put the two sides back where a round is supposed to start them.
 *
 * Far attacks and spells drag the sprites around: efxFarAttack walks gEkrBgXOffset
 * and rewrites all four anim x positions every frame, and a swapped round inherits
 * wherever it left them. Worse, changing weapon can change gEkrDistanceType (a bow is
 * EKR_DISTANCE_FAR, a sword is EKR_DISTANCE_CLOSE), and the base positions are keyed
 * off that - so switching off an archer left both sides standing at bow range.
 *
 * A natural arena round does not have this problem because InitMainAnims() recreates
 * the anims through InitLeftAnim()/InitRightAnim(), which is where these values come
 * from. We reuse the anims instead, so redo just the position half here. gEkrBgXOffset
 * is read rather than reset, exactly as InitLeftAnim() does, so the sprites stay in
 * step with however the background is currently scrolled.
 */
static void ResetAnimViewerAnimPositions(void)
{
    int i;

    gEkrXPosBase[EKR_POS_L] = -BanimLeftDefaultPos[gEkrDistanceType];
    gEkrYPosBase[EKR_POS_L] = 0;
    gEkrXPosReal[EKR_POS_L] = gEkrXPosBase[EKR_POS_L] + BanimTypesPosLeft[gEkrDistanceType];
    gEkrYPosReal[EKR_POS_L] = 0x58;

    gEkrXPosBase[EKR_POS_R] = 0;
    gEkrYPosBase[EKR_POS_R] = 0;
    gEkrXPosReal[EKR_POS_R] = BanimTypesPosRight[gEkrDistanceType];
    gEkrYPosReal[EKR_POS_R] = 0x58;

    for (i = 0; i < 4; ++i)
    {
        if (gAnims[i] == NULL)
            continue;

        gAnims[i]->xPosition = gEkrXPosReal[i / 2] - gEkrBgXOffset;
        gAnims[i]->yPosition = gEkrYPosReal[i / 2];
    }
}

/**
 * Retire the substitute battle sprites.
 *
 * efxMantBatabata (the cape flutter, banim command C47) and efxChillAnime both swap a
 * unit's battle sprite for one of their own: they AnimCreate() a replacement, stash it
 * in gEkrbattle_0[side] and call SetAnimStateHidden() on the real anims, then delete it
 * and unhide again when they finish. EfxMantBatabata_Loop1 gets there by waiting on
 * ANIM_BIT3_HIT_EFFECT_APPLIED - which we clear when we rewind the round - so a swapped
 * round leaves it blocked on a flag that is never coming. The replacement stays in the
 * pool drawing a full copy of the sprite, and the next round's flutter allocates
 * another on top. That is the stack of duplicate OAM entries for the target.
 *
 * End the owner before deleting the anim, so nothing is left to call AnimDelete() on a
 * slot we already freed, then unhide the real sprites - those two procs are the only
 * things that ever call SetAnimStateUnHidden(), so if we do not do it here the battle
 * animation stays invisible.
 */
static void ResetAnimViewerSubstituteAnims(void)
{
    int i;

    for (i = 0; i < AnimViewerProcCount; ++i)
    {
        struct Proc * it = &sProcArray[i];
        const char * name;

        if (it->proc_script == NULL)
            continue;

        name = GetAnimViewerProcScriptName(it->proc_script);

        if (name == NULL)
            continue;

        if (AnimViewerProcNameIs(name, "efxMantBatabata") || AnimViewerProcNameIs(name, "efxChillAnime"))
            Proc_End(it);
    }

    for (i = 0; i < 2; ++i)
    {
        if (gEkrSubstituteAnims[i] == NULL)
            continue;

        AnimDelete(gEkrSubstituteAnims[i]);
        gEkrSubstituteAnims[i] = NULL;
    }

    SetAnimViewerAnimsHidden(FALSE);
}

// 02028f78 b sAnimPool	/home/runner/work/fireemblem8u/fireemblem8u/src/animedrv.c:14
// 02029d88 b sFirstAnim	/home/runner/work/fireemblem8u/fireemblem8u/src/animedrv.c:15
/**
 * This is a full replacement of the vanilla ROM function (see the sAnimPool/sFirstAnim
 * extern comment above) - every AnimClearAll() call in the whole game goes through
 * this, not just the AnimViewer's.
 *
 * Vanilla only zeroes state/pPrev/pNext, which is enough to unlink every slot and mark
 * it disabled, but leaves everything else - notably pImgSheet and pSpriteData - holding
 * whatever the slot's previous occupant left there. AnimCreate() does not fill those
 * two in either (it only sets state/pScrCurrent/pScrStart/timer/oam2Base/
 * drawLayerPriority/state2/state3/oamBase/commandQueueSize and NULLs pImgSheetBuf/
 * pSpriteDataPool/pUnk40/pUnk44); pSpriteData specifically is only ever written when a
 * C0D "start round" script command runs (banim-main.c) or by
 * SwitchAISFrameDataFromBARoundType(). Between AnimCreate() and that first script step,
 * AnimDisplayPrivate() - which runs unconditionally for every enabled, unhidden anim,
 * every frame - reads anim->pSpriteData directly to find the OAM records to draw:
 *
 *     const struct AnimSpriteData* oamData = anim->pSpriteData;
 *     if (!oamData) return;
 *
 * so a slot whose pSpriteData is still a stale pointer from an unrelated previous
 * anim (a different unit, a digit display, a spell effect) draws THAT data for
 * however many frames it takes for the round-init script to reach it - a real piece
 * of the wrong sprite, not a rendering glitch. Zeroing it here makes that window draw
 * nothing (oamData == NULL, no-op) instead of garbage.
 *
 * A real battle rarely exposes this: AnimClearAll() runs once, then exactly four anims
 * get created and scripted in the same breath, so the stale-pointer window is razor
 * thin. The AnimViewer's rapid restart/scroll churn - many more AnimClearAll() calls
 * per minute than a real battle ever sees, hitting a 50-slot pool that used to hold
 * digit displays, substitute cape/chill anims, and both units - makes it common
 * instead of theoretical.
 */
/*
void AnimClearAll(void)
{
   brk;
   CpuFastFill(0, gOam, 0x600);
   struct Anim * it;

   for (it = sAnimPool; it < sAnimPool + ANIM_MAX_COUNT; ++it)
       *it = (struct Anim) { 0 };

   sFirstAnim = NULL;
}
*/
/**
 * AnimClearAll() (called from BeginAnimsOnBattle_Arena, i.e. every StartAnimViewerBattle)
 * zeroes every anim pool slot's state and unlinks it from the draw list, with no idea
 * which procs are holding raw struct Anim* pointers into that pool. It is meant to run
 * only between battles, when nothing else is alive to hold such a pointer - but our
 * "battle" auto-restarts on its own the moment a round finishes (ekrBattleInRoundIdle
 * -> ... -> ekrBattle_PostDragonStatusEffect sets gEkrBattleEndFlag, which tears the
 * deamon down and StartAnimViewerBattle fires again), with no scrolling required.
 *
 * If efxMantBatabata or efxChillAnime (see ResetAnimViewerSubstituteAnims) is still
 * mid-flight at that exact moment - EfxMantBatabata_Loop2 only breaks once
 * CheckEkrHitDone() is true, which is a separate gate from whatever let the round
 * itself report done - AnimClearAll() wipes its substitute anim's slot out from under
 * it without ending the owning proc. That proc keeps running afterward, writing into
 * (and eventually AnimDelete()-ing) whatever the next round's InitLeftAnim/InitRightAnim
 * happens to allocate into that same low-index slot - which, since AnimCreate() always
 * scans from the start of the pool, is exactly the range gAnims[0..3] draw from. That
 * silent corruption of a live main-anim slot is what shows up as a duplicated sprite.
 *
 * The digit sweep is included too for the same reason, even though its slot exposure
 * is smaller (see ResetAnimViewerBattleDigits) - both need to run before ANY AnimClearAll,
 * not only the ones the user's own scrolling triggers.
 */
static void ResetAnimViewerRoundEffects(void)
{
    ResetAnimViewerBattleDigits();
    ResetAnimViewerSubstituteAnims();
}

int ForceAnimViewerArenaRoundSwap(DebuggerProc * proc)
{
    // brk;
    int side;

    if (gAnims[0] == NULL || gAnims[2] == NULL)
        return false;

    // #ifdef AnimViewerWaitForRoundFinish
    /**
     * Hold the swap until the round on screen (hp-bar drain, spell effect) has
     * actually finished, rather than cutting it off mid-animation. Restart stays set
     * on the debugger proc, so AnimViewerControlLoop retries this every frame - cheap,
     * since it is just this one check until CheckEkrHitDone() goes true.
     */
    // if (!CheckEkrHitDone())
    // return false;
    // #endif

    /* clear what the round we are cutting short left drawn on screen */
    ResetAnimViewerRoundEffects();

    QueueAnimViewerAnimsHidden(proc, 2);
    SetupAnimViewerBattleRounds();

    /**
     * The vanilla arena round loop rewinds gEfxHpLutOff in InitMainAnims(); we swap
     * rounds without it, so rewind it here. Otherwise a swap taken mid-drain leaves
     * the offset pointing past the freshly parsed hits and NewEfxHpBar() reads the
     * 0xFFFF terminator as its target HP.
     */
    ResetAnimViewerBattleAnimHp();
    ParseBattleHitToBanimCmd();
    UpdateBanimFrame();
    ResetAnimViewerAnimPositions();

    for (side = 0; side < 2; ++side)
    {
        int type = GetBattleAnimRoundType(side);
        struct Anim * anim1 = gAnims[side * 2];
        struct Anim * anim2 = gAnims[side * 2 + 1];

        if (type == ANIM_ROUND_INVALID || anim1 == NULL || anim2 == NULL)
        {
            gBanimDoneFlag[side] = TRUE;
            continue;
        }

        SwitchAISFrameDataFromBARoundType(anim1, type);
        SwitchAISFrameDataFromBARoundType(anim2, type);

        anim1->state3 = ANIM_BIT3_C01_BLOCKING_IN_BATTLE;
        anim2->state3 = ANIM_BIT3_C01_BLOCKING_IN_BATTLE;

        anim1->nextRoundId = 1;
        anim2->nextRoundId = 1;

        AnimScrAdvance(anim1);
        AnimScrAdvance(anim2);

        gBanimDoneFlag[side] = FALSE;
    }

    gCtrlC01Blocking = 0;

    ResetAnimViewerBattleHp();

    /**
     * The teardown above already put the gauge back to full, and the LUT we just
     * parsed is the one the new round has to drain. Drop the latch so the falling
     * edge further down the control loop does not fire this frame and flatten it.
     */
    proc->tmp[AnimViewerTmp_HpBarBusy] = FALSE;

    return true;
}

static void RefreshAnimViewerBattleUi(void)
{
    struct Font * oldFont = gActiveFont;
    struct Text text;
    const char * str;
    int oldChrCounter;

    if (oldFont == NULL)
        return;

    oldChrCounter = oldFont->chr_counter;

    str = gpEkrBattleUnitLeft->weaponBefore == ITEM_NONE ? gNopStr : GetItemName(gpEkrBattleUnitLeft->weaponBefore);

    oldFont->chr_counter = AnimViewerLeftItemChr;
    InitText(&text, 8);
    Text_SetCursor(&text, GetStringTextCenteredPos(0x40, str));
    LZ77UnCompVram(Img_EfxLeftItemBox, (void *)0x6001A40);
    Text_DrawString(&text, str);

    str = gpEkrBattleUnitRight->weaponBefore == ITEM_NONE ? gNopStr : GetItemName(gpEkrBattleUnitRight->weaponBefore);

    oldFont->chr_counter = AnimViewerRightItemChr;
    InitText(&text, 8);
    Text_SetCursor(&text, GetStringTextCenteredPos(0x3E, str));
    LZ77UnCompVram(Img_EfxRightItemBox, (void *)0x6001E00);
    Text_DrawString(&text, str);

    oldFont->chr_counter = oldChrCounter;
    SetTextFont(oldFont);

    /**
     * The weapon icon OBJ tiles are only loaded once, by NewEkrGauge() at battle
     * start, so the icon kept showing whatever the viewer opened with. Reload the
     * same two chr slots NewEkrGauge uses. GetItemIconId() returns -1 for
     * ITEM_NONE, which makes LoadIconObjectGraphics blank the slot instead.
     */
    LoadIconObjectGraphics(GetItemIconId(gpEkrBattleUnitLeft->weaponBefore), 0x1DC);
    LoadIconObjectGraphics(GetItemIconId(gpEkrBattleUnitRight->weaponBefore), 0x1DE);

    EndProcEfxWeaponIcon();
    NewEfxWeaponIcon(0, 0);
}

static void InitAnimViewerUnit(struct Unit * unit, int charId, int classId, int faction, int item)
{
    int i;
    const struct ClassData * class = GetClassData(classId);

    ClearUnit(unit);

    unit->pCharacterData = GetCharacterData(charId);
    unit->pClassData = class;
    unit->level = 20;
    unit->exp = UNIT_EXP_DISABLED;
    unit->index = faction | 1;
    unit->xPos = 5;
    unit->yPos = 5;
    unit->maxHP = AnimViewerPreviewHp;
    unit->curHP = AnimViewerPreviewHp;
    unit->pow = class->basePow + 15;
    unit->skl = class->baseSkl + 15;
    unit->spd = class->baseSpd + 15;
    unit->def = class->baseDef + 10;
    unit->res = class->baseRes + 10;
    unit->lck = 15;
    unit->items[0] = item != ITEM_NONE ? MakeNewItem(item) : ITEM_NONE;

    for (i = 0; i < 8; ++i)
        unit->ranks[i] = WPN_EXP_A;
}

static int GetAnimViewerActorSide(void)
{
    if (gpEkrBattleUnitLeft == &gBattleActor)
        return EKR_POS_L;

    if (gpEkrBattleUnitRight == &gBattleActor)
        return EKR_POS_R;

    return EKR_POS_R;
}

static void RefreshAnimViewerBanimCache(void)
{
    u32 animId = 0;
    u16 banimId;
    int side = GetAnimViewerActorSide();
    int weapon = gBattleActor.weaponBefore;
    struct Unit * actor = &gBattleActor.unit;

    banimId = GetBattleAnimationId(actor, actor->pClassData->pBattleAnimDef, weapon, &animId);
    if (banimId == (u16)-1)
        return;

    gEkrPairBanimID2[side] = banimId;
    gEkrPairBanimID[side] = gEkrPairBanimID2[side];
    gAnimCharaPalIndex[side] = -1;
    gEkrSpellAnimIndex[side] = GetSpellAnimId(actor->pClassData->number, weapon);
    UnsetMapStaffAnim(&gEkrSpellAnimIndex[side], side, weapon);

    gEkrPairMaxHP[side] = AnimViewerPreviewHp;
    gEkrGaugeHp[side] = AnimViewerPreviewHp;
    gBanimSomeHp[side] = AnimViewerPreviewHp;
    gEkrPairHit[side] = gBattleActor.battleEffectiveHitRate;
    gEkrPairDmgPair[side] = AnimViewerPreviewDamage;
    gEkrPairCritPair[side] = AnimViewerPreviewCrit;
    gEkrPairBaseCon[side] = actor->pClassData->baseCon;
    gEkrPairWTABonus[side] = gBattleActor.wTriangleHitBonus;
    gEkrPairEffectiveAgainst[side] = IsUnitEffectiveAgainst(actor, &gBattleTarget.unit);
    if (!gEkrPairEffectiveAgainst[side])
        gEkrPairEffectiveAgainst[side] = IsItemEffectiveAgainst(gBattleActor.weapon, &gBattleTarget.unit);
}

static void GenerateAnimViewerBattle(DebuggerProc * proc)
{
    int item = NormalizeAnimViewerItemForClass(proc->tmp[AnimViewerOption_Class], proc->tmp[AnimViewerOption_Item]);
    int range = GetAnimViewerBattleRange(item);
    struct Unit * actor = GetAnimViewerActor();
    struct Unit * target = GetAnimViewerTarget();

    proc->tmp[AnimViewerOption_Item] = item;

    InitAnimViewerUnit(actor, 0xFC, proc->tmp[AnimViewerOption_Class], FACTION_BLUE, item);
    InitAnimViewerUnit(target, 0xFD, CLASS_SOLDIER, FACTION_RED, ITEM_NONE);

    target->pow = 0;
    target->skl = 0;
    target->spd = 0;
    target->def = 100;
    target->res = 100;
    target->xPos = actor->xPos + range;
    target->yPos = actor->yPos;

    gArenaState.playerUnit = actor;
    gArenaState.opponentUnit = target;
    gArenaState.result = 0;
    gArenaState.range = range;
    gArenaState.playerWeapon = item != ITEM_NONE ? MakeNewItem(item) : ITEM_NONE;
    gArenaState.opponentWeapon = ITEM_NONE;

    gActionData.trapType = 0;
    BattleGenerateArena(actor);
    RestoreAnimViewerBattleWeapons(item);
    ApplyAnimViewerPreviewBattleStats();
    RefreshAnimViewerBanimCache();
    ResetAnimViewerBattleHp();
}

static void StartAnimViewerBattle(DebuggerProc * proc)
{
    bool started;

    GenerateAnimViewerBattle(proc);

    /**
     * The imminent AnimClearAll() (inside BeginAnimsOnBattleAnimations, below) is about
     * to wipe the whole anim pool. This restart is not only reached via scrolling - a
     * round that is left to finish on its own gets here too - so the same stray-proc
     * sweep ForceAnimViewerArenaRoundSwap() uses has to run here as well, or whichever
     * one of those procs is still mid-flight at the moment gets orphaned. See
     * ResetAnimViewerRoundEffects() for why that is not just a proc leak but a corrupted
     * sprite.
     */
    ResetAnimViewerRoundEffects();

    SetBanimLinkArenaFlag(0);

    gEkrBattleEndFlag = 0;

    started = PrepareBattleGraphicsMaybe();

    if (started)
        BeginAnimsOnBattleAnimations();

    proc->tmp[AnimViewerTmp_Restart] = FALSE;
    proc->tmp[AnimViewerTmp_Rebuild] = FALSE;
    proc->tmp[AnimViewerTmp_BattleLive] = started;
    proc->tmp[AnimViewerTmp_Redraw] = TRUE;
}

static void UpdateAnimViewerBattle(DebuggerProc * proc)
{

    int item = NormalizeAnimViewerItemForClass(proc->tmp[AnimViewerOption_Class], proc->tmp[AnimViewerOption_Item]);
    int range = GetAnimViewerBattleRange(item);
    struct Unit * actor = GetAnimViewerActor();
    struct Unit * target = GetAnimViewerTarget();

    proc->tmp[AnimViewerOption_Item] = item;

    InitAnimViewerUnit(actor, 0xFD, proc->tmp[AnimViewerOption_Class], FACTION_BLUE, item);
    InitAnimViewerUnit(target, 0xFC, CLASS_SOLDIER, FACTION_RED, ITEM_NONE);

    target->pow = 0;
    target->skl = 0;
    target->spd = 0;
    target->def = 100;
    target->res = 100;
    target->xPos = actor->xPos + range;
    target->yPos = actor->yPos;

    gArenaState.playerUnit = actor;
    gArenaState.opponentUnit = target;
    gArenaState.result = 0;
    gArenaState.range = range;
    gArenaState.playerWeapon = item != ITEM_NONE ? MakeNewItem(item) : ITEM_NONE;
    gArenaState.opponentWeapon = ITEM_NONE;

    gBattleStats.config = BATTLE_CONFIG_REAL | BATTLE_CONFIG_ARENA;
    gBattleStats.range = range;
    gEkrDistanceType = range <= 1 ? EKR_DISTANCE_CLOSE : (range <= 3 ? EKR_DISTANCE_FAR : EKR_DISTANCE_FARFAR);

    InitBattleUnit(&gBattleActor, actor);
    InitBattleUnit(&gBattleTarget, target);

    gBattleTarget.unit.xPos = gBattleActor.unit.xPos + range;
    gBattleTarget.unit.yPos = gBattleActor.unit.yPos;

    SetBattleUnitWeapon(&gBattleActor, BU_ISLOT_ARENA_PLAYER);
    SetBattleUnitWeapon(&gBattleTarget, BU_ISLOT_ARENA_OPPONENT);

    BattleApplyWeaponTriangleEffect(&gBattleActor, &gBattleTarget);

    SetBattleUnitTerrainBonusesAuto(&gBattleActor);
    SetBattleUnitTerrainBonuses(&gBattleTarget, 8);

    ComputeBattleUnitStats(&gBattleActor, &gBattleTarget);
    ComputeBattleUnitStats(&gBattleTarget, &gBattleActor);
    ComputeBattleUnitEffectiveStats(&gBattleActor, &gBattleTarget);
    ComputeBattleUnitEffectiveStats(&gBattleTarget, &gBattleActor);

    RestoreAnimViewerBattleWeapons(item);
    ApplyAnimViewerPreviewBattleStats();
    RefreshAnimViewerBanimCache();
    ResetAnimViewerBattleHp();
    RefreshAnimViewerBattleUi();
    RestoreAnimViewerTextChr(proc);

    // StartAnimViewerBattle(proc);
}

static void StartAnimViewerControl(DebuggerProc * proc)
{
    AnimViewerControlProc * control;

    Proc_EndEach(sProc_AnimViewerControl);

    control = Proc_Start(sProc_AnimViewerControl, PROC_TREE_3);
    control->debugger = proc;
}

/**
 * Rebuild the map display the battle animation tore down.
 *
 * A banim that ends normally gets put back by ekrBattleEnding_4..7 - InitBmBgLayers(),
 * the unit sprite reload, UnpackChapterMapPalette() and RefreshBMapDisplay_FromBattle().
 * We exit through the arena path instead (ExecBattleAnimArenaExit -> ekrTogiEnd), which
 * only ends the deamon and the gauge, because a real arena fight returns to the arena
 * screen rather than to the map. So none of that restoration ever ran and we came back
 * to a map with battle-anim tiles and palettes still loaded.
 *
 * BMapDispResume_FromBattleDelayed() is deliberately not used - it calls StartMu() on
 * gBattleActor, which here is a throwaway unit sitting in gGenericBuffer.
 */
static void RestoreAnimViewerBMapGraphics(DebuggerProc * proc)
{
    RefreshBMapDisplay_FromBattle();

    ResetUnitSprites();

    /**
     * ClearSomeGfx() is the debugger's own screen restore, and it is what the rest of
     * this menu already uses. It matters here for two things RefreshBMapGraphics()
     * alone does not cover: it wipes all four tilemap buffers - EkrDispUP leaves BG0
     * filled with tile 0x80, which is the row of leftover garbage across the top of
     * the menu - and its SetupBackgrounds(0) call puts every BG's tile and map data
     * offset, screen size and scroll back to the map defaults. It resumes the map
     * display and redraws it too, so nothing before it needs to.
     */
    ClearSomeGfx(proc);

    UnpackChapterMapPalette();
    LoadObjUIGfx();
    RefreshUnitSprites();
    ForceSyncUnitSpriteSheet();
    ApplyUnitSpritePalettes();
}

/**
 * End the procs the arena exit path does not know about.
 *
 * We fake an arena battle so the animation loops, but real arena battles return to
 * the arena shop screen, not the map - so the arena teardown (ExecBattleAnimArenaExit
 * -> NewEkrTogiEndPROC -> ekrTogiEnd_End) only ends the battle deamon and the gauge.
 * Three things it never touches, all confirmed by their single caller in the decomp:
 *
 * - gProc_ekrDispUP (the hit/dmg/crit number boxes): started unconditionally by every
 *   ekrTogiInit_Init(), i.e. every StartAnimViewerBattle() call. Its only End call
 *   sits in EkrNamewinAppearMain(), which belongs to the non-arena battle-intro proc
 *   chain we never run - so nothing in our flow ever ends it, and a new one starts on
 *   top of the old one every single round. This is not a maybe: it leaks every round,
 *   guaranteed, so more than one can be alive by the time you exit.
 *
 * - ProcScr_efxHPBarColorChange: started once per StartAnimViewerBattle() call, in
 *   ekrBattleSetFlashingEffect(). Its only End call sits in ekrBattle_PostPopup(),
 *   deep in the natural post-round sequence (exp bar, popup, dragon status) that a
 *   round only reaches if it is left to finish on its own - exiting mid-round skips
 *   straight past it.
 *
 * ProcScr_efxWeaponIcon (started in the same place) has the same problem, but its own
 * EndProcEfxWeaponIcon() is already null-safe and self-nulling, and RefreshAnimViewer-
 * BattleUi() already calls it on every scroll - so it is used directly below instead
 * of being swept, to keep gpProcEfxWeaponIcon correctly NULL rather than dangling.
 *
 * gProc_ekrDispUP and ProcScr_efxHPBarColorChange have no such self-nulling exported
 * End function, and their cached owner pointers (gpProcEkrDispUP, the latter is not
 * even exported) are not guaranteed live - EkrEfxStatusClear() nulls the HP-bar one
 * only at the START of the next StartAnimViewerBattle(), not when the popup ends it,
 * so there is a real window after a natural completion where the cached pointer is
 * stale. Proc_EndEach() sidesteps that: it matches by script identity against the
 * actual live proc table, so it is correct whether zero, one, or (for the dispUP
 * case) several are running, and it never touches a pointer that might be reused.
 */
static void EndAnimViewerStrayBattleProcs(void)
{
    Proc_EndEach(gProc_ekrDispUP);
    Proc_EndEach(ProcScr_efxHPBarColorChange);
    EndProcEfxWeaponIcon();
}

/**
 * Shared teardown. Both exit paths reach this - AnimViewerLoop() runs first because the
 * debugger proc is older than the control proc, but FinishAnimViewer() still fires on
 * the same frame - so it guards itself rather than doing all this twice.
 */
static void RestoreAnimViewerState(DebuggerProc * proc)
{
    if (proc->tmp[AnimViewerTmp_Restored])
        return;

    proc->tmp[AnimViewerTmp_Restored] = TRUE;

    gPlaySt.config.animationType = proc->tmp[AnimViewerTmp_OldAnimType];
    RestoreAnimViewerSuspendSave(proc);

    EndAnimViewerStrayBattleProcs();

    /* display state the banim owned: main update routine, vblank handler, core gfx,
   windows and the blend config */

    // RestoreAnimViewerBMapGraphics(proc);
}

static void FinishAnimViewer(DebuggerProc * proc)
{
    if (IsBattleDeamonActive())
        gEkrBattleEndFlag = 1;

    // RestoreAnimViewerState(proc);
    proc->tmp[AnimViewerTmp_Exit] = TRUE;
    // Proc_Break(proc);
}

void DrawAnimViewerMenu(DebuggerProc * proc)
{
    struct Text * th = gStatScreen.text;
    int classId = proc->tmp[AnimViewerOption_Class];
    int item = proc->tmp[AnimViewerOption_Item];
    int selected = proc->tmp[AnimViewerOption_Selected];

    TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(0, 0), 22, 6, 0);

    ClearText(&th[0]);
    ClearText(&th[1]);
    ClearText(&th[2]);
    ClearText(&th[3]);

    Text_SetColor(&th[0], selected == AnimViewerOption_Class ? TEXT_COLOR_SYSTEM_GOLD : TEXT_COLOR_SYSTEM_WHITE);
    Text_DrawString(&th[0], "Class");
    PutText(&th[0], gBG0TilemapBuffer + TILEMAP_INDEX(2, 1));

    Text_SetColor(&th[1], TEXT_COLOR_SYSTEM_BLUE);
    Text_DrawString(&th[1], GetStringFromIndexSafe(GetClassData(classId)->nameTextId));
    PutText(&th[1], gBG0TilemapBuffer + TILEMAP_INDEX(9, 1));

    Text_SetColor(&th[2], selected == AnimViewerOption_Item ? TEXT_COLOR_SYSTEM_GOLD : TEXT_COLOR_SYSTEM_WHITE);
    Text_DrawString(&th[2], "Item");
    PutText(&th[2], gBG0TilemapBuffer + TILEMAP_INDEX(2, 3));

    Text_SetColor(&th[3], TEXT_COLOR_SYSTEM_BLUE);
    Text_DrawString(&th[3], GetAnimViewerItemName(item));
    PutText(&th[3], gBG0TilemapBuffer + TILEMAP_INDEX(9, 3));

    BG_EnableSyncByMask(BG0_SYNC_BIT);

    DisplayVertUiHand(8, (selected == AnimViewerOption_Class ? 1 : 3) * 8 + 16);
}

void AnimViewerInit(DebuggerProc * proc)
{
    int i;
    int classId = CLASS_EPHRAIM_LORD;
    MU_EndAll();
    EndAllMenus();
    ResetText();
    ResetTextFont();
    SetTextFontGlyphs(0);
    SetTextFont(0);
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);

    for (i = 0; i < 4; ++i)
        InitText(&gStatScreen.text[i], 12);

    SaveAnimViewerTextChr(proc);

    if (!IsAnimViewerClass(classId))
        classId = GetNextAnimViewerClass(classId, +1);

    proc->tmp[AnimViewerOption_Class] = classId;
    proc->tmp[AnimViewerOption_Item] = GetAnimViewerFallbackItem(classId);
    proc->tmp[AnimViewerOption_Selected] = AnimViewerOption_Class;
    proc->tmp[AnimViewerTmp_Restart] = FALSE;
    proc->tmp[AnimViewerTmp_Exit] = FALSE;
    proc->tmp[AnimViewerTmp_BattleLive] = FALSE;
    proc->tmp[AnimViewerTmp_OldAnimType] = gPlaySt.config.animationType;
    proc->tmp[AnimViewerTmp_Redraw] = TRUE;
    proc->tmp[AnimViewerTmp_UnhideAnims] = FALSE;
    proc->tmp[AnimViewerTmp_Rebuild] = FALSE;
    proc->tmp[AnimViewerTmp_HpBarBusy] = FALSE;
    proc->tmp[AnimViewerTmp_RetryTimer] = AnimViewerRetryFrames;
    proc->tmp[AnimViewerTmp_Restored] = FALSE;

    gPlaySt.config.animationType = PLAY_ANIMCONF_ON;
    SuppressAnimViewerSuspendSave(proc);
    BMapDispSuspend();

    StartAnimViewerControl(proc);
    StartAnimViewerBattle(proc);
}

static void AnimViewerRestore(DebuggerProc * proc)
{
    Proc_EndEach(sProc_AnimViewerControl);
    RestoreAnimViewerState(proc);
}

void AnimViewerLoop(DebuggerProc * proc)
{
    if (proc->tmp[AnimViewerTmp_Exit] && !IsBattleDeamonActive())
    {

        AnimViewerRestore(proc);
        Proc_Break(proc);
    }
}

static void AnimViewerControlLoop(AnimViewerControlProc * proc)
{
    u16 keys = gKeyStatusPtr->repeatedKeys;
    u16 newKeys = gKeyStatusPtr->newKeys;
    bool changed = FALSE;
    DebuggerProc * debugger = proc->debugger;

    if (debugger == NULL)
    {
        Proc_Break(proc);
        return;
    }

    if (newKeys & B_BUTTON)
    {
        FinishAnimViewer(debugger);
        BackPressSFX();
    }

    /**
     * ekrBattleInRoundIdle() is the only thing in the whole banim engine that reads
     * the key status, and all it does with it is "B held -> proc->speedup = true".
     * In an arena battle that means ArenaSetResult(4) and the battle ends as soon as
     * both sides' round flags land - then the full end sequence runs (fade out, exp
     * bar, popup, dragon status) before the deamon dies and we can start over, which
     * is the long dead patch. B held over from the menu we were opened from was
     * enough to kill the very first round.
     *
     * We consume B ourselves as "leave the viewer", so take it away from the engine.
     * This proc is older than gProc_ekrBattle and Proc_Run walks oldest-first, so the
     * mask lands before ekrBattleInRoundIdle reads it in the same frame.
     */
    gKeyStatusPtr->heldKeys &= ~B_BUTTON;

    if (debugger->tmp[AnimViewerTmp_Exit] && !IsBattleDeamonActive())
    {
        FinishAnimViewer(debugger);
        return;
    }

    if (!debugger->tmp[AnimViewerTmp_Exit])
    {
        if (keys & DPAD_UP)
        {
            debugger->tmp[AnimViewerOption_Item] =
                GetNextAnimViewerItem(debugger->tmp[AnimViewerOption_Class], debugger->tmp[AnimViewerOption_Item], -1);
            changed = TRUE;
        }

        if (keys & DPAD_DOWN)
        {
            debugger->tmp[AnimViewerOption_Item] =
                GetNextAnimViewerItem(debugger->tmp[AnimViewerOption_Class], debugger->tmp[AnimViewerOption_Item], +1);
            changed = TRUE;
        }

        if (keys & DPAD_LEFT)
        {
            debugger->tmp[AnimViewerOption_Class] = GetNextAnimViewerClass(debugger->tmp[AnimViewerOption_Class], -1);
            debugger->tmp[AnimViewerOption_Item] = GetAnimViewerItemAfterClassChange(
                debugger->tmp[AnimViewerOption_Class], debugger->tmp[AnimViewerOption_Item]);
            changed = TRUE;
        }

        if (keys & DPAD_RIGHT)
        {
            debugger->tmp[AnimViewerOption_Class] = GetNextAnimViewerClass(debugger->tmp[AnimViewerOption_Class], +1);
            debugger->tmp[AnimViewerOption_Item] = GetAnimViewerItemAfterClassChange(
                debugger->tmp[AnimViewerOption_Class], debugger->tmp[AnimViewerOption_Item]);
            changed = TRUE;
        }
    }

    if (changed)
    {
        debugger->tmp[AnimViewerTmp_Restart] = TRUE;
        debugger->tmp[AnimViewerTmp_Redraw] = TRUE;
        debugger->tmp[AnimViewerTmp_Rebuild] = TRUE;

        ConfirmPressSFX();
    }

    /**
     * UpdateAnimViewerBattle() is expensive: it regenerates both battle units,
     * unwinds the battle, redraws the item boxes and (via ForceAnimViewerArenaRoundSwap
     * -> UpdateBanimFrame) LZ77-decompresses both sides' banim scripts, palettes and
     * OAM data - roughly 20KB per call. It used to run twice on the frame the
     * selection changed, and then again on *every* frame until the round swap took,
     * which never ends while gAnims[0]/gAnims[2] are NULL. Regenerate once per
     * change and only retry the (cheap, early-outing) round swap after that.
     */
    if (debugger->tmp[AnimViewerTmp_Restart] && IsBattleDeamonActive())
    {
        if (debugger->tmp[AnimViewerTmp_Rebuild])
        {
            QueueAnimViewerAnimsHidden(debugger, 4);
            UpdateAnimViewerBattle(debugger);
            debugger->tmp[AnimViewerTmp_Rebuild] = FALSE;
        }

        if (ForceAnimViewerArenaRoundSwap(debugger))
            debugger->tmp[AnimViewerTmp_Restart] = FALSE;
    }

    if (debugger->tmp[AnimViewerTmp_BattleLive] && !IsBattleDeamonActive())
    {
        debugger->tmp[AnimViewerTmp_BattleLive] = FALSE;

        if (debugger->tmp[AnimViewerTmp_Exit])
        {
            FinishAnimViewer(debugger);
            return;
        }

        debugger->tmp[AnimViewerTmp_RetryTimer] = 0;
    }

    /**
     * PrepareBattleGraphicsMaybe() can refuse a combination outright (unreachable
     * banim id, a terrain with no floor effect, a Myrrh/status pairing...), and then
     * BeginAnimsOnBattleAnimations() never runs. That left BattleLive and Restart both
     * clear with nothing to kick it again, so the viewer just sat there until you
     * happened to press a direction. Retry on a timer instead, and back off so a
     * combination that can never start does not rebuild the battle every frame.
     */
    if (!debugger->tmp[AnimViewerTmp_BattleLive] && !debugger->tmp[AnimViewerTmp_Exit])
    {
        if (debugger->tmp[AnimViewerTmp_Restart] || debugger->tmp[AnimViewerTmp_RetryTimer] <= 0)
        {
            debugger->tmp[AnimViewerTmp_RetryTimer] = AnimViewerRetryFrames;
            StartAnimViewerBattle(debugger);
        }
        else
            debugger->tmp[AnimViewerTmp_RetryTimer]--;
    }

    if (debugger->tmp[AnimViewerTmp_Redraw])
    {
        // RestoreAnimViewerTextChr(debugger);
        debugger->tmp[AnimViewerTmp_Redraw] = FALSE;
        // DrawAnimViewerMenu(debugger);
        // RestoreAnimViewerTextChr(debugger);
    }

    if (debugger->tmp[AnimViewerTmp_UnhideAnims] > 0)
    {
        debugger->tmp[AnimViewerTmp_UnhideAnims]--;

        if (debugger->tmp[AnimViewerTmp_UnhideAnims] == 0)
            SetAnimViewerAnimsHidden(FALSE);
    }

    /**
     * Let the gauge actually drain. While the hp-bar effect (or a spell anim) is
     * running, the displayed HP and the hp LUT are left alone; the frame the drain
     * finishes, both are refilled to full so the next round starts from 61 again.
     * Pinning them every frame - as this used to - held the bar at full and, because
     * gBanimSomeHp is the gauge's "last drawn" cache, suppressed its redraw as well.
     */
    if (!CheckEkrHitDone())
        debugger->tmp[AnimViewerTmp_HpBarBusy] = TRUE;
    else if (debugger->tmp[AnimViewerTmp_HpBarBusy])
    {
        debugger->tmp[AnimViewerTmp_HpBarBusy] = FALSE;
        ResetAnimViewerBattleAnimHp();
        ResetAnimViewerGaugeHp();
    }

    SuppressAnimViewerBattleProgress();
    ResetAnimViewerUnitHp();
    RestoreAnimViewerBattleWeapons(debugger->tmp[AnimViewerOption_Item]);
}

void DrawGfxFromIDs(int type, int id, struct Unit * unit, DebuggerProc * proc)
{
    switch (type)
    {
        case 0:
        {
            ClearMainMenuGfx(proc);
            RedrawGfxViewerMenu(proc);
            GfxViewerInitMenuGfx(proc);
            DebuggerStartFace(id, 1); // was side 0 (left); menu box now owns the left side
            break;
        }
        case 1:
        {
            ClearMainMenuGfx(proc);
            GfxViewerInitMenuGfx(proc);
            DebuggerUpdateMMS(id, unit);
            DebuggerStartSMS();
            break;
        }
        case 2:
        {
            DebuggerStartBG(id);
            break;
        }
        case 3:
        {
            DebuggerStartCG(id);
            break;
        }
        case 4:
        {
            proc->tmp[GfxViewerOption_Weapon] = GetDebuggerDefaultPreviewWeapon(id);
            ClearMainMenuGfx(proc);
            GfxViewerInitMenuGfx(proc);
            MU_EndAll();
            StartDebuggerBanimPreview(id, unit, proc->tmp[GfxViewerOption_Weapon]);
            break;
        }
    }
}

static void RefreshDebuggerBanimPreviewForGfxViewer(DebuggerProc * proc, struct Unit * unit)
{
    if ((proc->id == GfxViewerOption_ClassAnim || proc->id == GfxViewerOption_Weapon) &&
        HasDebuggerBanimForClass(proc->tmp[GfxViewerOption_ClassAnim]))
    {
        StartDebuggerBanimPreview(proc->tmp[GfxViewerOption_ClassAnim], unit, proc->tmp[GfxViewerOption_Weapon]);
    }
}

void GfxViewerLoop(DebuggerProc * proc)
{
    struct Unit * unit = proc->unit;
    u16 keys = gKeyStatusPtr->repeatedKeys;
    u16 newKeys = gKeyStatusPtr->newKeys;
    bool menuHidden = proc->tmp[GfxViewerTmp_MenuHidden] != 0;

    if ((keys & START_BUTTON) || (keys & A_BUTTON) || keys & B_BUTTON)
    { // press B to not save Supports
        proc->tmp[GfxViewerTmp_MenuHidden] = FALSE;
        EndDebuggerBanimPreview();
        BMapDispResume();
        RefreshBMapGraphics();
        Proc_Goto(proc, RestartLabel);
        BackPressSFX();
        return;
    };

    if (newKeys & SELECT_BUTTON)
    {
        proc->tmp[GfxViewerTmp_MenuHidden] = !menuHidden;
        menuHidden = proc->tmp[GfxViewerTmp_MenuHidden] != 0;

        if (menuHidden)
            ClearGfxViewerMenuGfx();
        else
        {
            GfxViewerInitMenuGfx(proc);
            RedrawGfxViewerMenu(proc);
        }
    }

    if (keys & DPAD_RIGHT)
    {
        if (proc->id == GfxViewerOption_Weapon)
        {
            if (HasDebuggerBanimForClass(proc->tmp[GfxViewerOption_ClassAnim]))
            {
                proc->tmp[GfxViewerOption_Weapon] = GetNextDebuggerPreviewWeapon(proc->tmp[GfxViewerOption_Weapon], +1);
                StartDebuggerBanimPreview(
                    proc->tmp[GfxViewerOption_ClassAnim], unit, proc->tmp[GfxViewerOption_Weapon]);
            }
        }
        else
        {
            proc->tmp[proc->id]++;
            DrawGfxFromIDs(proc->id, proc->tmp[proc->id], unit, proc);
        }

        if (!menuHidden)
            RedrawGfxViewerMenu(proc);
    }
    if (keys & DPAD_LEFT)
    {
        if (proc->id == GfxViewerOption_Weapon)
        {
            if (HasDebuggerBanimForClass(proc->tmp[GfxViewerOption_ClassAnim]))
            {
                proc->tmp[GfxViewerOption_Weapon] = GetNextDebuggerPreviewWeapon(proc->tmp[GfxViewerOption_Weapon], -1);
                StartDebuggerBanimPreview(
                    proc->tmp[GfxViewerOption_ClassAnim], unit, proc->tmp[GfxViewerOption_Weapon]);
            }
        }
        else
        {
            proc->tmp[proc->id]--;
            if (proc->tmp[proc->id] < 0)
            {
                proc->tmp[proc->id] = 0; // I have no idea what the final valid mug/sms/mms/bg/cg will be lol
            }
            DrawGfxFromIDs(proc->id, proc->tmp[proc->id], unit, proc);
        }

        if (!menuHidden)
            RedrawGfxViewerMenu(proc);
    }
    RedrawGfxFromIDs(proc->tmp[1], proc); // redraw SMS each frame

    if (keys & DPAD_UP)
    {
        proc->id--;
        if (proc->id < 0)
        {
            proc->id = GfxViewerOptions - 1;
        }
        if (proc->id != GfxViewerOption_ClassAnim && proc->id != GfxViewerOption_Weapon)
        {
            EndDebuggerBanimPreview(); // battle anim only runs while browsing Class Anim/Weapon
            BMapDispResume();
        }
        RefreshDebuggerBanimPreviewForGfxViewer(proc, unit);
        RedrawGfxViewerMenu(proc);
    }
    if (keys & DPAD_DOWN)
    {
        proc->id++;
        if (proc->id >= GfxViewerOptions)
        {
            proc->id = 0;
        }
        if (proc->id != GfxViewerOption_ClassAnim && proc->id != GfxViewerOption_Weapon)
        {
            EndDebuggerBanimPreview(); // battle anim only runs while browsing Class Anim/Weapon
            BMapDispResume();
        }

        RefreshDebuggerBanimPreviewForGfxViewer(proc, unit);
        RedrawGfxViewerMenu(proc);
    }

    if (!menuHidden)
    {
        DisplayUiHand(
            CursorLocationTable[0].x - ((SupportWidth - 1) * 8) + (GfxViewerMenuXShift * 8),
            (Y_HAND + (proc->id * 2)) * 8);
    }
}
