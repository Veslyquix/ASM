#include "C_Code.h"
// //JOQUXY
extern ProcPtr StartClassNameIntroLetter(ProcPtr parent, u8 index);
#define brk asm("mov r11, r11");

#define NumOfStrs 5

typedef struct
{
    /* 00 */ PROC_HEADER;

    /* 29 */ u8 unk_29;
    u16 strID[5];
    u8 id;
} BigTextProc;

#define BigText_VRAMTile 0x180
#define BigTextVRAM (0x6010000 + (BigText_VRAMTile << 5)) // 0x6010000
extern const u16 sSprite_08A2EF48[];
u16 const sSprite_08A2EF48_new[] = // see gSprite_UiSpinningArrows_Horizontal and sSprite_08A2EF48
    {
        1, // number of entries
        OAM0_SHAPE_16x32 | OAM0_DOUBLESIZE | OAM0_AFFINE_ENABLE,
        OAM1_SIZE_32x32,
        OAM2_CHR(BigText_VRAMTile),
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
        offset += 0x40;
        if ((offset & 0x3FF) == 0) // If wrapped past a 0x400 boundary
            offset += 0xC00;       // Move to next text page
    }

    return offset;
}

const u16 strIDs[] = { 0x2c0, 0x2c1, 0, 0, 0 };
void InitBigTextStr(BigTextProc * proc)
{
    u16 vramOffset = 0;
    int sid;

    for (int i = 0; i < NumOfStrs; ++i)
    {
        sid = strIDs[i];
        proc->strID[i] = sid;
        if (sid)
        {
            signed char * str = (void *)GetStringFromIndex(sid);
            vramOffset = BigFontInit(str, vramOffset);
        }
    }
}

void PutSpriteExt(int layer, int xOam1, int yOam0, const u16 * object, int oam2);
extern void sub_80B2A14(u8 charId, int x, int y, u16 xScale, u16 yScale, u8 offset);
void PutBigLetter(u8 charId, int x, int y, u16 xScale, u16 yScale, u8 offset) // based on sub_80B2A14
{
    int palID = 0;

    if (yScale <= 8)
    {
        return;
    }

    if (xScale < 8)
    {
        xScale = 8;
    }
    int adjustedCharId = ((charId >> 4) * 0x30) + charId; // 16 letters per row

    SetObjAffine(
        adjustedCharId, Div(+COS(0) << 4, xScale), Div(-SIN(0) << 4, yScale), Div(+SIN(0) << 4, xScale),
        Div(+COS(0) << 4, yScale)); // unsure what this does, but it is needed

    int layer = 1; // sub_80B2A14 uses oam2 layer 1 for first letter and layer 2 after that
    int oam2 = adjustedCharId * 2 + OAM2_LAYER(layer) + OAM2_PAL(palID);
    PutSpriteExt(4, (x & 0x1FF) + (adjustedCharId << 9), y & 0x1FF, sSprite_08A2EF48_new, oam2);
}
#define Width_BigChar 12
unsigned int strlen(const char *);
int PrintBigString(BigTextProc * proc, signed char * str, int index, int x, int y)
{
    int len = strlen((void *)str);

    for (int i = 0; i < len; ++i)
    { // display each character in the string
        PutBigLetter(index + i, x + (i * Width_BigChar), y, 0x100, 0x100, 0);
        // sub_80B2A14(index + i, x + (i * Width_BigChar), y, 0x100, 0x100, 0);
    }
    return len;
}
void BigTextLoop(BigTextProc * proc)
{
    int x = 32;
    int y = 16;
    int offset = 0;
    int sid;
    for (int i = 0; i < NumOfStrs; ++i)
    {
        sid = proc->strID[i];
        if (sid)
        {
            offset = PrintBigString(proc, (void *)GetStringFromIndex(sid), offset, x, y + (i * 32));
        }
    }
    // offset = PrintBigString(proc, proc->str2, offset, x, y + 32);
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
    RegisterBlankTile(0x400);
    BG_Fill(gBG3TilemapBuffer, 0);
    //
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG3_SYNC_BIT);
    BigTextProc * proc = Proc_StartBlocking(ProcScr_BigText, parent);
    proc->id = 0;
}
