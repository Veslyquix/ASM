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
extern int RandomizeInputsFlag_Link; 
extern int RandomizeInputsSpeed; 
extern int CheckEventId(int); 
extern int NextRN_N(int);

u16 HashByte(int number, int max) { 
	if (!max) { return 0; } 
	u32 hash = 5381;
	hash = ((hash << 5) + hash) ^ number;
	return Mod((u16)hash, max);
}


u16 HashDirection(int dir, int noise) { 

/*
	switch (dir) { 
		case KEY_DPAD_RIGHT: { dir = 0; break; } 
		case KEY_DPAD_LEFT: { dir = 1; break; } 
		case KEY_DPAD_UP: { dir = 2; break; } 
		case KEY_DPAD_DOWN: { dir = 3; break; } 
		default: { dir = 3; break; } 
	}
*/
	dir = (dir&0xF0)>>5; 
	int num; // first result 
	u16 directionResults[] = { KEY_DPAD_RIGHT, KEY_DPAD_LEFT, KEY_DPAD_UP, KEY_DPAD_DOWN }; 
	int size = 4; //sizeof(directionResults); 
	if (dir >= size) { dir = 0x3; } 
	u16 newList[size]; 
	
	for (int i = 0; i < size; i++) { 
		num = HashByte(noise, size-i); 
		//num = NextRN_N(size-i); 
		newList[i] = directionResults[num]; 
		directionResults[num] = directionResults[(size-i)-1]; 
	} 
	return newList[dir]; 
} 

u16 HashButton(int dir, int noise) { 

	switch (dir) { 
		case KEY_BUTTON_A: { dir = 0; break; } 
		case KEY_BUTTON_B: { dir = 1; break; } 
		case KEY_BUTTON_R: { dir = 2; break; } 
		case KEY_BUTTON_L: { dir = 3; break; } 
		default: { dir = 3; break; } 
	}
	int num; // first result 
	u16 directionResults[] = { KEY_BUTTON_A, KEY_BUTTON_B, KEY_BUTTON_R, KEY_BUTTON_L }; 
	int size = 4; //sizeof(directionResults); 
	u16 newList[size]; 
	
	for (int i = 0; i < size; i++) { 
		num = HashByte(noise, size-i); 
		//num = NextRN_N(size-i); 
		newList[i] = directionResults[num]; 
		directionResults[num] = directionResults[(size-i)-1]; 
	} 
	return newList[dir]; 
} 


// never return the input? 
// for each bit, turn it off, then turn on one at random? 
u16 HashBits(u16 number, int max){
	if (!GetGameClock()) return number; 
	if (!CheckEventId(RandomizeInputsFlag_Link)) return number; 
	if (!number) { return number; } 
	
	u16 init_num = number; 
	int totalPossibilities = 12; // possibilities 
	int time = GetGameClock() >> RandomizeInputsSpeed; // every 4 seconds 
	int value = HashByte(time, totalPossibilities); 
	
	switch (value) { 
		case 0: { number = (1 << NextRN_N(10)) | KEY_BUTTON_B; return number; break; } // back out of things lol 
		case 1:
		case 2: { 
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
			return number; 
			break; 
		} 
		case 3: { 
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
			//return number; 
			break; 
		} 
		case 4: { 
			if (init_num & KEY_BUTTON_A) { number &= ~KEY_BUTTON_A; number |= KEY_DPAD_UP; } 
			if (init_num & KEY_BUTTON_B) { number &= ~KEY_BUTTON_B; number |= KEY_DPAD_DOWN; } 
			if (init_num & KEY_DPAD_UP) { number &= ~KEY_DPAD_UP; number |= KEY_BUTTON_A; } 
			if (init_num & KEY_DPAD_DOWN) { number &= ~KEY_DPAD_DOWN; number |= KEY_BUTTON_B; } 
			if (init_num & KEY_DPAD_LEFT) { number &= ~KEY_DPAD_LEFT; number |= KEY_BUTTON_L; } 
			if (init_num & KEY_DPAD_RIGHT) { number &= ~KEY_DPAD_RIGHT; number |= KEY_BUTTON_R; } 
			if (init_num & KEY_BUTTON_START) { number &= ~KEY_BUTTON_START; number |= KEY_BUTTON_SELECT; } 
			if (init_num & KEY_BUTTON_SELECT) { number &= ~KEY_BUTTON_SELECT; number |= KEY_BUTTON_START; } 
			if (init_num & KEY_BUTTON_R) { number &= ~KEY_BUTTON_R; number |= KEY_DPAD_RIGHT; } 
			if (init_num & KEY_BUTTON_L) { number &= ~KEY_BUTTON_L; number |= KEY_DPAD_LEFT; } 
			//return number; 
			break; 
		}
		default: 
	} 
	//if (init_num < 4) { number |= (1 << HashByte((init_num + time), 2)); } // if you pressed A or B, also press one of them at random 
	//time = 50; 
	if (init_num & (KEY_BUTTON_A|KEY_BUTTON_B|KEY_BUTTON_R|KEY_BUTTON_L)) { number = HashButton(init_num, time); } // if you pressed ABLR, press one of them at random 

	if (init_num & 0xF0) { number = HashDirection(init_num, time); } // if you pressed a direction, press one of them at random 

	return number & 0x3FF; 
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