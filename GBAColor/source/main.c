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

// Constants
#define MAX_COLORS 9
const u16 COLORS[] = { White, Yellow, Orange, Red, Blue, Green, Purple, Brown, Black };
#define MAX_CURSOR_COLORS 5
const u16 CURSOR_COLORS[] = {
    1,      // CURRENT COLOR
    0x7C11, // BLUE
    0x11F,  // RED
    0x7FFF, // WHITE
    0       // BLACK
};

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

#define imageBuffer ((u16 *)0x2000000)

void VSync()
{
    while (REG_VCOUNT >= 160)
        ;
    while (REG_VCOUNT < 160)
        ;
}
void ClearScreen()
{
    for (int i = 0; i < 240 * 160; i++)
    {
        imageBuffer[i] = 0;
    }
}
void BufferPixel(u32 x, u32 y, u16 col)
{
    imageBuffer[x + y * 240] = col;
}
void UpdateVRAM(void)
{
    int x, y;
    u16 * vramC;
    u16 * buf;
    for (y = 0; y < 160; ++y)
    {
        vramC = &VRAM[y * 240];
        buf = &imageBuffer[y * 240];
        for (x = 0; x < 240; ++x)
        {
            vramC[x] = buf[x];
        }
    }
}
void UpdateVRAMZoom(int zoom, int type)
{
    if (type < 0)
    {
        return;
    }
    int x = 0;
    int y = 0;
    int xMax = 240;
    int yMax = 160;
    switch (type)
    {
        case 0:
        {
            xMax >>= 1;
            yMax >>= 1;
            break;
        }
        case 1:
        {
            x = xMax >> 1;
            yMax >>= 1;
            break;
        }
        case 2:
        {
            xMax >>= 1;
            y = yMax >> 1;
            break;
        }
        case 3:
        {
            x = xMax >> 1;
            y = yMax >> 1;
            break;
        }
        default:
    }
    u16 * vramC;
    u16 * buf;
    for (int iy = y; iy <= yMax; ++iy)
    {
        vramC = &VRAM[iy * 240];
        buf = &imageBuffer[(iy >> zoom) * 240];
        for (int ix = x; ix <= xMax; ++ix)
        {
            vramC[ix] = buf[ix >> zoom];
        }
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

// 240x160
// 120x80
// 60x40
// 30x20
// 15x10
// 7x5
//

// x 120, 60, 30, 15, 8
// y 80, 40, 20, 10, 5
const int xQuadByZoom[] = { 120 << 4, 60 << 4, 30 << 4, 15 << 4, 15 << 3, 15 << 2 };
const int yQuadByZoom[] = { 80 << 4, 40 << 4, 20 << 4, 10 << 4, 5 << 4, 5 << 3 };

// int UpdateQuadrant(int x, int y, int zoom, int oX, int oY) {
// return (x / (120 << zoom)) + ((y / (80 << zoom)) * 2);
// return ((x << 4) / xQuadByZoom[zoom]) +
// (((y << 4) / (yQuadByZoom[zoom])) * 2);
// }
int UpdateQuadrant(int x, int y, int zoom, int oX, int oY)
{
    return 5;
}

#define RefreshScreen 10

int main()
{
    VIDEO_MODE = MODE_3;

    // u32 x = 120, y = 80;
    u32 x = 0, y = 0;
    int ActiveColorID = 0;
    int color = White;

    int keysPrev = 0;
    int zoom = 0;
    int quadrant = 0;
    int cycle = 0;
    u16 CursorColor = White;

    while (true)
    {
        VSync();
        InputPoll();
        cycle++;
        if (cycle > 3)
        {
            cycle = 0;
        }
        BufferPixel(x, y, color);
        // UpdateVRAM();
        UpdateVRAMZoom(zoom, cycle);
        if (quadrant != cycle)
        {
            UpdateVRAMZoom(zoom, quadrant);
        }

        // quadrant = HandleCursorInput(proc);
        quadrant = -1;
        // Moving the cursor and doing some conditions
        if (CheckPressedKeys(DPAD_UP) && y > 0)
        {
            y--;
            BufferPixel(x, y, color);
            quadrant = UpdateQuadrant(x, y, zoom, 0, 0);
        }

        if (CheckPressedKeys(DPAD_DOWN) && y < 160 - 1)
        {
            y++;
            BufferPixel(x, y, color);
            quadrant = UpdateQuadrant(x, y, zoom, 0, 0);
        }

        if (CheckPressedKeys(DPAD_LEFT) && x > 0)
        {
            x--;
            BufferPixel(x, y, color);
            quadrant = UpdateQuadrant(x, y, zoom, 0, 0);
        }

        if (CheckPressedKeys(DPAD_RIGHT) && x < 240 - 1)
        {
            x++;
            BufferPixel(x, y, color);
            quadrant = UpdateQuadrant(x, y, zoom, 0, 0);
        }

        if (CheckPressedKeys(SELECT_BUTTON))
        {
            // Change mode
            // ClearScreen();
            zoom = ((zoom + 1) % 6);
            quadrant = RefreshScreen;
        }

        // Cycle through palette
        if (CheckPressedKeys(L_BUTTON) & keysPrev)
        {
            ActiveColorID = ((ActiveColorID - 1) % sizeof(COLORS));
        }

        if (CheckPressedKeys(R_BUTTON) & keysPrev)
        {
            ActiveColorID = ((ActiveColorID + 1) % sizeof(COLORS));
        }

        keysPrev = CheckPressedKeys(KEYS_MASK);

        color = GetPixel(x, y);

        BufferPixel(x, y, CursorColor);
    }
    return 0;
}
