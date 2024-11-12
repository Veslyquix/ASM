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
#define spriteBuffer ((u8 *)zoomBuffer + (240 * 160))

void VSync()
{

    while (REG_VCOUNT2 >= 160)
        ;
    while (REG_VCOUNT2 < 160)
        ;
}

// clang-format off
struct MainProc
{
    u8 colorId; 
    u8 cursColId;
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

void DrawPix(u32 x, u32 y, u16 col)
{

    _VRAM[(x) + (y) * 240] = col;
}

//
// VRAM has a bus width of 16/32 bits, so this doesn't work.
void BufferPixel(u32 x, u32 y, u16 col, int zoom)
{
    if (col == 0)
    {
        col = 0x20;
    }
    imageBuffer[x + (y * 240)] = col;
    x <<= zoom;
    y <<= zoom;
    int tmp;
    for (int iy = 0; iy < (1 << zoom); ++iy)
    {
        for (int ix = 0; ix < (1 << zoom); ix += 2)
        {
            tmp = (x + ix) + (y + iy) * 240;
            zoomBuffer[tmp] = col;
            if (ix + 1 < 1 << zoom)
            {
                zoomBuffer[tmp + 1] = col;
            }
            tmp >>= 1; // ensure it is even
            tmp <<= 1;

            _VRAM[((x + ix) >> 1) + (y + iy) * 120] = zoomBuffer[tmp] | (zoomBuffer[tmp + 1] << 8);
        }
    }
}

void UpdateVRAM(void)
{
    int x, y;
    u16 * vramStart = &_VRAM[0];
    u16 * dest;
    u8 * src;
    for (y = 0; y < 160; ++y)
    {
        dest = &vramStart[y * 120];
        src = &imageBuffer[y * 240];
        for (x = 0; x < 240; x += 2)
        {
            dest[x >> 1] = src[x] | (src[x + 1] << 8);
        }
    }
}
void UpdateVRAMZoom(int zoom, int xOffset, int yOffset)
{
    u8 * dest;
    u16 * vramDest;
    u8 * src;
    int tmp;
    for (int iy = 0; iy <= SCREEN_HEIGHT; ++iy)
    {
        vramDest = &_VRAM[iy * (SCREEN_WIDTH >> 1)];
        dest = &zoomBuffer[iy * SCREEN_WIDTH];
        src = &imageBuffer[((yOffset + iy) >> zoom) * SCREEN_WIDTH];
        for (int ix = 0; ix <= SCREEN_WIDTH; ix += 2)
        {
            tmp = src[(xOffset + ix) >> zoom] | (src[((xOffset + ix) >> zoom) + 1] << 8);
            dest[ix] = tmp;          // u8
            dest[ix + 1] = tmp;      // always the same since zoomed in
            vramDest[ix >> 1] = tmp; // u16
        }
    }
}

void DrawPixel(u32 x, u32 y, u16 col, int zoom)
{
    _VRAM[(x >> zoom) + (y >> zoom) * 240] = col;
}
u16 GetPixel(u32 x, u32 y)
{
    return imageBuffer[x + y * 240];
}
const u16 spritePalette[16] = {
    RGB2HEX(0, 0, 0),    // Black
    RGB2HEX(31, 0, 0),   // Red
    RGB2HEX(0, 31, 0),   // Green
    RGB2HEX(0, 0, 31),   // Blue
    RGB2HEX(31, 31, 0),  // Yellow
    RGB2HEX(31, 0, 31),  // Magenta
    RGB2HEX(0, 31, 31),  // Cyan
    RGB2HEX(31, 31, 31), // White
    RGB2HEX(15, 15, 15), // Gray
    RGB2HEX(31, 15, 0),  // Orange
    RGB2HEX(15, 31, 0),  // Lime
    RGB2HEX(0, 15, 31),  // Light Blue
    RGB2HEX(31, 15, 31), // Pink
    RGB2HEX(15, 0, 31),  // Purple
    RGB2HEX(15, 31, 15), // Mint
    RGB2HEX(25, 25, 25)  // Light Gray
};
const u8 spriteTiles[128] = {
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Row 1
    0x00, 0x00, 0x07, 0x70, 0x00, 0x00, 0x00, 0x00, // Row 2
    0x00, 0x07, 0x77, 0x77, 0x70, 0x00, 0x00, 0x00, // Row 3
    0x00, 0x07, 0x76, 0x67, 0x77, 0x70, 0x00, 0x00, // Row 4
    0x00, 0x77, 0x66, 0x66, 0x67, 0x77, 0x00, 0x00, // Row 5
    0x07, 0x76, 0x66, 0x66, 0x66, 0x77, 0x70, 0x00, // Row 6
    0x07, 0x66, 0x66, 0x66, 0x66, 0x67, 0x70, 0x00, // Row 7
    0x07, 0x66, 0x66, 0x66, 0x66, 0x67, 0x70, 0x00, // Row 8
    0x07, 0x76, 0x66, 0x66, 0x66, 0x77, 0x70, 0x00, // Row 9
    0x00, 0x77, 0x66, 0x66, 0x67, 0x77, 0x00, 0x00, // Row 10
    0x00, 0x07, 0x77, 0x77, 0x77, 0x70, 0x00, 0x00, // Row 11
    0x00, 0x00, 0x07, 0x77, 0x70, 0x00, 0x00, 0x00, // Row 12
    0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, // Row 13
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Row 14
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Row 15
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  // Row 16
};

void restoreBuffer(u8 * buffer, int x, int y)
{
    for (int row = 0; row < 16; row++)
    {
        for (int col = 0; col < 8; col++)
        {
            int screenX = x + col;
            int screenY = y + row;

            // Ensure the sprite is within screen bounds
            if (screenX < SCREEN_WIDTH && screenY < SCREEN_HEIGHT)
            {

                // Set pixel in buffer (index-based for 8-bit Mode 4)
                buffer[screenY * SCREEN_WIDTH + screenX] = spriteBuffer[row * 16 + col];
            }
        }
    }
}

void drawSpriteToBuffer(u8 * buffer, int x, int y)
{
    for (int row = 0; row < 16; row++)
    {
        for (int col = 0; col < 8; col++)
        {
            int screenX = x + col;
            int screenY = y + row;

            // Ensure the sprite is within screen bounds
            if (screenX < SCREEN_WIDTH && screenY < SCREEN_HEIGHT)
            {
                // spriteBuffer[screenY * SCREEN_WIDTH + screenX] = buffer[screenY * SCREEN_WIDTH + screenX];
                // Set pixel in buffer (index-based for 8-bit Mode 4)
                buffer[screenY * SCREEN_WIDTH + screenX] = spriteTiles[row * 16 + col];
            }
        }
    }
}
#define MODE4_BACKBUFFER ((u8 *)0x600A000)
void DrawCursor(struct MainProc * proc, int x, int y)
{
    int frame = proc->frame & 1;
    int col = proc->cursColId;
    int zoom = proc->zoom;
    // int size = proc->size << zoom;
    int size = 1 << zoom;
    u16 * dest = _VRAM;
    // copyBuffer(buffer, spriteBuffer);
    // copyBuffer(spriteBuffer, buffer);

    // restoreBuffer(dest, x << zoom, y << zoom);
    // drawSpriteToBuffer(dest, proc->x << zoom, proc->y << zoom);
    // BufferPixel(proc->x, proc->y, zoom, col);
    // _VRAM[proc->y * 240 + proc->x] = col;
    // DrawPixel(proc->x, proc->y, zoom, col);
    return;
    // u8 * vramStart = &_VRAM[0];
    // if (frame)
    // {
    // vramStart = &_VRAM[0];
    // }
    // u8 * vramC;
    // for (int iy = proc->y << zoom; iy < (size + (proc->y << zoom)); ++iy)
    // {
    // vramC = &vramStart[iy * 240];
    // for (int ix = proc->x << zoom; ix < (size + (proc->x << zoom)); ++ix)
    // {
    // DrawPixel(ix, iy, col, zoom);
    // vramC[(ix)] = col;
    // }
    // }
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
#define PROC_RAM ((void *)0x3000000)
int main()
{
    // VIDEO_MODE = DISPCNT_BG2_ON | DISPCNT_MODE_3;
    VIDEO_MODE = DISPCNT_OBJ_ON | DISPCNT_BG2_ON | DISPCNT_MODE_4;
    struct MainProc * proc = PROC_RAM;
    proc->mode = drawLines;
    proc->frame = 0;
    proc->x = 0;
    proc->y = 0;
    // u32 x = 120, y = 80;
    proc->ActiveColorID = 0;
    proc->colorId = 1;
    proc->keysPrev = 0;
    proc->zoom = 0;
    proc->cycle = 0;
    proc->cursColId = 0x20;
    proc->size = 0;
    proc->xOffset = 0;
    proc->yOffset = 0;
    SetupPalette(proc);
    int zoom = proc->zoom;
    while (true)
    {
        // REG_DISPCNT ^= BACKBUFFER;
        //
        InputPoll();

        if (proc->zoom != zoom)
        {
            UpdateVRAMZoom(proc->zoom, proc->xOffset, proc->yOffset);
            zoom = proc->zoom;
        }

        int x = proc->x;
        int y = proc->y;
        HandleCursorInput(proc);
        DrawCursor(proc, x, y);

        if (CheckPressedKeys(SELECT_BUTTON))
        {
            // Change mode
            // ClearScreen();
            proc->zoom = ((proc->zoom + 1) % 6);
        }

        // Cycle through palette
        if (CheckPressedKeys(L_BUTTON) & proc->keysPrev)
        {
            proc->ActiveColorID = ((proc->ActiveColorID - 1) % sizeof(COLORS));
        }

        if (CheckPressedKeys(R_BUTTON) & proc->keysPrev)
        {
            proc->ActiveColorID = ((proc->ActiveColorID + 1) % sizeof(COLORS));
        }

        proc->keysPrev = CheckPressedKeys(KEYS_MASK);

        // BufferPixel(proc->x, proc->y, proc->cursColId);
        // VBlankIntrWait(); // Wait for vertical blank
        VSync();
        // VBlankIntrWait
    }
    return 0;
}
