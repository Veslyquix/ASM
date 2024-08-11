

#include "C_Code.h" // headers 
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;

typedef struct {
    /* 00 */ PROC_HEADER;
	int timer;
    int hpBarTimer; 
    int roundId; 
    u8 actionID; 
    struct Unit* unit; 
} DebuggerProc;
void LoopDebuggerProc(DebuggerProc* proc);
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

#define LoopLabel 0 
#define UnitActionLabel 1 
#define EndLabel 99 
#define PostActionLabel 10 

#define ActionID_Promo 1 
#define ActionID_Arena 2 

const struct ProcCmd DebuggerProcCmd[] =
{
	PROC_NAME("DebuggerProcName"), 
    PROC_YIELD,
    PROC_LABEL(LoopLabel), // loop indefinitely 
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
    
    PROC_LABEL(EndLabel), 
    
    PROC_CALL(ClearActiveUnitStuff),
    PROC_END,
};

void ClearActiveUnitStuff(DebuggerProc* proc) { 
    MU_EndAll(); 
    gActiveUnit->state = gActiveUnit->state & ~(US_UNSELECTABLE|US_CANTOING); 
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



const struct MenuItemDef gMapMenuItems[] = {
    //{"　部隊", 0x69A, 0x6DF, 0, 0x6e, MenuAlwaysEnabled, 0, MapMenu_UnitCommand, 0, 0, 0}, // Unit >
    {"　状況", 0x690, 0x6E0, 0, 0x6f, MenuAlwaysEnabled, 0, StartPromotionNow, 0, 0, 0}, // Status >
    {"　辞書", 0x69C, 0x6E5, 4, 0x74, MapMenu_IsGuideCommandAvailable, MapMenu_GuideCommandDraw, StartArenaNow}, // Guide
    {"　戦績", 0x69E, 0x6E3, 0, 0x70, MapMenu_IsRecordsCommandAvailable, 0, MapMenu_RecordsCommand, 0, 0, 0}, // Records
    {"　設定", 0x69B, 0x6E1, 0, 0x71, MenuAlwaysEnabled, 0, MapMenu_OptionsCommand, 0, 0, 0}, // Options
    {"　退却", 0x69D, 0x6E2, 0, 0x72, MapMenu_IsRetreatCommandAvailable, 0, MapMenu_RetreatCommand, 0, 0, 0}, // Retreat
    {"　中断", 0x69F, 0x6E4, 0, 0x73, MapMenu_IsSuspendCommandAvailable, 0, MapMenu_SuspendCommand, 0, 0, 0}, // Suspend
    {"　終了", 0x6A0, 0x6E6, 0, 0x78, MenuAlwaysEnabled, 0, CommandEffectEndPlayerPhase, 0, 0, 0}, // End Phase
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
    UnitBeginActionInit(unit); 
	DebuggerProc* proc; 
	proc = Proc_Find(DebuggerProcCmd); 
	if (!proc) { 
		//proc = Proc_Start(DebuggerProcCmd, (void*)3); 
		proc = Proc_StartBlocking(DebuggerProcCmd, playerPhaseProc); 
	} 
    proc->timer = 0; 
    proc->hpBarTimer = 0; 
    proc->roundId = 0xFF;
    proc->unit = unit; 
    proc->actionID = 0; 

    EndPlayerPhaseSideWindows();
    gPlaySt.xCursor = gBmSt.playerCursor.x;
    gPlaySt.yCursor = gBmSt.playerCursor.y;
    //MU_EndAll();
    //ShowUnitSprite(unit);
    //UnitSpriteHoverUpdate();
    RefreshBMapGraphics();

    //gBmMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
    gActiveUnit->state |= US_HIDDEN;
    HideUnitSprite(gActiveUnit);
    MakeMoveunitForActiveUnit(); 
    Proc_Goto(playerPhaseProc, 9); // wait for menu? 
    gBmSt.gameStateBits &= ~(BM_FLAG_0 | BM_FLAG_1);
    gBmSt.gameStateBits &= ~BM_FLAG_3;
    PutMapCursor(
        gBmSt.playerCursorDisplay.x, gBmSt.playerCursorDisplay.y,
        IsUnitSpriteHoverEnabledAt(gBmSt.playerCursor.x, gBmSt.playerCursor.y) ? 3 : 0);
    StartOrphanMenuAdjusted(&gDebuggerMenuDef, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x15);
    
    
    
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




