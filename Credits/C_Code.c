#include "C_Code.h"
// //JOQUXY
extern ProcPtr StartClassNameIntroLetter(ProcPtr parent, u8 index);
#define brk asm("mov r11, r11");

#define CreditsSpeed 1
#define NumOfStrs 2
struct CreditsStruct
{
    signed char * header;
    signed char * body;
};
extern struct CreditsStruct gCreditsText[];

#define LinesOnScreen 10 // 160y / 16 pixels
#define BufferedLines 6
#define TotalLines (LinesOnScreen + BufferedLines) // max 14 or 16,
typedef struct
{
    /* 00 */ PROC_HEADER;

    /* 29 */ u8 unk_29;
    s8 vramRow[TotalLines]; // indexed by stringID & 0xF;
    u16 freeRows;           // bitfield of which obj vram lines are taken up or free to use
    u16 textTypeBitfield;   // bitfield of which lines are header (unset) or body (set)
    s8 textType;            // Header or Body
    s8 strID;

    u8 id;
    u8 finished;
    u8 maxId;
    u8 advanceId;
    s16 y;
    u32 clock;
} BigTextProc;

//
#define BigText_VRAMTile 0                                // 0x280
#define BigTextVRAM (OBJ_VRAM0 + (BigText_VRAMTile << 5)) // 0x6010000
extern const u16 sSprite_08A2EF48[];
extern struct Font * gActiveFont;
u16 const sSprite_08A2EF48_new[] = // see gSprite_UiSpinningArrows_Horizontal and sSprite_08A2EF48
    {
        1, // number of entries
        OAM0_SHAPE_16x32 | OAM0_DOUBLESIZE | OAM0_AFFINE_ENABLE,
        OAM1_SIZE_32x32,
        OAM2_CHR(BigText_VRAMTile),
    };

int CountTextLines(signed char * str)
{
    signed char * tmp = str;
    int i = 1;
    while (*tmp)
    {
        while (*tmp > 1)
        {
            tmp++;
        }
        i++;
        tmp++;
    }
    if (i > 4)
    {
        i = 4;
    }
    return i;
}

// 16y pixels per small text line
// 48y for big text

int GetYOffsetBetweenText(BigTextProc * proc, int id)
{
    int result = 48;
    result += CountTextLines(gCreditsText[id].body) * 16;
    // return 64;
    return result;
}

extern u8 * const gUnknown_08A2F2C0[];
u16 BigFontInit(signed char * str, u16 offset)
{
    ApplyPalette(gUnknown_08A37300, 0x10);
    while (*str != 0)
    {
        Decompress((gUnknown_08A2F2C0[*str] != 0) ? gUnknown_08A2F2C0[*str] : gUnknown_08A2F2C0[0x58], gGenericBuffer);
        Copy2dChr(gGenericBuffer, (void *)(offset + BigTextVRAM), 2, 4);

        str++;
        offset += 0x40;
        if ((offset & 0x3FF) == 0) // If wrapped past a 0x400 boundary
            offset += 0xC00;       // Move to next text page

        if ((int)(offset + BigTextVRAM) >= 0x6018000)
        {
            offset = 0;
        }
    }
    gActiveFont->vramDest += offset;
    return offset;
}

// void InitBigTextStr(BigTextProc * proc)
// {
// u16 vramOffset = 0;

// for (int i = 0; i < NumOfStrs; i++)
// {
// signed char * str = gCreditsText[i + proc->id].header;
// if (str && *str)
// {
// vramOffset = BigFontInit(str, vramOffset);
// }
// }
// }

static inline const char * Text_DrawCharacterAscii_BL(struct Text * th, const char * str);
void InitCreditsBodyText(BigTextProc * proc, const char * str)
{
    const char * iter;
    int line;  // current one
    int lines; // how many
    u32 width;
    struct Text * th = gStatScreen.text;

    for (int i = 0; i < 1; ++i)
    {
        th = &gStatScreen.text[i * 4]; // Max Number of lines
        // str = (void *)gCreditsText[i + proc->id].body;
        if (str && *str)
        {

            lines = 1; // CountTextLines(str);
            for (line = 0; line < lines; line++)
            {
                InitSpriteText(&th[line]);

                SpriteText_DrawBackgroundExt(&th[line], 0); // clears the vram obj behind the sprite text
                Text_SetColor(&th[line], 0);
            }
            iter = str;
            line = 0;
            if (iter != 0)
            {

                // while (*iter > 1)
                while (*iter)
                {
                    if (line >= lines)
                    {
                        break;
                    }

                    if (Text_GetCursor(&th[line]) > 0xE0 || (*iter == 1))
                    {

                        // iter -= 2;
                        iter++;
                        line++;

                        // GetCharTextLen(iter, &width);

                        // Text_SetCursor(&th[line], (Text_GetCursor(&th[line - 1]) - width) - 0xC0);
                        Text_SetCursor(&th[line], 0);
                    }
                    iter = Text_DrawCharacterAscii_BL(&th[line], iter); // 160k cycles
                    // iter = Text_DrawCharacter(&th[line], iter); // 278k cycles
                }

                // proc->textCount = ((GetStringTextLen(str) + 16) >> 5) + 1;
                // proc->textNum = proc->textCount - 1;
            }
        }
    }
    SetTextFont(0);
    return;
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
    if (y > 160 || y < (-48))
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
    if (y > 160 || y < (-16))
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
    int yDiff = GetYOffsetBetweenText(proc, proc->id) * 2;
    // brk;
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
        // brk;
        yDiff = GetYOffsetBetweenText(proc, proc->id);
        proc->y += yDiff;
        // InitCreditsText(proc);
        proc->advanceId = false;
    }
    if (!gCreditsText[proc->id].header && !gCreditsText[proc->id].body)
    { // nothing left to display, so end
        Proc_Break(proc);
        return;
    }
    if (TryAdvanceID(proc))
    {
        return; // display nothing for a frame when redrawing stuff
    }

    int x = 0;
    int offset = 0;
    int lines;

    signed char * str;

    for (int i = 0; i < NumOfStrs; ++i)
    // for (int i = 0; i < 1; ++i)
    {
        str = gCreditsText[i + proc->id].header;
        // str = gCreditsText[i];
        if (str && *str)
        {
            offset += PrintBigString(proc, str, offset, x, proc->y + (i * yDiff)); // (i * yDiff)
        }
    }
    for (int i = 0; i < NumOfStrs; ++i)
    // for (int i = 0; i < 1; ++i)
    {
        str = gCreditsText[i + proc->id].body;
        if (str && *str)
        {
            lines = CountTextLines(str);
            for (int c = 0; c < lines; ++c)
            {
                PutNormalSpriteText(
                    2, x + 16, proc->y + (i * yDiff) + (c * 16) + 48, gObject_32x16, OAM2_PAL(1) + (c * 0x40));
            }
        }
    }
}

// 1. Init text

int GetFreeRow(BigTextProc * proc)
{
    u32 freeRows = proc->freeRows;
    for (int i = 0; i < TotalLines; ++i)
    {
        if ((1 << i) & freeRows)
        {
            continue;
        }
        proc->freeRows |= (1 << i);
        return i & 0xF;
    }
    return (-1); // nothing free
}

// GetFreeDoubleRow - for header text?

void FreeRow(BigTextProc * proc, int i)
{
    proc->freeRows &= ~(1 << i); // unset the bit, as it is now free.
}

#define HeaderType 0
#define BodyType 1
signed char * GetNextStrLine(BigTextProc * proc)
{
    // handle multiline?
    switch (proc->textType)
    {
        case HeaderType: // current one is header
        {
            proc->textType = BodyType; // next one will be body
            // proc->textTypeBitfield &= ~(1<< strID); // unset the bit for PutSprite to know it's a header
            return gCreditsText[proc->id].header;
            break;
        }
        case BodyType:
        {
            proc->textType = HeaderType;
            // proc->textTypeBitfield &= ~(1<< strID); // set the bit for PutSprite to know it's a body
            return gCreditsText[proc->id].body;
            break;
        }
    }
    return gCreditsText[proc->id].header; // shouldn't reach
}

#define LineChr 0x40 // per line

int InitNextLine(BigTextProc * proc)
{
    int type = proc->textType;
    signed char * str = GetNextStrLine(proc);

    if (!str || !(*str))
    {
        return false;
    }
    int strID = proc->strID & 0xF;
    proc->strID++;
    int rowID = GetFreeRow(proc);
    if (rowID < 0)
    {
        return false;
    }
    proc->vramRow[strID] = rowID;

    switch (type)
    {
        case HeaderType: // current one is header
        {
            BigFontInit(str, rowID * LineChr);
            return true;
            break;
        }
        case BodyType:
        {
            InitCreditsBodyText(proc, (void *)str);
            return true;
            break;
        }
    }
    return false;
}

void InitCreditsText(BigTextProc * proc)
{
    InitSpriteTextFont(&gHelpBoxSt.font, OBJ_VRAM0, 0x11);
    SetTextFontGlyphs(1);
    ApplyPalette(gUnknown_0859EF20, 0x11);
    for (int i = 0; i < LinesOnScreen; ++i)
    {
        InitNextLine(proc);
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
    proc->freeRows = 0;
    for (int i = 0; i < TotalLines; ++i)
    {
        proc->vramRow[i] = (-1); // do not use if -1
    }
    proc->id = 0;
    proc->textTypeBitfield = 0;
    proc->textType = 0;
    proc->strID = 0;

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

extern struct Font * gActiveFont;
inline void * GetSpriteTextDrawDest_BL(struct Text * text)
{
    int r1 = (text->db_id * text->tile_width + text->chr_position + text->x / 8);
    return gActiveFont->vramDest + r1 * 32;
}
inline u16 * GetColorLut_BL(int color)
{
    return s2bppTo4bppLutTable[color];
}

static inline u32 * DrawHalfRow(u32 * dest, u32 * bitmap, u16 * r8, int xoffset)
{
    u64 bmpRow;
    for (int i = 0; i < 8; i++)
    {

        // read one row of 32 bits from the bitmap
        bmpRow = (u64)*bitmap << xoffset * 2;
        bitmap++;
        u32 val0 = bmpRow & 0xFF;
        u32 val1 = (bmpRow >> 8) & 0xFF;
        u32 val2 = (bmpRow >> 16) & 0xFF;
        u32 val3 = (bmpRow >> 24) & 0xFF;
        u32 val4 = (bmpRow >> 32) & 0xFF;
        u32 val5 = (bmpRow >> 40) & 0xFF;

        dest[0] |= r8[val0] | (r8[val1] << 16);
        dest[8] |= r8[val2] | (r8[val3] << 16);
        dest[16] |= r8[val4] | (r8[val5] << 16);

        dest++;
    }
    return bitmap;
}
static inline void DrawSpriteTextGlyph_BL(struct Text * text, struct Glyph * glyph)
{
    u32 * dest = GetSpriteTextDrawDest_BL(text);
    int xoffset = text->x & 7;
    u32 * bitmap = glyph->bitmap;
    u16 * r8 = GetColorLut_BL(text->colorId);

    bitmap = DrawHalfRow(dest, bitmap, r8, xoffset);

    dest = GetSpriteTextDrawDest_BL(text) + 0x400;
    bitmap = DrawHalfRow(dest, bitmap, r8, xoffset);

    text->x += glyph->width;
}

static inline const char * Text_DrawCharacterAscii_BL(struct Text * th, const char * str)
{
    struct Glyph * glyph = gActiveFont->glyphs[*str++];

    if (glyph == NULL)
        glyph = gActiveFont->glyphs['?'];

    DrawSpriteTextGlyph_BL(th, glyph);
    return str;
}
