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

#define imageBuffer ((u8 *)0x2000000)

void VSync()
{

    while (REG_VCOUNT >= 160)
        ;
    while (REG_VCOUNT < 160)
        ;
}
/*
void VSync()
{
    if (REG_VCOUNT >= 160)
    {
        while (REG_VCOUNT >= 160)
            ;
        return;
    }
    else
    {
        while (REG_VCOUNT < 160)
            ;
    }
}*/

// clang-format off
struct MainProc
{
    s16 x;
    s16 y;
    u8 frame; 
    s8 size; // cursor 
    s8 mode; 
    s8 quadrant; 
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
void BufferPixel(u32 x, u32 y, u16 col)
{
    imageBuffer[x + y * 240] = col;
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
void UpdateVRAMZoom(int zoom, int type, int frame)
{
    frame &= 1;
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
    u8 * vramStart = &VRAM[0];
    if (frame)
    {
        vramStart = &VRAM[0];
    }
    u8 * vramC;
    u8 * buf;
    for (int iy = y; iy <= yMax; ++iy)
    {
        vramC = &vramStart[iy * 240];
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
//

// x 120, 60, 30, 15, 8
// y 80, 40, 20, 10, 5
const int xQuadByZoom[] = { 120 << 4, 60 << 4, 30 << 4, 15 << 4, 15 << 3, 15 << 2 };
const int yQuadByZoom[] = { 80 << 4, 40 << 4, 20 << 4, 10 << 4, 5 << 4, 5 << 3 };

const u16 xSizeByZoom[] = { 240 << 2, 120 << 2, 60 << 2, 30 << 2, 15 << 2, 15 << 1, 15 }; // screen size
const u16 ySizeByZoom[] = { 160 << 2, 80 << 2, 40 << 2, 20 << 2, 10 << 2, 10 << 1, 10 };

int UpdateQuadrant(int x, int y, int zoom, int oX, int oY)
{
    // return (x / (120 << zoom)) + ((y / (80 << zoom)) * 2);
    return ((x << 4) / xQuadByZoom[zoom]) + (((y << 4) / (yQuadByZoom[zoom])) * 2);
}

#define RefreshScreen 10

int HandleCursorInput(struct MainProc * proc)
{
    int quadrant = proc->quadrant;
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
        BufferPixel(proc->x, proc->y, colorId);
        quadrant = UpdateQuadrant(proc->x, proc->y, zoom, xOffset, yOffset);
    }

    if (CheckPressedKeys(DPAD_DOWN))
    {
        proc->y++;
        if (proc->y >= ((ySizeByZoom[zoom] >> 2) + yOffset))
        {
            proc->y = yOffset;
        }
        BufferPixel(proc->x, proc->y, colorId);
        quadrant = UpdateQuadrant(proc->x, proc->y, zoom, xOffset, yOffset);
    }

    if (CheckPressedKeys(DPAD_LEFT))
    {
        proc->x--;
        if (proc->x < xOffset)
        {
            proc->x = (xSizeByZoom[zoom] >> 2) - 1 + xOffset;
        }
        BufferPixel(proc->x, proc->y, colorId);
        quadrant = UpdateQuadrant(proc->x, proc->y, zoom, xOffset, yOffset);
    }

    if (CheckPressedKeys(DPAD_RIGHT))
    {
        proc->x++;
        if (proc->x >= ((xSizeByZoom[zoom] >> 2) + xOffset))
        {
            proc->x = xOffset;
        }
        BufferPixel(proc->x, proc->y, colorId);
        quadrant = UpdateQuadrant(proc->x, proc->y, zoom, xOffset, yOffset);
    }
    return quadrant;
}

#define drawLines 0
#define zoomArea 1

const u8 modeTypes[] = {
    drawLines,
    zoomArea,
};

void SetupPalette(struct MainProc * proc)
{
    u16 * dest = (u16 *)PLTT;
    for (int i = 0; i < 256; ++i)
    {
        dest[i] = (White) - (0x80 * i);
    }
    dest[0] = Black;
}

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
    proc.quadrant = 0;
    proc.size = 0;
    SetupPalette(&proc);

    while (true)
    {
        // VIDEO_MODE = (VIDEO_MODE & ~(0x10)) | ((proc.frame & 1) << 4); // swap between frame 1 and 2
        proc.frame++;
        proc.cycle++;
        if (proc.cycle > 3)
        {
            proc.cycle = 0;
        }
        BufferPixel(proc.x, proc.y, proc.colorId);
        // UpdateVRAM();
        UpdateVRAMZoom(proc.zoom, proc.cycle, proc.frame);
        if (proc.quadrant != proc.cycle)
        {
            UpdateVRAMZoom(proc.zoom, proc.quadrant, proc.frame);
        }
        DrawCursor(&proc);

        proc.quadrant = HandleCursorInput(&proc);

        if (CheckPressedKeys(SELECT_BUTTON))
        {
            // Change mode
            // ClearScreen();
            proc.zoom = ((proc.zoom + 1) % 6);
            proc.quadrant = RefreshScreen;
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
