

#include "C_Code.h" // headers 
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;

#define xTilesAmount 15
#define favTilesAmount 15

typedef struct {
    /* 00 */ PROC_HEADER;
	int timer;
    int tileID; 
    u8 actionID; 
    struct Unit* unit; 
    u16 xTiles[15]; 
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
u8 CanActiveUnitPromote(void);

#define InitProcLabel 0
#define RestartLabel 1
#define LoopLabel 2
#define UnitActionLabel 3 
#define PickupUnitLabel 4
#define ChooseTileLabel 5
#define EditMapLabel 6
#define EditTerrainLabel 7
#define EditTrapLabel 8
#define EndLabel 99 
#define PostActionLabel 10 

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
    
    
    PROC_LABEL(EndLabel), 
    
    PROC_CALL(ClearActiveUnitStuff),
    PROC_END,
};

void ChooseTileInit(DebuggerProc* proc) { // if need to load gfx 
    EndPlayerPhaseSideWindows(); 
    RenderTilesetRowOnBg2(proc); 
    return; 
}

void OffsetTileset(DebuggerProc* proc, int amount) { 
    int newVal = 0; 
    if (amount < 0) { 
        for (int i = 0; i < xTilesAmount; ++i) { 
            newVal = proc->xTiles[i] & 0x3FF; 
            proc->xTiles[i] = (newVal - ABS(amount)) & 0x3FF; 
        } 
    
    } 
    else { 
        for (int i = 0; i < xTilesAmount; ++i) { 
            newVal = proc->xTiles[i] & 0x3FF; 
            proc->xTiles[i] = (newVal + amount) & 0x3FF; 
        } 
    } 
    RenderTilesetRowOnBg2(proc);
}

// bg0 text, bg1 menu bgs, bg2 blank, bg3 map 
void ChooseTileIdle(DebuggerProc* proc) { 
    int x = 7; 
    int y = 9; 
    u16 keys = gKeyStatusPtr->newKeys | gKeyStatusPtr->repeatedKeys; 
    if (keys & A_BUTTON) {
        proc->tileID = proc->xTiles[7]; 
        Proc_Goto(proc, EditMapLabel); 
    }
    if (keys & A_BUTTON) {
        Proc_Goto(proc, EditMapLabel); 
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
    
    u16* tile = sTilesetConfig + (proc->xTiles[xTileMap] << 2);

    // TODO: palette id constants
    u16 base = gBmMapFog[yBmMap][xBmMap] ? (6 << 12) : (11 << 12);

    out[0x00 + 0] = base + *tile++;
    out[0x00 + 1] = base + *tile++;
    out[0x20 + 0] = base + *tile++;
    out[0x20 + 1] = base + *tile++;
}

void EditMapInit(DebuggerProc* proc) { 
    SetBackgroundTileDataOffset(2, 0);
    BG_Fill(gBG2TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT);
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
        gActionData.xMove = gActiveUnitMoveOrigin.x; 
        gActionData.yMove = gActiveUnitMoveOrigin.y; 
        PlayerPhase_ApplyUnitMovementWithoutMenu(proc); 
        ClearActiveUnitStuff(proc); 
        PlaySoundEffect(0x6B);
        Proc_Goto(proc, RestartLabel); 
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
    if ((gActionData.unitActionType != UNIT_ACTION_WAIT) && !gBmSt.just_resumed)
    {
        gActionData.suspendPointType = SUSPEND_POINT_DURINGACTION;
        WriteSuspendSave(SAVE_ID_SUSPEND);
    }

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

const struct MenuItemDef gMapMenuItems[] = {
    {"　戦績", 0xB03, 0x6E3, 0, 0x70, MenuAlwaysEnabled, 0, PickupUnitNow, 0, 0, 0}, 
    {"　状況", 0xB04, 0x6E0, 0, 0x6f, CanActiveUnitPromoteMenu, 0, StartPromotionNow, 0, 0, 0},
    {"　辞書", 0xB07, 0x6E5, 0, 0x74, CallArenaIsUnitAllowed, 0, StartArenaNow}, 
    {"　辞書", 0xB08, 0x6E5, 0, 0x74, MenuAlwaysEnabled, 0, CallEndEventNow}, 
    {"　辞書", 0xB09, 0x6E5, 0, 0x74, MenuAlwaysEnabled, 0, EditMapNow}, 
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
    gMapMenuItems,
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
    proc->timer = 0; 
    proc->actionID = 0; 
    proc->tileID = 1; 
    for (int i = 0; i < xTilesAmount; ++i) { 
        proc->xTiles[i] = i; 
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

