
#include "C_Code.h" // headers
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;
// vanilla UI images
extern const u8 gUiFrameImage[];
extern u8 gGfx_PlayerInterfaceFontTiles[];
extern u8 gGfx_PlayerInterfaceNumbers[];
extern u8 CONST_DATA gUnknown_08A1B730[];
extern u8 gUnknown_08A1B1FC[]; // unused atm
extern u16 Img_ShopGoldBox[];  // unused atm
extern u16 CONST_DATA Img_PrepItemUseScreen[];

// battle
extern u16 gUnknown_08802558[]; // palette in func EfxPrepareScreenFx
// TSA ?
extern u8 gUnknown_0880210C[]; // ekrGaugeMain
extern u8 gUnknown_088021C0[];
extern u8 gUnknown_08802274[];
extern u8 gUnknown_08802348[];
extern u8 gUnknown_08802428[]; // ekrGaugeMain
extern u8 gUnknown_08802508[]; // EfxPrepareScreenFx
// Img
extern u16 Img_08801C14[];
extern u16 Img_EfxLeftNameBox[];
extern u16 Img_EfxLeftItemBox[];
extern u16 Img_EfxRightNameBox[];
extern u16 Img_EfxRightItemBox[];

extern const u8 gUiFrameImage_Alt[];
extern const u8 gGfx_PlayerInterfaceFontTiles_Alt[];
extern const u8 gGfx_PlayerInterfaceNumbers_Alt[];
extern const u8 gPrepExtra1_Alt[]; // gUnknown_08A1B730
extern const u8 gPrepUseGfx_Alt[]; // Img_PrepItemUseScreen
// battle
extern u16 gUnknown_08802558_Alt[]; // palette in func EfxPrepareScreenFx
// TSA
extern u8 gUnknown_0880210C_Alt[]; // ekrGaugeMain
extern u8 gUnknown_088021C0_Alt[];
extern u8 gUnknown_08802274_Alt[];
extern u8 gUnknown_08802348_Alt[];
extern u8 gUnknown_08802428_Alt[]; // ekrGaugeMain
extern u8 gUnknown_08802508_Alt[]; // EfxPrepareScreenFx
// img
extern u16 Img_08801C14_Alt[];
extern u16 Img_EfxLeftNameBox_Alt[];
extern u16 Img_EfxLeftItemBox_Alt[];
extern u16 Img_EfxRightNameBox_Alt[];
extern u16 Img_EfxRightItemBox_Alt[];

int GetUI_id(void)
{
    return CheckFlag(0xB0);
}

static const void * sUiFrame[] = {

    gUiFrameImage, // vanilla
    gUiFrameImage_Alt,
    gUiFrameImage,
    gUiFrameImage,
};

const u8 * GetUiFrame(void)
{
    int id = GetUI_id();
    return sUiFrame[id];
}

static const void * sPIFontTiles[] = {

    gGfx_PlayerInterfaceFontTiles, // vanilla
    gGfx_PlayerInterfaceFontTiles_Alt,
    gGfx_PlayerInterfaceFontTiles_Alt,
    gGfx_PlayerInterfaceFontTiles_Alt,
};

const u8 * GetPIFontTiles(void)
{
    int id = GetUI_id();
    return sPIFontTiles[id];
}

static const void * sPINumbers[] = {

    gGfx_PlayerInterfaceNumbers, // vanilla
    gGfx_PlayerInterfaceNumbers_Alt,
    gGfx_PlayerInterfaceNumbers_Alt,
    gGfx_PlayerInterfaceNumbers_Alt,
};

const u8 * GetPINumbers(void)
{
    int id = GetUI_id();
    return sPINumbers[id];
}

void PlayerPhaseInterfaceNumbersHook(void)
{
    Decompress(GetPIFontTiles(), (void *)(VRAM + 0x2000));
    Decompress(GetPINumbers(), (void *)(VRAM + 0x15C00));
}

static const void * sPrepExtra1[] = {

    gUnknown_08A1B730, // vanilla
    gPrepExtra1_Alt,
    gPrepExtra1_Alt,
    gPrepExtra1_Alt,
};

const u8 * GetPrepExtra1(void)
{
    int id = GetUI_id();
    return sPrepExtra1[id];
}

void PrepInitGfxHook(void)
{
    sub_80950E8(0x6000, 0xF);

    Decompress(GetPrepExtra1(), (void *)0x06000440);
}

static const void * sPrepUseItem[] = {

    Img_PrepItemUseScreen, // vanilla
    gPrepUseGfx_Alt,
    gPrepUseGfx_Alt,
    gPrepUseGfx_Alt,
};

const u8 * GetPrepUseItem(void)
{
    int id = GetUI_id();
    return sPrepUseItem[id];
}

void Decompress_Img_PrepItemUseScreen(void)
{
    Decompress(GetPrepUseItem(), (void *)BG_VRAM + 0x440);
}

void DrawFundsSprite_Init(struct DrawFundsSpriteProc * proc)
{
    Decompress(gUnknown_08A1B1FC, (void *)0x06013000);
    ApplyPalette(gUnknown_08A1B638, proc->pal + 0x10);
    return;
}
enum bmshop_bgchr
{
    OBJCHR_SHOP_SPINARROW = 0x4800 / 0x20,
    OBJPAL_SHOP_SPINARROW = 3,

    OBJCHR_SHOP_GOLDBOX = 0x4C00 / 0x20,
    OBJPAL_SHOP_GOLDBOX = 4,

    BGPAL_SHOP_4 = 4,
    BGPAL_SHOP_MAINBG = 14,
};
void DecompressImg_ShopGoldBox(void)
{
    Decompress(Img_ShopGoldBox, OBJ_CHR_ADDR(OBJCHR_SHOP_GOLDBOX));
}

void UnpackUiFrameImage(void * dest)
{
    const u8 * UiFrame = GetUiFrame();
    if (dest == NULL)
        dest = BG_CHAR_ADDR(0);

    Decompress(UiFrame, dest);
}

void UnpackUiFrameBuffered(int id)
{
    const u8 * UiFrame = GetUiFrame();
    int bufSize;
    s8 * bufAddr;

    if (id < 0)
        id = gPlaySt.config.windowColor;

    bufSize = GetDataSize(UiFrame);
    bufAddr = gFadeComponentStep - bufSize;

    Decompress(UiFrame, bufAddr);
    RegisterDataMove(bufAddr, BG_CHAR_ADDR(0), bufSize);

    UnpackUiFramePalette(-1);
}

// battle below

struct ProcEkrDispUP2
{
    PROC_HEADER;

    /* 29 */ u8 sync;
    /* 2A */ u8 asnyc;

    /* 2B */ u8 _pad_2B[0x32 - 0x2B];

    /* 32 */ u16 x; /* unused actually */

    /* 34 */ u8 _pad_32[0x3A - 0x34];

    /* 3A */ u16 y;

    /* 3C */ u8 _pad_3C[0x4C - 0x3C];

    /* 4C */ u32 unk4C;
    /* 50 */ u32 unk50;
};
// decomp says [1], not [16] !
#define gBG0TilemapBuffer2D ((u16(*)[16])gBG0TilemapBuffer)

static const void * sBUiFrame_880210C[] = {

    gUnknown_0880210C, // vanilla
    gUnknown_0880210C_Alt,
    gUnknown_0880210C,
    gUnknown_0880210C,
};
const u8 * GetBUiFrame_880210C(void)
{
    int id = GetUI_id();
    return sBUiFrame_880210C[id];
}
static const void * sBUiFrame_88021C0[] = {

    gUnknown_088021C0, // vanilla
    gUnknown_088021C0_Alt,
    gUnknown_088021C0,
    gUnknown_088021C0,
};
const u8 * GetBUiFrame_88021C0(void)
{
    int id = GetUI_id();
    return sBUiFrame_88021C0[id];
}

void ekrDispUPMain(struct ProcEkrDispUP * var)
{
    struct ProcEkrDispUP2 * proc = (struct ProcEkrDispUP2 *)var;
    int val0, iy, height, map_idx, ix1;
    int ix2 = 15; // for matching

    if (proc->asnyc == true)
        return;

    if (proc->sync != false)
        return;

    val0 = (proc->y << 0x10) >> 0x13;
    iy = val0 << 5;
    if (iy < 0)
        iy = 0;

    height = val0 + 7;
    if (height > 6)
        height = 6;

    map_idx = 30 * (6 - height);

    if (gEkrDistanceType >= 0)
    {
        if (gEkrDistanceType <= 2)
            ix1 = 0;
        else
            goto label;
    }
    else
    {
        ix1 = 0; // for matching, can be any value
    label:
        ix1 = 15;
    }

    FillBGRect(gBG0TilemapBuffer, 30, 7, 0, 128);

    if (height > 0)
    {
        if (proc->unk4C == 0)
        {
            EfxTmCpyBG(&GetBUiFrame_880210C()[map_idx], &gBG0TilemapBuffer2D[iy][ix1], 15, height, -1, -1);
            sub_8070D04(&gBG0TilemapBuffer2D[iy][ix1], 15, height, 2, 128);
        }

        if (proc->unk50 == 0)
        {
            EfxTmCpyBG(&GetBUiFrame_88021C0()[map_idx], &gBG0TilemapBuffer2D[iy][ix2], ix2, height, -1, -1);
            sub_8070D04(&gBG0TilemapBuffer2D[iy][ix2], 15, height, 3, 128);
        }
    }

    BG_EnableSyncByMask(BG0_SYNC_BIT);
}

static const void * sUnknown_08802274[] = {

    gUnknown_08802274, // vanilla
    gUnknown_08802274_Alt,
    gUnknown_08802274,
    gUnknown_08802274,
};

const u8 * ekrGaugeMain_GetImg()
{
    int id = GetUI_id();
    return sUnknown_08802274[id];
}

static const void * sUnknown_08802348[] = {

    gUnknown_08802348, // vanilla
    gUnknown_08802348,
    gUnknown_08802348,
    gUnknown_08802348,
};

const u8 * ekrGaugeMain2_GetImg()
{
    int id = GetUI_id();
    return sUnknown_08802348[id];
}

static const void * sUnknown_08802428[] = {

    gUnknown_08802428, // vanilla
    // gUnknown_08802428_Alt,
    gUnknown_08802428,
    gUnknown_08802428,
    gUnknown_08802428,
};

const u8 * ekrGaugeMain3_GetImg()
{
    int id = GetUI_id();
    return sUnknown_08802428[id];
}

static const void * sUnknown_08802508[] = {

    gUnknown_08802508, // vanilla
    gUnknown_08802508_Alt,
    gUnknown_08802508,
    gUnknown_08802508,
};

const u8 * GetUnknown_08802508()
{
    int id = GetUI_id();
    return sUnknown_08802508[id];
}

static const void * sImg_08801C14[] = {

    Img_08801C14, // vanilla
    Img_08801C14_Alt,
    Img_08801C14,
    Img_08801C14,
};

const u8 * GetImg_08801C14()
{
    int id = GetUI_id();
    return sImg_08801C14[id];
}

static const void * sBPal_8802558[] = {

    gUnknown_08802558, // vanilla
    gUnknown_08802558_Alt,
    gUnknown_08802558,
    gUnknown_08802558,
};
const u16 * GetBPal_8802558(void)
{
    int id = GetUI_id();
    return sBPal_8802558[id];
}

// extern const u16 gUnknown_08802598[];
// static const void * sBPal_8802598[] = {

// gUnknown_08802598, // vanilla
// gUnknown_08802598,
// gUnknown_08802598,
// gUnknown_08802598,
// };
// const u8 * GetBPal_8802598(void)
// {
// int id = GetUI_id();
// return sBPal_8802598[id];
// }

extern s16 gBanimFactionPal[2];
// void EfxPrepareScreenFxHook()
// {
// CpuFastCopy(&PAL_BUF_COLOR(GetBPal_8802558(), gBanimFactionPal[POS_L], 0), PAL_BG(0x2), 0x20);
// CpuFastCopy(&PAL_BUF_COLOR(GetBPal_8802558(), gBanimFactionPal[POS_R], 0), PAL_BG(0x3), 0x20);
// }

extern struct Font gBanimFont;
extern s16 gBanimValid[2];
extern struct Text gBanimText[20];

static const void * sImg_EfxLeftNameBox[] = {

    Img_EfxLeftNameBox, // vanilla
    Img_EfxLeftNameBox_Alt,
    Img_EfxLeftNameBox,
    Img_EfxLeftNameBox,
};

const u8 * GetImg_EfxLeftNameBox()
{
    int id = GetUI_id();
    return sImg_EfxLeftNameBox[id];
}
static const void * sImg_EfxLeftItemBox[] = {

    Img_EfxLeftItemBox, // vanilla
    Img_EfxLeftItemBox_Alt,
    Img_EfxLeftItemBox,
    Img_EfxLeftItemBox,
};

const u8 * GetImg_EfxLeftItemBox()
{
    int id = GetUI_id();
    return sImg_EfxLeftItemBox[id];
}

static const void * sImg_EfxRightNameBox[] = {

    Img_EfxRightNameBox, // vanilla
    Img_EfxRightNameBox_Alt,
    Img_EfxRightNameBox,
    Img_EfxRightNameBox,
};

const u8 * GetImg_EfxRightNameBox()
{
    int id = GetUI_id();
    return sImg_EfxRightNameBox[id];
}

static const void * sImg_EfxRightItemBox[] = {

    Img_EfxRightItemBox, // vanilla
    Img_EfxRightItemBox_Alt,
    Img_EfxRightItemBox,
    Img_EfxRightItemBox,
};

const u8 * GetImg_EfxRightItemBox()
{
    int id = GetUI_id();
    return sImg_EfxRightItemBox[id];
}

extern u16 Img_EfxLeftNameBox[];
extern u16 Img_EfxLeftItemBox[];
extern u16 Img_EfxRightNameBox[];
extern u16 Img_EfxRightItemBox[];
void EfxPrepareScreenFx(void)
{
    const char * str;

    ApplyPalette(Pal_Text, 2);
    ApplyPalette(Pal_Text, 3);
    InitTextFont(&gBanimFont, (void *)0x6001880, 0xC4, 2);
    SetTextDrawNoClear();
    LZ77UnCompVram(GetImg_08801C14(), (void *)0x6001000);

    /* left unit name */
    if (gBanimValid[EKR_POS_L] == false)
        str = gNopStr;
    else
        str = GetStringFromIndex(gpEkrBattleUnitLeft->unit.pCharacterData->nameTextId);

    InitText(&gBanimText[0], 7);
    Text_SetCursor(&gBanimText[0], GetStringTextCenteredPos(0x38, str));
    LZ77UnCompVram(GetImg_EfxLeftNameBox(), (void *)0x6001880);
    Text_DrawString(&gBanimText[0], str);

    /* left unit item */
    if (gBanimValid[EKR_POS_L] == false)
        str = gNopStr;
    else
        str = GetItemName(gpEkrBattleUnitLeft->weaponBefore);

    InitText(&gBanimText[2], 8);
    Text_SetCursor(&gBanimText[2], GetStringTextCenteredPos(0x40, str));
    LZ77UnCompVram(GetImg_EfxLeftItemBox(), (void *)0x6001A40);
    Text_DrawString(&gBanimText[2], str);

    /* right unit name */
    if (gBanimValid[EKR_POS_R] == false)
        str = gNopStr;
    else
        str = GetStringFromIndex(gpEkrBattleUnitRight->unit.pCharacterData->nameTextId);

    InitText(&gBanimText[3], 7);
    Text_SetCursor(&gBanimText[3], GetStringTextCenteredPos(0x38, str));
    LZ77UnCompVram(GetImg_EfxRightNameBox(), (void *)0x6001C40);
    Text_DrawString(&gBanimText[3], str);

    /* right unit item */
    if (gBanimValid[EKR_POS_R] == false)
        str = gNopStr;
    else
        str = GetItemName(gpEkrBattleUnitRight->weaponBefore);

    InitText(&gBanimText[1], 8);
    Text_SetCursor(&gBanimText[1], GetStringTextCenteredPos(0x3E, str));
    LZ77UnCompVram(GetImg_EfxRightItemBox(), (void *)0x6001E00);
    Text_DrawString(&gBanimText[1], str);

    BG_Fill(gBG0TilemapBuffer, 0x80);
    EfxTmCpyBG(GetUnknown_08802508(), gBG0TilemapBuffer + 0x1E, 2, 20, -1, -1);
    sub_8070D04(gBG0TilemapBuffer + 0x1F, 1, 20, 2, 128);
    sub_8070D04(gBG0TilemapBuffer + 0x1E, 1, 20, 3, 128);
    BG_EnableSyncByMask(BG0_SYNC_BIT);

    CpuFastCopy(&PAL_BUF_COLOR(GetBPal_8802558(), gBanimFactionPal[POS_L], 0), PAL_BG(0x2), 0x20);
    CpuFastCopy(&PAL_BUF_COLOR(GetBPal_8802558(), gBanimFactionPal[POS_R], 0), PAL_BG(0x3), 0x20);
    EnablePaletteSync();

    gEkrBg0QuakeVec.x = 0;
    gEkrBg0QuakeVec.y = 0;
    BG_SetPosition(BG_0, 0, 0);
}