
#include "headers/prelude.h"
#include "headers/types.h"
#define ABS(aValue) ((aValue) >= 0 ? (aValue) : -(aValue))
extern u8 gCh; 
extern int CheckFlag(int flag); 
struct ReplaceTextStruct { 
// conditions 
	u16 flag; 
	u8 chapterID; 
	u8 pad; 
	const char* find; 
	const char* replace; 
};  
extern struct ReplaceTextStruct ReplaceTextList[]; 
extern char sMsgString[0x1000]; // fe7 202A5B4 
extern void SetMsgTerminator(char * str); 
extern void Arm_DecompText(const char *, char*, u32 addr); 
extern void (*gARM_DecompText)(const char *, char *); // fe8 3004150 fe7 3003940 fe6 3003780
extern void CallARM_DecompText(const char *a, char *b);

int GetStringLength(const char* str) { 
	int i = 0; 
	for (i = 0; i < 255; ++i) { 
		if (!str[i]) break; 
	} 
	return i; 

} 
int GetEndOfBuffer(char* buffer) { 
	for (int i = 0; i < 0x1000; ++i) { 
		if (!buffer[i]) { return i; } 
	} 
	return 0; 

} 
void ShiftDataInBuffer(char *buffer, int amount, int offset) { 
	int endOfBuffer = GetEndOfBuffer(buffer); 
	if (!amount) { return; } 
	int i; 
	if (amount < 0) { 
		amount = ABS(amount); 
		for (i = offset; i < endOfBuffer; ++i) { 
			//asm("mov r11, r11"); 
			buffer[i] = buffer[i + amount]; 
		} 
	} 
	else { 
		for (i = endOfBuffer; i >= offset; --i) { 
			buffer[i+amount] = buffer[i]; 
		} 
	
	} 

} 

void ReplaceIfMatching(char *buffer, const char* find, const char* replace, int c) { 
	int len1 = GetStringLength(find); 
	int i; 
	for (i = 0; i < len1; ++i) { 
		if (buffer[i] != find[i]) { return; }
	} 
	
	int len2 = GetStringLength(replace); 
	ShiftDataInBuffer(sMsgString, len2-len1, c); 
	
	for (i = 0; i < len2; ++i) { 
		buffer[i] = replace[i]; 
	} 
	

}  

 
void CallARM_DecompText(const char *a, char *b) // 2ba4 // fe7 8004364 fe6 800384C 
{
	// maybe fill with 0 beforehand for fe6? 
	if ((int)a & 0x80000000) { // anti huffman 
		a = (const char*) ((int)a & 0x7FFFFFFF); 
		for (int i = 0; i < 0x1000; ++i) { 
			sMsgString[i] = a[i];
			if (!a[i]) { 
			#ifndef FE8 
			sMsgString[i] = 0; 
			sMsgString[i+1] = 0; 
			#endif 
			break; }  
		}
	} 
	else { 
		#ifdef FE8 
		Arm_DecompText(a, b, 0x3004150);
		#endif 
		#ifdef FE7 
		Arm_DecompText(a, b, 0x3003940); 
		#endif 
		#ifdef FE6
		Arm_DecompText(a, b, 0x3003780);
		#endif 
	} 
	#ifdef FE8 
	SetMsgTerminator(sMsgString); 
	#endif 
	for (int c = 0; c < 255; ++c) { 
		if (!ReplaceTextList[c].find) { break; } 
		if (ReplaceTextList[c].flag) { if (!CheckFlag(ReplaceTextList[c].flag)) { continue; }} 
		if (ReplaceTextList[c].chapterID != 0xFF) { if (gCh != ReplaceTextList[c].chapterID) { continue; }} 
		for (int i = 0; i < 0x1000; ++i) { 
			ReplaceIfMatching(&sMsgString[i], ReplaceTextList[c].find, ReplaceTextList[c].replace, i);
			if (!sMsgString[i]) { break; } 
		}
	} 
	
	
}