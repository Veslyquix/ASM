#ifndef _CONSTANTS_H
#define _CONSTANTS_H

#define u16 unsigned short
#define u32 unsigned int

#define true (!0)
#define false 0  

#define REG_BASE 0x4000000 // I/O register base address
#define VIDEO_MODE      *(u32*)0x4000000
#define VRAM            ((u16*)0x6000000)
#define MODE_3          0x403
#define REG_VCOUNT      *(volatile u16*)0x04000006

#define INPUT_MEMORY    (*(u32*)0x4000130)
#define INPUT_MASK      0xFC00

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









