#ifndef _CONSTANTS_H
#define _CONSTANTS_H
#include <stdint.h>
typedef uint8_t   u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
typedef int8_t    s8;
typedef int16_t  s16;
typedef int32_t  s32;
typedef int64_t  s64;

typedef volatile u8   vu8;
typedef volatile u16 vu16;
typedef volatile u32 vu32;
typedef volatile u64 vu64;
typedef volatile s8   vs8;
typedef volatile s16 vs16;
typedef volatile s32 vs32;
typedef volatile s64 vs64;

typedef float  f32;
typedef double f64;

typedef u8  bool8;
typedef u16 bool16;
typedef u32 bool32;

#define true (!0)
#define false 0  

#define REG_BASE 0x4000000 // I/O register base address
#define VIDEO_MODE      *(u32*)0x4000000
#define VRAM            ((u16*)0x6000000)
#define VRAM2            ((u16*)0x600A000)
#define MODE_3          0x403
#define REG_VCOUNT      *(volatile u16*)0x04000006

#define INPUT_MEMORY    (*(u32*)0x4000130)
#define INPUT_MASK      0xFC00

// DISPCNT
#define DISPCNT_MODE_0       0x0000 // BG0: text, BG1: text, BG2: text,   BG3: text
#define DISPCNT_MODE_1       0x0001 // BG0: text, BG1: text, BG2: affine, BG3: off
#define DISPCNT_MODE_2       0x0002 // BG0: off,  BG1: off,  BG2: affine, BG3: affine
#define DISPCNT_MODE_3       0x0003 // Bitmap mode, 240x160, BGR555 color
#define DISPCNT_MODE_4       0x0004 // Bitmap mode, 240x160, 256 color palette
#define DISPCNT_MODE_5       0x0005 // Bitmap mode, 160x128, BGR555 color
#define DISPCNT_OBJ_1D_MAP   0x0040
#define DISPCNT_FORCED_BLANK 0x0080
#define DISPCNT_BG0_ON       0x0100
#define DISPCNT_BG1_ON       0x0200
#define DISPCNT_BG2_ON       0x0400
#define DISPCNT_BG3_ON       0x0800
#define DISPCNT_BG_ALL_ON    0x0F00
#define DISPCNT_OBJ_ON       0x1000
#define DISPCNT_WIN0_ON      0x2000
#define DISPCNT_WIN1_ON      0x4000
#define DISPCNT_OBJWIN_ON    0x8000

// keys
#define A_BUTTON        0x0001
#define B_BUTTON        0x0002
#define SELECT_BUTTON   0x0004
#define START_BUTTON    0x0008
#define DPAD_RIGHT      0x0010
#define DPAD_LEFT       0x0020
#define DPAD_UP         0x0040
#define DPAD_DOWN       0x0080
#define R_BUTTON        0x0100
#define L_BUTTON        0x0200
#define KEYS_MASK       0x03FF
#define KEY_INTR_ENABLE 0x0400
#define KEY_OR_INTR     0x0000
#define KEY_AND_INTR    0x8000
#define DPAD_ANY        0x00F0
#define JOY_EXCL_DPAD   0x030F


#endif









