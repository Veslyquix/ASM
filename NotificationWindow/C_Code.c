#include "C_Code.h"

#define brk asm("mov r11, r11");

struct PlayerInterfaceProc
{
    /* 00 */ PROC_HEADER;
    /* 29 */ u8 finished;
    /* 2a */ u8 pad1;
    /* 2b */ u8 pad2;
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

extern struct ProcCmd gProcScr_UnitDisplay_MinimugBox[];
extern struct ProcCmd gProcScr_TerrainDisplay[];
extern struct ProcCmd sProc_Menu[];

extern struct PlayerInterfaceConfigEntry sPlayerInterfaceConfigLut[4];
extern s8 sGoalSlideInWidthLut[5];
extern s8 sGoalSlideOutWidthLut[3];
extern int GetCursorQuadrant();
extern int GetWindowQuadrant(int, int);
extern void sub_808D514(int quadrant, int param_2, int param_3);

void NotificationWindow_Init(struct PlayerInterfaceProc * proc);
void NotificationWindow_Loop_OnSideChange(struct PlayerInterfaceProc * proc);
void NotificationWindow_Loop_SlideIn(struct PlayerInterfaceProc * proc);
void NotificationWindow_Loop_Display(struct PlayerInterfaceProc * proc);
void NotificationWindow_Loop_SlideOut(struct PlayerInterfaceProc * proc);
void NotificationWindowDraw(struct PlayerInterfaceProc * proc);
void NotificationWindowClean(struct PlayerInterfaceProc * proc);
void EnqueueIfUnfinished(struct PlayerInterfaceProc * proc);
void NotificationIdleWhileMenuEtc(struct PlayerInterfaceProc * proc);

// notifications eg. new BGM, ingame achievements, NG+ unlocks, or spam

// queue a notification
// display at start of enemy phase & when player interfaces like terrain/goal show up
// after x seconds, disappear
// if B is pressed twice, disappear
// if interrupted, enqueue again

#define StartLabel 0
#define LoopLabel 1
#define ClearGfxLabel 97
#define EnqueueLabel 98
#define EndLabel 99
struct ProcCmd const gProcScr_NotificationWindow[] = {
    PROC_NAME("NotificationWindow"),
    PROC_15, // ?
    PROC_YIELD,
    PROC_LABEL(StartLabel),
    PROC_REPEAT(NotificationIdleWhileMenuEtc),
    PROC_SLEEP(0),

    PROC_CALL(NotificationWindow_Init),

    PROC_LABEL(LoopLabel),

    PROC_WHILE_EXISTS(gProcScr_CamMove), // ProcScr_CamMove

    PROC_REPEAT(NotificationWindow_Loop_OnSideChange),
    PROC_REPEAT(NotificationWindow_Loop_SlideIn),
    PROC_REPEAT(NotificationWindow_Loop_Display),
    PROC_REPEAT(NotificationWindow_Loop_SlideOut),

    PROC_GOTO(LoopLabel),

    PROC_LABEL(ClearGfxLabel),
    PROC_CALL(NotificationWindowClean),

    PROC_LABEL(EnqueueLabel),
    PROC_CALL(EnqueueIfUnfinished),
    PROC_YIELD,

    PROC_LABEL(EndLabel),

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
    if (!Proc_Find(gProcScr_NotificationWindow))
    {
        // Proc_EndEach(gProcScr_NotificationWindow);
        Proc_Start(gProcScr_NotificationWindow, PROC_TREE_3);
    }
    else
    {
        Proc_Goto(Proc_Find(gProcScr_NotificationWindow), StartLabel);
    }

    return;
}

// NotificationWindow

#ifdef FE6
typedef struct SoundRoomData
{
    int songID;
    int songName;
    int songDesc;
} SoundRoomData;
#endif

#ifndef FE6
typedef struct SoundRoomData
{
    int songID;
    int songLength;
    int displayCondition;
    int songName;
} SoundRoomData;
#endif

// use a pointer to the sound room in case it has been repointed
extern struct SoundRoomData * sSoundRoom;
extern int GetCurrentBgmSong(void);
extern int GetCurrentMapMusicIndex(void);

int GetSoundRoomIDFromTrack(int id)
{
    int i = 0;
    struct SoundRoomData * data = sSoundRoom;
    if (data[id - 1].songID == id)
    { // vanilla tracks are the same order as sound room
        return id - 1;
    }
    while (data->songID != (-1))
    {
        if (data->songID == id)
        {
            return i;
        }
        data++;
        i++;
    }
    return (-1);
}

const char * GetPlayingBGMName(void)
{
    int id = GetCurrentBgmSong();
    struct SoundRoomData * data = sSoundRoom;
    id = GetSoundRoomIDFromTrack(id);
    if (id == (-1))
    {
        return "";
    }

    const char * str = GetStringFromIndex(data[id].songName);
    return str;
}

void EnqueueIfUnfinished(struct PlayerInterfaceProc * proc)
{
    if (!proc->finished)
    {

        Proc_Goto(proc, StartLabel);
    }
}
const char * GetNextNotificationStr(struct PlayerInterfaceProc * proc)
{
    const char * str = "";

    str = GetPlayingBGMName();
    return str;
}

extern struct Font * gActiveFont;

// draw text farther down in tile1 page
#define DefaultTextChr 0x80
#define NotificationChr 0x180
int InitNotificationText(struct Text * text, const char * str, int tileWidth, int chr_counter)
{
    // save where text was drawing
    u32 chr = gActiveFont->chr_counter;

    // change it to after MMB
    // ResetText does: InitTextFont(&gDefaultFont, (void *)(VRAM + 0x1000), 0x80, 0);
    // then, chr_counter * 2 is the chr tile ID we want
    // (0x200 - 0x80) / 2 = 0xC0;
    // if we wanted to start at 0x200 tile, then we'd put 0xC0 here, or change NotifChr to 0x200
    gActiveFont->chr_counter =
        ((NotificationChr - DefaultTextChr) >> 1) + chr_counter; // starts at 0x80 tile normally, then

    InitText(text, tileWidth);
    Text_InsertDrawString(text, GetStringTextCenteredPos(tileWidth * 8 + 8, str), TEXT_COLOR_SYSTEM_WHITE, str);
    int result = gActiveFont->chr_counter;

    // restore where text was drawing
    gActiveFont->chr_counter = chr;

    return result;
}

void NotificationWindow_Init(struct PlayerInterfaceProc * proc)
{

    proc->burstUnitId = 0;
    proc->hideContents = false;
    proc->showHideClock = 0;
    proc->wBurst = 0;
    proc->hBurst = 0;
    proc->isRetracting = false;

    const char * str = GetNextNotificationStr(proc);
    if (!*str || !str)
    {
        Proc_Goto(proc, EndLabel);
        return;
    }
    proc->finished = false;
    int len = GetStringTextLen(str);
    int tileWidth = (len + 15) >> 3;

    int chr_counter = 0;
    chr_counter = InitNotificationText(proc->texts, str, tileWidth, chr_counter);

    // Text_InsertDrawString(&proc->texts[0], GetStringTextCenteredPos(64, str), TEXT_COLOR_SYSTEM_WHITE, str);

    return;
}

void NotificationWindow_Loop_OnSideChange(struct PlayerInterfaceProc * proc)
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

    NotificationWindowDraw(proc);

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

void NotificationWindow_808D514(int quadrant, int height, int width) // originally param3 would be line 0 or line 1
{

    TileMap_FillRect(gBG1TilemapBuffer, width, gUiWindowY_Size, 0);
    TileMap_FillRect(gBG0TilemapBuffer, width, gUiWindowY_Size, 0);

    TileMap_CopyRect(
        gUiTmScratchB + TILEMAP_INDEX(gUiScratchX + 1, (gUiScratchY + 6 - height)), gBG1TilemapBuffer, width, height);
    TileMap_CopyRect(
        gUiTmScratchA + TILEMAP_INDEX(gUiScratchX + 1, (gUiScratchY + 8 - height)), gBG0TilemapBuffer, width, height);

    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
}

int GetNotificationWindowWidth(struct PlayerInterfaceProc * proc)
{
    return proc->texts[0].tile_width + 1;
}

int GetNotificationWindowHeight(struct PlayerInterfaceProc * proc)
{
    return 4;
}

void NotificationWindowClean(struct PlayerInterfaceProc * proc)
{

    int w = GetNotificationWindowWidth(proc);
    int h = GetNotificationWindowHeight(proc);
    int x = 0;
    int y = 0;

    // DrawUiFrame(BG_GetMapBuffer(1), x, y, w, h, TILEREF(0, 0), 0);

    ClearUiFrame(BG_GetMapBuffer(0), x, y, w, h);
    ClearUiFrame(BG_GetMapBuffer(1), x, y, w, h);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
}

void NotificationWindowDraw(struct PlayerInterfaceProc * proc)
{
    int w = GetNotificationWindowWidth(proc);
    int h = GetNotificationWindowHeight(proc);
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

void NotificationWindow_Loop_SlideIn(struct PlayerInterfaceProc * proc)
{
    int height = sGoalSlideInWidthLut[proc->showHideClock];

    // NotificationWindow_808D514(proc->cursorQuadrant, height, GetNotificationWindowWidth(proc));

    proc->showHideClock++;

    if (proc->showHideClock == 5)
    {
        proc->showHideClock = 0;
        proc->hideContents = false;

        Proc_Break(proc);
    }

    return;
}

void NotificationWindow_Loop_SlideOut(struct PlayerInterfaceProc * proc)
{
    int height;

    proc->hideContents = true;

    height = sGoalSlideOutWidthLut[proc->showHideClock];

    // NotificationWindow_808D514(proc->cursorQuadrant, height, GetNotificationWindowWidth(proc));

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
int CheckNotificationInterrupted(struct PlayerInterfaceProc * proc)
{
    if (gBmMapUnit[gBmSt.playerCursor.y][gBmSt.playerCursor.x])
    { // then minimug will show up
        struct PlayerInterfaceProc * mmb = Proc_Find(gProcScr_UnitDisplay_MinimugBox);

        if (mmb)
        {
            if (mmb->windowQuadrant == 0) // top left
            {
                return true;
            }

            // if (mmb->isRetracting || mmb->showHideClock)
            // {
            // brk;
            // return;
            // }
        }
    }
    if (Proc_Find(sProc_Menu))
    {
        return true;
    }
    return false;
}

void NotificationIdleWhileMenuEtc(struct PlayerInterfaceProc * proc)
{
    if (CheckNotificationInterrupted(proc))
    {
        return;
    }

    if (Proc_Find(gProcScr_TerrainDisplay))
    {
        Proc_Break(proc);
    }
}

extern int NotificationWindow_DisplayFrames;
void NotificationWindow_Loop_Display(struct PlayerInterfaceProc * proc)
{
    proc->xCursorPrev = proc->xCursor;
    proc->yCursorPrev = proc->yCursor;

    proc->xCursor = gBmSt.playerCursor.x;
    proc->yCursor = gBmSt.playerCursor.y;

    if (CheckNotificationInterrupted(proc))
    {
        NotificationWindowClean(proc);
        Proc_Goto(proc, EnqueueLabel);
        return;
    }

    proc->showHideClock++;
    if (proc->showHideClock > NotificationWindow_DisplayFrames)
    {
        proc->finished = true;
        Proc_Goto(proc, ClearGfxLabel);
        return;
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
