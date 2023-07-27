#include "include/gba/gba.h"
#include "include/hardware.h"
#include "include/functions.h"
#include <string.h>
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;

// extern struct KeyStatusBuffer gKeyState; //! FE8U = 0x2024CC0

enum
{
    KEY_BUTTON_A      = (1 << 0),
    KEY_BUTTON_B      = (1 << 1),
    KEY_BUTTON_SELECT = (1 << 2),
    KEY_BUTTON_START  = (1 << 3),
    KEY_DPAD_RIGHT    = (1 << 4),
    KEY_DPAD_LEFT     = (1 << 5),
    KEY_DPAD_UP       = (1 << 6),
    KEY_DPAD_DOWN     = (1 << 7),
    KEY_BUTTON_R      = (1 << 8),
    KEY_BUTTON_L      = (1 << 9),
};

// never return the input? 
// for each bit, turn it off, then turn on one at random? 
u16 HashBits(u16 number, int max){
	if (!GetGameClock()) return number; 
	u16 init_num = number; 
	int value = Mod((GetGameClock() >> 8), 3); // every 4 seconds 
	if (value == 1) { 
		if (init_num & KEY_BUTTON_A) { number &= ~KEY_BUTTON_A; number |= KEY_BUTTON_B; } 
		if (init_num & KEY_BUTTON_B) { number &= ~KEY_BUTTON_B; number |= KEY_BUTTON_A; } 
		if (init_num & KEY_DPAD_UP) { number &= ~KEY_DPAD_UP; number |= KEY_DPAD_DOWN; } 
		if (init_num & KEY_DPAD_DOWN) { number &= ~KEY_DPAD_DOWN; number |= KEY_DPAD_UP; } 
		if (init_num & KEY_DPAD_LEFT) { number &= ~KEY_DPAD_LEFT; number |= KEY_DPAD_RIGHT; } 
		if (init_num & KEY_DPAD_RIGHT) { number &= ~KEY_DPAD_RIGHT; number |= KEY_DPAD_LEFT; } 
		if (init_num & KEY_BUTTON_START) { number &= ~KEY_BUTTON_START; number |= KEY_BUTTON_SELECT; } 
		if (init_num & KEY_BUTTON_SELECT) { number &= ~KEY_BUTTON_SELECT; number |= KEY_BUTTON_START; } 
		if (init_num & KEY_BUTTON_R) { number &= ~KEY_BUTTON_R; number |= KEY_BUTTON_L; } 
		if (init_num & KEY_BUTTON_L) { number &= ~KEY_BUTTON_L; number |= KEY_BUTTON_R; } 
	} 
	if (value == 2) { 
		if (init_num & KEY_BUTTON_A) { number &= ~KEY_BUTTON_A; number |= KEY_BUTTON_L; } 
		if (init_num & KEY_BUTTON_B) { number &= ~KEY_BUTTON_B; number |= KEY_BUTTON_R; } 
		if (init_num & KEY_DPAD_UP) { number &= ~KEY_DPAD_UP; number |= KEY_DPAD_DOWN; } 
		if (init_num & KEY_DPAD_DOWN) { number &= ~KEY_DPAD_DOWN; number |= KEY_DPAD_UP; } 
		if (init_num & KEY_DPAD_LEFT) { number &= ~KEY_DPAD_LEFT; number |= KEY_DPAD_RIGHT; } 
		if (init_num & KEY_DPAD_RIGHT) { number &= ~KEY_DPAD_RIGHT; number |= KEY_DPAD_LEFT; } 
		if (init_num & KEY_BUTTON_START) { number &= ~KEY_BUTTON_START; number |= KEY_BUTTON_SELECT; } 
		if (init_num & KEY_BUTTON_SELECT) { number &= ~KEY_BUTTON_SELECT; number |= KEY_BUTTON_START; } 
		if (init_num & KEY_BUTTON_R) { number &= ~KEY_BUTTON_R; number |= KEY_BUTTON_B; } 
		if (init_num & KEY_BUTTON_L) { number &= ~KEY_BUTTON_L; number |= KEY_BUTTON_A; } 
	} 
	
	
	return number; 
  //u32 hash = 5381;
  //hash = ((hash << 5) + hash) ^ number;
  //hash = ((hash << 5) + hash) ^ gChapterData.chapterIndex;
  //hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
  //return Mod((u16)hash, max);
};

void _UpdateKeyStatus(struct KeyStatusBuffer *keyStatus, s16 keys)
{
	keys = HashBits(keys, 0x200); 
    keyStatus->prevKeys = keyStatus->heldKeys;
    keyStatus->heldKeys = keys;

    // keys that are pressed now, but weren't pressed before
    keyStatus->newKeys = keyStatus->repeatedKeys = keyStatus->heldKeys & ~keyStatus->prevKeys;

    if (keyStatus->newKeys != 0)
        keyStatus->LastPressState = keys;
    keyStatus->ABLRPressed = 0;
    if (keyStatus->heldKeys == 0)
    {
        if (keyStatus->LastPressState != 0 && keyStatus->LastPressState == (keyStatus->prevKeys & (L_BUTTON | R_BUTTON | B_BUTTON | A_BUTTON)))
            keyStatus->ABLRPressed = keyStatus->prevKeys;
    }

    if (keyStatus->heldKeys != 0 && keyStatus->heldKeys == keyStatus->prevKeys)  // keys are being held
    {
        keyStatus->repeatTimer--;
        if (keyStatus->repeatTimer == 0)
        {
            keyStatus->repeatedKeys = keyStatus->heldKeys;
            keyStatus->repeatTimer = keyStatus->repeatInterval;  // reset repeat timer
        }
    }
    else
    {
        // held key combination has changed. reset timer
        keyStatus->repeatTimer = keyStatus->repeatDelay;
    }

    keyStatus->newKeys2 ^= keyStatus->heldKeys;
    keyStatus->newKeys2 &= keyStatus->heldKeys;
    if (keys & (A_BUTTON | B_BUTTON | DPAD_ANY | R_BUTTON | L_BUTTON)) // any button other than start and select
        keyStatus->TimeSinceStartSelect = 0;
    else if (keyStatus->TimeSinceStartSelect < 0xFFFF)
        keyStatus->TimeSinceStartSelect++;
}