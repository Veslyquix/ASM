
#include <string.h>

#define brk asm("mov r11, r11");

struct NotificationsStruct
{
    const char * text;
    u16 textID;
    u16 flag;
    u8 colour[4];
};
extern const struct NotificationsStruct gNotificationsData[];

extern struct ProcCmd gProcScr_UnitDisplay_MinimugBox[];
extern struct ProcCmd gProcScr_TerrainDisplay[];
extern struct ProcCmd sProc_Menu[];

extern s8 sGoalSlideInWidthLut[5];
extern s8 sGoalSlideOutWidthLut[3];
extern int GetCursorQuadrant();
extern int GetWindowQuadrant(int, int);
extern void sub_808D514(int quadrant, int param_2, int param_3);

int IsNotificationActive(struct NotificationWindowProc * proc)
{
    return proc->active;
}
int CheckInSaveScreen(void)
{
    // if (GetGameControl()->nextAction == LGAMECTRL_POST_NORMAL_CHAPTER)
    if (HasNextChapter())
    {
        return true;
    }
    // if (Proc_Find((void *)Make6C_SaveMenuPostChapter)) // gProcScr_SaveMenuPostChapter
    // {
    // return true;
    // }
    return false;
}

int IdleForNow(struct NotificationWindowProc * proc, int frames)
{
    proc->delayFrames = frames;

    return true;
}

int IsScreenDark(struct NotificationWindowProc * proc)
{
    int result = false;
    if (proc->delayFrames > 0)
    {
        proc->delayFrames--;
        result = true;
    }

    if (sPalFadeSt[0].clock_end && sPalFadeSt[0].clock_end != 0x100)
    {
        // brk;
        return IdleForNow(proc, 100);
    }
    if (FadeExists())
    {
        return IdleForNow(proc, 100);
    }

    if (gLCDControlBuffer.blendY >= 5) // we're at least 5/16ths faded - FadeToCommon_OnLoop
    {                                  // [202b6d8..202b6dd]!!
        // brk;
        return IdleForNow(proc, 100);
    }

    // u32 * data = (void *)gPaletteBuffer;
    u32 * data = (void *)PLTT;
    int faded = true;
    for (int i = 0; i < 15; ++i)
    {
        if (data[i] && data[i] != 0xFFFFFFFF)
        {
            faded = false;
            break;
        }
    }
    if (faded)
    {
        return IdleForNow(proc, 100);
    }

    return result;
}
extern struct ProcCmd const gProcScr_SaveMenuPostChapter[];
// on player phase, during battles, and during conversations
int CanNotifsDisplayCurrently(struct NotificationWindowProc * proc, struct Proc * playerPhase)
{
    if (proc->delayFrames)
    {
        proc->delayFrames--;
        return false;
    }
    int result = false;
    if (playerPhase && !playerPhase->proc_lockCnt)
    {
        result = true; // player phase, no blocking
    }
    if (Proc_Find(sProcScr_CombatAction))
    {
        result = true;
    }
    // if (Proc_Find(gProcScr_Talk))
    // {
    // result = true;
    // }
    if (Proc_Find(gProcScr_SaveMenuPostChapter))
    {
        if (!proc->initDelay)
        {
            proc->initDelay = true;
            brk;
            proc->delayFrames = 100;
            return false;
        }
        result = true;
    }

    if (Proc_Find(sProc_Menu))
    {
        return false; // no menus
    }
    if (FadeExists() || DoesBMXFADEExist())
    {
        return false; // fading
    }

    return result;
}

int CheckNotificationConflict(struct NotificationWindowProc * proc, struct Proc * playerPhase)
{ // interrupted or should just not display
    return !CanNotifsDisplayCurrently(proc, playerPhase);
    if (*DebuggerProcCmd && Proc_Find((void *)&DebuggerProcCmd))
    {
        return true;
    }
    if (Proc_Find(sProc_Menu))
    {
        return true;
    }
    if (HasNextChapter()) // save screen
    {
        if (playerPhase && !playerPhase->proc_lockCnt)
        {
            SetNextChapterId(0);
        }
        return true;
    }
    // if (IsScreenDark(proc))
    // {
    // return true;
    // }

    // if (EventEngineExists()) // doesn't include battle event engine
    // {
    // return IdleForNow(proc, 100);
    // }
    return false;
}

struct ProcCmd const gProcScr_NotificationWindow[];
void WhileNotificationActive(struct PlayerInterfaceProc * parent)
{
    struct Proc * playerPhase = Proc_Find(gProcScr_PlayerPhase);
    struct NotificationWindowProc * proc = Proc_Find(gProcScr_NotificationWindow);
    if (CheckNotificationConflict(proc, playerPhase))
    // ((playerPhase) && (playerPhase->proc_lockCnt))) // player phase has a blocking proc (such as the debugger)
    {
        Proc_End(parent); // do not start player phase side windows
        return;
    }

    if (!IsNotificationActive(proc))
    {
        // InitPlayerPhaseInterface needs to happen on the same frame that we
        // check for these procs / playphase blocking proc
        InitPlayerPhaseInterface();
        Proc_Break(parent); // start player phase side windows
    }
}

struct ProcCmd const New_gProcScr_SideWindowMaker[] = {
    PROC_END_IF_DUPLICATE, // fixes a nasty bug where text was being drawn to tile space twice
    PROC_WHILE(DoesBMXFADEExist), PROC_CALL(RestartNotificationProc), PROC_REPEAT(WhileNotificationActive), PROC_END,
};

#define StartLabel 0
#define LoopLabel 1
#define ClearGfxLabel 97
#define EnqueueLabel 98
#define EndLabel 99

struct ProcCmd const gProcScr_NotificationWindow[] = {
    PROC_NAME("NotificationWindow"),
    // PROC_15, // ?
    PROC_YIELD,
    PROC_LABEL(StartLabel),
    PROC_SLEEP(2),
    PROC_REPEAT(NotificationIdleWhileMenuEtc),
    PROC_SLEEP(2),

    PROC_CALL(NotificationWindow_Init),

    PROC_LABEL(LoopLabel),

    PROC_WHILE_EXISTS(ProcScr_CamMove),

    PROC_REPEAT(NotificationWindow_Loop_Display), // usually goes to ContinueToNextNotification

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
    struct Proc * playerPhase = Proc_Find(gProcScr_PlayerPhase);
    if (CheckNotificationConflict(proc, playerPhase))
    {
        return IdleForNow(proc, 2);
    }
    if (CheckInBattleAnim())
    {
        return result;
    }

    // if (GetGameLock())
    // {
    // return IdleForNow(proc, 2);
    // }
    // playerCursorDisplay
    if (!proc->spriteText)
    {
        // sprite text appears over the minimug box, so not an issue
        if (gBmMapUnit[gBmSt.playerCursor.y][gBmSt.playerCursor.x])
        // if (gBmMapUnit[gBmSt.playerCursor.y][gBmSt.playerCursor.x] ||
        // gBmMapUnit[gBmSt.cursorPrevious.y][gBmSt.cursorPrevious.x])

        { // then minimug will show up
            struct PlayerInterfaceProc * mmb = Proc_Find(gProcScr_UnitDisplay_MinimugBox);

            if (mmb)
            {
                if (mmb->windowQuadrant == 0) // top left
                {
                    return IdleForNow(proc, 2);
                }

                // if (mmb->isRetracting || mmb->showHideClock)
                // {
                // return IdleForNow(proc, 2);
                // }
            }
        }
    }

    // struct Proc * playerPhase = Proc_Find(gProcScr_PlayerPhase);
    // if (playerPhase)
    // {
    // if (playerPhase->proc_lockCnt) // player phase has a blocking proc (such as the debugger)
    // {
    // return IdleForNow(proc, 2);
    // }
    // }

    return result;
}

void NotificationSetFastPrint(struct NotificationWindowProc * proc)
{
    proc->fastPrint = true;
}

// notifications eg. new BGM, ingame achievements, NG+ unlocks, or spam

// queue a notification
// display at start of enemy phase & when player interfaces like terrain/goal show up
// after x seconds, disappear
// if B is pressed twice, disappear
// if interrupted, enqueue again

// #define MAX_LINE_WIDTH 151
extern const int MAX_LINE_WIDTH;
#define CHAR_NEWLINE 1
#define CHAR_SPACE 0x20
#define SpriteTextBG
// draw text farther down in tile1 page
#define DefaultTextChr 0x80
#define NotificationChr 0x180

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
        if (proc->queue[i] != (-1))
        {
            return i;
        }
    }
    return (-1);
}

void NotificationInitVariables(struct NotificationWindowProc * proc)
{
    proc->initDelay = false;
    proc->fastPrint = false;
    // StartGreenText(proc);
    for (int i = 0; i < QueueSize; i++)
    {
        proc->queue[i] = (-1);
        proc->type[i] = 0; // notification type, or 1 = ACHIEVEMENT_TYPE
    }
}

void StartNotificationProc(int id, int type)
{
    struct NotificationWindowProc * proc = Proc_Find(gProcScr_NotificationWindow);
    if (!proc)
    {
        InitAchievementMenuSt();
        proc = Proc_Start(gProcScr_NotificationWindow, PROC_TREE_3);
        NotificationInitVariables(proc);
        int slot = GetFreeQueueSlot(proc);
        proc->active = true;
        proc->type[slot] = type;
        proc->queue[slot] = id;
        proc->id = slot;
        proc->bgm = 0xFFFF;
    }
    else
    {
        int slot = GetFreeQueueSlot(proc);
        proc->active = true;
        proc->type[slot] = type;
        proc->queue[slot] = id;
        proc->id = slot;
        Proc_Goto(proc, StartLabel);
    }
    proc->str = "Error";
    proc->strOriginal = "Error";
}

void DoNotificationsForFlag(int id)
{
    const struct NotificationsStruct * data = &gNotificationsData[0];
    int i = 0;
    while (data->text || data->textID)
    {
        if (data->flag == id)
        {
            StartNotificationProc(i, 0);
            // no break in case more than 1 notification is to display for the 1 flag
        }
        data++;
        i++;
    }
    return;
}

void DoNotificationForAchievement(int id)
{
    // const struct NotificationsStruct * data = &gNotificationsData[0];
    StartNotificationProc(id, 1);

    return;
}

void RestartNotificationProc(struct PlayerInterfaceProc * parent)
{
    struct NotificationWindowProc * proc = Proc_Find(gProcScr_NotificationWindow);
    if (!proc)
    {
        InitAchievementMenuSt();
        proc = Proc_Start(gProcScr_NotificationWindow, PROC_TREE_3);
        // proc = Proc_StartBlocking(gProcScr_NotificationWindow, parent);
        NotificationInitVariables(proc);
        proc->id = (-1); // bgm only
        proc->active = true;

        // int slot = GetFreeQueueSlot(proc); // show first notification for testing !
        // proc->type[slot] = 0;              // flag           // show first notification for testing !
        // proc->queue[slot] = 0;             // show first notification for testing !
        // proc->id = slot;                   // show first notification for testing !

        proc->bgm = 0xFFFF;
    }
    else
    {
        proc->active = true;
        Proc_Goto(proc, StartLabel); // maybe ?
    }
    proc->str = "Error";
    proc->strOriginal = "Error";
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

int CheckInMapBattle(void)
{
    if (Proc_Find(ProcScr_MapAnimBattle))
    {
        return true;
    }
    return false;
}

int CheckInBattleAnim(void)
{
    struct ProcEkrBattle * battleProc = gpProcEkrBattle;
    if (!battleProc)
    {
        return false;
    } // 0 after suspend until battle start
    // if (!proc->anim2)
    // {
    // return false;
    // }
    if (gEkrBattleEndFlag)
    {
        return false;
    } // 0 after suspend until battle done
    return true;
}

int ShowBgm(struct NotificationWindowProc * proc)
{
    int songID = GetCurrentBgmSong();
    if (songID == proc->bgm)
    {
        return false;
    }
    proc->bgm = songID;
    if (CheckInBattleAnim())
    {
        return false;
    }
    return !CheckFlag(DisableBGMNotificationsFlag);
}

void NotificationWindow_Idle(struct NotificationWindowProc * proc)
{
    if (ShowBgm(proc))
    {
        Proc_Goto(proc, StartLabel);
    }
    else
    {
        proc->active = false;
    }
}

const char * GetNextNotificationStr(struct NotificationWindowProc * proc)
{
    const char * str = "";
    const struct NotificationsStruct * data = NULL;
    const struct AchievementsRomStruct * data2 = NULL;
    int id = GetNotificationId(proc);
    if (id != (-1))
    {
        if (proc->type[proc->id] == ACHIEVEMENT_TYPE)
        {
            data2 = &gAchievementsTable[id];
        }
        data = &gNotificationsData[id];
    }
    else if (ShowBgm(proc))
    {
        proc->showingBgm = true;
        return GetPlayingBGMName(proc);
    }

    if (proc->type[proc->id] == ACHIEVEMENT_TYPE)
    {
        if (!data2 || (data2->entryName == NULL))
        {
            return NULL;
        }

        str = data2->entryName;
        for (int i = 0; i < 4; i++)
        {
            proc->colour[i] = 0;
        }
    }
    else
    {
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
    }

    return str;
}

extern struct Font * gActiveFont;

// if CheckInSaveScreen()
// wait until Proc_Find((void *)Make6C_SaveMenuPostChapter))
// to decompress / apply palette

int GetSpriteTextCHR(struct NotificationWindowProc * proc)
{
    if (CheckInSaveScreen())
    {
        return 0x200;
    }
    if (CheckInBattleAnim())
    {
        return 0xC0;
        // return 0x140;
    }

    return NotificationChr;
}
#define NotificationObjPalID 0x15
int GetNotifObjPalID(void)
{
    if (CheckInSaveScreen())
    {
        return 0x19;
    }
    if (CheckInBattleAnim())
    {
        return 0x12;
    }
    if (CheckInMapBattle())
    {
        return 0x16;
    }

    return 0x15;
}

void * GetSpriteTextVRAM(struct NotificationWindowProc * proc)
{
    return VRAM + (void *)0x10000 + (GetSpriteTextCHR(proc) << 5);
}

void ClearNotificationText(struct NotificationWindowProc * proc, struct Text * text, int tileWidth, int line)
{
    struct Font * font = gActiveFont;
    SetTextFont(&gHelpBoxSt.font); // use our own chr_counter

    if (proc->spriteText)
    {
        InitSpriteText(text);
#ifdef SpriteTextBG
        // SpriteText_DrawBackgroundExt(text, 0x44444444);
        // SpriteText_DrawBackgroundExt(text, 0);
        SpriteText_DrawBackground(text);
#else
        SpriteText_DrawBackgroundExt(text, 0);
#endif
    }
    else
    {
        InitText(text, tileWidth);
    }
    SetTextFont(font);
}
struct Text * GetTextHandleForLine(int line)
{
    // return &gHelpBoxSt.text[line]; // max 3 lines
    return &gLinkArenaSt.texts[line]; // max 11
    // return &gStatScreen.text[line]; // doesn't work in battle fsr
}
void NotificationWindow_LoopDrawText(struct NotificationWindowProc * proc)
{
    struct Font * font = gActiveFont;
    SetTextFont(&gHelpBoxSt.font); // use our own chr_counter
    if (!proc->fastPrint && (GetGameClock() & 1))
    {
        SetTextFont(font);
        return;
    }

    if (!proc->showingBgm)
    {
        if (proc->str == proc->strOriginal)
        {
            // brk;
        }
    }

    struct Text * th = GetTextHandleForLine(proc->line);

    proc->str = NotificationPrintText(proc, th, proc->str);

    if (!proc->str || !*proc->str)
    {
        proc->finishedPrinting = true;
    }
    SetTextFont(font);
}

int GetSpriteTextXPos(struct NotificationWindowProc * proc)
{
    return 10;
}
int GetSpriteTextYPos(struct NotificationWindowProc * proc)
{
    return 10;
}

int GetNotificationSpriteWindowWidth(struct NotificationWindowProc * proc);
void NotificationWindow_LoopDrawSpriteText(struct NotificationWindowProc * proc)
{
    int lines = proc->lines;
    int x = GetSpriteTextXPos(proc);
    int y = GetSpriteTextYPos(proc);
    DisplayNotifBoxObj(x, y, GetNotificationSpriteWindowWidth(proc), lines * 16, true);
    NotificationWindow_LoopDrawText(proc);
}
void BlendSprites(int spriteTransparency)
{
    gLCDControlBuffer.bldcnt.effect = BLEND_EFFECT_ALPHA;
    gLCDControlBuffer.bldcnt.target1_obj_on = 1;                    // Background being blended
    gLCDControlBuffer.bldcnt.target2_bd_on = 1;                     // Blend with backdrop
    gLCDControlBuffer.blendCoeffA = 16 - spriteTransparency;        // Strength of first layer
    gLCDControlBuffer.blendCoeffB = 16 - (16 - spriteTransparency); // Strength of second layer

    gLCDControlBuffer.dispcnt.bg3_on = 1;
    gLCDControlBuffer.dispcnt.obj_on = 1; // If blending objects
}
extern u8 gGfx_NotificationTextBox1[];
extern u8 gGfx_NotificationTextBox2[];
extern u8 gGfx_NotificationTextBox3[];
extern u8 gGfx_NotificationTextBox4[];
extern u8 gGfx_NotificationTextBox5[];
void NotificationInitSpriteText(void * vram)
{
    // InitTextFont(&gHelpBoxSt.font, (void *)(VRAM + (NotificationChr << 5)), NotificationChr, GetNotifObjPalID());
    InitSpriteTextFont(&gHelpBoxSt.font, vram, GetNotifObjPalID());
    SetTextFontGlyphs(1);
    // ApplyPalette(gUnknown_0859EF20, GetNotifObjPalID());

    Decompress(gGfx_NotificationTextBox1, vram + 0x360);
    Decompress(gGfx_NotificationTextBox2, vram + 0x760);
    Decompress(gGfx_NotificationTextBox3, vram + 0xb60);
    Decompress(gGfx_NotificationTextBox4, vram + 0xf60);
    Decompress(gGfx_NotificationTextBox5, vram + 0x1360);
    gHelpBoxSt.oam2_base = (((u32)vram << 0x11) >> 0x16) + (GetNotifObjPalID() & 0xF) * 0x1000;
    // ApplyPalette(Pal_HelpBox, GetNotifObjPalID());
    ApplyPalette(gPal_HelpTextBox, GetNotifObjPalID());
    BlendSprites(2);
}

void NotificationWindow_Init(struct NotificationWindowProc * proc)
{
    proc->showingBgm = false;
    proc->spriteText = true;
    proc->lines = 1;

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

    // proc->spriteText = false;
    proc->delayFrames = 0;
    proc->finishedPrinting = false;
    proc->active = true;
    proc->str = (void *)str;
    proc->strOriginal = (void *)str;
    proc->unitClock = 0;
    struct Font * font = gActiveFont;
    int chr = GetSpriteTextCHR(proc);
    InitTextFont(&gHelpBoxSt.font, (void *)(VRAM + (chr << 5)), chr, GetNotifObjPalID());

    if (proc->spriteText)
    {

        // ResetText();
        // ResetTextFont();
        // brk;
        void * vram = GetSpriteTextVRAM(proc);
        NotificationInitSpriteText(vram);
    }
    int len = GetNotificationStringTextLenASCII_Wrapped(str);
    int tileWidth = (len + 7) >> 3;
    proc->line = 0;
    proc->lines = CountStrLines(str);
    if (!proc->spriteText)
    {
        NotificationWindowDraw(proc);
    }
    struct Text * th = GetTextHandleForLine(0);

    for (int i = 0; i < proc->lines; i++)
    {
        ClearNotificationText(proc, &th[i], tileWidth, i);
    }
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
        if (!proc->spriteText)
        {
            PutText(&th[i], &gBG0TilemapBuffer[TILEMAP_INDEX(1, 1 + (i * 2))]);
        }
    }
    SetTextFont(font);
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

        // if word doesn’t fit, we've hit the max width
        if (curX > 0 && curX + wordWidth > MAX_LINE_WIDTH)
        {
            return MAX_LINE_WIDTH;
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
    int forceNewLine = false;

    int nextWordWidth = 0;

    while (*iter > CHAR_NEWLINE)
    {

        curX = Text_GetCursor(th); // current x position
        if (proc->spriteText && !curX)
        {
            // InitSpriteText(th);

            // SpriteText_DrawBackgroundExt(th, 0); // clears the vram obj behind the sprite text
        }
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

        iter = (void *)Text_DrawCharacterAscii(th, (void *)iter);
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
int GetNotificationSpriteWindowWidth(struct NotificationWindowProc * proc)
{
    int width = ((GetNotificationStringTextLenASCII_Wrapped(proc->strOriginal) + 7));
    if (width > MAX_LINE_WIDTH)
    {
        width = MAX_LINE_WIDTH;
    }
    return width + 24;
}

int GetNotificationWindowHeight(struct NotificationWindowProc * proc)
{
    return (proc->lines * 2) + 2;
}

void NotificationWindowClean(struct NotificationWindowProc * proc)
{

    if (proc->spriteText)
    {
        CpuFastFill(0, GetSpriteTextVRAM(proc), 0x800 * proc->lines);
        BlendSprites(0);
    }
    else
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

void NotificationIdleWhileMenuEtc(struct NotificationWindowProc * proc)
{

    if (CheckInBattleAnim())
    {
        Proc_Break(proc);
        return;
    }

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
    }
    Proc_Break(proc);
}

void ContinueToNextNotification(struct NotificationWindowProc * proc)
{
    NotificationWindowClean(proc);
    if (!proc->showingBgm)
    {
        proc->queue[proc->id] = (-1);
        proc->id = GetTakenQueueSlot(proc);
        proc->fastPrint = false;
        // proc->id++;
    }
    Proc_Goto(proc, StartLabel);
    return;
}

extern int NotificationWindow_DisplayFrames;
void NotificationWindow_Loop_Display(struct NotificationWindowProc * proc)
{
    if (CheckNotificationInterrupted(proc))
    {
        if (proc->finishedPrinting)
        {
            ContinueToNextNotification(proc);
            return;
        }
        else
        {
            NotificationWindowClean(proc);
            Proc_Goto(proc, EnqueueLabel); // print faster this time
            return;
        }
    }
    if (proc->spriteText)
    {
        NotificationWindow_LoopDrawSpriteText(proc);
    }
    else
    {
        NotificationWindow_LoopDrawText(proc);
    }
    if (proc->finishedPrinting)
    {
        proc->unitClock++;
        if (proc->unitClock > NotificationWindow_DisplayFrames)
        {
            ContinueToNextNotification(proc);
        }
    }
}

void DisplayNotifBoxObj(int x, int y, int w, int h, int hideHelpText)
{
    s8 flag;
    s8 flag_;
    s8 anotherFlag;

    int xCount;
    int yCount;

    int xPx;
    int yPx;
    int iy;
    int ix;

    flag = (w + 7) & 0x10;
    anotherFlag = w & 0xf;

    if (w < 0x20)
    {
        w = 0x20;
    }

    if (w > 0xC0)
    {
        w = 0xc0;
    }

    if (h < 0x10)
    {
        h = 0x10;
    }

    if (h > 0x60)
    {
        h = 0x60;
    }

    xCount = (w + 0x1f) / 0x20;
    yCount = (h + 0x0f) / 0x10;

    flag_ = flag;

    for (ix = xCount - 1; ix >= 0; ix--)
    {
        for (iy = yCount; iy >= 0; iy--)
        {

            yPx = (iy + 1) * 0x10;
            if (yPx > h)
            {
                yPx = h;
            }
            yPx -= 0x10;

            xPx = (ix + 1) * 0x20;

            if (flag_ != 0)
            {
                xPx -= 0x20;
                PutSprite(0, x + xPx, y + yPx, gObject_16x16, gHelpBoxSt.oam2_base + ix * 4 + iy * 0x40);
            }
            else
            {

                if (xPx > w)
                    xPx = w;

                xPx -= 0x20;

                PutSprite(0, x + xPx, y + yPx, gObject_32x16, gHelpBoxSt.oam2_base + ix * 4 + iy * 0x40);
            }
        }

        flag_ = 0;
    }

    flag_ = flag;

    for (ix = xCount - 1; ix >= 0; ix--)
    {
        xPx = (ix + 1) * 0x20;

        if (flag_ != 0)
        {
            xPx -= 0x20;

            PutSprite(0, x + xPx, y - 8, gObject_16x8, gHelpBoxSt.oam2_base + 0x1b);
            PutSprite(0, x + xPx, y + h, gObject_16x8, gHelpBoxSt.oam2_base + 0x3b);

            flag_ = 0;
        }
        else
        {
            if (xPx > w)
            {
                xPx = w;
            }
            xPx -= 0x20;

            PutSprite(0, x + xPx, y - 8, gObject_32x8, gHelpBoxSt.oam2_base + 0x1b);
            PutSprite(0, x + xPx, y + h, gObject_32x8, gHelpBoxSt.oam2_base + 0x3b);
        }
    }

    for (iy = yCount; iy >= 0; iy--)
    {
        yPx = (iy + 1) * 0x10;
        if (yPx > h)
        {
            yPx = h;
        }
        yPx -= 0x10;

        PutSprite(0, x - 8, y + yPx, gObject_8x16, gHelpBoxSt.oam2_base + 0x5f);
        PutSprite(0, x + w, y + yPx, gObject_8x16, gHelpBoxSt.oam2_base + 0x1f);

        if (anotherFlag != 0)
        {
            PutSprite(0, x + w - 8, y + yPx, gObject_8x16, gHelpBoxSt.oam2_base + 0x1a);
        }
    }

    PutSprite(0, x - 8, y - 8, gObject_8x8, gHelpBoxSt.oam2_base + 0x5b); // top left
    PutSprite(0, x + w, y - 8, gObject_8x8, gHelpBoxSt.oam2_base + 0x5c); // top right
    PutSprite(0, x - 8, y + h, gObject_8x8, gHelpBoxSt.oam2_base + 0x5d); // bottom left
    PutSprite(0, x + w, y + h, gObject_8x8, gHelpBoxSt.oam2_base + 0x5e); // bottom right

    if (anotherFlag != 0)
    {
        PutSprite(0, x + w - 8, y - 8, gObject_8x8, gHelpBoxSt.oam2_base + 0x1b);
        PutSprite(0, x + w - 8, y + h, gObject_8x8, gHelpBoxSt.oam2_base + 0x3b);
    }

    if (hideHelpText == 0)
    {
        PutSprite(0, x, y - 0xb, gObject_32x16, (0x3FF & gHelpBoxSt.oam2_base) + 0x7b);
    }

    return;
}
