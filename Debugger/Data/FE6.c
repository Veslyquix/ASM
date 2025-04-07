#define FE6

#include "../C_Code.h" // headers

// #include "../C_code.c"

#define tmpSize 15

#define InitProcLabel 0
#define RestartLabel 1
#define PostActionLabel                                                                                                \
    2 // ClassChgMenuSelOnPressB 80CDC15 has Proc_Goto(proc, 2) in it, so we make
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
#define LoopLabel 20
#define EndLabel 99

#define ActionID_Promo 1
#define ActionID_Arena 2
#define ActionID_Levelup 3

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
    u8 page;
    s8 mainID; // by the main debugger menu
    u16 lastFlag;
    int gold;
    struct Unit * unit;
    s16 tmp[tmpSize];
} DebuggerProc;

typedef struct
{
    /* 00 */ PROC_HEADER;
    int id;
} CheatCodeKeyListenerProc;

const struct ProcCmd DebuggerProcCmd[];
const struct ProcCmd DebuggerProcCmdIdler[];

extern int NumberOfPages;
void RestartDebuggerMenu(DebuggerProc * proc);
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
void CallPlayerPhase_FinishAction(DebuggerProc * proc);
int PlayerPhase_PrepareActionBasic(DebuggerProc * proc);
void PlayerPhase_ApplyUnitMovementWithoutMenu(DebuggerProc * proc);
void EditMapIdle(DebuggerProc * proc);
void StartPlayerPhaseTerrainWindow();
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
void ClearSomeGfx(DebuggerProc * proc);
const struct MenuDef gDebuggerMenuDef;
const struct MenuDef gDebuggerMenuDefPage2;
const struct MenuDef gDebuggerMenuDefPage3;

void LoopDebuggerProc(DebuggerProc * proc);
int ClearActiveUnitStuff(DebuggerProc * proc);
void CopyProcVariables(DebuggerProc * dst, DebuggerProc * src);
void SaveProcVarsToIdler(DebuggerProc * proc);
void PickupUnitIdle(DebuggerProc * proc);
// extern struct KeyStatusBuffer gKeyStatusBuffer; // 2024C78

extern const struct MenuItemDef gDebuggerMenuItems[];
extern const struct MenuItemDef gDebuggerMenuItemsPage2[];
extern const struct MenuItemDef gDebuggerMenuItemsPage3[];
extern char * gDebuggerMenuText[];
extern const struct MenuItemDef * ggDebuggerMenuItems[];

const struct ProcCmd DebuggerProcCmd[] = {
    PROC_NAME("DebuggerProcName"),
    PROC_YIELD,
    PROC_LABEL(InitProcLabel),
    // PROC_CALL(InitProc),
    PROC_LABEL(RestartLabel), // Menu

    PROC_CALL(EndPlayerPhaseSideWindows),
    PROC_SLEEP(1),
    PROC_WHILE(DoesBMXFADEExist),
    PROC_CALL(SetAllUnitNotBackSprite),
    PROC_CALL(RefreshUnitSprites),
    PROC_CALL_2(ClearActiveUnitStuff), // in case we didn't refresh units before restarting
    PROC_CALL(RestartDebuggerMenu),

    PROC_LABEL(LoopLabel), // Loop indefinitely
    PROC_REPEAT(LoopDebuggerProc),

    PROC_LABEL(PickupUnitLabel), // Pickup
    // PROC_CALL(StartPlayerPhaseTerrainWindow),
    PROC_CALL(ResetUnitSpriteHover),
    PROC_REPEAT(PickupUnitIdle),
    PROC_GOTO(EndLabel),

    PROC_LABEL(EndLabel),
    PROC_CALL_2(ClearActiveUnitStuff),
    PROC_CALL(SaveProcVarsToIdler),
    PROC_END,
};

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
void InitProc(DebuggerProc * proc)
{
    proc->mainID = 0;
    proc->page = 0;
    proc->editing = false;
    proc->actionID = 0;
    proc->godMode = 0;
    proc->autoplay = 0;
    proc->lastFlag = 1;
    proc->tileID = 1;
    proc->id = 0;
    proc->lastTileHovered = 0;
    for (int i = 0; i < tmpSize; ++i)
    {
        proc->tmp[i] = 0;
    }
}

void CopyProcVariables(DebuggerProc * dst, DebuggerProc * src)
{
    // dst->tileID = src->tileID;
    // dst->mainID = src->mainID;
    // dst->lastTileHovered = src->lastTileHovered;
    // dst->editing = src->editing;
    // dst->actionID = src->actionID;
    // dst->id = src->id;
    // dst->digit = src->digit;
    // dst->godMode = src->godMode;
    // dst->page = src->page;
    // dst->lastFlag = src->lastFlag;
    // dst->gold = src->gold;
    // dst->autoplay = src->autoplay;
    // for (int i = 0; i < tmpSize; ++i)
    // {
    // dst->tmp[i] = src->tmp[i];
    // }
    // dst->unit = src->unit;
}

void LoopDebuggerProc(DebuggerProc * proc)
{
    return;
}

u16 * const BgTilemapBuffers[] = {
    gBG0TilemapBuffer,
    gBG1TilemapBuffer,
    gBG2TilemapBuffer,
    gBG3TilemapBuffer,
};

u16 * BG_GetMapBuffer2(int bg)
{
    return BgTilemapBuffers[bg];
}

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

void FixAndHandlePlayerCursorMovement(void)
{
    FixCursorOverflow();
    HandlePlayerCursorMovement();
}

void PlayerPhase_ApplyUnitMovementWithoutMenu(DebuggerProc * proc)
{
    gActiveUnit->xPos = gActionData.xMove;
    gActiveUnit->yPos = gActionData.yMove;
    UnitFinalizeMovement(gActiveUnit);
    ResetTextFont();
}

void PickupUnitIdle(DebuggerProc * proc)
{
    FixAndHandlePlayerCursorMovement();
    u16 keys = gKeyStatusPtr->newKeys;
    if (keys & A_BUTTON)
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

    if (keys & B_BUTTON)
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

u8 PickupUnitNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    Proc_Goto(proc, PickupUnitLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

int DebuggerMenuItemDraw(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);

    Text_DrawString(&menuItem->text, GetDebuggerMenuText(procIdler, menuItem->itemNumber));
    PutText(&menuItem->text, BG_GetMapBuffer2(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
    return 0;
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

void UnitBeginActionInit(struct Unit * unit)
{
    gActiveUnit = unit;
    gActiveUnitId = unit->index;

    gActiveUnitMoveOrigin.x = unit->xPos;
    gActiveUnitMoveOrigin.y = unit->yPos;
    gActionData.xMove = unit->xPos;
    gActionData.yMove = unit->yPos;

    gActionData.subjectIndex = unit->index;
    gActionData.itemSlotIndex = -1;
    gActionData.unitActionType = 0;
    gActionData.moveCount = 0;

    gBmSt.taken_action = 0;
    gBmSt.unk3F = 0xFF;

    sub_802C334(); // zeroes out a few bits of unknown ram

    // gActiveUnit->state |= US_HIDDEN;
    // gBmMapUnit[unit->yPos][unit->xPos] = 0;
}

extern int DebuggerTurnedOff_Flag;
int ShouldStartDebugger(void)
{
    if (CheckFlag(DebuggerTurnedOff_Flag))
    {
        return false;
    }
    return true;
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
    if (!unit)
    {
        return;
    }
    gActiveUnitMoveOrigin.x = unit->xPos;
    gActiveUnitMoveOrigin.y = unit->yPos;
    UnitBeginActionInit(unit);
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
    PutMapCursor(
        gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y,
        IsUnitSpriteHoverEnabledAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y) ? 3 : 0);

    struct MenuProc * menu = NULL;
    switch (proc->page)
    {
        case 0:
        {
            menu = StartOrphanMenuAdjusted(&gDebuggerMenuDef, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x15);
            break;
        }
        case 1:
        {
            menu = StartOrphanMenuAdjusted(&gDebuggerMenuDefPage2, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x15);
            break;
        }
        case 2:
        {
            menu = StartOrphanMenuAdjusted(&gDebuggerMenuDefPage3, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x15);
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
    // Decompress(gUnknown_08A02274, (void *)(VRAM + 0x10000 + 0x240 * 0x20));
}

void PageMenuItemDrawSprites(struct MenuProc * menu)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
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

u8 PageIncrementNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
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

int PageMenuItemDraw(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    Text_DrawString(&menuItem->text, GetDebuggerMenuText(procIdler, menuItem->itemNumber));
    PutText(&menuItem->text, BG_GetMapBuffer2(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
    // PageMenuItemDrawSprites(menuItem);
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

const u16 KonamiCodeSequence[] = { DPAD_UP,   DPAD_UP,    DPAD_DOWN, DPAD_DOWN, DPAD_LEFT, DPAD_RIGHT,
                                   DPAD_LEFT, DPAD_RIGHT, B_BUTTON,  A_BUTTON,  0,         0 };
extern int DebuggerTurnedOff_Flag;
extern int KeyComboToDisableFlag;
extern int KonamiCodeEnabled;

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

/*
extern const struct ProcCmd gProcScr_TerrainDisplay[];
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
*/
u8 MenuCancelSelectResumePlayerPhase(struct MenuProc * menu, struct MenuItemProc * item)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    Proc_Goto(proc, EndLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_CLEAR | MENU_ACT_END | MENU_ACT_SND6B;
}
u8 DebuggerHelpBox(struct MenuProc * menu, struct MenuItemProc * item);
const struct MenuDef gDebuggerMenuDef = { { 1, 0, 9, 0 }, // { s8 x, y, w, h; };
                                          0,
                                          gDebuggerMenuItems,
                                          0,
                                          0,
                                          0,
                                          MenuCancelSelectResumePlayerPhase,
                                          MenuAutoHelpBoxSelect,
                                          DebuggerHelpBox };

const struct MenuDef gDebuggerMenuDefPage2 = { { 1, 0, 9, 0 }, // { s8 x, y, w, h; };
                                               0,
                                               gDebuggerMenuItemsPage2,
                                               0,
                                               0,
                                               0,
                                               MenuCancelSelectResumePlayerPhase,
                                               MenuAutoHelpBoxSelect,
                                               DebuggerHelpBox };
const struct MenuDef gDebuggerMenuDefPage3 = { { 1, 0, 9, 0 }, // { s8 x, y, w, h; };
                                               0,
                                               gDebuggerMenuItemsPage3,
                                               0,
                                               0,
                                               0,
                                               MenuCancelSelectResumePlayerPhase,
                                               MenuAutoHelpBoxSelect,
                                               DebuggerHelpBox };
