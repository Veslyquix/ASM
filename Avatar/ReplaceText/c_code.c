
#include "headers/prelude.h"
#include "headers/types.h"
#define ABS(aValue) ((aValue) >= 0 ? (aValue) : -(aValue))
extern u8 gCh;
extern int CheckFlag(int flag);
struct ReplaceTextStruct
{
    // conditions
    u16 flag;
    u8 chapterID;
    u8 pad;
    const char * find;
    const char * replace;
};
extern struct ReplaceTextStruct ReplaceTextList[];
#define TextBufferSize 0x1000
#define ListSize 255
extern char sMsgString[0x1000]; // fe7 202A5B4
extern u32 u32MsgString[0x400];
extern void SetMsgTerminator(char * str);
extern int Arm_DecompText(const char *, char *, u32 addr);
extern void (*gARM_DecompText)(const char *, char *); // fe8 3004150 fe7 3003940 fe6 3003780
extern void CallARM_DecompText(const char * a, char * b);
extern const u8 *** const ggMsgStringTable; // a2a0 is POIN TextTable
extern int sActiveMsg;

/*
char * GetStringFromIndex(int index) // so we can set sActiveMsg as the index
{
    // if (index == sActiveMsg)
    // return sMsgString.buffer1;
    sActiveMsg = index;
    CallARM_DecompText((void *)ggMsgStringTable[index], sMsgString);
#ifdef FE8
    SetMsgTerminator(sMsgString);
#endif
    return sMsgString;
}
*/
int GetStringLength(const char * str)
{
    for (int i = 0; i < 0x1000; ++i)
    {
        if (!str[i])
            return i;
    }
    return 0;
}
int GetEndOfBuffer(char * buffer)
{
    for (int i = 0; i < 0x1000; ++i)
    {
        if (!buffer[i])
        {
            return i;
        }
    }
    return 0;
}
void ShiftDataInBuffer(char * buffer, int amount, int offset, int usedBufferLength[])
{
    if (amount == 0)
        return;

    int length = usedBufferLength[0];

    // Sanity check
    if (offset < 0 || offset > length)
        return;

    if (amount < 0)
    {
        // Left shift
        int absAmount = -amount;

        if (offset + absAmount > length)
            return; // Prevent invalid read

        int bytesToMove = length - (offset + absAmount);

        // Manual safe copy: shift left
        for (int i = 0; i < bytesToMove; ++i)
        {
            buffer[offset + i] = buffer[offset + absAmount + i];
        }

        // Zero the trailing garbage
        for (int i = length - absAmount; i < length; ++i)
        {
            buffer[i] = 0;
        }

        usedBufferLength[0] -= absAmount;
    }
    else
    {
        // Right shift
        if (length + amount >= 0x1000)
            return;

        int bytesToMove = length - offset;

        // Manual safe copy: shift right (back to front to avoid overwrite)
        for (int i = bytesToMove; i >= 0; --i)
        {
            buffer[offset + amount + i] = buffer[offset + i];
        }

        // Zero the gap we created
        for (int i = offset; i < offset + amount; ++i)
        {
            buffer[i] = 0;
        }

        usedBufferLength[0] += amount;
    }

    // Optional: null-terminate buffer (if treated as a C string)
    buffer[usedBufferLength[0]] = 0;
}

void ShiftDataInBufferSmall(char * buffer, int amount, int offset, int usedBufferLength[])
{
    if (amount == 0)
        return;

    int length = usedBufferLength[0];

    if (amount < 0)
    {
        int absAmount = -amount;

        if (offset + absAmount > length)
            return;

        int bytesToMove = length - (offset + absAmount);
        for (int i = 0; i < bytesToMove; ++i)
        {
            buffer[offset + i] = buffer[offset + absAmount + i];
        }

        for (int i = length - absAmount; i < length; ++i)
        {
            buffer[i] = 0;
        }

        usedBufferLength[0] -= absAmount;
    }
    else
    {
        if (length + amount >= 0x1000)
            return;

        for (int i = length; i >= offset; --i)
        {
            buffer[i + amount] = buffer[i];
        }

        for (int i = offset; i < offset + amount; ++i)
        {
            buffer[i] = 0;
        }

        usedBufferLength[0] += amount;
    }
}

int ReplaceIfMatching(int usedBufferLength[], const char * find, const char * replace, int c, char * b)
{

    int i;
    char * buffer = &b[c];
    if (!find[0])
        return 0;

    for (i = 0; find[i]; ++i) // while find[i] is non-zero (eg. a character), compare
    {
        if (buffer[i] != find[i])
            return 0; // mismatch
    }

    int len2 = GetStringLength(replace);
    int bufLength = usedBufferLength[0];
    if (len2 != bufLength)
    {
        if (bufLength < 16)
        {
            ShiftDataInBufferSmall(b, len2 - i, c, usedBufferLength);
        }
        else
        {
            ShiftDataInBuffer(b, len2 - i, c, usedBufferLength);
        }
    }

    for (i = 0; i < len2; ++i)
    {
        buffer[i] = replace[i];
    }
    return len2;
}
extern int ControlCodesStartWithBracket;
void CallARM_DecompText(const char * a, char * b) // 2ba4 // fe7 8004364 fe6 800384C
{
    // asm("mov r11, r11");
    int length[1] = { 0 };
    if ((int)a & 0x80000000)
    { // anti huffman
        a = (const char *)((int)a & 0x7FFFFFFF);
        for (int i = 0; i < 0x1000; ++i)
        {
            b[i] = a[i];
            if (!a[i])
            {
                length[0] = i;
                break;
            }
        }
    }
    else
    {
#ifdef FE8
        length[0] = Arm_DecompText(a, b, 0x3004150);
#endif
#ifdef FE7
        length[0] = Arm_DecompText(a, b, 0x3003940);
#endif
#ifdef FE6
        length[0] = Arm_DecompText(a, b, 0x3003780);
#endif
    }
#ifdef FE8
// SetMsgTerminator(b);
#endif
    if (length[0] < 0xFFF)
    {
        b[length[0]] = 0;
        b[length[0] + 1] = 0;
    }

    int replacedLen = 0;
    // asm("mov r11, r11");
    for (int i = 0; i < TextBufferSize; ++i)
    {
        if (!b[i])
        {
            return;
        }
        if (ControlCodesStartWithBracket && b[i] != 0x5B) // control codes to start with `[`
        {
            continue;
        }
        for (int c = 0; c < ListSize; ++c)
        {
            if (!b[i])
            {
                return;
            }
            if (!ReplaceTextList[c].find)
            {
                break;
            }
            if (ReplaceTextList[c].flag)
            {
                // asm("mov r11, r11");
                if (!CheckFlag(ReplaceTextList[c].flag))
                {
                    continue;
                }
            }
            if (ReplaceTextList[c].chapterID != 0xFF)
            {
                if (gCh != ReplaceTextList[c].chapterID)
                {
                    continue;
                }
            }

            replacedLen = ReplaceIfMatching(length, ReplaceTextList[c].find, ReplaceTextList[c].replace, i, b);
            if (replacedLen)
            {
                i += replacedLen - 1;
                break;
            }
        }
    }

    /*
        for (int c = 0; c < 255; ++c)
        {
            if (!ReplaceTextList[c].find)
            {
                break;
            }
            if (ReplaceTextList[c].flag)
            {
                if (!CheckFlag(ReplaceTextList[c].flag))
                {
                    continue;
                }
            }
            if (ReplaceTextList[c].chapterID != 0xFF)
            {
                if (gCh != ReplaceTextList[c].chapterID)
                {
                    continue;
                }
            }
            for (int i = 0; i < 0x555; ++i)
            {
                i = ReplaceIfMatching(length, ReplaceTextList[c].find, ReplaceTextList[c].replace, i, b);
                if (!b[i])
                {
                    break;
                }
            }
        }
        */

    // asm("mov r11, r11");
}