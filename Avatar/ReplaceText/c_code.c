
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
extern char sMsgString[0x1000]; // fe7 202A5B4
extern u32 u32MsgString[0x400];
extern void SetMsgTerminator(char * str);
extern int Arm_DecompText(const char *, char *, u32 addr);
extern void (*gARM_DecompText)(const char *, char *); // fe8 3004150 fe7 3003940 fe6 3003780
extern void CallARM_DecompText(const char * a, char * b);

int GetStringLength(const char * str)
{
    for (int i = 0; i < 255; ++i)
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
    if (!amount)
    {
        return;
    }
    // int length = GetEndOfBuffer(buffer);
    int length = usedBufferLength[0];

    int i;
    if (amount < 0)
    {
        amount = ABS(amount);
        for (i = offset; i < length; ++i)
        {
            buffer[i] = buffer[i + amount];
        }
    }
    else
    {
        for (i = length; i >= offset; --i)
        {
            buffer[i + amount] = buffer[i];
        }
    }
    usedBufferLength[0] = length + amount;
}

int ReplaceIfMatching(int usedBufferLength[], const char * find, const char * replace, int c, char * b)
{
    int i;
    char * buffer = &b[c];

    // could string be in the next 4 bytes?
    if (!(c & 3))
    { // 4 aligned, as the buffers all start 4 aligned
        u32 search = find[0];
        u32 data = u32MsgString[c >> 2];
        if (((data & 0xFF) != search) && (((data & 0xFF00) >> 8) != search) && (((data & 0xFF0000) >> 16) != search) &&
            (((data) >> 24) != search))
        {
            return c + 4;
        }
    }

    for (i = 0; i < 255; ++i)
    {
        if (!find[i])
        {
            break;
        }
        if (buffer[i] != find[i])
        {
            return c;
        }
    }

    int len2 = GetStringLength(replace);
    ShiftDataInBuffer(b, len2 - i, c, usedBufferLength);

    for (i = 0; i < len2; ++i)
    {
        buffer[i] = replace[i];
    }
    return c;
}

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

    // asm("mov r11, r11");
}