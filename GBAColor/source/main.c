#include "Constants.h"

#define RGB2HEX(red, green, blue) (red >> 3) | ((green >> 3) << 5) | ((blue >> 3) << 10)
#define Blue RGB2HEX(27, 2, 218)
#define Red RGB2HEX(218, 2, 5)
#define Yellow RGB2HEX(232, 253, 77)
#define Orange RGB2HEX(218, 83, 2)
#define Green RGB2HEX(24, 196, 66)
#define Purple RGB2HEX(188, 2, 218)
#define Brown RGB2HEX(87, 23, 24)
#define White RGB2HEX(255, 255, 255)
#define Black RGB2HEX(0, 0, 0)

const u16 COLORS[] = { White, Yellow, Orange, Red, Blue, Green, Purple, Brown, Black };
const u16 CURSOR_COLORS[] = { Blue, Red, White, Black };

void VSync();
void ClearScreen();
void DrawPixel(u32 x, u32 y, u16 col, int zoom);
u16 GetPixel(u32 x, u32 y);

int SetSwitch(u16 col, int _switch);

void InputPoll();
u32 CheckPressedKeys(u32 key);

u32 INPUT_DATA;

void InputPoll()
{
    INPUT_DATA = INPUT_MASK | INPUT_MEMORY;
}
u32 CheckPressedKeys(u32 key)
{
    return !(INPUT_DATA & key);
}

#define imageBuffer ((u8 *)0x2000000)
#define zoomBuffer ((u8 *)0x2000000 + (240 * 160))

void VSync()
{

    while (REG_VCOUNT >= 160)
        ;
    while (REG_VCOUNT < 160)
        ;
}

// clang-format off
struct MainProc
{
    s16 x;
    s16 y;
    s16 xOffset; 
    s16 yOffset; 
    u8 frame; 
    s8 size; // cursor 
    s8 mode; 
    s8 zoom;
    s8 cycle;
    s8 ActiveColorID;
    u8 colorId; 
    u16 color;
    u8 cursColId;
    u16 keysPrev;
};
// clang-format on

void ClearScreen()
{
    for (int i = 0; i < 240 * 160; i++)
    {
        imageBuffer[i] = 0;
    }
}
void BufferPixel(u32 x, u32 y, u16 col, int zoom)
{
    imageBuffer[x + y * 240] = col;
    zoomBuffer[(x >> zoom) + (y >> zoom) * 240] = col;
}

void updateScreen(u32 src)
{
    // Configure DMA to copy from imageBuffer to VRAM
    DMA0SAD = (u32)src;                                                         // Set source address
    DMA0DAD = (u32)VRAM;                                                        // Set destination address
    DMA0CNT_H = DMA_ENABLE | DMA_REPEAT | DMA_START_VBLANK | ((256 * 160) / 4); // Set transfer mode and size
}

void UpdateVRAM(void)
{
    int x, y;
    u8 * vramStart = &VRAM[0];
    u8 * vramC;
    u8 * buf;
    for (y = 0; y < 160; ++y)
    {
        vramC = &vramStart[y * 240];
        buf = &imageBuffer[y * 240];
        for (x = 0; x < 240; ++x)
        {
            vramC[x] = buf[x];
        }
    }
}
void UpdateVRAMZoom(int zoom, int xOffset, int yOffset)
{
    int x = xOffset;
    int y = yOffset;
    int xMax = 240;
    int yMax = 160;

    u8 * dest;
    u8 * src;
    for (int iy = y; iy <= yMax; ++iy)
    {
        dest = &zoomBuffer[iy * 240];
        src = &imageBuffer[(iy >> zoom) * 240];
        for (int ix = x; ix <= xMax; ++ix)
        {
            dest[ix] = src[ix >> zoom];
        }
    }
    if (zoom)
    {
        updateScreen((u32)zoomBuffer);
    }
    else
    {
        updateScreen((u32)imageBuffer);
    }
}

void DrawPixel(u32 x, u32 y, u16 col, int zoom)
{
    VRAM[(x >> zoom) + (y >> zoom) * 240] = col;
}
u16 GetPixel(u32 x, u32 y)
{
    return imageBuffer[x + y * 240];
}

void DrawCursor(struct MainProc * proc)
{
    int frame = proc->frame & 1;
    int col = proc->cursColId;
    int zoom = proc->zoom;
    // int size = proc->size << zoom;
    int size = 1 << zoom;
    u8 * vramStart = &VRAM[0];
    if (frame)
    {
        vramStart = &VRAM[0];
    }
    u8 * vramC;
    for (int iy = proc->y << zoom; iy < (size + (proc->y << zoom)); ++iy)
    {
        vramC = &vramStart[iy * 240];
        for (int ix = proc->x << zoom; ix < (size + (proc->x << zoom)); ++ix)
        {
            // DrawPixel(ix, iy, col, zoom);
            vramC[(ix)] = col;
        }
    }
}

// 240x160
// 120x80
// 60x40
// 30x20
// 15x10
// 7x5

const u16 xSizeByZoom[] = { 240 << 2, 120 << 2, 60 << 2, 30 << 2, 15 << 2, 15 << 1, 15 }; // screen size
const u16 ySizeByZoom[] = { 160 << 2, 80 << 2, 40 << 2, 20 << 2, 10 << 2, 10 << 1, 10 };

void HandleCursorInput(struct MainProc * proc)
{
    int colorId = proc->colorId;
    int zoom = proc->zoom;
    int xOffset = 0;
    int yOffset = 0;

    if (CheckPressedKeys(DPAD_UP))
    {
        proc->y--;
        if (proc->y < yOffset) // if outside border of screen, jump to opposite edge
        {
            proc->y = (ySizeByZoom[zoom] >> 2) - 1 + yOffset;
        }
        BufferPixel(proc->x, proc->y, colorId, zoom);
    }

    if (CheckPressedKeys(DPAD_DOWN))
    {
        proc->y++;
        if (proc->y >= ((ySizeByZoom[zoom] >> 2) + yOffset))
        {
            proc->y = yOffset;
        }
        BufferPixel(proc->x, proc->y, colorId, zoom);
    }

    if (CheckPressedKeys(DPAD_LEFT))
    {
        proc->x--;
        if (proc->x < xOffset)
        {
            proc->x = (xSizeByZoom[zoom] >> 2) - 1 + xOffset;
        }
        BufferPixel(proc->x, proc->y, colorId, zoom);
    }

    if (CheckPressedKeys(DPAD_RIGHT))
    {
        proc->x++;
        if (proc->x >= ((xSizeByZoom[zoom] >> 2) + xOffset))
        {
            proc->x = xOffset;
        }
        BufferPixel(proc->x, proc->y, colorId, zoom);
    }
}

#define drawLines 0
#define zoomArea 1

const u8 modeTypes[] = {
    drawLines,
    zoomArea,
};

const u16 ColorBank[] = { Blue, Red, Yellow, Orange, Green, Purple, Brown, White };

void SetupPalette(struct MainProc * proc)
{
    u16 * dest = (u16 *)PLTT;
    int colorCount = sizeof(ColorBank) / sizeof(ColorBank[0]);

    // Fill the palette with progressively darker shades of each base color
    for (int i = 0; i < colorCount; ++i)
    {
        u16 baseColor = ColorBank[i];
        u8 baseRed = baseColor & 0x1F;
        u8 baseGreen = (baseColor >> 5) & 0x1F;
        u8 baseBlue = (baseColor >> 10) & 0x1F;

        for (int shade = 0; shade < 16; ++shade)
        {
            // Gradually reduce brightness by scaling each component
            u8 newRed = (baseRed * (16 - shade) / 16) & 0x1F;
            u8 newGreen = (baseGreen * (16 - shade) / 16) & 0x1F;
            u8 newBlue = (baseBlue * (16 - shade) / 16) & 0x1F;

            // Combine into final color
            u16 newShade = newRed | (newGreen << 5) | (newBlue << 10);
            dest[i * 16 + shade] = newShade;
        }
    }
    dest[0] = Black;
}

#define SCREEN_WIDTH 240
#define SCREEN_HEIGHT 160

int main()
{
    // VIDEO_MODE = DISPCNT_BG2_ON | DISPCNT_MODE_3;
    VIDEO_MODE = DISPCNT_BG2_ON | DISPCNT_MODE_4;
    struct MainProc proc;
    proc.mode = drawLines;
    proc.frame = 0;
    proc.x = 0;
    proc.y = 0;
    // u32 x = 120, y = 80;
    proc.ActiveColorID = 0;

    proc.color = White;
    proc.colorId = 1;
    proc.keysPrev = 0;
    proc.zoom = 0;
    proc.cycle = 0;
    proc.cursColId = 7;
    proc.size = 0;
    proc.xOffset = 0;
    proc.yOffset = 0;
    SetupPalette(&proc);
    updateScreen((u32)imageBuffer);
    VRAM[0] = 1;
    int zoom = proc.zoom;
    while (true)
    {
        // VIDEO_MODE = (VIDEO_MODE & ~(0x10)) | ((proc.frame & 1) << 4); // swap between frame 1 and 2
        proc.frame++;
        proc.cycle++;
        if (proc.cycle > 3)
        {
            proc.cycle = 0;
        }
        BufferPixel(proc.x, proc.y, proc.colorId, proc.zoom);

        if (proc.zoom != zoom)
        {
            UpdateVRAMZoom(proc.zoom, proc.xOffset, proc.yOffset);
            zoom = proc.zoom;
        }
        // drawZoomedBuffer(imageBuffer, proc.zoom, proc.xOffset, proc.yOffset);
        // UpdateVRAMZoom(proc.zoom, proc.xOffset, proc.yOffset);
        // DrawCursor(&proc);

        HandleCursorInput(&proc);

        if (CheckPressedKeys(SELECT_BUTTON))
        {
            // Change mode
            // ClearScreen();
            proc.zoom = ((proc.zoom + 1) % 6);
        }

        // Cycle through palette
        if (CheckPressedKeys(L_BUTTON) & proc.keysPrev)
        {
            proc.ActiveColorID = ((proc.ActiveColorID - 1) % sizeof(COLORS));
        }

        if (CheckPressedKeys(R_BUTTON) & proc.keysPrev)
        {
            proc.ActiveColorID = ((proc.ActiveColorID + 1) % sizeof(COLORS));
        }

        proc.keysPrev = CheckPressedKeys(KEYS_MASK);

        proc.color = GetPixel(proc.x, proc.y);

        // BufferPixel(proc.x, proc.y, proc.cursColId);

        VSync();
        InputPoll();
    }
    return 0;
}
