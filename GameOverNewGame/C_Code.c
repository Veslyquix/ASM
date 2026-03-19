#include "C_Code.h"

extern int StartNewGameOnGameOver_Link;
const struct ProcCmd VeslyGameOverWrapper[];
const struct ProcCmd VeslyGameOverProc[];
const struct ProcCmd VanillaGameOverProcCopy[];
extern const u16 * GameOverEventTable[];
extern int InitWM;
extern int InitSupply;
extern int InitChars;
extern int InitTime;
extern int InitGold;
int ShouldInitAll(void)
{

    return InitWM && InitSupply && InitChars && InitTime && InitGold;
}
static void sub_8009C5C_(void)
{
    int gold = gPlaySt.partyGoldAmount;
    int id = (-1);
    struct PlaySt play_st;

    if (IsValidSuspendSave(SAVE_ID_SUSPEND))
    {
        ReadSuspendSavePlaySt(SAVE_ID_SUSPEND, &play_st);

        id = play_st.gameSaveSlot;
    }
    if (id < 0)
    {
        id = ReadLastGameSaveId();
    }
    int isTutorial = gPlaySt.config.controller; // see InitPlayConfig
    int isDifficult = gPlaySt.chapterStateBits & PLAY_FLAG_HARD;
    if (InitWM)
        GmDataInit(); // wipe world map stuff

    InitPlayConfig(isDifficult, isTutorial); // gPlaySt stuff like difficulty
    // gPlaySt.chapterStateBits |= PLAY_FLAG_TUTORIAL; // Pre-Eirika/Ephraim route split
    ResetChapterFlags();

    // if (InitFlags) // WM stuff breaks without resetting flags
    ResetPermanentFlags();

    if (InitChars)
        InitUnits();

    gPlaySt.chapterIndex = 0;

    if (InitSupply)
        ClearSupplyItems();

    if (InitTime)
        SetGameTime(0);

    if (!InitGold)
        gPlaySt.partyGoldAmount = gold;

    if (ShouldInitAll())
        WriteNewGameSave(id, isDifficult, 1, isTutorial);
    else
        WriteGameSave(id);

    // WriteNewGameSave(int index, int isDifficult, int mode, int isTutorial)

    // gPlaySt.chapterIndex = proc->nextChapter;
    // ReadGameSave(ReadLastGameSaveId()); // added to restart the chapter for debugger
}

void VeslyStartNewGame(void)
{

    struct GameCtrlProc * proc = Proc_Find(gProcScr_GameControl);

    proc->unk_2E = 20; // ?
    sub_8009C5C_();
    Proc_Goto(proc, LGAMECTRL_EXEC_BM);
}

void StartNewGameOverWrapper(ProcPtr proc)
{
    ProcPtr phaseProc = Proc_Find(gProcScr_PlayerPhase);
    if (!phaseProc)
    {
        phaseProc = Proc_Find(gProcScr_CpPerform);
    }
    // normally the game over proc is a child of event engine, which blocks player/enemy phase
    // we need to unblock the event engine, so this must be a child of player/enemy phase
    // (this is so suspend isn't overwritten here)
    Proc_StartBlocking(VeslyGameOverWrapper, phaseProc);
}

void StartNewGameOverProc(ProcPtr proc)
{

    if (StartNewGameOnGameOver_Link)
    {
        Proc_Start(VeslyGameOverProc, (void *)3);
    }
    else
    {
        Proc_Start(VanillaGameOverProcCopy, (void *)3);
    }
}

void GameOver_HookCommon(ProcPtr proc)
{
    EndAllMus();
    // SetNextGameActionId(GAME_ACTION_B); // GAME_ACTION_EVENT_RETURN
    //
    DeleteEventEngines();

    VeslyStartNewGame();
}
struct VeslyGameOver
{
    PROC_HEADER;
    u8 fadedIn;
    u8 chapterID;
};
void GameOverInit(struct VeslyGameOver * proc)
{
    proc->fadedIn = false;
    proc->chapterID = gPlaySt.chapterIndex;
}
int GameOver_Event(struct VeslyGameOver * proc)
{
    if (GameOverEventTable[proc->chapterID])
    {
        // CallEvent(GameOverEventTable[gPlaySt.chapterIndex], EV_EXEC_GAMEPLAY);
        CallEvent(GameOverEventTable[proc->chapterID], EV_EXEC_QUIET);
    }
    return 0;
}

void GameOver_Fade(struct VeslyGameOver * proc)
{

    if ((PLAY_FLAG_TUTORIAL & gPlaySt.chapterStateBits) || 0 == gPlaySt.config.disableBgm)
        Sound_FadeOutBGM(4);
    if (!FadeExists() && !proc->fadedIn)
    {
        StartMidFadeToBlack();
    }
}

void VeslyEventEngineExists(struct VeslyGameOver * proc)
{
    // check if the event engine fades to black. If it does, no need to fade after the event is done
    struct EventEngineProc * evProc = Proc_Find(ProcScr_StdEventEngine);
    if (evProc)
    {

        if (evProc->evStateBits & EV_STATE_FADEDIN)
        {
            proc->fadedIn = true;
        }
        else
        {
            proc->fadedIn = false;
        }
    }
    else
    {
        Proc_Break(proc);
    }
}

void WaitForGameOverProc(ProcPtr proc)
{
    if (Proc_Find(VeslyGameOverProc) || Proc_Find(VanillaGameOverProcCopy))
    {
        return;
    }
    Proc_Break(proc);
}
const struct ProcCmd VeslyGameOverWrapper[] = {
    PROC_NAME("VeslyGameOverWrapper"), PROC_YIELD, PROC_CALL(StartNewGameOverProc),
    PROC_REPEAT(WaitForGameOverProc),  PROC_END,

};

const struct ProcCmd VeslyGameOverProc[] = {
    PROC_NAME("VeslyGameOverProc"),
    PROC_YIELD,
    PROC_CALL(GameOverInit),
    PROC_CALL(GameOver_HookCommon),
    PROC_CALL(GameOver_Event),
    PROC_SLEEP(1),
    PROC_REPEAT(VeslyEventEngineExists),
    PROC_CALL(GameOver_Fade),
    PROC_REPEAT(WaitForFade),
    PROC_CALL(EndBMapMain), // this has to be after the event, otherwise the event breaks
    PROC_END,
};

const struct ProcCmd VanillaGameOverProcCopy[] = {
    PROC_YIELD,
    PROC_CALL(GameOverInit),
    PROC_CALL(GameOver_Event),
    PROC_SLEEP(1),
    PROC_REPEAT(VeslyEventEngineExists),
    // PROC_WHILE(EventEngineExists),

    PROC_CALL(GameOver_Fade),
    PROC_REPEAT(WaitForFade),
    // PROC_CALL(GameOver_FadeOutCurrentBgm),
    // PROC_SLEEP(0xA),
    // PROC_CALL(StartSlowFadeToBlack),
    // PROC_SLEEP(0x50),
    PROC_CALL(EndAllMus),
    PROC_CALL(SkilGameOverForToturialExtraMap),
    PROC_CALL(StartGameOverScreen),
    PROC_YIELD,

    PROC_LABEL(0x0),
    PROC_CALL(PostGameOverHandler),
    PROC_END,
};

/*
[OpenMidLeft][LoadFace][0x164][OpenMidLeft]Try placing units on [ToggleRed]Forts[ToggleRed]
and healing with [ToggleRed]Vulneraries[ToggleRed].[A]
Don't lose hope![A]
*/
