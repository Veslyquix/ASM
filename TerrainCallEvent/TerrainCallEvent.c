#include "gbafe.h"
#include "stdlib.h" 



extern u8 * * gMapTerrain;
extern void MU_EndAll(void);
extern void EndPlayerPhaseSideWindows(void); 
struct TerrainExecuteEventList_Struct { 
	u8 chapterID; 
	u8 terrain; 
	u16 flag; 
	const void* event;
};

extern struct TerrainExecuteEventList_Struct TerrainExecuteEventList[]; 
extern int CheckEventId(int flag); 
extern void SetEventId(int flag); 

int TerrainTryCallEvent(Proc* proc) { 
	int x = gGameState.cursorMapPos.x;
	int y = gGameState.cursorMapPos.y;
	int terrain = gMapTerrain[y][x]; 
	int chapter = gChapterData.chapterIndex; 
	int i = 0; 
	struct TerrainExecuteEventList_Struct list = TerrainExecuteEventList[i]; 
	while (list.event != 0xFFFFFFFF) { 
		list = TerrainExecuteEventList[i];
		if ((list.chapterID == chapter) || (list.chapterID == 0xFF)) { 
			if ((list.terrain == terrain) || (list.terrain == 0)) { 
				if (!(CheckEventId(list.flag)) || (list.flag == 0)) { 
					if (list.flag) SetEventId(list.flag); // set completion flag to on 
					EndPlayerPhaseSideWindows(); 
					MU_EndAll(); 
					CallMapEventEngine(list.event, 1); 
					ProcGoto(proc, 9); 
					return (-1); // true 
				} 
			} 
		} 
		i++; 
	} 
	return false; 
} 


