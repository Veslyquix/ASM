#include "C_Code.h"
#define EndLabel 99
#define brk asm("mov r11, r11");

extern int ProcsReqForErrorMsg;
extern int EmergencyHandlingNum;

extern const u16 EventScr_ErrorOccurred[];
extern void * sProcAllocList[65];
extern void * sProcAllocListHead;
extern void SetupDebugFontForOBJ(int a, int objPalNum);
extern void PrintDebugStringAsOBJ(int a, int b, const char * str);

const struct ProcCmd * Proc_FindMostCommonDuplicate(const char * str, u8 * count)
{
    int i, j;
    struct Proc * proc;
    const struct ProcCmd * mostCommonCmd = NULL;
    int mostCommonCount = 0;

    // We'll track seen ProcCmd pointers and their counts
    const struct ProcCmd * seen[65] = { 0 };
    int counts[65] = { 0 };
    int seenCount = 0;
    int start = ((int)sProcAllocListHead - (int)&sProcAllocList[0]) >> 2;
    for (i = start; i >= 0; i--)
    {
        proc = sProcAllocList[i];
        if (!proc || !proc->proc_script)
            continue;

        // Check if we've seen this cmd before
        for (j = 0; j < seenCount; j++)
        {
            if (seen[j] == proc->proc_script)
            {
                counts[j]++;
                if (counts[j] > mostCommonCount)
                {
                    mostCommonCount = counts[j];
                    mostCommonCmd = proc->proc_script;
                    str = proc->proc_name;
                }
                break;
            }
        }

        // If not seen, add to list
        if (j == seenCount)
        {
            seen[seenCount] = proc->proc_script;
            counts[seenCount] = 1;
            if (mostCommonCount == 0)
            {
                mostCommonCount = 1;
                mostCommonCmd = proc->proc_script;
                str = proc->proc_name;
            }
            seenCount++;
        }
    }
    count[0] = mostCommonCount;
    return mostCommonCmd;
}
struct ProcMonitor;
#define MAX_TRACKED_PROCS 5
struct ProcTrackerEntry
{
    const struct ProcCmd * proc;
    const char * str;
    u16 count;
};
typedef struct
{
    /* 00 */ PROC_HEADER;
    u8 peak;
    struct ProcTrackerEntry entries[MAX_TRACKED_PROCS];
} ProcMonitor;

static void SortProcMonitorEntries(ProcMonitor * monitor)
{
    for (int i = 0; i < MAX_TRACKED_PROCS - 1; i++)
    {
        for (int j = i + 1; j < MAX_TRACKED_PROCS; j++)
        {
            if (monitor->entries[j].count > monitor->entries[i].count)
            {
                // Swap entries[i] and entries[j]
                struct ProcTrackerEntry temp = monitor->entries[i];
                monitor->entries[i] = monitor->entries[j];
                monitor->entries[j] = temp;
            }
        }
    }
}

// Call this each frame

void ProcMonitor_UpdateEachFrame(ProcMonitor * monitor, const char * str, u8 * count)
{
    const struct ProcCmd * current = Proc_FindMostCommonDuplicate(str, count);
    if (!current)
        return;

    int i;
    int minIndex = 0;

    for (i = 0; i < MAX_TRACKED_PROCS; i++)
    {
        if (monitor->entries[i].proc == current)
        {
            // Update only if this frame's count is higher than what we had
            if (*count > monitor->entries[i].count)
            {
                monitor->entries[i].str = str;
                monitor->entries[i].count = *count;
            }
            SortProcMonitorEntries(monitor);
            return;
        }

        if (monitor->entries[i].proc == NULL)
        {
            monitor->entries[i].proc = current;
            monitor->entries[i].str = str;
            monitor->entries[i].count = *count;
            SortProcMonitorEntries(monitor);
            return;
        }

        if (monitor->entries[i].count < monitor->entries[minIndex].count)
            minIndex = i;
    }

    // Replace the lowest-count entry if this one is better
    if (*count > monitor->entries[minIndex].count)
    {
        monitor->entries[minIndex].proc = current;
        monitor->entries[minIndex].str = str;
        monitor->entries[minIndex].count = *count;
    }

    SortProcMonitorEntries(monitor);
    return;
}

extern void EndPlayerPhaseSideWindows(void);
void PrintErrorToScreen(ProcMonitor * proc)
{

    EndPlayerPhaseSideWindows();
    SetupDebugFontForOBJ(0, 15);
    // StartGreenText(proc);
}

const u8 hexTable[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };

char * HexToStr(u32 value, char * outStr)
{
    int started = 0;
    int outIndex = 0;

    for (int i = 7; i >= 0; --i)
    {
        u8 digit = (value >> (i * 4)) & 0xF;
        if (digit || started)
        {
            outStr[outIndex++] = hexTable[digit];
            started = 1;
        }
    }

    // Special case for 0
    if (!started)
        outStr[outIndex++] = '0';

    outStr[outIndex] = '\0';
    return outStr;
}

static const int DigitDecimalTable[] = { 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000 };

const u8 decTable[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

char * NumToStr(u32 value, char * outStr)
{
    int started = 0;
    int outIndex = 0;

    for (int i = 8; i >= 0; --i)
    {
        u32 place = DigitDecimalTable[i];
        u8 digit = value / place;
        if (digit || started)
        {
            outStr[outIndex++] = decTable[digit];
            started = true;
        }
        value -= place * digit;
    }

    // Special case for 0
    if (!started)
        outStr[outIndex++] = '0';

    outStr[outIndex] = '\0';
    return outStr;
}

void KillProcsWhenOutOfSpace(ProcMonitor * proc)
{
    if ((int)sProcAllocListHead > (int)&sProcAllocList[EmergencyHandlingNum])
    {
        Proc_EndEach(proc->entries[0].proc);
    }
}

void PrintErrorNumberToScreen(ProcMonitor * proc)
{
    if (!EventEngineExists())
    {
        Proc_Break(proc);
        return;
    }

    BG_Fill(gBG0TilemapBuffer, 0);
    BG_Fill(gBG1TilemapBuffer, 0);
    BG_Fill(gBG2TilemapBuffer, 0);
    BG_Fill(gBG3TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT | BG3_SYNC_BIT);

    ResetTextFont();
    SetTextFontGlyphs(0);
    SetTextFont(0);
    RegisterBlankTile(0);
    RegisterBlankTile(0x400);
    SetupDebugFontForOBJ(0, 15);
    const char * str = NULL;
    u8 count[1] = { 0 };
    ProcMonitor_UpdateEachFrame(proc, str, count);

    // char valueStr[9];

    // HexToStr(mostCommon, valueStr);
    char countStr[12];
    // HexToStr(count[0], countStr);
    int x = 3;
    int y = 7;

    int num = ((int)sProcAllocListHead - (int)&sProcAllocList[0]) / 4;
    if (proc->peak < num)
    {
        proc->peak = num;
    }
    // brk;
    if (*gBuildDateTime)
    {
        PrintDebugStringAsOBJ((x) << 3, (y - 2) << 3, gBuildDateTime);
    }
    PrintDebugStringAsOBJ((x) << 3, (y - 1) << 3, NumToStr(num, countStr));
    PrintDebugStringAsOBJ((x + 2) << 3, (y - 1) << 3, "/");
    PrintDebugStringAsOBJ((x + 3) << 3, (y - 1) << 3, NumToStr(64, countStr));
    PrintDebugStringAsOBJ((x + 7) << 3, (y - 1) << 3, "Most: ");
    PrintDebugStringAsOBJ((x + 13) << 3, (y - 1) << 3, NumToStr(proc->peak, countStr));
    for (int i = 0; i < MAX_TRACKED_PROCS; ++i)
    {
        if (proc->entries[i].str)
        {
            PrintDebugStringAsOBJ((x) << 3, (y + (i * 2)) << 3, proc->entries[i].str);
        }
        PrintDebugStringAsOBJ((x + 9) << 3, (y + (i * 2) + 1) << 3, NumToStr(proc->entries[i].count, countStr));
        PrintDebugStringAsOBJ((x) << 3, (y + (i * 2) + 1) << 3, HexToStr((int)proc->entries[i].proc, countStr));
    }
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT | BG3_SYNC_BIT);

    KillProcsWhenOutOfSpace(proc);
}

void CheckForProcSpace(ProcMonitor * proc)
{
    if ((int)sProcAllocListHead > (int)&sProcAllocList[ProcsReqForErrorMsg])
    {

        EndGreenText();

        LockGame();
        BMapDispSuspend();
        PrintErrorToScreen((void *)proc);
        CallEvent(EventScr_ErrorOccurred, 1);
        Proc_Goto((void *)proc, 1);
        PrintErrorNumberToScreen(proc);
    }
}

const struct ProcCmd ProcMonitorCmd[] = {
    PROC_NAME("MonitorProcs"),
    PROC_YIELD,
    PROC_REPEAT(CheckForProcSpace),
    PROC_GOTO(EndLabel),
    PROC_LABEL(1),
    PROC_SLEEP(10),
    PROC_REPEAT(PrintErrorNumberToScreen),
    // PROC_WHILE(),
    PROC_CALL(ClearBg0Bg1),
    PROC_CALL(UnlockGame),
    PROC_CALL(BMapDispResume),
    PROC_LABEL(EndLabel),
    PROC_END,
};

void StartProcMonitor(void)
{
    if (!Proc_Find(ProcMonitorCmd))
    {
        ProcMonitor * proc = Proc_Start(ProcMonitorCmd, (void *)3);
        proc->peak = 0;
    }
}

extern void APProc_OnUpdate(struct APProc * proc);
extern void APProc_OnEnd(struct APProc * proc);
struct ProcCmd const ProcScr_ApProc_New[] = {
    PROC_SET_END_CB(APProc_OnEnd),
    PROC_CALL(StartProcMonitor),
    PROC_REPEAT(APProc_OnUpdate),

    PROC_END,
};
