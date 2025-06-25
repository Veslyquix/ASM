
// #define USE_CCODE
#define brk asm("mov r11, r11");
#include "../C_code.h"

#ifdef FE6
#define hidden 2
#define greyed 1
#define usable 0
#else
#define hidden 3
#define greyed 2
#define usable 1
#endif

int Mod(int a, int b);
extern const char BlankString[];
char * GetStringFromIndexSafe(int index)
{
    if ((index > 0x4000) || (index <= 0))
    {
        return (void *)BlankString;
    }
    return GetStringFromIndex(index);
}
void PutUiWindowFrame(int x, int y, int width, int height, int window_kind);
void DrawUiFrame(u16 * tilemap, int x, int y, int width, int height, int tilebase, int style)
{
    PutUiWindowFrame(x, y, width, height, style);
}

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
    PROC_HEADER;
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
    PROC_HEADER;
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
void RedrawUnitStatsMenu(DebuggerProc * proc);
void ClearSomeGfx(DebuggerProc * proc);
u8 CanActiveUnitPromote(void);
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

    PROC_LABEL(LevelupLabel), // Levelup
    // ProcScr_EndManim 664E4C @
    // https://github.com/FireEmblemUniverse/fireemblem6j/blob/c0065f139f1cbe2aa974046448898427ecc5a021/src/manim.c#L159
    PROC_SLEEP(5),
    PROC_WHILE(BattleEventEngineExists),  // IsEventRunning
    PROC_CALL(DeleteBattleAnimInfoThing), // EndManimInfoWindow
    PROC_SLEEP(0x1),
    PROC_CALL(MapAnimProc_DisplayExpBar), // Manim_ExpBar
    PROC_YIELD,
    PROC_CALL(MapAnim_MoveCameraOntoSubject), // Manim_WatchActorA
    PROC_SLEEP(0x2),
    PROC_CALL(UpdateActorFromBattle),
    PROC_CALL(MapAnim_Cleanup), // Manim_Finish
    PROC_GOTO(RestartLabel),

    PROC_LABEL(PickupUnitLabel), // Pickup
    // PROC_CALL(StartPlayerPhaseTerrainWindow),
    PROC_CALL(ResetUnitSpriteHover),
    PROC_REPEAT(PickupUnitIdle),
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

    PROC_LABEL(StateLabel), // Unit state
    PROC_CALL(StateInit),
    PROC_REPEAT(StateIdle),
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
    for (int i = 0; i < tmpSize; ++i)
    {
        dst->tmp[i] = src->tmp[i];
    }
    dst->unit = src->unit;
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

u16 * BG_GetMapBuffer(int bg)
{
    if (bg > 3)
    {
        bg = 0;
    }
    return BgTilemapBuffers[bg];
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

#define NumberOfOptions 9
#define NumberOfItems 5
#define START_X 19
#define Y_HAND 2
#define NUMBER_X 17

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
static const int DigitDecimalTable[] = { 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000 };

static const int DigitHexTable[] = { 0x1, 0x10, 0x100, 0x1000, 0x10000, 0x100000, 0x1000000, 0x10000000, 0x7fffffff };

static const int * pDigitTable[2] = { DigitDecimalTable, DigitHexTable };

#ifdef FE6
#define NumberOfState 16
#else
#define NumberOfState 32
#endif
#define StateWidth 7
#define StatWidth 4
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
#ifndef FE6
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
#endif
};

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

void BackPressSFX(void)
{
#ifdef FE8
    int id = 0x6B;
    m4aSongNumStart(id);
#endif
#ifdef FE7

#endif
#ifdef FE6

#endif
}
void ConfirmPressSFX(void)
{
#ifdef FE8
    int id = 0x6A;
    PlaySoundEffect(id);
#endif
#ifdef FE7

#endif
#ifdef FE6

#endif
}

void EditStatsIdle(DebuggerProc * proc)
{

    // DisplayVertUiHand(CursorLocationTable[proc->digit].x,
    // CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if (keys & B_BUTTON)
    { // press B to not save stats
        Proc_Goto(proc, RestartLabel);
        ConfirmPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update stats and continue
        SaveStats(proc);
        Proc_Goto(proc, RestartLabel);
        ConfirmPressSFX();
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

#ifdef FE6
extern const char states[32][32];

#else

static const char states[32][16] = {
    "Acting",  "Acted",        "Dead",       "Undeployed",  "Rescuing",  "Rescued",     "Cantoed",    "Under roof",
    "Spotted", "Concealed",    "AI decided", "In ballista", "Drop item", "Afa's drops", "Solo anim1", "Solo anim2",
    "Escaped", "Arena 1",      "Arena 2",    "Super arena", "Unk 25",    "Benched",     "Scene unit", "Portrait+1",
    "Shake",   "Can't deploy", "Departed",   "4th palette", "Unk 35",    "Unk 36",      "Capture",    "Unk 38",
};
#endif

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
        ConfirmPressSFX();
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
        id %= NumberOfState;
        proc->id = id;
        RedrawStateMenu(proc);
    }
}
extern const char MaxHPText[];
extern const char HPText[];
extern const char StrText[];
extern const char SklText[];
extern const char SpdText[];
extern const char DefText[];
extern const char ResText[];
extern const char LckText[];
extern const char MagText[];
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

    Text_DrawString(&th[c], MaxHPText);
    c++;
    Text_DrawString(&th[c], HPText);
    c++;
    Text_DrawString(&th[c], StrText);
    c++;
    Text_DrawString(&th[c], SklText);
    c++;
    Text_DrawString(&th[c], SpdText);
    c++;
    Text_DrawString(&th[c], DefText);
    c++;
    Text_DrawString(&th[c], ResText);
    c++;
    Text_DrawString(&th[c], LckText);
    c++;
#ifdef FE8
    Text_DrawString(&th[c], GetStringFromIndexSafe(0x4FF));
    c++;
#endif

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
    for (int i = 0; i < NumberOfItems; ++i)
    {
        ClearText(&th[i]);
        if (proc->tmp[i])
        {
            Text_DrawString(&th[i], GetStringFromIndexSafe(itemData[i]->nameTextId));
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
        icon = GetItemIconId(proc->tmp[i]);
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
        ConfirmPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update stats and continue
        SaveItems(proc);
        Proc_Goto(proc, RestartLabel);
        ConfirmPressSFX();
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
    if (unit->statusIndex)
    {
        unit->statusDuration = 5;
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
extern const char LevelText[];
extern const char ExpText[];
extern const char BonusConText[];
extern const char BonusMovText[];
extern const char StatusText[];
extern const char AllegianceText[];
extern const char PlayerText[];
extern const char NPCText[];
extern const char EnemyText[];
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

#ifdef FE6

    Text_DrawString(&th[i], LevelText);
    i++;
    Text_DrawString(&th[i], ExpText);
    i++;
    Text_DrawString(&th[i], BonusConText);
    i++;
    Text_DrawString(&th[i], BonusMovText);
    i++;
#else
    Text_DrawString(&th[i], "Level");
    i++;
    Text_DrawString(&th[i], "Exp");
    i++;
    Text_DrawString(&th[i], "Bonus Con");
    i++;
    Text_DrawString(&th[i], "Bonus Mov");
    i++;
#endif

#ifndef FE8
#ifdef FE6
    Text_DrawString(&th[i], StatusText);
#else
    Text_DrawString(&th[i], "Status");
#endif
    i++;
#endif

#ifdef FE8
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
#endif

#ifdef FE6
    Text_DrawString(&th[i], AllegianceText);
    // i++;

    int x = NUMBER_X - (MiscNameWidth)-1;

    if (proc->tmp[7] == 0)
    {

        Text_DrawString(&th[8], PlayerText);
    }
    else if (proc->tmp[7] == 1)
    {
        Text_DrawString(&th[8], NPCText);
    }
    else if (proc->tmp[7] == 2)
    {
        Text_DrawString(&th[8], EnemyText);
    }
#else
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

#endif
    PutText(&th[8], gBG0TilemapBuffer + TILEMAP_INDEX(START_X - 3, Y_HAND + (i * 2)));

    for (i = 0; i < NumberOfMisc; ++i)
    {
        PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (i * 2)));
    }

    for (i = 0; i < NumberOfMisc; ++i)
    {
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
    int i = 1;
    for (; i <= 256; i++)
    {
        table = GetItemData(i);
        if (table->number != i)
        {
            i--;
            break;
        }
    }
    table = GetItemData(i);
    c = table->number;
    if (c > 255)
    {
        c = 255;
    }
    if (c <= 1)
    {
        c = 0x7F;
    }
    return c;
}

static int GetMaxClasses(void)
{
    const struct ClassData * table = GetClassData(1);
    int c = 256;
    int i = 1;
    for (; i <= c; i++)
    {
        table = GetClassData(i);
        if (table->number != i)
        {
            i--;
            break;
        }
    }
    table = GetClassData(i);
    c = table->number;
    if (c > 255)
    {
        c = 255;
    }
    if (c <= 1)
    {
        c = 0x49;
    }
    return c;
}

static int GetMaxChars(void)
{
    const struct CharacterData * table = GetCharacterData(1);
    int c = 256;
    int i = 1;
    for (; i <= c; i++)
    {
        table = GetCharacterData(i);
        if (table->number != i)
        {
            i--;
            break;
        }
    }
    table = GetCharacterData(i);
    c = table->number;
    if (c > 255)
    {
        c = 255;
    }
    if (c <= 1)
    {
        c = 0x49;
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
            result = GetMaxChars();
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
#ifdef FE6
            result = 4;
#else
            result = 10;
#endif
            break;
        } // status
        default:
        case 7:
        {
            result = 2;
            break;
        }
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
        ConfirmPressSFX();
    };
    if ((keys & START_BUTTON) || (keys & A_BUTTON))
    { // press A or Start to update stats and continue
        SaveMisc(proc);
        Proc_Goto(proc, RestartLabel);
        ConfirmPressSFX();
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
        BackPressSFX();
        Proc_Goto(proc, RestartLabel);
        return;
    }

    if (keys & B_BUTTON)
    {
        gActionData.xMove = gActiveUnitMoveOrigin.x;
        gActionData.yMove = gActiveUnitMoveOrigin.y;
        PlayerPhase_ApplyUnitMovementWithoutMenu(proc);
        BackPressSFX();
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
u8 StartPromotionNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    if (CanActiveUnitPromote() != usable)
    {
        return MENU_ACT_SKIPCURSOR | MENU_ACT_SND6B;
    }
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    proc->actionID = ActionID_Promo;
    Proc_Goto(proc, UnitActionLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 StartArenaNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    proc->actionID = ActionID_Arena;
    Proc_Goto(proc, UnitActionLabel); // 0xb7
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 LevelupNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    // SetupUnitFunc();
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    proc->actionID = ActionID_Levelup;
    Proc_Goto(proc, UnitActionLabel); // 0xb7
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditStatsNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    Proc_Goto(proc, EditStatsLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditItemsNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    Proc_Goto(proc, EditItemsLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditMiscNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    Proc_Goto(proc, EditMiscLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditStateNow(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    Proc_Goto(proc, StateLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

int DebuggerMenuItemDraw(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    if (menuItem->availability == greyed)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);

    Text_DrawString(&menuItem->text, GetDebuggerMenuText(procIdler, menuItem->itemNumber));
    PutText(&menuItem->text, BG_GetMapBuffer(0) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
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
    InitBattleUnit(&gBattleActor, unit);
    ClearUnit(&gBattleTarget.unit); // so a previous unit isn't affected
    gBattleTarget.unit.index = 0;   // (fixed bug of promote -> levelup with another char)

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
    Decompress(gUnknown_08A02274, (void *)(VRAM + 0x10000 + 0x240 * 0x20)); //
}

void PageMenuItemDrawSprites(struct MenuProc * menu)
{
    DebuggerProc * proc;
    proc = Proc_Find(DebuggerProcCmd);
    int chr = 0x289;
    int chr2 = 0x289;
#ifndef FE8
    chr = 0x2A4;
    chr2 = 0x245;
#endif
    // fe7: / is 0x245, numbers 0x2A5-0x2A9
    int x = (menu->menuItems[menu->itemCount - 1]->xTile * 8) + 6 + (8 * 3);
    int y = (menu->menuItems[menu->itemCount - 1]->yTile * 8) + 4;

    PutSprite(0, x, y, gObject_8x8, TILEREF(chr, 0) + OAM2_LAYER(0) + proc->page + 1);
    x += 8;
    PutSprite(0, x, y, gObject_8x8, TILEREF(chr2, 0) + OAM2_LAYER(0));
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
    if (menuItem->availability == greyed)
    {
        Text_SetColor(&menuItem->text, 1);
    }
    DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    Text_DrawString(&menuItem->text, GetDebuggerMenuText(procIdler, menuItem->itemNumber));
    PutText(&menuItem->text, BG_GetMapBuffer(0) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));
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

u8 MenuAutoHelpBoxSelect(struct MenuProc * menu)
{
    // Proc_GotoScript(menu, sProc_MenuAutoHelpBox);
    return 0;
}
u8 DebuggerHelpBox(struct MenuProc * menu, struct MenuItemProc * item)
{
    // DebuggerProc * procIdler = Proc_Find(DebuggerProcCmdIdler);
    // StartHelpBoxString(item->xTile * 8, item->yTile * 8, GetDebuggerMenuDesc(procIdler, item->itemNumber));
    return 0;
}

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

/*
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
*/
void PutNumberHex(u16 * tm, int color, int number)
{
    PutNumber(tm, color, number);
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
    // MapAnimState same in fe6/7/8
    gActiveUnit->exp = 99;
    InitBattleUnit(&gBattleActor, gActiveUnit);

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

        default:
    }
    proc->actionID = 0;
    return 0;
}

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
    if (gActiveUnit->curHP != 0)
        gActiveUnit->state = gActiveUnit->state & ~US_HIDDEN;

    SetCursorMapPositionIfValid(gActiveUnit->xPos, gActiveUnit->yPos);

    gPlaySt.xCursor = gBmSt.playerCursor.x;
    gPlaySt.yCursor = gBmSt.playerCursor.y;

    MU_EndAll();

    return;
}

void CallPlayerPhase_FinishAction(DebuggerProc * proc)
{
    PlayerPhase_FinishActionNoCanto(proc);
    ProcPtr playerPhaseProc = Proc_Find(gProcScr_PlayerPhase);
    Proc_Goto(playerPhaseProc, 0);
}

u8 CanActiveUnitPromote(void)
{
    if (UNIT_FACTION(gActiveUnit) != gPlaySt.faction)
    {
        return greyed;
    }
    // int classNumber = gActiveUnit->pClassData->number;
    int promoted = UNIT_CATTRIBUTES(gActiveUnit) & CA_PROMOTED;
    if (promoted)
    {
        return greyed;
    }
    int promotionClass = gActiveUnit->pClassData->promotion;
    if (!promotionClass)
    {
        return greyed;
    }

    return usable;
}
u8 CanActiveUnitPromoteMenu(const struct MenuItemDef * def, int number)
{
    return CanActiveUnitPromote();
}

u8 CallArenaIsUnitAllowed(const struct MenuItemDef * def, int number)
{
    if (ArenaIsUnitAllowed(gActiveUnit))
    {
        return usable;
    }
    return greyed;
}
