#include "C_Code.h"
#define EndLabel 99
#define brk asm("mov r11, r11");
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

/*
const struct ProcCmd * ProcMonitor_UpdateEachFrame(ProcMonitor * monitor, const char * str, u8 * count)
{
    const struct ProcCmd * current = Proc_FindMostCommonDuplicate(str, count);
    if (!current)
        return current;

    int i;
    int minIndex = 0;
    // Look for a match or empty spot
    for (i = 0; i < MAX_TRACKED_PROCS; i++)
    {
        if (monitor->entries[i].proc == current)
        {

            if (count > monitor->entries[i].count)
            {
                monitor->entries[i].str = str;
                monitor->entries[i].count = count;
            }
            // return current;
        }
        if (monitor->entries[i].proc == NULL)
        {
            monitor->entries[i].proc = current;
            monitor->entries[i].str = str;
            monitor->entries[i].count = 1;
            // return current;
        }
        // Track lowest-count entry in case we need to replace it
        if (monitor->entries[i].count < monitor->entries[minIndex].count)
            minIndex = i;
    }

    // If we got here, we need to possibly replace an entry
    // Optional: Only replace if count is 0 or 1 (to avoid churning)
    monitor->entries[minIndex].proc = current;
    monitor->entries[minIndex].str = str;
    monitor->entries[minIndex].count = 1;
    return current;
}
*/
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
    char countStr[9];
    // HexToStr(count[0], countStr);
    int x = 3;
    int y = 5;
    for (int i = 0; i < MAX_TRACKED_PROCS; ++i)
    {
        if (proc->entries[i].str)
        {
            PrintDebugStringAsOBJ((x) << 3, (y + (i * 2)) << 3, proc->entries[i].str);
        }
        PrintDebugStringAsOBJ((x + 9) << 3, (y + (i * 2) + 1) << 3, HexToStr(proc->entries[i].count, countStr));
        PrintDebugStringAsOBJ((x) << 3, (y + (i * 2) + 1) << 3, HexToStr((int)proc->entries[i].proc, countStr));
    }
    // PrintDebugStringAsOBJ(x << 3, y << 3, valueStr);
    // PrintDebugStringAsOBJ((x + 9) << 3, y << 3, countStr);

    // PutNumberHex(TILEMAP_LOCATED(gBG0TilemapBuffer, 10, 6), green, mostCommon);
    // PutNumberHex(TILEMAP_LOCATED(gBG1TilemapBuffer, 10, 6), green, mostCommon);
    // PutNumberHex(TILEMAP_LOCATED(gBG2TilemapBuffer, 10, 6), green, mostCommon);
    // PutNumberHex(TILEMAP_LOCATED(gBG0TilemapBuffer, 14, 6), green, count[0]);
    // PutNumberHex(TILEMAP_LOCATED(gBG1TilemapBuffer, 14, 6), green, count[0]);
    // PutNumberHex(TILEMAP_LOCATED(gBG2TilemapBuffer, 14, 6), green, count[0]);

    // PrintDebugStringAsOBJ(int a, int b, const char *str);
    // PutNumberHex(TILEMAP_LOCATED(gBG1TilemapBuffer, 14, 6), green, count);
    // PutNumberHex(TILEMAP_LOCATED(gBG2TilemapBuffer, 14, 6), green, count);
    if (str)
    {
        // PrintDebugStringAsOBJ(x << 3, (y + 2) << 3, str);
        // PutDrawText(gStatScreen.text, TILEMAP_LOCATED(gBG0TilemapBuffer, 10, 10), green, 0, 0, str);
        // PutDrawText(gStatScreen.text, TILEMAP_LOCATED(gBG1TilemapBuffer, 10, 10), green, 0, 0, str);
        // PutDrawText(gStatScreen.text, TILEMAP_LOCATED(gBG2TilemapBuffer, 10, 10), green, 0, 0, str);
    }
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT | BG3_SYNC_BIT);
}

void CheckForProcSpace(ProcMonitor * proc)
{
    if ((int)sProcAllocListHead > (int)&sProcAllocList[40])
    {
        EndGreenText();

        LockGame();
        BMapDispSuspend();
        PrintErrorToScreen((void *)proc);
        CallEvent(EventScr_ErrorOccurred, 1);
        Proc_Goto((void *)proc, 1);
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
        Proc_Start(ProcMonitorCmd, (void *)3);
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
