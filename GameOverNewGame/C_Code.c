#include "C_Code.h"

extern int StartNewGameOnGameOver_Link;
const struct ProcCmd VeslyGameOverWrapper[];
const struct ProcCmd VeslyGameOverProc[];
const struct ProcCmd VanillaGameOverProcCopy[];
static void sub_8009C5C_(void)
{
    InitPlayConfig(0, 0);                           // gPlaySt stuff like difficulty
    gPlaySt.chapterStateBits |= PLAY_FLAG_TUTORIAL; // Pre-Eirika/Ephraim route split
    ResetPermanentFlags();
    ResetChapterFlags();
    InitUnits();
    gPlaySt.chapterIndex = 0;
    // gPlaySt.chapterIndex = proc->nextChapter;
    // ReadGameSave(ReadLastGameSaveId()); // added
}
extern const u16 PreGameOverEvent;
extern const u16 PostGameOverEvent;
void VeslyStartNewGame(void)
{
    GmDataInit(); // wipe stuff ?
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
    EndBMapMain();
    DeleteEventEngines();

    VeslyStartNewGame();

    // CallEvent(&PostGameOverEvent, EV_EXEC_GAMEPLAY);
}
struct VeslyGameOver
{
    PROC_HEADER;
    u8 fadedIn;
};
int GameOver_PreEvent(struct VeslyGameOver * proc)
{
    proc->fadedIn = false;
    // EndBMapMain();
    // DeleteEventEngines();
    CallEvent(&PreGameOverEvent, EV_EXEC_GAMEPLAY);
    return 0;
}

void VeslyEventEngineExists(struct VeslyGameOver * proc)
{
    struct EventEngineProc * evProc = Proc_Find(ProcScr_StdEventEngine);
    int fade = proc->fadedIn;
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
    if (fade != proc->fadedIn)
    {
        brk;
    }
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
    PROC_CALL(GameOver_PreEvent),
    PROC_SLEEP(1),
    // PROC_REPEAT(VeslyEventEngineExists),
    PROC_WHILE(EventEngineExists),
    PROC_CALL(GameOver_Fade),
    PROC_REPEAT(WaitForFade),
    PROC_CALL(GameOver_HookCommon),
    PROC_END,
};

const struct ProcCmd VanillaGameOverProcCopy[] = {
    PROC_YIELD,
    PROC_CALL_2(GameOver_PreEvent),
    // PROC_REPEAT(VeslyEventEngineExists),
    PROC_WHILE(EventEngineExists),

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
