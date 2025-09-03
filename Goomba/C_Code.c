#include "C_Code.h"
#define brk asm("mov r11, r11");
extern const u8 GameboyRom[];
#define MaxGBSize (256 * 1024) // size of WRAM (256 kb)

static void SetBootType(int id);
static int GetBootType(void);
void LaunchGameboyRomASMC(void)
{
    if (GetBootType() == 3) // we already resumed
    {
        SetBootType(0);
        return;
    }
    SetBootType(3); // Resume immediately on reset

    // Disable interrupts
    REG_IME = 0;
    REG_IE = 0;
    // REG_IF = REG_IF;

    u8 * src = (u8 *)GameboyRom;
    u8 * dst = (u8 *)EWRAM_START;
    CpuFastCopy(src, dst, MaxGBSize);

    // // reset all ram etc except WRAM
    RegisterRamReset(
        RESET_IWRAM | RESET_PALETTE | RESET_VRAM | RESET_OAM | RESET_SIO_REGS | RESET_SOUND_REGS | RESET_REGS);

    asm volatile("mov sp, %0" ::"r"(0x03007F00)); // reset stack
    asm volatile("mov lr, %0" ::"r"(0x02000000)); // reset lr

    asm volatile("bx %0" ::"r"(0x02000000)); // jump to start of goomba

    while (1)
        ; // should never reach this and never return
}

// this stuff is copied from the debugger
static void SetBootType(int id)
{
    struct GlobalSaveInfo info;
    ReadGlobalSaveInfo(&info);
    info.charKnownFlags[0x1F] = id;
    WriteGlobalSaveInfoNoChecksum(&info);
}

static int GetBootType(void)
{
    struct GlobalSaveInfo info;
    ReadGlobalSaveInfo(&info);
    return info.charKnownFlags[0x1F];
}

static void sub_8009C5C_edit(struct GameCtrlProc * proc)
{
    // if (proc->nextAction == GAME_ACTION_5)
    // {
    // Proc_Goto(proc, 5);
    // return;
    // }

    // InitPlayConfig(0, 0); gPlaySt stuff like difficulty
    //  gPlaySt.chapterStateBits |= PLAY_FLAG_TUTORIAL;
    ResetPermanentFlags();
    ResetChapterFlags();
    InitUnits();
    gPlaySt.chapterIndex = proc->nextChapter;
    ReadGameSave(ReadLastGameSaveId()); // added
}
void GameControl_CallEraseSaveEventWithKeyCombo(ProcPtr aproc)
{
    struct GameCtrlProc * proc = (void *)aproc;
    if (gKeyStatusPtr->heldKeys == (L_BUTTON | DPAD_RIGHT | SELECT_BUTTON))
    {
        Proc_Goto(proc, LGAMECTRL_ERASE_SAVE);
    }
    else
    {
        int var = GetBootType();
        switch (var)
        {
            case 1:
            {
                // GmDataInit();
                proc->unk_2E = 20;
                sub_8009C5C_edit(proc);
                Proc_Goto(proc, LGAMECTRL_EXEC_BM);
                break;
            }
            // case 2:
            // {
            // // GmDataInit();
            // proc->unk_2E = 20;
            // sub_8009C5C_edit(proc);
            // Proc_Goto(proc, LGAMECTRL_EXEC_BM_EXT);
            // break;
            // } // Directly goto bmmap / skirmish
            case 2:
            {
                if (IsValidSuspendSave(SAVE_ID_SUSPEND))
                {
                    ReadSuspendSave(3);
                    // SetNextGameActionId(GAME_ACTION_4);
                    Proc_Goto(proc, 8);
                    break;
                }
            } // Resume ch
            case 3:
            {
                if (IsValidSuspendSave(SAVE_ID_SUSPEND))
                {
                    ReadSuspendSave(3);
                    // SetNextGameActionId(GAME_ACTION_4);
                    Proc_Goto(proc, 8);
                    break;
                }
            } // Resume ch once
            default:
        }
    }

    // 8 = resume
    //
}
