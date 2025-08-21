#include "C_Code.h"

#define brk asm("mov r11, r11");

struct PlayerInterfaceProc
{
    /* 00 */ PROC_HEADER;
    /* 29 */ u8 finished;
    /* 2a */ u8 id;
    /* 2b */ u8 chr_counter;
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

struct NotificationWindowProc
{
    /* 00 */ PROC_HEADER;
    /* 29 */ u8 finishedPrinting;
    /* 2a */ u8 id;
    /* 2b */ u16 chr_counter;
    // /* 2C */ struct Text texts[2];

    // char str[30];
    u8 line;
    u8 lines;
    /* 44 */ s16 unitClock;
    // /* 50 */ s8 cursorQuadrant;
    // /* 55 */ s8 hideContents;
    // /* 56 */ s8 isRetracting;
    // /* 57 */ s8 windowQuadrant;
    // /* 58 */ int showHideClock;
    char * str;
    char * strOriginal;
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

void NotificationWindow_Init(struct NotificationWindowProc * proc);
void NotificationWindow_Loop_Display(struct NotificationWindowProc * proc);
void NotificationWindow_LoopDrawText(struct NotificationWindowProc * proc);
void NotificationWindowDraw(struct NotificationWindowProc * proc);
void NotificationWindowClean(struct NotificationWindowProc * proc);
char * NotificationPrintText(struct NotificationWindowProc * proc, struct Text * th, const char * str);
void NotificationIdleWhileMenuEtc(struct NotificationWindowProc * proc);
int CountStrLines(const char * str);
int GetNotificationStringTextLenASCII_Wrapped(const char * str);
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
    PROC_SLEEP(2),
    PROC_REPEAT(NotificationIdleWhileMenuEtc),
    PROC_SLEEP(2),

    PROC_CALL(NotificationWindow_Init),

    PROC_LABEL(LoopLabel),

    PROC_WHILE_EXISTS(gProcScr_CamMove), // ProcScr_CamMove

    PROC_REPEAT(NotificationWindow_Loop_Display),

    PROC_GOTO(LoopLabel),

    PROC_LABEL(ClearGfxLabel),
    PROC_CALL(NotificationWindowClean),

    PROC_LABEL(EnqueueLabel),
    PROC_GOTO(StartLabel),
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
        struct NotificationWindowProc * notifProc = Proc_Start(gProcScr_NotificationWindow, PROC_TREE_3);
        StartGreenText(notifProc);
        notifProc->id = 0;
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

int ShowBgm()
{
    return false;
}
struct NotificationsStruct
{
    const char * text;
    u16 textID;
    u16 flag;
};
extern const struct NotificationsStruct gNotificationsData[];

const char * GetNextNotificationStr(struct NotificationWindowProc * proc)
{
    const char * str = "";
    const struct NotificationsStruct data = gNotificationsData[proc->id];
    if (data.text == NULL && data.textID == 0)
    {
        return NULL;
    }
    if (ShowBgm())
    {
        str = GetPlayingBGMName();
    }
    else
    {
        str = data.text;
        if (!str)
        {
            str = GetStringFromIndex(data.textID);
        }
    }

    return str;
}

extern struct Font * gActiveFont;

// draw text farther down in tile1 page
#define DefaultTextChr 0x80
#define NotificationChr 0x180

#define MAX_LINE_WIDTH 151
#define CHAR_NEWLINE 1
#define CHAR_SPACE 0x20

int ClearNotificationText(
    struct NotificationWindowProc * proc, struct Text * text, int tileWidth, int chr_counter, int line)
{

    // save where text was drawing
    u32 chr = gActiveFont->chr_counter;

    // change it to after MMB
    // ResetText does: InitTextFont(&gDefaultFont, (void *)(VRAM + 0x1000), 0x80, 0);
    // then, chr_counter * 2 is the chr tile ID we want
    // (0x200 - 0x80) / 2 = 0xC0;
    // if we wanted to start at 0x200 tile, then we'd put 0xC0 here, or change NotifChr to 0x200
    if (!line)
    {
        gActiveFont->chr_counter = ((NotificationChr - DefaultTextChr) >> 1) + proc->chr_counter;
    }
    else
    {
        gActiveFont->chr_counter = proc->chr_counter;
    }

    InitText(text, tileWidth);
    int result = gActiveFont->chr_counter;
    proc->chr_counter = gActiveFont->chr_counter;
    gActiveFont->chr_counter = chr;

    return result;
}

void NotificationWindow_LoopDrawText(struct NotificationWindowProc * proc)
{
    if (GetGameClock() & 1)
    {
        return;
    }
    struct Text * th = &gStatScreen.text[0];
    const char * str = (const char *)proc->str;
    // chr_counter = InitNotificationText(proc, th, str, tileWidth, chr_counter);

    // save where text was drawing
    u32 chr = gActiveFont->chr_counter;

    // change it to after MMB
    // ResetText does: InitTextFont(&gDefaultFont, (void *)(VRAM + 0x1000), 0x80, 0);
    // then, chr_counter * 2 is the chr tile ID we want
    // (0x200 - 0x80) / 2 = 0xC0;
    // if we wanted to start at 0x200 tile, then we'd put 0xC0 here, or change NotifChr to 0x200

    if (!proc->line)
    {
        gActiveFont->chr_counter = ((NotificationChr - DefaultTextChr) >> 1) + proc->chr_counter;
    }
    else
    {
        gActiveFont->chr_counter = proc->chr_counter;
    }

    proc->str = NotificationPrintText(proc, th, str);
    if (!proc->str || !*proc->str)
    {
        proc->finishedPrinting = true;
    }

    proc->chr_counter = gActiveFont->chr_counter;

    // restore where text was drawing
    gActiveFont->chr_counter = chr;
}

void NotificationWindow_Init(struct NotificationWindowProc * proc)
{

    const char * str = GetNextNotificationStr(proc);
    if (!str || !*str)
    {

        Proc_Goto(proc, EndLabel);
        return;
    }
    proc->finishedPrinting = false;
    proc->str = (void *)str;
    proc->strOriginal = (void *)str;
    proc->unitClock = 0;

    int len = GetNotificationStringTextLenASCII_Wrapped(str);
    int tileWidth = (len + 7) >> 3;
    proc->line = 0;
    proc->lines = CountStrLines(str);
    int chr_counter = 0;
    NotificationWindowDraw(proc);
    proc->chr_counter = 0;
    struct Text * th = &gStatScreen.text[proc->line];

    for (int i = 0; i < proc->lines; i++)
    {
        chr_counter = ClearNotificationText(proc, &th[i], tileWidth, chr_counter, i);
    }
    // chr_counter = InitNotificationText(proc, th, str, tileWidth, chr_counter);
    proc->chr_counter = 0;
    for (int i = 0; i < proc->lines; i++)
    {
        PutText(&th[i], &gBG0TilemapBuffer[TILEMAP_INDEX(1, 1 + (i * 2))]);
    }

    // Text_InsertDrawString(&proc->texts[0], GetStringTextCenteredPos(64, str), TEXT_COLOR_SYSTEM_WHITE, str);

    return;
}

int GetNotificationStringTextLenASCII_Wrapped(const char * str)
{
    int curX = 0;     // current line width
    int maxWidth = 0; // widest line we’ve seen

    while (*str)
    {
        // explicit newline → commit line width
        if (*str == CHAR_NEWLINE)
        {
            if (curX > maxWidth)
                maxWidth = curX;
            curX = 0;
            str++;
            continue;
        }

        // measure next word (including leading space if any)
        const char * lookahead = str;
        int wordWidth = 0;

        // include a leading space if present
        if (*lookahead == ' ')
        {
            struct Glyph * glyph = gActiveFont->glyphs[(u8)*lookahead++];
            wordWidth += glyph->width;
        }

        while (*lookahead && *lookahead != ' ' && *lookahead != CHAR_NEWLINE)
        {
            struct Glyph * glyph = gActiveFont->glyphs[(u8)*lookahead++];
            wordWidth += glyph->width;
        }

        // if word doesn’t fit, wrap before it
        if (curX > 0 && curX + wordWidth > MAX_LINE_WIDTH)
        {
            if (curX > maxWidth)
                maxWidth = curX;
            curX = 0;
            continue; // retry this word on new line
        }

        // place word
        curX += wordWidth;
        str = lookahead;
    }

    // commit last line width
    if (curX > maxWidth)
        maxWidth = curX;

    return maxWidth;
}
int CountStrLines(const char * str)
{
    if (!str)
        return 0;

    int lines = 0;

    while (*str) // stop at NUL
    {
        int width = 0;
        const char * lastSpace = NULL;

        // consume one visual line (until newline/control or wrap)
        while (*str > 1) // > CHAR_NEWLINE
        {
            if (*str == ' ')
                lastSpace = str;

            struct Glyph * glyph = gActiveFont->glyphs[(u8)*str];
            width += glyph->width;
            str++;

            if (width > MAX_LINE_WIDTH)
            {
                // wrap: if we saw a space on this line, resume after it
                if (lastSpace)
                    str = lastSpace + 1;
                break;
            }
        }

        // explicit newline: consume it
        if (*str == CHAR_NEWLINE)
            str++;

        lines++; // finished one line (even if empty)
    }

    return lines; // empty string -> 0, otherwise number of visual lines
}

char * NotificationPrintText(struct NotificationWindowProc * proc, struct Text * th, const char * str)
{

    char * iter = (void *)str;
    int curX;
    int line = proc->line;
    int forceNewLine = false;

    int nextWordWidth = 0;
    // while (*iter == CHAR_NEWLINE)
    // {
    // iter++;
    // }

    while (*iter > CHAR_NEWLINE)
    {
        curX = Text_GetCursor(&th[line]); // current x position

        if (*iter == CHAR_SPACE)
        {
            char * lookahead = iter + 1;
            nextWordWidth = gActiveFont->glyphs[(u8)*iter]->width; // include the space in width

            while (*lookahead > CHAR_NEWLINE && *lookahead != ' ' && *lookahead != CHAR_NEWLINE)
            {
                struct Glyph * glyph = gActiveFont->glyphs[(u8)*lookahead++];
                nextWordWidth += glyph->width;
            }

            // If the next word doesn't fit, break before this space
            if (curX + nextWordWidth > MAX_LINE_WIDTH)
            {
                // brk;
                forceNewLine = true;
                // proc->line++;
                // iter++; // so next line does not start with a space
                break; // wrap before the next word
            }
        }
        if (curX > MAX_LINE_WIDTH || *iter == CHAR_NEWLINE)
        {
            forceNewLine = true;
            break;
        }
        iter = (void *)Text_DrawCharacterAscii(&th[line], (void *)iter);
        break;
    }
    if (*iter == CHAR_NEWLINE || forceNewLine)
    {
        proc->line++;
        while (*iter == CHAR_SPACE || *iter == CHAR_NEWLINE)
        {
            iter++;
        }
    }

    return iter;
}

int GetNotificationWindowWidth(struct NotificationWindowProc * proc)
{
    // int lines = proc->lines;
    // int result = 0;
    return ((GetNotificationStringTextLenASCII_Wrapped(proc->strOriginal) + 7) >> 3) + 2;
    // return gStatScreen.text[proc->line].tile_width + 1;s
}

int GetNotificationWindowHeight(struct NotificationWindowProc * proc)
{
    return (proc->lines * 2) + 2;
}

void NotificationWindowClean(struct NotificationWindowProc * proc)
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

void NotificationWindowDraw(struct NotificationWindowProc * proc)
{
    int w = GetNotificationWindowWidth(proc);
    int h = GetNotificationWindowHeight(proc);
    int x = 0;
    int y = 0;

    DrawUiFrame(BG_GetMapBuffer(1), x, y, w, h, TILEREF(0, 0), 0);

    ClearUiFrame(BG_GetMapBuffer(0), x, y, w, h);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
}

int CheckNotificationInterrupted(struct NotificationWindowProc * proc)
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

            if (mmb->isRetracting || mmb->showHideClock)
            {
                return true;
            }
        }
    }
    if (Proc_Find(sProc_Menu))
    {
        return true;
    }
    return false;
}

void NotificationIdleWhileMenuEtc(struct NotificationWindowProc * proc)
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
void NotificationWindow_Loop_Display(struct NotificationWindowProc * proc)
{
    if (CheckNotificationInterrupted(proc))
    {
        NotificationWindowClean(proc);
        Proc_Goto(proc, EnqueueLabel);
        return;
    }
    NotificationWindow_LoopDrawText(proc);

    if (proc->finishedPrinting)
    {

        proc->unitClock++;
        if (proc->unitClock > NotificationWindow_DisplayFrames)
        {
            NotificationWindowClean(proc);
            proc->id++;
            Proc_Goto(proc, EnqueueLabel);
            return;
        }
    }
}
