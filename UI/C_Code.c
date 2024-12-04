
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

extern const u8 gUiFrameImage_Alt[];
extern const u8 gGfx_PlayerInterfaceFontTiles_Alt[];
extern const u8 gGfx_PlayerInterfaceNumbers_Alt[];
extern const u8 gPrepExtra1_Alt[]; // gUnknown_08A1B730
extern const u8 gPrepUseGfx_Alt[]; // Img_PrepItemUseScreen

static const void * sUiFrame[] = {

    gUiFrameImage, // vanilla
    gUiFrameImage_Alt,
    gUiFrameImage,
    gUiFrameImage,
};

const u8 * GetUiFrame(void)
{
    int id = CheckFlag(8);
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
    int id = CheckFlag(8);
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
    int id = CheckFlag(8);
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
    int id = CheckFlag(8);
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
    int id = CheckFlag(8);
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
