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

void BGMWindow_Init(struct PlayerInterfaceProc * proc)
{
    InitTextDb(proc->texts, 7);
    proc->burstUnitId = 0;
    proc->hideContents = false;
    proc->showHideClock = 0;
    proc->wBurst = 0;
    proc->hBurst = 0;
    proc->isRetracting = false;

    return;
}

void BGMWindow_Loop_OnSideChange(struct PlayerInterfaceProc * proc)
{
    int quadrant;

    proc->showHideClock = 0;
    proc->hideContents = true;

    proc->cursorQuadrant = GetCursorQuadrant();

    quadrant = GetWindowQuadrant(
        sPlayerInterfaceConfigLut[proc->cursorQuadrant].xGoal, sPlayerInterfaceConfigLut[proc->cursorQuadrant].yGoal);

    // struct PlayerInterfaceProc * tiProc;
    // tiProc = Proc_Find(gProcScr_TerrainDisplay);

    // if (tiProc != NULL)
    // {
    // if ((tiProc->windowQuadrant > -1) && (tiProc->windowQuadrant == quadrant))
    // {
    // return;
    // }
    // }

    proc->windowQuadrant = quadrant;
    proc->windowQuadrant = 0;

    BGMWindowDraw(proc);

    proc->xCursor = gBmSt.playerCursor.x;
    proc->yCursor = gBmSt.playerCursor.y;

    proc->xCursorPrev = proc->xCursor;
    proc->yCursorPrev = proc->yCursor;

    Proc_Break(proc);

    return;
}

void BGMWindow_Loop_SlideIn(struct PlayerInterfaceProc * proc)
{
    int unk = sGoalSlideInWidthLut[proc->showHideClock];

    sub_808D514(proc->cursorQuadrant, unk, proc->unitClock);

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
    int unk;

    proc->hideContents = true;

    unk = sGoalSlideOutWidthLut[proc->showHideClock];

    sub_808D514(proc->cursorQuadrant, unk, proc->unitClock);

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

void BGMWindowDraw(struct PlayerInterfaceProc * proc)
{
    TileMap_FillRect(gUiTmScratchB + TILEMAP_INDEX(20, 10), 11, 9, 0);
    TileMap_FillRect(gUiTmScratchA + TILEMAP_INDEX(20, 12), 11, 9, 0);

    if (proc->unitClock == 0)
    {
        CallARM_FillTileRect(gUiTmScratchB + TILEMAP_INDEX(20, 10), gTSA_GoalBox_OneLine, TILEREF(0x0, 1));
        PutText(proc->texts, gUiTmScratchA + TILEMAP_INDEX(21, 13));
    }

    if (proc->unitClock == 1)
    {
        CallARM_FillTileRect(gUiTmScratchB + TILEMAP_INDEX(20, 10), gTSA_GoalBox_TwoLines, TILEREF(0x0, 1));
        PutText(&proc->texts[0], gUiTmScratchA + TILEMAP_INDEX(21, 13));
        PutText(&proc->texts[1], gUiTmScratchA + TILEMAP_INDEX(21, 15));
    }
}

void BGMWindow_Loop_Display(struct PlayerInterfaceProc * proc)
{
    proc->xCursorPrev = proc->xCursor;
    proc->yCursorPrev = proc->yCursor;

    proc->xCursor = gBmSt.playerCursor.x;
    proc->yCursor = gBmSt.playerCursor.y;

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

    proc->isRetracting = true;

    Proc_Break(proc);

    return;
}
