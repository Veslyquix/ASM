
//#include "include/gbafe.h" 
#include "gbafe.h" 

void MapFloodCoreStep(int connexion, int x, int y);

// vanilla's pointer to the IWRAM copy of MapFloodCore, which FloodCore.c replaces
extern int (*gMapFloodCoreRam)(void);
