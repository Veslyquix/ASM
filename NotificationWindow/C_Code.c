#include "C_Code.h"

#define brk asm("mov r11, r11");

struct NotificationsStruct
{
    const char * text;
    u16 textID;
    u16 flag;
    u8 colour[4];
};
extern const struct NotificationsStruct gNotificationsData[];

#define QueueSize 30
struct NotificationWindowProc
{
    PROC_HEADER;
    u8 finishedPrinting;
    u8 showingBgm;
    s8 delayFrames;
    char * str;
    char * strOriginal;
    s16 id;
    u16 chr_counter;
    u16 bgm;

    s16 unitClock;
    u8 line;
    u8 lines;

    u8 fastPrint;

    u8 colour[4]; // up to 0x41
    u8 queue[30];
};

// MSa_SaveBonusClaim
// default EMS seems to save 4 bytes for bonus content data that's been claimed
// although the global sram for it is still in the link arena sram at like 0xE007200ish

static const u8 iid_bonus[] = {
    ITEM_BOOSTER_HP,  ITEM_BOOSTER_POW, ITEM_BOOSTER_SKL, ITEM_BOOSTER_SPD, ITEM_BOOSTER_LCK,
    ITEM_BOOSTER_DEF, ITEM_BOOSTER_RES, ITEM_BOOSTER_MOV, ITEM_BOOSTER_CON,
};
struct BonusClaimEnt
{
    /* 00 */ u8 unseen;
    /* 01 */ u8 kind; // 2 = gold, 0/1 = items
    /* 02 */ u8 itemId;
    /* 03 */ char str[0x11]; // Only used in FE8
};

#define BONUS_CLAIM_MAX 16
#include <string.h>

void SetBonusDataItem(struct BonusClaimEnt * data, int itemID, const char * str)
{
    data->unseen = true; // "viewable" would be better name
    data->kind = BONUSKIND_ITEM0;
    data->itemId = itemID;

    // Clear the buffer
    for (int i = 0; i < 0x11; i++)
    {
        data->str[i] = 0;
    }

    int len = strlen(str);
    if (len >= 0x11)
    {
        return; // too long, skip
    }

    CopyString(data->str, str);
}
// vanilla only supports 3000g and 5000g items
void SetBonusData3000Gold(struct BonusClaimEnt * data, const char * str)
{
    SetBonusDataItem(data, ITEM_3000G, str);
    data->kind = BONUSKIND_MONEY;
}
void SetBonusData5000Gold(struct BonusClaimEnt * data, const char * str)
{
    SetBonusDataItem(data, ITEM_5000G, str);
    data->kind = BONUSKIND_MONEY;
}

void CreateBonusContentData()
{

    struct BonusClaimEnt data[BONUS_CLAIM_MAX] = { 0 };
    // brk;
    for (int i = 0; i < BONUS_CLAIM_MAX; ++i)
    {
        SetBonusDataItem(&data[i], i + 1, "enjoy :)");
    }
    SetBonusData3000Gold(&data[0], "Monies");
    SetBonusData5000Gold(&data[1], "Im rich");
    SaveBonusContentData(data);
}

extern struct ProcCmd gProcScr_UnitDisplay_MinimugBox[];
extern struct ProcCmd gProcScr_TerrainDisplay[];
extern struct ProcCmd sProc_Menu[];

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
void NotificationWindow_Idle(struct NotificationWindowProc * proc);
void StartNotificationProc(int id);
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

void NotificationSetFastPrint(struct NotificationWindowProc * proc)
{
    proc->fastPrint = true;
}

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
    PROC_CALL(NotificationSetFastPrint),
    PROC_GOTO(StartLabel),
    PROC_YIELD,

    PROC_LABEL(EndLabel),
    PROC_REPEAT(NotificationWindow_Idle),
    PROC_GOTO(StartLabel),

    PROC_END,
};

int GetNotificationId(struct NotificationWindowProc * proc)
{
    int id = proc->id;
    if (id == (-1))
    {
        return id;
    }
    return proc->queue[id];
}

int GetFreeQueueSlot(struct NotificationWindowProc * proc)
{
    for (int i = 0; i < QueueSize; ++i)
    {
        if (proc->queue[i] == 0xFF)
        {
            return i;
        }
    }
    return 0;
}

int GetTakenQueueSlot(struct NotificationWindowProc * proc)
{
    for (int i = 0; i < QueueSize; ++i)
    {
        if (proc->queue[i] != 0xFF)
        {
            return i;
        }
    }
    return (-1);
}

void NotificationInitVariables(struct NotificationWindowProc * proc)
{
    proc->fastPrint = false;
    StartGreenText(proc);
    for (int i = 0; i < QueueSize; i++)
    {
        proc->queue[i] = 0xFF;
    }
}

void StartNotificationProc(int id)
{
    struct NotificationWindowProc * proc = Proc_Find(gProcScr_NotificationWindow);
    if (!proc)
    {
        proc = Proc_Start(gProcScr_NotificationWindow, PROC_TREE_3);
        NotificationInitVariables(proc);
        int slot = GetFreeQueueSlot(proc);
        proc->queue[slot] = id;
        proc->id = slot;
        proc->bgm = 0xFFFF;
    }
    else
    {
        int slot = GetFreeQueueSlot(proc);
        brk;
        proc->queue[slot] = id;
        proc->id = slot;
        Proc_Goto(proc, StartLabel);
    }
}

void DoNotificationsForFlag(int id)
{
    const struct NotificationsStruct * data = &gNotificationsData[0];
    int i = 0;
    while (data->text || data->textID)
    {
        if (data->flag == id)
        {
            StartNotificationProc(i);
            // no break in case more than 1 notification is to display for the 1 flag
        }
        data++;
        i++;
    }
    return;
}

void RestartNotificationProc(void)
{
    struct NotificationWindowProc * proc = Proc_Find(gProcScr_NotificationWindow);
    if (!proc)
    {
        proc = Proc_Start(gProcScr_NotificationWindow, PROC_TREE_3);
        NotificationInitVariables(proc);
        proc->id = (-1); // bgm only
        proc->bgm = 0xFFFF;
    }
    else
    {
        Proc_Goto(proc, StartLabel); // maybe ?
    }
}

//! FE8U = 0x0808CB34
void TerrainDisplay_Init(struct PlayerInterfaceProc * proc) // start
{
    proc->windowQuadrant = -1;
    proc->isRetracting = false;
    proc->showHideClock = 0;
    proc->cursorQuadrant = 1;

    InitTextDb(proc->texts, 5);

    RestartNotificationProc();
    CreateBonusContentData();

    return;
}

// Hooks:
// void SetChapterFlag(int flag);
// void SetPermanentFlag(int flag);

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

struct MsgBuffer
{
    u8 buffer1[0x555];
    u8 buffer2[0x555];
    u8 buffer3[0x356];
    u8 buffer4[0x100];
    u8 buffer5[0x100];
};
extern struct MsgBuffer sMsgString;
const char * GetPlayingBGMName(struct NotificationWindowProc * proc)
{
    int id = GetCurrentBgmSong();
    struct SoundRoomData * data = sSoundRoom;
    id = GetSoundRoomIDFromTrack(id);
    if (id == (-1))
    {
        return "";
    }

    // use this buffer so that moving the cursor over different terrain doesn't overwrite the buffered text
    char * buf = (void *)sMsgString.buffer3;

    CopyString(buf, "BGM: ");
    GetStringFromIndexInBuffer(data[id].songName, buf + strlen(buf));

    return buf;
}

extern const int DisableBGMNotificationsFlag;
int ShowBgm(struct NotificationWindowProc * proc)
{
    int songID = GetCurrentBgmSong();
    if (songID == proc->bgm)
    {
        return false;
    }
    proc->bgm = songID;
    return !CheckFlag(DisableBGMNotificationsFlag);
}

void NotificationWindow_Idle(struct NotificationWindowProc * proc)
{
    if (ShowBgm(proc))
    {
        Proc_Goto(proc, StartLabel);
    }
}

const char * GetNextNotificationStr(struct NotificationWindowProc * proc)
{
    const char * str = "";
    const struct NotificationsStruct * data = NULL;
    int id = GetNotificationId(proc);
    if (id != (-1))
    {
        data = &gNotificationsData[id];
    }
    else if (ShowBgm(proc))
    {
        proc->showingBgm = true;
        return GetPlayingBGMName(proc);
    }
    if (!data || (data->text == NULL && data->textID == 0))
    {
        return NULL;
    }

    str = data->text;
    for (int i = 0; i < 4; i++)
    {
        proc->colour[i] = data->colour[i];
    }

    if (!str)
    {
        str = GetStringFromIndexInBuffer(data->textID, (void *)sMsgString.buffer3);
    }

    return str;
}

extern struct Font * gActiveFont;

// draw text farther down in tile1 page
#define DefaultTextChr 0x80
#define NotificationChr 0x180

// #define MAX_LINE_WIDTH 151
extern const int MAX_LINE_WIDTH;
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
    if (!proc->fastPrint && (GetGameClock() & 1))
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
    proc->showingBgm = false;
    for (int i = 0; i < 4; ++i)
    {
        proc->colour[i] = TEXT_COLOR_SYSTEM_WHITE;
    }
    const char * str = GetNextNotificationStr(proc);
    if (!str || !*str)
    {

        Proc_Goto(proc, EndLabel);
        return;
    }
    proc->delayFrames = 0;
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
        if (i < 4)
        {
            Text_SetColor(&th[i], proc->colour[i]);
        }
        else
        {
            Text_SetColor(&th[i], proc->colour[3]);
        }
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
    int width = ((GetNotificationStringTextLenASCII_Wrapped(proc->strOriginal) + 7) >> 3) + 2;
    if (width > 19)
    {
        width = 19;
    }
    return width;
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

int UpdateIdleDelayFrames(struct NotificationWindowProc * proc)
{
    proc->delayFrames = 2;

    return true;
}

// idle for a couple extra frames so menu closing to MMB opening doesn't trigger
int CheckNotificationInterrupted(struct NotificationWindowProc * proc)
{
    int result = false;
    if (proc->delayFrames > 0)
    {
        result = true;
    }
    proc->delayFrames--;
    if (proc->delayFrames < 0)
    {
        proc->delayFrames = 0;
    }
    if (GetGameLock())
    {
        return UpdateIdleDelayFrames(proc);
    }
    // playerCursorDisplay
    if (gBmMapUnit[gBmSt.playerCursor.y][gBmSt.playerCursor.x])
    // if (gBmMapUnit[gBmSt.playerCursor.y][gBmSt.playerCursor.x] ||
    // gBmMapUnit[gBmSt.cursorPrevious.y][gBmSt.cursorPrevious.x])

    { // then minimug will show up
        struct PlayerInterfaceProc * mmb = Proc_Find(gProcScr_UnitDisplay_MinimugBox);

        if (mmb)
        {
            if (mmb->windowQuadrant == 0) // top left
            {
                return UpdateIdleDelayFrames(proc);
            }

            // if (mmb->isRetracting || mmb->showHideClock)
            // {
            // return UpdateIdleDelayFrames(proc);
            // }
        }
    }
    if (Proc_Find(sProc_Menu))
    {
        return UpdateIdleDelayFrames(proc);
    }
    struct Proc * playerPhase = Proc_Find(gProcScr_PlayerPhase);
    if (playerPhase)
    {
        if (playerPhase->proc_lockCnt) // player phase has a blocking proc (such as the debugger)
        {
            return UpdateIdleDelayFrames(proc);
        }
    }
    else
    {
        return UpdateIdleDelayFrames(proc);
    }

    return result;
}

void NotificationIdleWhileMenuEtc(struct NotificationWindowProc * proc)
{
    if (CheckNotificationInterrupted(proc))
    {
        return;
    }
    struct PlayerInterfaceProc * terrainProc = Proc_Find(gProcScr_TerrainDisplay);
    if (terrainProc)
    {
        if (terrainProc->isRetracting || terrainProc->showHideClock)
        {
            return;
        }
        if (terrainProc->windowQuadrant == (-1))
        {
            return;
        }
        Proc_Break(proc);
    }
}

extern int NotificationWindow_DisplayFrames;
void NotificationWindow_Loop_Display(struct NotificationWindowProc * proc)
{
    if (CheckNotificationInterrupted(proc))
    {
        NotificationWindowClean(proc);
        Proc_Goto(proc, EnqueueLabel); // print faster this time
        return;
    }
    NotificationWindow_LoopDrawText(proc);

    if (proc->finishedPrinting)
    {

        proc->unitClock++;
        if (proc->unitClock > NotificationWindow_DisplayFrames)
        {
            NotificationWindowClean(proc);
            if (!proc->showingBgm)
            {
                proc->queue[proc->id] = 0xFF;
                proc->id = GetTakenQueueSlot(proc);
                proc->fastPrint = false;
                // proc->id++;
            }
            Proc_Goto(proc, StartLabel);
            return;
        }
    }
}
