#include "C_Code.h"

#define brk asm("mov r11, r11");

struct PlayerInterfaceProc
{
    /* 00 */ PROC_HEADER;

    /* 2C */ struct Text texts[2];

    /* 3C */ s8 xBurst;
    /* 3D */ s8 yBurst;
    /* 3E */ s8 wBurst;
    /* 3F */ s8 hBurst;

    /* 40 */ u16 * statusTm;
    /* 44 */ s16 unitClock;
    /* 46 */ s16 xHp;
    /* 48 */ s16 yHp;
    /* 4A */ u8 burstUnitIdPrev;
    /* 4B */ u8 burstUnitId;
    /* 4C */ u8 xCursorPrev;
    /* 4D */ u8 yCursorPrev;
    /* 4E */ u8 xCursor;
    /* 4F */ u8 yCursor;
    /* 50 */ s8 cursorQuadrant;
    /* 51 */ u8 hpCurHi;
    /* 52 */ u8 hpCurLo;
    /* 53 */ u8 hpMaxHi;
    /* 54 */ u8 hpMaxLo;
    /* 55 */ s8 hideContents;
    /* 56 */ s8 isRetracting;
    /* 57 */ s8 windowQuadrant;
    /* 58 */ int showHideClock;
};

struct PlayerInterfaceConfigEntry
{
    /* 00 */ s8 xTerrain, yTerrain;
    /* 02 */ s8 xMinimug, yMinimug;
    /* 04 */ s8 xGoal, yGoal;
    STRUCT_PAD(0x06, 0x08);
};
extern struct PlayerInterfaceConfigEntry sPlayerInterfaceConfigLut[4];
extern s8 sGoalSlideInWidthLut[5];
extern s8 sGoalSlideOutWidthLut[3];
extern int GetCursorQuadrant();
extern int GetWindowQuadrant(int, int);
extern void sub_808D514(int quadrant, int param_2, int param_3);

void BGMWindow_Init(struct PlayerInterfaceProc * proc);
void BGMWindow_Loop_OnSideChange(struct PlayerInterfaceProc * proc);
void BGMWindow_Loop_SlideIn(struct PlayerInterfaceProc * proc);
void BGMWindow_Loop_Display(struct PlayerInterfaceProc * proc);
void BGMWindow_Loop_SlideOut(struct PlayerInterfaceProc * proc);
void BGMWindowDraw(struct PlayerInterfaceProc * proc);

struct ProcCmd const gProcScr_BGMWindow[] = {
    PROC_NAME("BGMWindow"),
    PROC_15, // ?
    PROC_YIELD,

    PROC_CALL(BGMWindow_Init),

    PROC_LABEL(0),

    PROC_WHILE_EXISTS(gProcScr_CamMove), // ProcScr_CamMove

    PROC_REPEAT(BGMWindow_Loop_OnSideChange),
    PROC_REPEAT(BGMWindow_Loop_SlideIn),
    PROC_REPEAT(BGMWindow_Loop_Display),
    PROC_REPEAT(BGMWindow_Loop_SlideOut),

    PROC_GOTO(0),

    PROC_END,
};

//! FE8U = 0x0808CB34
void TerrainDisplay_Init(struct PlayerInterfaceProc * proc) // start
{
    proc->windowQuadrant = -1;
    proc->isRetracting = false;
    proc->showHideClock = 0;
    proc->cursorQuadrant = 1;

    InitTextDb(proc->texts, 5);
    Proc_EndEach(gProcScr_BGMWindow);
    Proc_Start(gProcScr_BGMWindow, PROC_TREE_3);

    return;
}

// BGMWindow
extern int GetCurrentBgmSong(void);
extern int GetCurrentMapMusicIndex(void);

const char * GetPlayingBGM(void)
{
    int id = GetCurrentBgmSong() - 1;
    const char * str = GetStringFromIndex(gSoundRoomTable[id].nameTextId);
    return str;
}

const char * GetNextNotificationStr(struct PlayerInterfaceProc * proc)
{
    const char * str = "";

    str = GetPlayingBGM();
    return str;
}

extern struct Font * gActiveFont;
void BGMWindow_Init(struct PlayerInterfaceProc * proc)
{

    proc->burstUnitId = 0;
    proc->hideContents = false;
    proc->showHideClock = 0;
    proc->wBurst = 0;
    proc->hBurst = 0;
    proc->isRetracting = false;

    const char * str = GetNextNotificationStr(proc);
    int len = GetStringTextLen(str);
    int tileWidth = (len + 15) >> 3;
    // brk;
    // InitTextDb(proc->texts, pTextWidth[0]);
    // InitTextDb(proc->texts, tileWidth);
    // int chr_counter = gActiveFont->chr_counter;
    // brk;
    // gActiveFont->chr_counter = (((uintptr_t)gActiveFont->vramDest & 0x1FFFF) >> 5) + 0x100;
    InitText(proc->texts, tileWidth);
    // gActiveFont->chr_counter = chr_counter;

    // Text_InsertDrawString(&proc->texts[0], GetStringTextCenteredPos(64, str), TEXT_COLOR_SYSTEM_WHITE, str);
    Text_InsertDrawString(
        &proc->texts[0], GetStringTextCenteredPos(tileWidth * 8 + 8, str), TEXT_COLOR_SYSTEM_WHITE, str);

    return;
}

void BGMWindow_Loop_OnSideChange(struct PlayerInterfaceProc * proc)
{
    int quadrant;

    proc->showHideClock = 0;
    proc->hideContents = true;

    // proc->cursorQuadrant = GetCursorQuadrant();

    // quadrant = GetWindowQuadrant(
    // sPlayerInterfaceConfigLut[proc->cursorQuadrant].xGoal, sPlayerInterfaceConfigLut[proc->cursorQuadrant].yGoal);

    // struct PlayerInterfaceProc * tiProc;
    // tiProc = Proc_Find(gProcScr_TerrainDisplay);

    // if (tiProc != NULL)
    // {
    // if ((tiProc->windowQuadrant > -1) && (tiProc->windowQuadrant == quadrant))
    // {
    // return;
    // }
    // }

    // proc->windowQuadrant = quadrant;
    proc->windowQuadrant = 0;

    BGMWindowDraw(proc);

    proc->xCursor = gBmSt.playerCursor.x;
    proc->yCursor = gBmSt.playerCursor.y;

    proc->xCursorPrev = proc->xCursor;
    proc->yCursorPrev = proc->yCursor;

    Proc_Break(proc);

    return;
}

//! FE8U = 0x0808D514
#define gUiScratchX 0 // vanilla uses 19
#define gUiScratchY 0 // vanilla uses 10

#define gUiWindowX_Size 12
#define gUiWindowY_Size 6

void BGMWindow_808D514(int quadrant, int height, int width) // originally param3 would be line 0 or line 1
{

    TileMap_FillRect(gBG1TilemapBuffer, width, gUiWindowY_Size, 0);
    TileMap_FillRect(gBG0TilemapBuffer, width, gUiWindowY_Size, 0);

    TileMap_CopyRect(
        gUiTmScratchB + TILEMAP_INDEX(gUiScratchX + 1, (gUiScratchY + 6 - height)), gBG1TilemapBuffer, width, height);
    TileMap_CopyRect(
        gUiTmScratchA + TILEMAP_INDEX(gUiScratchX + 1, (gUiScratchY + 8 - height)), gBG0TilemapBuffer, width, height);

    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
}

int GetBGMWindowWidth(struct PlayerInterfaceProc * proc)
{
    return proc->texts[0].tile_width + 1;
}

int GetBGMWindowHeight(struct PlayerInterfaceProc * proc)
{
    return 4;
}

void BGMWindowClean(struct PlayerInterfaceProc * proc)
{
    int w = GetBGMWindowWidth(proc);
    int h = GetBGMWindowHeight(proc);
    int x = 0;
    int y = 0;

    // DrawUiFrame(BG_GetMapBuffer(1), x, y, w, h, TILEREF(0, 0), 0);

    ClearUiFrame(BG_GetMapBuffer(0), x, y, w, h);
    ClearUiFrame(BG_GetMapBuffer(1), x, y, w, h);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
}

void BGMWindowDraw(struct PlayerInterfaceProc * proc)
{
    int w = GetBGMWindowWidth(proc);
    int h = GetBGMWindowHeight(proc);
    int x = 0;
    int y = 0;

    DrawUiFrame(BG_GetMapBuffer(1), x, y, w, h, TILEREF(0, 0), 0);

    ClearUiFrame(BG_GetMapBuffer(0), x, y, w, h);

    PutText(&proc->texts[0], gBG0TilemapBuffer + TILEMAP_INDEX(gUiScratchX + 0, gUiScratchY + 1));
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);

    // TileMap_FillRect(gUiTmScratchB + TILEMAP_INDEX(gUiScratchX + 1, gUiScratchY), 11, 9, 0);
    // TileMap_FillRect(gUiTmScratchA + TILEMAP_INDEX(gUiScratchX + 1, gUiScratchY + 2), 11, 9, 0);

    // if (proc->unitClock == 0)
    // {
    // CallARM_FillTileRect(
    // gUiTmScratchB + TILEMAP_INDEX(gUiScratchX + 1, gUiScratchY), gTSA_GoalBox_OneLine, TILEREF(0x0, 1));
    // PutText(proc->texts, gUiTmScratchA + TILEMAP_INDEX(gUiScratchX + 2, gUiScratchY + 3));
    // }

    // if (proc->unitClock == 1)
    // {
    // CallARM_FillTileRect(
    // gUiTmScratchB + TILEMAP_INDEX(gUiScratchX + 1, gUiScratchY), gTSA_GoalBox_TwoLines, TILEREF(0x0, 1));
    // PutText(&proc->texts[0], gUiTmScratchA + TILEMAP_INDEX(gUiScratchX + 2, gUiScratchY + 3));
    // PutText(&proc->texts[1], gUiTmScratchA + TILEMAP_INDEX(gUiScratchX + 2, gUiScratchY + 5));
    // }
}

void BGMWindow_Loop_SlideIn(struct PlayerInterfaceProc * proc)
{
    int height = sGoalSlideInWidthLut[proc->showHideClock];

    // BGMWindow_808D514(proc->cursorQuadrant, height, GetBGMWindowWidth(proc));

    proc->showHideClock++;

    if (proc->showHideClock == 5)
    {
        proc->showHideClock = 0;
        proc->hideContents = false;

        Proc_Break(proc);
    }

    return;
}

void BGMWindow_Loop_SlideOut(struct PlayerInterfaceProc * proc)
{
    int height;

    proc->hideContents = true;

    height = sGoalSlideOutWidthLut[proc->showHideClock];

    // BGMWindow_808D514(proc->cursorQuadrant, height, GetBGMWindowWidth(proc));

    proc->showHideClock++;

    if (proc->showHideClock == 3)
    {
        proc->showHideClock = 0;
        proc->hideContents = false;
        proc->isRetracting = false;
        proc->windowQuadrant = -1;

        Proc_Break(proc);
    }

    return;
}
extern int BGMWindow_DisplayFrames;
void BGMWindow_Loop_Display(struct PlayerInterfaceProc * proc)
{
    proc->xCursorPrev = proc->xCursor;
    proc->yCursorPrev = proc->yCursor;

    proc->xCursor = gBmSt.playerCursor.x;
    proc->yCursor = gBmSt.playerCursor.y;

    proc->showHideClock++;
    if (proc->showHideClock > BGMWindow_DisplayFrames)
    {
        BGMWindowClean(proc);
        Proc_End(proc);
    }

    if (proc->xCursor == proc->xCursorPrev && proc->yCursor == proc->yCursorPrev)
    {
        return;
    }

    if (Proc_Find(gProcScr_CamMove) == NULL)
    {
        int cursorQuadrant = GetCursorQuadrant();
        int quadrant = proc->cursorQuadrant;

        if (cursorQuadrant == quadrant)
        {
            return;
        }

        if ((sPlayerInterfaceConfigLut[cursorQuadrant].xGoal == sPlayerInterfaceConfigLut[quadrant].xGoal) &&
            (sPlayerInterfaceConfigLut[cursorQuadrant].yGoal == sPlayerInterfaceConfigLut[quadrant].yGoal))
        {
            return;
        }
    }

    // proc->isRetracting = true;

    // Proc_Break(proc);

    return;
}
