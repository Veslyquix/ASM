#include "C_Code.h" // headers 

void GameOverScreen_LoopIdle(struct ProcGameOverScreen *proc)
{
    if ((A_BUTTON | B_BUTTON | START_BUTTON) & gKeyStatusPtr->newKeys)
        Proc_Goto(proc, 0x63);
}
