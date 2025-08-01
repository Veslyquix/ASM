#include "C_Code.h"
// //JOQUXY
extern ProcPtr StartClassNameIntroLetter(ProcPtr parent, u8 index);
#define brk asm("mov r11, r11");

#define CreditsSpeed 1
#define NumOfStrs 4
struct CreditsStruct
{
    signed char * header;
    signed char * body;
};
extern struct CreditsStruct gCreditsText[];

typedef struct
{
    /* 00 */ PROC_HEADER;

    /* 29 */ u8 unk_29;
    u16 strID[5];
    u8 id;
    u8 finished;
    u8 maxId;
    u8 advanceId;
    s16 y;
    u32 clock;
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

int GetYOffsetBetweenText(BigTextProc * proc, int id)
{
    return 64;
}

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

        if ((offset + BigTextVRAM) >= 0x6018000)
        {
            offset = 0;
        }
    }

    return offset;
}

void InitBigTextStr(BigTextProc * proc)
{
    u16 vramOffset = 0;

    for (int i = 0; i < NumOfStrs; i++)
    {
        signed char * str = gCreditsText[i + proc->id].header;
        if (str)
        {
            vramOffset = BigFontInit(str, vramOffset);
        }
    }
}

void InitCreditsBodyText(BigTextProc * proc)
{
    const char * str;
    const char * iter;
    int line;
    u32 width;
    struct Text * th = gStatScreen.text;

    InitSpriteTextFont(&gHelpBoxSt.font, OBJ_VRAM0, 0x11);
    SetTextFontGlyphs(1);
    ApplyPalette(gUnknown_0859EF20, 0x11);

    for (int i = 0; i < NumOfStrs; ++i)
    {

        th = &gStatScreen.text[i * 4]; // Max Number of lines
        str = (void *)gCreditsText[i + proc->id].body;
        for (line = 0; line < 1; line++)
        {
            InitSpriteText(&th[line]);

            SpriteText_DrawBackgroundExt(&th[line], 0); // clears the vram obj behind the sprite text
            Text_SetColor(&th[line], 0);
        }
        iter = str;

        line = 0;
        if (iter != 0)
        {
            while (*iter > 1)
            {
                iter = Text_DrawCharacter(&th[line], iter);

                if (Text_GetCursor(&th[line]) > 0xE0)
                {

                    iter -= 2;
                    line++;

                    GetCharTextLen(iter, &width);

                    Text_SetCursor(&th[line], (Text_GetCursor(&th[line - 1]) - width) - 0xC0);
                }
            }

            // proc->textCount = ((GetStringTextLen(str) + 16) >> 5) + 1;
            // proc->textNum = proc->textCount - 1;
        }
    }
    SetTextFont(0);

    return;
}
void InitCreditsText(BigTextProc * proc)
{
    InitBigTextStr(proc);
    InitCreditsBodyText(proc);
}

void PutSpriteExt(int layer, int xOam1, int yOam0, const u16 * object, int oam2);
void PutBigLetter(u8 charId, int x, int y, u16 xScale, u16 yScale, u8 offset) // based on sub_80B2A14
{
    int palID = 0;
    // if (x > 224)
    if (x > 240)
    {
        return;
    }
    if (yScale <= 8)
    {
        return;
    }

    if (xScale < 8)
    {
        xScale = 8;
    }
    int adjustedCharId = ((charId >> 4) * 0x30) + charId; // 16 letters per row

    int matrixId = charId & 0x1F; // affine matrix index (0-31)
    SetObjAffine(
        matrixId, Div(+COS(0) << 4, xScale), Div(-SIN(0) << 4, yScale), Div(+SIN(0) << 4, xScale),
        Div(+COS(0) << 4, yScale)); // unsure what this does, but it is needed

    int layer = 1; // sub_80B2A14 uses oam2 layer 1 for first letter and layer 2 after that
    int oam2 = adjustedCharId * 2 + OAM2_LAYER(layer) + OAM2_PAL(palID);
    PutSpriteExt(4, (x & 0x1FF) + (matrixId << 9), y & 0x1FF, sSprite_08A2EF48_new, oam2);
}
#define Width_BigChar 12
unsigned int strlen(const char *);
int PrintBigString(BigTextProc * proc, signed char * str, int index, int x, int y)
{
    if (!str)
    {
        return 0;
    }
    if (y > 160)
    {
        return 0;
    }
    int ix;
    int len = strlen((void *)str);

    for (int i = 0; i < len; ++i)
    { // display each character in the string
        ix = x + (i * Width_BigChar);
        PutBigLetter(index + i, ix, y, 0x100, 0x100, 0);
    }
    return len;
}

// PutSprite(2, x, proc->y + (i * 32), gObject_32x16, 0x4240 + lut[index]);
void PutNormalSpriteText(int layer, int x, int y, const u16 * object, int oam2)
{ // see  PutSubtitleHelpText
    if (y > 160)
    {
        return;
    }
    static u16 lut[] = {
        0x00, 0x04, 0x08, 0x0C, 0x10, 0x14, 0x18, 0x44, 0x48, 0x4C, 0x50, 0x54, 0x58,
    };

    int i;
    int ix;

    for (i = 0; i < 9; i++)
    {
        // int x = (i * 32) - 32 + proc->textOffset;
        // int index = (proc->textNum + i) % proc->textCount;
        ix = x + (i * 32);

        PutSprite(layer, ix, y, gObject_32x16, oam2 + lut[i]);
    }

    return;
}

int TryAdvanceID(BigTextProc * proc)
{
    int yDiff = GetYOffsetBetweenText(proc, proc->id);
    if (proc->y < (-yDiff))
    {

        proc->advanceId = true;
        return true;
    }
    return false;
}

int ShouldAdvanceFrame(BigTextProc * proc);
void BigTextLoop(BigTextProc * proc)
{
    proc->y -= ShouldAdvanceFrame(proc);
    int yDiff = GetYOffsetBetweenText(proc, proc->id);
    if (proc->advanceId)
    {
        proc->id++;
        yDiff = GetYOffsetBetweenText(proc, proc->id);
        proc->y += yDiff;
        InitCreditsText(proc);
        proc->advanceId = false;
        // return;
    }
    if (TryAdvanceID(proc))
    {
        return;
    }
    if (!gCreditsText[proc->id].header && !gCreditsText[proc->id].body)
    { // nothing left to display, so end
        Proc_Break(proc);
        return;
    }
    // struct Text * th = gStatScreen.text;

    int x = 0;
    int offset = 0;

    signed char * str;
    // for (int i = 0; i < proc->id; i++)
    // {
    // str = gCreditsText[i].header;
    // offset += strlen((void *)str);
    // }

    // for (int i = 0; i < NumOfStrs; ++i)
    for (int i = 0; i < NumOfStrs; ++i)
    {
        str = gCreditsText[i + proc->id].header;
        // str = gCreditsText[i];
        if (str && *str)
        {
            offset += PrintBigString(proc, str, offset, x, proc->y + (i * yDiff));
        }
    }
    for (int i = 0; i < NumOfStrs; ++i)
    {
        str = gCreditsText[i + proc->id].body;
        // str = gCreditsText[i];
        if (str && *str)
        {
            PutNormalSpriteText(2, x + 16, proc->y + (i * yDiff) + 48, gObject_32x16, OAM2_PAL(1) + (i * 0x40));
        }
    }
}

struct ProcCmd const ProcScr_BigText[] = {
    PROC_NAME("opinfo"),
    PROC_SLEEP(0),
    PROC_CALL(LockGame),
    PROC_CALL(BMapDispSuspend),
    PROC_CALL(InitCreditsText),
    PROC_REPEAT(BigTextLoop),
    PROC_CALL(StartFastFadeToBlack),
    PROC_REPEAT(WaitForFade),
    PROC_SLEEP(16),
    PROC_CALL(RefreshUnitSprites),
    PROC_CALL(BMapDispResume),
    PROC_CALL(RefreshBMapGraphics),
    PROC_CALL(UnlockGame),
    PROC_CALL(StartFastFadeFromBlack),
    PROC_REPEAT(WaitForFade),
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
    proc->finished = false;
    proc->maxId = 255;
    proc->y = 160;
    proc->advanceId = false;
    proc->clock = GetGameClock();
}

extern int HeldButtonSpeed;
extern int DefaultSpeed;
extern struct KeyStatusBuffer sKeyStatusBuffer;
int ShouldAdvanceFrame(BigTextProc * proc)
{
    u32 clock = GetGameClock();
    u16 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
    int speed = DefaultSpeed;
    if (keys & (B_BUTTON | A_BUTTON))
    {
        speed = HeldButtonSpeed;
    }
    if (keys & (START_BUTTON))
    {
        Proc_Break(proc);
    }
    if ((clock - proc->clock) >= speed)
    {
        proc->clock = clock;
        return 1;
    }
    else
    {
        return false;
    }
}
