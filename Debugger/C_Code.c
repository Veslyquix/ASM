

#include "C_Code.h" // headers 
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;

#define xTilesAmount 15
#define favTilesAmount 15
#define tmpSize 15

typedef struct {
    /* 00 */ PROC_HEADER;
    s16 tileID; 
    u16 lastTileHovered; 
    s8 editing; 
    u8 actionID; 
    s8 id;
    s8 digit;
    u16 tmp[tmpSize];
    struct Unit* unit; 
    u16 favTiles[15]; 
} DebuggerProc;
void RestartDebuggerMenu(DebuggerProc* proc); 
void LoopDebuggerProc(DebuggerProc* proc);
void PickupUnitIdle(DebuggerProc* proc); 
void SetupUnitFunc(void); 
int PromoAction(DebuggerProc* proc);
int ArenaAction(DebuggerProc* proc); 
int UnitActionFunc(DebuggerProc* proc); 
void CallPlayerPhase_FinishAction(DebuggerProc* proc);
void ClearActiveUnitStuff(DebuggerProc* proc); 
void PlayerPhase_FinishActionNoCanto(ProcPtr proc);
void CallPlayerPhase_FinishAction(DebuggerProc* proc);
int PlayerPhase_PrepareActionBasic(DebuggerProc* proc);
void PlayerPhase_ApplyUnitMovementWithoutMenu(DebuggerProc* proc);
void EditMapIdle(DebuggerProc* proc); 
void StartPlayerPhaseTerrainWindow(); 
void ChooseTileInit(DebuggerProc* proc);
void ChooseTileIdle(DebuggerProc* proc);
void RenderTilesetRowOnBg2(DebuggerProc* proc);
void DisplayTilesetTile(DebuggerProc* proc, u16* bg, int xTileMap, int yTileMap, int xBmMap, int yBmMap);
void EditMapInit(DebuggerProc* proc);
void InitProc(DebuggerProc* proc);
void EditStatsInit(DebuggerProc* proc);
void EditStatsIdle(DebuggerProc* proc);
void EditItemsInit(DebuggerProc* proc);
void EditItemsIdle(DebuggerProc* proc);
void RedrawItemMenu(DebuggerProc* proc);
u8 CanActiveUnitPromote(void);

#define InitProcLabel 0
#define RestartLabel 1
#define PostActionLabel 2 // ClassChgMenuSelOnPressB 80CDC15 has Proc_Goto(proc, 2) in it, so we make this post action label 2 
#define UnitActionLabel 3 
#define PickupUnitLabel 4
#define ChooseTileLabel 5
#define EditMapLabel 6
#define EditTerrainLabel 7
#define EditTrapLabel 8
#define EditStatsLabel 9
#define EditItemsLabel 10
#define LoopLabel 11
#define EndLabel 99 

#define ActionID_Promo 1 
#define ActionID_Arena 2 

const struct ProcCmd DebuggerProcCmd[] =
{
	PROC_NAME("DebuggerProcName"), 
    PROC_YIELD,
    PROC_LABEL(InitProcLabel), 
    PROC_CALL(InitProc), 
    PROC_LABEL(RestartLabel), // Menu 
    
    PROC_CALL(EndPlayerPhaseSideWindows), 
    PROC_SLEEP(1),
    PROC_WHILE(DoesBMXFADEExist),
    PROC_CALL(SetAllUnitNotBackSprite),
    PROC_CALL(RefreshUnitSprites),
    PROC_CALL(RestartDebuggerMenu), 
    PROC_LABEL(LoopLabel), // Loop indefinitely 
	PROC_REPEAT(LoopDebuggerProc), 
    
    PROC_LABEL(UnitActionLabel), 
    PROC_CALL(PlayerPhase_ApplyUnitMovementWithoutMenu), 
    PROC_WHILE_EXISTS(gProcScr_CamMove),
    PROC_CALL_2(PlayerPhase_PrepareActionBasic), 
    PROC_CALL_2(UnitActionFunc),
    
    PROC_LABEL(PostActionLabel), // after action 
    PROC_CALL_2(HandlePostActionTraps),
    PROC_CALL_2(RunPotentialWaitEvents),
    PROC_CALL_2(EnsureCameraOntoActiveUnitPosition),
    PROC_CALL(CallPlayerPhase_FinishAction),
    PROC_GOTO(EndLabel), 
    
    PROC_LABEL(PickupUnitLabel), // Pickup 
    PROC_CALL(StartPlayerPhaseTerrainWindow),
    PROC_CALL(ResetUnitSpriteHover),
    PROC_REPEAT(PickupUnitIdle), 
    PROC_GOTO(EndLabel), 
    
    PROC_LABEL(ChooseTileLabel), // Tile select 
    PROC_CALL(ChooseTileInit), 
    PROC_REPEAT(ChooseTileIdle), 
    
    PROC_LABEL(EditMapLabel), // Map
    PROC_CALL(EditMapInit), 
    PROC_REPEAT(EditMapIdle), 
    PROC_GOTO(EndLabel), 
    
    PROC_LABEL(EditStatsLabel), // Stats 
    PROC_CALL(EditStatsInit), 
    PROC_REPEAT(EditStatsIdle), 
    PROC_GOTO(EndLabel), 

    PROC_LABEL(EditItemsLabel), // Items 
    PROC_CALL(EditItemsInit), 
    PROC_REPEAT(EditItemsIdle), 
    PROC_GOTO(EndLabel), 
    
    PROC_LABEL(EndLabel), 
    
    PROC_CALL(ClearActiveUnitStuff),
    PROC_END,
};

//const char* UnitStats
#define NumberOfOptions 8 
#define NumberOfItems 5
#define START_X 19
#define Y_HAND 2
#define NUMBER_X 17
typedef const struct {
  u32 x;
  u32 y;
} LocationTable;
LocationTable CursorLocationTable[] = {
  //{(NUMBER_X*8) - (0 * 8) - 4, Y_HAND*8},
  {(START_X*8) - (1 * 8) + 4, Y_HAND*8},
  {(START_X*8) - (2 * 8) + 4, Y_HAND*8},
  {(START_X*8) - (3 * 8) + 4, Y_HAND*8},
  {(START_X*8) - (4 * 8) + 4, Y_HAND*8},
  {(START_X*8) - (5 * 8) + 4, Y_HAND*8},
  {(START_X*8) - (6 * 8) + 4, Y_HAND*8}, 
  {(START_X*8) - (7 * 8) + 4, Y_HAND*8}, 
  {(START_X*8) - (8 * 8) + 4, Y_HAND*8}, 
};

const u32 DigitDecimalTable[] = { 
1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000
}; 

static int GetMaxDigits(int number) { 

	int result = 1; 
	while (number > DigitDecimalTable[result]) { result++; } 
	//result++; // table is 0 indexed, but we count digits from 1 
	if (result > 9) { result = 9; } 
	return result; 

} 

#define StatWidth 3
void RedrawUnitStatsMenu(DebuggerProc* proc); 

void SomeMenuInit(DebuggerProc* proc) { 
    ResetTextFont();
    SetTextFontGlyphs(0);
//		ChapterStatus_SetupFont((void*)proc);

    BG_Fill(gBG0TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    ResetTextFont();
    SetTextFontGlyphs(0);
    SetTextFont(0);
    ClearBg0Bg1(); 
    ResetText();
}

void EditStatsInit(DebuggerProc* proc) { 
    SomeMenuInit(proc); 
    struct Unit* unit = proc->unit; 
    proc->tmp[0] = unit->maxHP; 
    proc->tmp[1] = unit->pow; 
    proc->tmp[2] = unit->skl; 
    proc->tmp[3] = unit->spd; 
    proc->tmp[4] = unit->def; 
    proc->tmp[5] = unit->res; 
    proc->tmp[6] = unit->lck; 
    proc->tmp[7] = unit->_u3A; 
    
    
    int x = NUMBER_X - StatWidth - 1; 
    int y = Y_HAND - 1; 
    int w = StatWidth + (START_X - NUMBER_X) + 3; 
    int h = (NumberOfOptions * 2) + 2; 
    
    DrawUiFrame(
        BG_GetMapBuffer(1), // back BG
        x, y, w, h,
        TILEREF(0, 0), 0); // style as 0 ? 

    //ClearUiFrame(
    //    BG_GetMapBuffer(1), // front BG 
    //    x, y, w, h);
    
    struct Text* th = gStatScreen.text;
    
    for (int i = 0; i < 15; ++i) { 
        InitText(&th[i], StatWidth);
    } 
    int c = 0; 
    Text_DrawString(&th[c], GetStringFromIndex(0x4E9)); c++; 
    Text_DrawString(&th[c], GetStringFromIndex(0x4FE)); c++; 
    Text_DrawString(&th[c], GetStringFromIndex(0x4EC)); c++; 
    Text_DrawString(&th[c], GetStringFromIndex(0x4ED)); c++; 
    Text_DrawString(&th[c], GetStringFromIndex(0x4EF)); c++; 
    Text_DrawString(&th[c], GetStringFromIndex(0x4F0)); c++; 
    Text_DrawString(&th[c], GetStringFromIndex(0x4EE)); c++; 
    Text_DrawString(&th[c], GetStringFromIndex(0x4FF)); c++; 
    RedrawUnitStatsMenu(proc);
}

void RedrawUnitStatsMenu(DebuggerProc* proc) { 
	TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-2, Y_HAND), 9, 2 * NumberOfOptions, 0);
	BG_EnableSyncByMask(BG0_SYNC_BIT);
    //ResetText();
    int c = 0; 
    struct Text* th = gStatScreen.text;

    
    c = 0; 
    int x = NUMBER_X - StatWidth; 
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c*2))); c++; 
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c*2))); c++; 
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c*2))); c++; 
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c*2))); c++; 
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c*2))); c++; 
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c*2))); c++; 
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c*2))); c++; 
    PutText(&th[c], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (c*2))); c++; 


    for (int i = 0; i < NumberOfOptions; ++i) { 
        PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i*2)), TEXT_COLOR_SYSTEM_GOLD, proc->tmp[i]); 
    } 

	BG_EnableSyncByMask(BG0_SYNC_BIT);

}


const u16 sSprite_VertHand[] = {
    1,
    0x0002, 0x4000, 0x0006
};
const u8 sHandVOffsetLookup[] = {
    0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 3, 3,
    4, 4, 4, 4, 4, 4, 4, 3, 3, 2, 2, 2, 1, 1, 1, 1,
};
extern int sPrevHandClockFrame; 
extern struct Vec2 sPrevHandScreenPosition; 
extern int sPrevHandClockFrame; 
static void DisplayVertUiHand(int x, int y)
{
    if ((GetGameClock() - 1) == sPrevHandClockFrame)
    {
        x = (x + sPrevHandScreenPosition.x) >> 1;
        y = (y + sPrevHandScreenPosition.y) >> 1;
    }

    sPrevHandScreenPosition.x = x;
    sPrevHandScreenPosition.y = y;
    sPrevHandClockFrame = GetGameClock();

    y += (sHandVOffsetLookup[Mod(GetGameClock(), ARRAY_COUNT(sHandVOffsetLookup))] - 14);
    PutSprite(2, x, y, sSprite_VertHand, 0);
}

const s8 StatCapLookup[] = { 
    99, 63, 63, 63, 63, 63, 63, 63, 
}; 

void SaveStats(DebuggerProc* proc) { 
    struct Unit* unit = proc->unit; 
    int hpDiff = proc->tmp[0] - unit->maxHP; 
    unit->maxHP = proc->tmp[0]; 
    if (hpDiff) { unit->curHP = unit->maxHP; } 
    unit->pow = proc->tmp[1]; 
    unit->skl = proc->tmp[2]; 
    unit->spd = proc->tmp[3]; 
    unit->def = proc->tmp[4]; 
    unit->res = proc->tmp[5]; 
    unit->lck = proc->tmp[6]; 
    unit->_u3A = proc->tmp[7]; 
} 

void SaveItems(DebuggerProc* proc) { 

    struct Unit* unit = proc->unit; 
    for (int i = 0; i < NumberOfItems; ++i) { 
        unit->items[i] = proc->tmp[i]; 
    }
    
    UnitRemoveInvalidItems(unit);


} 

extern struct KeyStatusBuffer sKeyStatusBuffer;
void EditStatsIdle(DebuggerProc* proc) { 
    
	//DisplayVertUiHand(CursorLocationTable[proc->digit].x, CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand 	
	u16 keys = sKeyStatusBuffer.repeatedKeys; 
    if (keys & B_BUTTON) { //press B to not save stats 
        Proc_Goto(proc, RestartLabel);
        m4aSongNumStart(0x6B); 
    };
    if ((keys & START_BUTTON)||(keys & A_BUTTON)) { //press A or Start to update stats and continue 
        SaveStats(proc); 
        Proc_Goto(proc, RestartLabel);
        m4aSongNumStart(0x6B); 
    };
    if (proc->editing) { 
        DisplayVertUiHand(CursorLocationTable[proc->digit].x, (Y_HAND + (proc->id * 2)) * 8); 	
        int max = StatCapLookup[proc->id]; 
        int min = 0; 
        int max_digits = GetMaxDigits(max); 
        
        if (keys & DPAD_RIGHT) {
          if (proc->digit > 0) { proc->digit--; }
          else { proc->digit = max_digits - 1; proc->editing = false; } 
          RedrawUnitStatsMenu(proc);
        }
        if (keys & DPAD_LEFT) {
          if (proc->digit < (max_digits-1)) { proc->digit++; }
          else { proc->digit = 0; proc->editing = false; } 
          RedrawUnitStatsMenu(proc);
        }
        
        if (keys & DPAD_UP) {
            if (proc->tmp[proc->id] == max) { proc->tmp[proc->id] = min; } 
            else { 
                proc->tmp[proc->id] += DigitDecimalTable[proc->digit]; 
                if (proc->tmp[proc->id] > max) { proc->tmp[proc->id] = max; } 
            } 
            RedrawUnitStatsMenu(proc); 
        }
        if (keys & DPAD_DOWN) {
            
            if (proc->tmp[proc->id] == min) { proc->tmp[proc->id] = max; } 
            else { 
                proc->tmp[proc->id] -= DigitDecimalTable[proc->digit]; 
                if (proc->tmp[proc->id] < min) { proc->tmp[proc->id] = min; } 
            } 
            
            RedrawUnitStatsMenu(proc); 
        }
    }
    else { 
        DisplayUiHand(CursorLocationTable[0].x - ((StatWidth + 2) * 8), (Y_HAND + (proc->id * 2)) * 8);
        if (keys & DPAD_RIGHT) {
            proc->digit = 1; 
          proc->editing = true; 
        }
        if (keys & DPAD_LEFT) {
          proc->digit = 0; 
          proc->editing = true; 
        }
        
        if (keys & DPAD_UP) {
            proc->id--; 
            if (proc->id < 0) { proc->id = NumberOfOptions - 1; } 
            RedrawUnitStatsMenu(proc); 
        }
        if (keys & DPAD_DOWN) {
            proc->id++; 
            if (proc->id >= NumberOfOptions) { proc->id = 0; } 
            
            RedrawUnitStatsMenu(proc); 
        }
    } 
} 

#define ItemNameWidth 8
void EditItemsInit(DebuggerProc* proc) { 
    SomeMenuInit(proc); 
    LoadIconPalettes(4);
    struct Unit* unit = proc->unit; 
    for (int i = 0; i < NumberOfItems; ++i) { 
        proc->tmp[i] = unit->items[i]; 
    }
    
    int x = NUMBER_X - ItemNameWidth - 3; 
    int y = Y_HAND - 1; 
    int w = ItemNameWidth + (START_X - NUMBER_X) + 8; 
    int h = (NumberOfItems * 2) + 2; 
    
    DrawUiFrame(
        BG_GetMapBuffer(1), // back BG
        x, y, w, h,
        TILEREF(0, 0), 0); // style as 0 ? 

    struct Text* th = gStatScreen.text;
    
    for (int i = 0; i < NumberOfItems; ++i) { 
        InitText(&th[i], ItemNameWidth);
    } 


    RedrawItemMenu(proc);
}

void RedrawItemMenu(DebuggerProc* proc) { 
	//TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-2, Y_HAND), 9, 2 * NumberOfItems, 0);
    BG_Fill(gBG0TilemapBuffer, 0); 
	BG_EnableSyncByMask(BG0_SYNC_BIT);
    ResetIconGraphics();
    //ResetText();
    const struct ItemData* itemData[5]; 
    struct Text* th = gStatScreen.text;
    for (int i = 0; i < NumberOfItems; ++i) { 
        itemData[i] = GetItemData(proc->tmp[i] & 0xFF); 
    } 
    for (int i = 0; i < NumberOfItems; ++i) { 
        ClearText(&th[i]); 
        if (proc->tmp[i]) { 
            Text_DrawString(&th[i], GetStringFromIndex(itemData[i]->nameTextId));
        } 
    } 
    
    int x = NUMBER_X - (ItemNameWidth); 
    for (int i = 0; i < NumberOfItems; ++i) { 
        if (proc->tmp[i]) { 
            PutText(&th[i], gBG0TilemapBuffer + TILEMAP_INDEX(x, Y_HAND + (i*2))); 
        }
    } 
    int n = 0; 
    for (int i = 0; i < NumberOfItems; ++i) { // item id 
        if (proc->tmp[i]) { n = itemData[i]->number; } else { n = 0; } 
        PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND + (i*2)), TEXT_COLOR_SYSTEM_GOLD, n); 
    } 
    
    for (int i = 0; i < NumberOfItems; ++i) { // uses 
        if (proc->tmp[i]) { n = (proc->tmp[i] & 0xFF00) >> 8; } else { n = 0; } 
        PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X + 3, Y_HAND + (i*2)), TEXT_COLOR_SYSTEM_GOLD, n); 
    } 
    
    int icon; 
    for (int i = 0; i < NumberOfItems; ++i) { 
        icon = GetItemIconId(proc->tmp[i]);
        if (icon >= 0) { 
            if (proc->tmp[i]) { 
            DrawIcon(TILEMAP_LOCATED(gBG0TilemapBuffer, x-2, Y_HAND + (i*2)), icon, 0x4000);
            }
        }
    }

	BG_EnableSyncByMask(BG0_SYNC_BIT);

}


void EditItemsIdle(DebuggerProc* proc) { 
	//DisplayVertUiHand(CursorLocationTable[proc->digit].x, CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand 	
	u16 keys = sKeyStatusBuffer.repeatedKeys; 
    if (keys & B_BUTTON) { //press B to not save stats 
        Proc_Goto(proc, RestartLabel);
        m4aSongNumStart(0x6B); 
    };
    if ((keys & START_BUTTON)||(keys & A_BUTTON)) { //press A or Start to update stats and continue 
        SaveItems(proc); 
        Proc_Goto(proc, RestartLabel);
        m4aSongNumStart(0x6B); 
    };
    if (proc->editing) { 
        if (proc->editing == 1) { 
            DisplayVertUiHand(CursorLocationTable[proc->digit].x, (Y_HAND + (proc->id * 2)) * 8); 	
            int max = 0xBB; 
            int min = 1; 
            int max_digits = GetMaxDigits(max); 
            int val = 0; 
            
            if (keys & DPAD_RIGHT) {
              if (proc->digit > 0) { proc->digit--; }
              else { proc->digit = max_digits - 1; proc->editing = 2; proc->digit = 1; } 
              RedrawItemMenu(proc);
            }
            if (keys & DPAD_LEFT) {
              if (proc->digit < (max_digits-1)) { proc->digit++; }
              else { proc->digit = 0; proc->editing = false; } 
              RedrawItemMenu(proc);
            }
            
            if (keys & DPAD_UP) {
                if ((proc->tmp[proc->id] & 0xFF) == max) { proc->tmp[proc->id] = min | (proc->tmp[proc->id] & 0xFF00); } 
                else { 
                    proc->tmp[proc->id] += DigitDecimalTable[proc->digit]; 
                    if ((proc->tmp[proc->id] & 0xFF) > max) { proc->tmp[proc->id] = max | (proc->tmp[proc->id] & 0xFF00); } 
                } 
                proc->tmp[proc->id] = MakeNewItem(proc->tmp[proc->id] & 0xFF); 
                RedrawItemMenu(proc); 
            }
            if (keys & DPAD_DOWN) {
                if ((proc->tmp[proc->id] & 0xFF) == min) { proc->tmp[proc->id] = max | (proc->tmp[proc->id] & 0xFF00); } 
                else { 
                    val = (proc->tmp[proc->id] & 0xFF) - DigitDecimalTable[proc->digit]; 
                    if (val < min) { proc->tmp[proc->id] = min | (proc->tmp[proc->id] & 0xFF00); } 
                    else { proc->tmp[proc->id] = val | (proc->tmp[proc->id] & 0xFF00); } 
                } 
                proc->tmp[proc->id] = MakeNewItem(proc->tmp[proc->id] & 0xFF); 
                RedrawItemMenu(proc); 
            }
        }
        else { 
            DisplayVertUiHand(CursorLocationTable[proc->digit].x + (3 * 8), (Y_HAND + (proc->id * 2)) * 8); 	
            int max = 63 << 8; 
            int min = 1 << 8; 
            int max_digits = GetMaxDigits(max >> 8); 
            
            if (keys & DPAD_RIGHT) {
              if (proc->digit > 0) { proc->digit--; }
              else { proc->digit = max_digits - 1; proc->editing = false; } 
              RedrawItemMenu(proc);
            }
            if (keys & DPAD_LEFT) {
              if (proc->digit < (max_digits-1)) { proc->digit++; }
              else { proc->digit = 0; proc->editing = 1; proc->digit = 0; } 
              RedrawItemMenu(proc);
            }
            
            if (keys & DPAD_UP) {
                if ((proc->tmp[proc->id] & 0xFF00) == max) { proc->tmp[proc->id] = min | (proc->tmp[proc->id] & 0xFF); } 
                else { 
                    proc->tmp[proc->id] += DigitDecimalTable[proc->digit] << 8; 
                    if ((proc->tmp[proc->id] & 0xFF00) > max) { proc->tmp[proc->id] = max | (proc->tmp[proc->id] & 0xFF); } 
                } 
                RedrawItemMenu(proc); 
            }
            if (keys & DPAD_DOWN) {
                
                if ((proc->tmp[proc->id] & 0xFF00) == min) { proc->tmp[proc->id] = max | (proc->tmp[proc->id] & 0xFF); } 
                else { 
                    proc->tmp[proc->id] -= DigitDecimalTable[proc->digit] << 8; 
                    if ((proc->tmp[proc->id] & 0xFF00) < min) { proc->tmp[proc->id] = min | (proc->tmp[proc->id] & 0xFF); } 
                } 
                
                RedrawItemMenu(proc); 
            }
        }
    }
    else { 
        DisplayUiHand(CursorLocationTable[0].x - ((ItemNameWidth + 4) * 8), (Y_HAND + (proc->id * 2)) * 8);
        if (keys & DPAD_RIGHT) {
            proc->digit = 1; 
          proc->editing = true; 
        }
        if (keys & DPAD_LEFT) {
          proc->digit = 0; 
          proc->editing = 2; 
        }
        
        if (keys & DPAD_UP) {
            proc->id--; 
            if (proc->id < 0) { proc->id = NumberOfItems - 1; } 
            RedrawItemMenu(proc); 
        }
        if (keys & DPAD_DOWN) {
            proc->id++; 
            if (proc->id >= NumberOfItems) { proc->id = 0; } 
            
            RedrawItemMenu(proc); 
        }
    } 
} 


void ChooseTileInit(DebuggerProc* proc) { // if need to load gfx 
    EndPlayerPhaseSideWindows(); 
    int lastTile = proc->lastTileHovered;
    for (int i = 0; i < xTilesAmount; ++i) { 
        proc->tmp[i] = (lastTile + i) & 0x3FF; 
    } 
    RenderTilesetRowOnBg2(proc); 
}

void OffsetTileset(DebuggerProc* proc, int amount) { 
    int newVal = 0; 
    if (amount < 0) { 
        for (int i = 0; i < xTilesAmount; ++i) { 
            newVal = proc->tmp[i] & 0x3FF; 
            proc->tmp[i] = (newVal - ABS(amount)) & 0x3FF; 
        } 
    
    } 
    else { 
        for (int i = 0; i < xTilesAmount; ++i) { 
            newVal = proc->tmp[i] & 0x3FF; 
            proc->tmp[i] = (newVal + amount) & 0x3FF; 
        } 
    } 
    proc->lastTileHovered = proc->tmp[0]; 
    RenderTilesetRowOnBg2(proc);
}

void ClearTilesetRow(DebuggerProc* proc) { 
    SetBackgroundTileDataOffset(2, 0);
    BG_Fill(gBG2TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT);
} 

// bg0 text, bg1 menu bgs, bg2 blank, bg3 map 
void ChooseTileIdle(DebuggerProc* proc) { 
    int x = 7; 
    int y = 9; 
    u16 keys = gKeyStatusPtr->newKeys | gKeyStatusPtr->repeatedKeys; 
    if (keys & A_BUTTON) {
        proc->tileID = proc->tmp[7]; 
        Proc_Goto(proc, EditMapLabel); 
    }
    if (keys & B_BUTTON) {
        gActionData.xMove = gActiveUnitMoveOrigin.x; 
        gActionData.yMove = gActiveUnitMoveOrigin.y; 
        PlayerPhase_ApplyUnitMovementWithoutMenu(proc); 
        ClearActiveUnitStuff(proc); 
        ClearTilesetRow(proc); 
        PlaySoundEffect(0x6B);
        Proc_Goto(proc, RestartLabel); 
    }
    if (keys & DPAD_LEFT) {
        OffsetTileset(proc, -1); 
    }
    if (keys & DPAD_RIGHT) {
        OffsetTileset(proc, 1); 
    }
    if (keys & DPAD_UP) {
        OffsetTileset(proc, -16); 
    }
    if (keys & DPAD_DOWN) {
        OffsetTileset(proc, 16); 
    }

    PutMapCursor(x << 4, y << 4, 0);


}

extern u16 sTilesetConfig[]; 
void RenderTilesetRowOnBg2(DebuggerProc* proc) {
    int ix, iy;
    //RegisterBlankTile(0x400); 
    //BG_Fill(gBG0TilemapBuffer, 0);
    //BG_Fill(gBG1TilemapBuffer, 0);
    //SetBackgroundTileDataOffset(2, 0);
    //BG_Fill(gBG2TilemapBuffer, 0);
    //
    //BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT);
    
    RenderBmMapOnBg2(); 
    
    SetBackgroundTileDataOffset(2, 0x8000);

    gBmSt.mapRenderOrigin.x = gBmSt.camera.x >> 4;
    gBmSt.mapRenderOrigin.y = gBmSt.camera.y >> 4;

    for (iy = (10 - 1); iy >= 9; --iy) // 9 so only bottom row 
        for (ix = (15 - 1); ix >= 0; --ix)
            DisplayTilesetTile(proc, gBG2TilemapBuffer, ix, iy,
                (short) gBmSt.mapRenderOrigin.x + ix, (short) gBmSt.mapRenderOrigin.y + iy);

    BG_EnableSyncByMask(1 << 2);
    BG_SetPosition(2, 0, 0);
}

void DisplayTilesetTile(DebuggerProc* proc, u16* bg, int xTileMap, int yTileMap, int xBmMap, int yBmMap) {
    u16* out = bg + yTileMap * 0x40 + xTileMap * 2; // TODO: BG_LOCATED_TILE?
    //u16* tile = sTilesetConfig + gBmMapBaseTiles[yBmMap][xBmMap];
    
    u16* tile = sTilesetConfig + (proc->tmp[xTileMap] << 2);

    // TODO: palette id constants
    u16 base = gBmMapFog[yBmMap][xBmMap] ? (6 << 12) : (11 << 12);

    out[0x00 + 0] = base + *tile++;
    out[0x00 + 1] = base + *tile++;
    out[0x20 + 0] = base + *tile++;
    out[0x20 + 1] = base + *tile++;
}

void EditMapInit(DebuggerProc* proc) { 
    ClearTilesetRow(proc); 
    StartPlayerPhaseTerrainWindow(); 
} 

extern const struct ProcCmd gProcScr_TerrainDisplay[]; 
void EditMapIdle(DebuggerProc* proc) { 
    HandlePlayerCursorMovement();
    int x = gBmSt.playerCursor.x; 
    int y = gBmSt.playerCursor.y; 
    if (gKeyStatusPtr->newKeys & A_BUTTON) { // see https://github.com/FireEmblemUniverse/fireemblem8u/blob/a608c6c4b6bc0cdf15f14292c99657cae73f6bdb/src/bmmap.c#L271
        gBmMapBaseTiles[y][x] = proc->tileID << 2;
        RefreshTerrainBmMap();
        UpdateRoofedUnits();
        RenderBmMap();
        ProcPtr terrainDispProc = Proc_Find(gProcScr_TerrainDisplay); 
        Proc_Goto(terrainDispProc, 0); // new terrain 
        //PlaySoundEffect(0x6A);
        return; 
    } 
    
    if (gKeyStatusPtr->newKeys & B_BUTTON) { 
        PlaySoundEffect(0x6A);
        Proc_Goto(proc, ChooseTileLabel); 
        return; 
    } 
    if (gKeyStatusPtr->newKeys & (R_BUTTON | START_BUTTON)) {
        PlaySoundEffect(0x6A);
        Proc_Goto(proc, ChooseTileLabel); 
        return; 
    }
    PutMapCursor(gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y, IsUnitSpriteHoverEnabledAt(x, y) ? 3 : 0);
}


void PickupUnitIdle(DebuggerProc* proc) { 
    HandlePlayerCursorMovement();
    if (gKeyStatusPtr->newKeys & A_BUTTON) { 
        gActionData.xMove = gBmSt.playerCursor.x; 
        gActionData.yMove = gBmSt.playerCursor.y; 
        PlayerPhase_ApplyUnitMovementWithoutMenu(proc); 
        ClearActiveUnitStuff(proc); 
        PlaySoundEffect(0x6B);
        Proc_Goto(proc, RestartLabel);
        return; 
    } 
    
    if (gKeyStatusPtr->newKeys & B_BUTTON) { 
        gActionData.xMove = gActiveUnitMoveOrigin.x; 
        gActionData.yMove = gActiveUnitMoveOrigin.y; 
        PlayerPhase_ApplyUnitMovementWithoutMenu(proc); 
        ClearActiveUnitStuff(proc); 
        PlaySoundEffect(0x6B);
        Proc_Goto(proc, RestartLabel); 
        return; 
    } 
    PutMapCursor(
        gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y,
        IsUnitSpriteHoverEnabledAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y) ? 3 : 0);
}

void ClearActiveUnitStuff(DebuggerProc* proc) { 
    MU_EndAll(); 
    if (UNIT_FACTION(gActiveUnit) == gPlaySt.faction) { // if turn of the actor, refresh 
        gActiveUnit->state = gActiveUnit->state & ~(US_UNSELECTABLE|US_CANTOING); 
    } 
    ClearActiveUnit(gActiveUnit); 
    EnsureCameraOntoPosition(proc, gActiveUnitMoveOrigin.x, gActiveUnitMoveOrigin.y);
    SetCursorMapPosition(gActiveUnitMoveOrigin.x, gActiveUnitMoveOrigin.y);
    gBmSt.gameStateBits &= ~BM_FLAG_3;

    HideMoveRangeGraphics();

    RefreshEntityBmMaps();
    RefreshUnitSprites();

    //PlaySoundEffect(0x6B);

    //Proc_Goto(proc, 9);
} 

void PlayerPhase_ApplyUnitMovementWithoutMenu(DebuggerProc* proc) { 
    gActiveUnit->xPos = gActionData.xMove;
    gActiveUnit->yPos = gActionData.yMove;
    UnitFinalizeMovement(gActiveUnit); 
    ResetTextFont();
}

int PlayerPhase_PrepareActionBasic(DebuggerProc* proc) { 
    s8 cameraReturn;
    SetupUnitFunc(); 

    cameraReturn = EnsureCameraOntoPosition(
        proc, GetUnit(gActionData.subjectIndex)->xPos, GetUnit(gActionData.subjectIndex)->yPos);
    cameraReturn ^= 1;
    //if ((gActionData.unitActionType != UNIT_ACTION_WAIT) && !gBmSt.just_resumed)
    //{
    //    gActionData.suspendPointType = SUSPEND_POINT_DURINGACTION;
    //    WriteSuspendSave(SAVE_ID_SUSPEND);
    //}

    return cameraReturn;

} 

void CallPlayerPhase_FinishAction(DebuggerProc* proc) { 
    PlayerPhase_FinishActionNoCanto(proc); 
    ProcPtr playerPhaseProc = Proc_Find(gProcScr_PlayerPhase); 
    Proc_Goto(playerPhaseProc, 0); 
} 

int UnitActionFunc(DebuggerProc* proc) { 
    switch (proc->actionID) { 
        case ActionID_Promo: { 
            PromoAction(proc); 
        break; } 
        case ActionID_Arena: { 
            ArenaAction(proc); 
        break; } 
        default: 
    } 
    proc->actionID = 0; 
    return 0; 
} 

int PromoAction(DebuggerProc* proc) { 
    StartBmPromotion(proc);
    Proc_Goto(proc, PostActionLabel); 
    return 0; 
} 
int ArenaAction(DebuggerProc* proc) { 
    StartArenaScreen();
    Proc_Goto(proc, PostActionLabel); 
    return 0; 
} 
u8 StartPromotionNow(struct MenuProc * menu, struct MenuItemProc * menuItem) {
    //SetupUnitFunc(); 
    if (CanActiveUnitPromote() != 1) { return MENU_ACT_SKIPCURSOR | MENU_ACT_SND6B; } 
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
    proc->actionID = ActionID_Promo; 
    Proc_Goto(proc, UnitActionLabel); 
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
} 
u8 StartArenaNow(struct MenuProc * menu, struct MenuItemProc * menuItem) {
    //SetupUnitFunc(); 
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
    proc->actionID = ActionID_Arena; 
    Proc_Goto(proc, UnitActionLabel); // 0xb7 
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 PickupUnitNow(struct MenuProc * menu, struct MenuItemProc * menuItem) {
    //SetupUnitFunc(); 
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
    Proc_Goto(proc, PickupUnitLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 EditMapNow(struct MenuProc * menu, struct MenuItemProc * menuItem) {
    //SetupUnitFunc(); 
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
    Proc_Goto(proc, ChooseTileLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

u8 EditStatsNow(struct MenuProc * menu, struct MenuItemProc * menuItem) {
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
    Proc_Goto(proc, EditStatsLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}
u8 EditItemsNow(struct MenuProc * menu, struct MenuItemProc * menuItem) {
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
    Proc_Goto(proc, EditItemsLabel);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}


int ShouldStartDebugger(void) { 
    return true; 
} 


void SetupUnitFunc(void) { 
    gBattleActor.weaponBefore = gBattleTarget.weaponBefore = GetUnit(gActionData.subjectIndex)->items[gActionData.itemSlotIndex];

    gBattleActor.weapon = gBattleTarget.weapon = GetUnitEquippedWeapon(GetUnit(gActionData.subjectIndex));
    gBattleActor.hasItemEffectTarget = 0;
    gBattleTarget.statusOut = -1;
    gActionData.unitActionType = 1; 
    UnitBeginAction(gActiveUnit); 
}
u8 CanActiveUnitPromote(void) { 
    if (UNIT_FACTION(gActiveUnit) != gPlaySt.faction) { return 2; } 
    int classNumber = gActiveUnit->pClassData->number; 
    if (!gPromoJidLut[classNumber][0] && !gPromoJidLut[classNumber][1]) { 
        return 2; // greyed out 
    } 
            
    return 1; 
} 
u8 CanActiveUnitPromoteMenu(const struct MenuItemDef* def, int number) { 
    return CanActiveUnitPromote(); 
} 


u8 CallArenaIsUnitAllowed(const struct MenuItemDef* def, int number) { 
    return ArenaIsUnitAllowed(gActiveUnit); 
} 

u8 CallEndEventNow(struct MenuProc * menu, struct MenuItemProc * menuItem) {
    //SetupUnitFunc(); 
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
    Proc_Goto(proc, EndLabel);
    CallEndEvent(); 
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}


extern const struct MenuItemDef gDebuggerMenuItems[]; 
extern const char* gDebuggerMenuText[]; 
int DebuggerMenuItemDraw(struct MenuProc * menu, struct MenuItemProc * menuItem) { 
    if (menuItem->availability == MENU_DISABLED) {
        Text_SetColor(&menuItem->text, 1);
    }
    Text_DrawString(&menuItem->text, gDebuggerMenuText[menuItem->itemNumber]);

    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));

    return 0;


} 


const struct MenuItemDef gMapMenuItems2[] = {
    {"　戦績", 0xB03, 0x6E3, 0, 0x70, MenuAlwaysEnabled, 0, PickupUnitNow, 0, 0, 0}, 
    {"　状況", 0xB04, 0x6E0, 0, 0x6f, CanActiveUnitPromoteMenu, 0, StartPromotionNow, 0, 0, 0},
    {"　辞書", 0xB07, 0x6E5, 0, 0x74, CallArenaIsUnitAllowed, 0, StartArenaNow}, 
    {"　辞書", 0xB08, 0x6E5, 0, 0x74, MenuAlwaysEnabled, 0, CallEndEventNow}, 
    {"　辞書", 0xB09, 0x6E5, 0, 0x74, MenuAlwaysEnabled, 0, EditMapNow}, 
    {"　辞書", 0xB0A, 0x6E5, 0, 0x74, MenuAlwaysEnabled, 0, EditStatsNow}, 
    {"　辞書", 0xB0B, 0x6E5, 0, 0x74, MenuAlwaysEnabled, 0, EditItemsNow}, 
    MenuItemsEnd
};

u8 MenuCancelSelectResumePlayerPhase(struct MenuProc* menu, struct MenuItemProc* item)
{
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
    Proc_Goto(proc, EndLabel); 
    return MENU_ACT_SKIPCURSOR | MENU_ACT_CLEAR | MENU_ACT_END | MENU_ACT_SND6B;
}

const struct MenuDef gDebuggerMenuDef = {
    {1, 2, 7, 0},
    0,
    gDebuggerMenuItems,
    0, 0, 0,
    MenuCancelSelectResumePlayerPhase,
    MenuAutoHelpBoxSelect,
    MenuStdHelpBox
};

void UnitBeginActionInit(struct Unit* unit) {
    gActiveUnit = unit;
    gActiveUnitId = unit->index;

    gActiveUnitMoveOrigin.x = unit->xPos;
    gActiveUnitMoveOrigin.y = unit->yPos;
    gActionData.xMove = unit->xPos; 
    gActionData.yMove = unit->yPos; 

    gActionData.subjectIndex = unit->index;
    gActionData.itemSlotIndex = -1; 
    gActionData.unitActionType = 0;
    gActionData.moveCount = 0;

    gBmSt.taken_action = 0;
    gBmSt.unk3F = 0xFF;

    sub_802C334();

    //gActiveUnit->state |= US_HIDDEN;
    //gBmMapUnit[unit->yPos][unit->xPos] = 0;
}


void StartDebuggerProc(ProcPtr playerPhaseProc) { // based on PlayerPhase_MainIdle
    if (!ShouldStartDebugger()) { return; } 
    struct Unit * unit = GetUnit(gBmMapUnit[gBmSt.playerCursor.y][gBmSt.playerCursor.x]);
    if (!unit) { return; } 
    
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
	if (!proc) { 
		//proc = Proc_Start(DebuggerProcCmd, (void*)3); 
		proc = Proc_StartBlocking(DebuggerProcCmd, playerPhaseProc); 
	} 
    //RestartDebuggerMenu(proc);
    //Proc_Goto(proc, RestartLabel); 
    
}
void MakeMoveunitForAnyActiveUnit(void) {
    if (!MU_Exists()) {
        MU_Create(gActiveUnit);
        HideUnitSprite(gActiveUnit);
    }
    MU_SetDefaultFacing_Auto();
}
void InitProc(DebuggerProc* proc) { 
    proc->editing = false; 
    proc->actionID = 0; 
    proc->tileID = 1; 
    proc->id = 0; 
    proc->lastTileHovered = 0; 
    for (int i = 0; i < tmpSize; ++i) { 
        proc->tmp[i] = 0; 
    } 
}

void RestartDebuggerMenu(DebuggerProc* proc) { 
    struct Unit * unit = GetUnit(gBmMapUnit[gBmSt.playerCursor.y][gBmSt.playerCursor.x]);
    if (!unit) { Proc_Goto(proc, EndLabel); return; } 
    ProcPtr playerPhaseProc = Proc_Find(gProcScr_PlayerPhase); 
    Proc_Goto(playerPhaseProc, 9); // wait for menu? 
    UnitBeginActionInit(unit); 
    proc->unit = unit; 

    gPlaySt.xCursor = gBmSt.playerCursor.x;
    gPlaySt.yCursor = gBmSt.playerCursor.y;
    //MU_EndAll();
    //ShowUnitSprite(unit);
    //UnitSpriteHoverUpdate();
    

    //gBmMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
    gActiveUnit->state |= US_HIDDEN;
    HideUnitSprite(gActiveUnit);
    MakeMoveunitForAnyActiveUnit(); 
    
    gBmSt.gameStateBits &= ~(BM_FLAG_0 | BM_FLAG_1);
    gBmSt.gameStateBits &= ~BM_FLAG_3;
    PutMapCursor(
        gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y,
        IsUnitSpriteHoverEnabledAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y) ? 3 : 0);
    StartOrphanMenuAdjusted(&gDebuggerMenuDef, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x15);
    //RefreshBMapGraphics(); // should not happen on the same frame as starting a menu, or black boxes occur 
    // perhaps they both use the generic buffer 
    
    
} 




void LoopDebuggerProc(DebuggerProc* proc) { 
    return; 
} 




/*
#define A_BUTTON        0x0001
#define B_BUTTON        0x0002
#define SELECT_BUTTON   0x0004
#define START_BUTTON    0x0008
#define DPAD_RIGHT      0x0010
#define DPAD_LEFT       0x0020
#define DPAD_UP         0x0040
#define DPAD_DOWN       0x0080
*/




void PlayerPhase_FinishActionNoCanto(ProcPtr proc)
{
    if (gPlaySt.chapterVisionRange != 0)
    {
        RenderBmMapOnBg2();

        MoveActiveUnit(gActionData.xMove, gActionData.yMove);

        RefreshEntityBmMaps();
        RenderBmMap();

        NewBMXFADE(0);

        RefreshUnitSprites();
    }
    else
    {
        MoveActiveUnit(gActionData.xMove, gActionData.yMove);

        RefreshEntityBmMaps();
        RenderBmMap();
    }

    SetCursorMapPosition(gActiveUnit->xPos, gActiveUnit->yPos);

    gPlaySt.xCursor = gBmSt.playerCursor.x;
    gPlaySt.yCursor = gBmSt.playerCursor.y;

    //if (TryMakeCantoUnit(proc)) // has PROC_GOTO in it 
    //{
    //    HideUnitSprite(gActiveUnit);
    //    return;
    //}

    // if (ShouldCallEndEvent())
    // {
        // MU_EndAll();

        // RefreshEntityBmMaps();
        // RenderBmMap();
        // RefreshUnitSprites();

        // MaybeCallEndEvent_();

        // Proc_Goto(proc, 8);

        // return;
    // }

    MU_EndAll();

    return;
}

extern void SetBlendConfig(u16 effect, u8 coeffA, u8 coeffB, u8 blendY); 
extern const struct ProcCmd gProcScr_TerrainDisplay[]; 
extern const struct ProcCmd gProcScr_PrepMap_MenuButtonDisplay[]; 
void InitPlayerPhaseTerrainWindow(); 
struct ProcCmd const gProcScr_TerrainWindowMaker[] = {
    PROC_WHILE(DoesBMXFADEExist),

    PROC_CALL(InitPlayerPhaseTerrainWindow),

    PROC_END,
};
void InitPlayerPhaseTerrainWindow() {

    gLCDControlBuffer.dispcnt.win0_on = 0;
    gLCDControlBuffer.dispcnt.win1_on = 0;
    gLCDControlBuffer.dispcnt.objWin_on = 0;

    gLCDControlBuffer.wincnt.wout_enableBg0 = 1;
    gLCDControlBuffer.wincnt.wout_enableBg1 = 1;
    gLCDControlBuffer.wincnt.wout_enableBg2 = 1;
    gLCDControlBuffer.wincnt.wout_enableBg3 = 1;
    gLCDControlBuffer.wincnt.wout_enableObj = 1;
    gLCDControlBuffer.wincnt.wout_enableBlend = 1;

    BG_SetPosition(0, 0, 0);
    BG_SetPosition(1, 0, 0);
    BG_SetPosition(2, 0, 0);

    SetBlendConfig(1, 0xD, 3, 0);

    SetBlendTargetA(0, 1, 0, 0, 0);

    SetBlendBackdropA(0);

    SetBlendTargetB(0, 0, 1, 1, 1);

    Decompress(gGfx_PlayerInterfaceFontTiles, (void*)(VRAM + 0x2000));
    Decompress(gGfx_PlayerInterfaceNumbers, (void*)(VRAM + 0x15C00));

    CpuFastSet((void*)(VRAM + 0x2EA0), (void*)(VRAM + 0x15D40), 8);

    ApplyPalette(gPaletteBuffer, 0x18);

    LoadIconPalette(1, 2);

    ResetTextFont();

    if (gPlaySt.config.disableTerrainDisplay == 0) {
        Proc_Start(gProcScr_TerrainDisplay, PROC_TREE_3);
    }

    return;
}



void StartPlayerPhaseTerrainWindow() {
    Proc_Start(gProcScr_TerrainWindowMaker, PROC_TREE_3);
    return;
}
