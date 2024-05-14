#include "C_Code.h" // headers 

typedef struct {
    /* 00 */ PROC_HEADER;
	int timer; 
	struct Unit* unit;
	u8 something; 
	u8 anotherThing; 
} SomeProc;
void LoopSomeProc(SomeProc* proc);
const struct ProcCmd SomeProcCmd[] =
{
	PROC_NAME("SomeProcName"), 
    PROC_YIELD,
	PROC_REPEAT(LoopSomeProc), 
    PROC_END,
};

extern struct KeyStatusBuffer sKeyStatusBuffer; // 2024C78
void SomeC_Code(void) { 
	SomeProc* proc = Proc_Start(SomeProcCmd, (void*)3); 
	proc->timer = 0; 
	proc->unit = NULL; 
	

	// load graphics into obj vram here 
	LoadObjUIGfx(); // usually already loaded anyway 



} 

const u16 sSprite_VertHand[] = {
    1,
    0x0002, 0x4000, 0x0006
};
void LoopSomeProc(SomeProc* proc) { 
	proc->timer++; 
	if (proc->timer > 50) { Proc_Break(proc); } 
	
	u16 keys = sKeyStatusBuffer.heldKeys; //| newKeys; 
	int x = 0; 
	int y = 0; 
	if (keys & A_BUTTON) { 
		PutSprite(2, x, y, sSprite_VertHand, 0);
	
	} 



} 

