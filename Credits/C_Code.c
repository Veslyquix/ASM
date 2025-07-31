#include "C_Code.h"
// //JOQUXY
extern ProcPtr StartClassNameIntroLetter(ProcPtr parent, u8 index);
#define brk asm("mov r11, r11");
typedef struct
{
    /* 00 */ PROC_HEADER;

    /* 29 */ u8 unk_29;
    signed char * str;
    signed char * str2;
} BigTextProc;

#define BigText_VRAMTile 0                                // 0x180
#define BigTextVRAM (0x6010000 + (BigText_VRAMTile << 5)) // 0x6010000
extern const u16 sSprite_08A2EF48[];
u16 const sSprite_08A2EF48_new[] = // see gSprite_UiSpinningArrows_Horizontal and sSprite_08A2EF48
    {
        1,                                  // number of entries
        OAM0_SHAPE_32x32 | OAM0_DOUBLESIZE, // 0x8300, // oam0 size
        OAM1_SIZE_32x32,                    // 0x8000, // oam1 size
        0x400                               // OAM2_CHR(BigText_VRAMTile + 0x20),
    };

extern u8 * const gUnknown_08A2F2C0[];
u16 BigFontInit(signed char * str, u16 offset)
{
    ApplyPalette(gUnknown_08A37300, 0x10);
    // ApplyPalette(gUnknown_08A30780, 0x1E);
    // ApplyPalette(gUnknown_08A30780, 0x1F);
    while (*str != 0)
    {
        Decompress((gUnknown_08A2F2C0[*str] != 0) ? gUnknown_08A2F2C0[*str] : gUnknown_08A2F2C0[0x58], gGenericBuffer);
        Copy2dChr(gGenericBuffer, (void *)(offset + BigTextVRAM), 2, 4);

        str++;
        offset += 0x40 + (((offset + 0x40) / 0x400) * 0xC00);
    }

    return offset;
}

void InitBigTextStr(BigTextProc * proc)
{
    u16 vramOffset = 0;
    signed char * str = (void *)GetStringFromIndex(0x2C0);
    vramOffset = BigFontInit(str, vramOffset);
    proc->str = str;
    str = (void *)GetStringFromIndex(0x2C1);
    vramOffset = BigFontInit(str, vramOffset);
    proc->str2 = str;
}

void PutSpriteExt(int layer, int xOam1, int yOam0, const u16 * object, int oam2);
extern void sub_80B2A14(u8 charId, int x, int y, u16 xScale, u16 yScale, u8 offset);
void PutBigLetter(u8 charId, int x, int y, u16 xScale, u16 yScale, u8 offset) // based on sub_80B2A14
{
    int i;
    int palID = 0;

    // if (yScale <= 8)
    // {
    // return;
    // }

    // if (xScale < 8)
    // {
    // xScale = 8;
    // }

    // SetObjAffine(
    // charId, Div(+COS(0) << 4, xScale), Div(-SIN(0) << 4, yScale), Div(+SIN(0) << 4, xScale),
    // Div(+COS(0) << 4, yScale));

    // if (offset != 0) {
    int layer = 2;
    // int oam2 = TILEREF(BigText_VRAMTile, 0) + OAM2_LAYER(layer);
    int oam2 = charId * 2 + OAM2_LAYER(layer); // + 0x800;
    // int oam2 = charId * 2 + (palID & 0xF) * 0x1000 + 0x800 + BigText_VRAMTile;
    // PutSpriteExt(4, (x & 0x1FF) + (charId << 9), y & 0x1FF, sSprite_08A2EF48, oam2);

    PutSpriteExt(4, (x & 0x1FF) + (charId << 9), y & 0x1FF, sSprite_08A2EF48, charId * 2 + (0 & 0xF) * 0x1000 + 0x400);
    // }

    // else { // first letter uses 0x400 instead of 0x800 for the oam2
    // PutSpriteExt(
    // 4,
    // (x & 0x1FF) + (charId << 9),
    // y & 0x1FF,
    // sSprite_08A2EF48,
    // charId * 2 + (k & 0xF) * 0x1000 + 0x400
    // );
    // }
}
#define Width_BigChar 12
extern int StrLen(u8 * buf);
int PrintBigString(BigTextProc * proc, signed char * str, int index, int x, int y)
{
    // char * myStr = str;
    int len = StrLen((void *)str);

    for (int i = 0; i < len; ++i)
    { // display each character in the string
        // PutBigLetter(index + i, x + (i * Width_BigChar), y, 0x100, 0x100, 0);
        sub_80B2A14(index + i, x + (i * Width_BigChar), y, 0x100, 0x100, 0);
    }
    return len;
}
void BigTextLoop(BigTextProc * proc)
{
    int x = 32;
    int y = 32;
    int offset = 0;
    offset = PrintBigString(proc, proc->str, offset, x, y);
    offset = PrintBigString(proc, proc->str2, offset, x, y + 32);
}

struct ProcCmd const ProcScr_BigText[] = {
    PROC_NAME("opinfo"),
    PROC_SLEEP(0),
    PROC_CALL(LockGame),
    PROC_CALL(BMapDispSuspend),
    PROC_CALL(InitBigTextStr),
    PROC_REPEAT(BigTextLoop),
    PROC_CALL(UnlockGame),
    PROC_CALL(BMapDispResume),
    PROC_END,
};

void StartCreditsProc(ProcPtr parent)
{
    BigTextProc * proc = Proc_StartBlocking(ProcScr_BigText, parent);
}
