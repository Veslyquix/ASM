#ifndef GUARD_eventinfo_H
#define GUARD_eventinfo_H

#include "global.h"
#include "event.h"
#include "bmunit.h"

enum { EVENT_NOSCRIPT = 1 };

enum
{
    TILE_COMMAND_NONE,

    TILE_COMMAND_VISIT    = 0x10,
    TILE_COMMAND_SEIZE    = 0x11,

    TILE_COMMAND_DOOR     = 0x12,
    TILE_COMMAND_BRIDGE   = 0x13,
    TILE_COMMAND_CHEST    = 0x14,
    TILE_COMMAND_15       = 0x15,
    TILE_COMMAND_ARMORY   = 0x16,
    TILE_COMMAND_VENDOR   = 0x17,
    TILE_COMMAND_SECRET   = 0x18,
    TILE_COMMAND_SHOP_UNK = 0x19,

    TILE_COMMAND_20       = 0x20,
};

enum {
    TUTORIAL_EVT_TYPE_PHASECHANGE = 0,
    TUTORIAL_EVT_TYPE_POSTACTION = 1,
    TUTORIAL_EVT_TYPE_ONSELECT = 2,
    TUTORIAL_EVT_TYPE_DESTSELECTED = 3,
    TUTORIAL_EVT_TYPE_AFTERMOVE = 4,
    TUTORIAL_EVT_TYPE_FORECAST = 5,
    TUTORIAL_EVT_TYPE_PLAYERPHASE = 6,
};

enum char_identifier_event {
    CHAR_EVT_PLAYER_LEADER = 0,
    CHAR_EVT_ACTIVE_UNIT = -1,
    CHAR_EVT_POSITION_AT_SLOTB = -2,
    CHAR_EVT_SLOT2 = -3,
};

struct EventInfo {
    /* 00 */ const EventListScr * listScript;
    /* 04 */ u32 script;
    /* 08 */ u32 flag;
    /* 0C */ u32 commandId;
    /* 10 */ u32 givenMoney;
    /* 14 */ u32 givenItem;
    /* 18 */ s8 xPos;
    /* 19 */ s8 yPos;
    /* 1A */ u8 pidA;
    /* 1B */ u8 pidB;
};

struct EventListCmdInfo {
    /* 00 */ int (*func)(struct EventInfo* buf);
    /* 04 */ int length;
};

struct SupportTalkEnt {
    /* 00 */ u16 unitA;
    /* 02 */ u16 unitB;

    /* 04 */ u16 msgSupports[3];

    /* 0A */ u16 _pad1;
    /* 0C */ u16 unk_0c_0 : 5;
    /* 0C */ u16 unk_0c_5 : 5;
    /* 0D */ u16 unk_0d_3 : 5;
} BITPACKED;

struct BattleTalkEnt {
    /* 00 */ u8 pid;
    /* 01 */ u8 chapter;
    /* 04 */ u32 msg;
    /* 08 */ u32 flag;
};

struct BattleTalkExtEnt {
    /* 00 */ u16 pidA;
    /* 02 */ u16 pidB;
    /* 04 */ u16 chapter;
    /* 06 */ u16 flag;
    /* 08 */ u16 msg;
    /* 0C */ EventScr * event;
};

struct DefeatTalkEnt {
    /* 00 */ u16 pid;
    /* 02 */ u8 route;
    /* 03 */ u8 chapter;
    /* 04 */ u16 flag;
    /* 06 */ u16 msg;
    /* 08 */ EventScr * event;
};

struct ForceDeploymentEnt {
    /* 00 */ u16 pid;
    /* 01 */ u8 route;
    /* 02 */ u8 chapter;
};

#define TUTORIAL_MODE() (!(gPlaySt.chapterStateBits & PLAY_FLAG_HARD) && gPlaySt.config.controller != 1)

void StartEventFromInfo(struct EventInfo* info, u8 execType);
struct EventInfo* SearchAvailableEvent(struct EventInfo* info);
struct EventInfo* SearchNextAvailableEvent(struct EventInfo* info);
bool EventInfoCheckTalk(struct EventInfo * info, u8 pidA, u8 pidB);
bool CheckActiveUnitArea(int x1, int y1, int x2, int y2);
bool CheckAnyBlueUnitArea(int x1, int y1, int x2, int y2);
bool CheckAnyBlueUnitArea1(void);
bool CheckAnyBlueUnitArea2(void);
bool CheckAnyBlueUnitArea3(void);
bool CheckAnyBlueUnitArea4(void);
bool CheckAnyBlueUnitArea5(void);
bool CheckAnyBlueUnitArea6(void);
bool CheckAnyBlueUnitArea7(void);
bool CheckAnyRedUnitArea(int x1, int y1, int x2, int y2);
bool IsThereClosedChestAt(s8 x, s8 y);
void StartAvailableChestTileEvent(s8, s8);
bool IsThereClosedDoorAt(s8 x, s8 y);
void StartAvailableDoorTileEvent(s8, s8);
bool IsThereTileCommand15(s8 x, s8 y);
bool ShouldCallEndEvent(void);
void MaybeCallEndEvent_(void);
void CallEndEvent(void);
bool sub_80832C4(void);
bool sub_80832C8(void);
bool sub_80832CC(void);
bool sub_80832D0(void);
bool sub_80832D4(void);
bool CheckWin(void);
void MaybeCallEndEvent(void);
const struct TrapData * GetTrapPointer(void);
const struct TrapData * GetHardModeTrapPointer(void);
const void * GetChapterAllyUnitDataPointer(void);
const struct UnitDefinition * GetChapterEnemyUnitDefinitions(void);
void GetChapterSkirmishLeaderClasses(u8 chapterId, u8* list);
bool sub_8083424(void);
struct BattleTalkEnt* GetAvailableBattleTalk(u8 pid, struct BattleTalkEnt* it);
bool ShouldCallBattleQuote(u8 charA, u8 charB);
void CallBattleQuoteEventsIfAny(u8 charA, u8 charB);
void SetPidDefeatedFlag(u8 pid, int flag);
bool ShouldDisplayDefeatTalkForPid(u8 pid);
void DisplayDefeatTalkForPid(u8 pid);
void sub_8083654(u16 pid);
void StartSupportTalk(u8, u8, int);
void StartSupportViewerTalk(u8, u8, int);
// ?? GetSupportTalkSong_(u8 unused, u8 pidA, u8 pidB, int rank);
void sub_80837B0(void);
bool sub_80837D8(void);
bool CheckTradeTutorial(void);
int EvCheck00_Always(struct EventInfo* info);
// ??? EvCheck01_AFEV(???);
// ??? EvCheck02_TURN(???);
// ??? EvCheck03_CHAR(???);
// ??? EvCheck04_CHARASM(???);
// ??? EvCheck05_LOCA(???);
// ??? EvCheck06_VILL(???);
// ??? EvCheck07_CHES(???);
// ??? EvCheck08_DOOR(???);
// ??? EvCheck09_(???);
// ??? EvCheck0A_SHOP(???);
// ??? EvCheck0B_AREA(???);
// ??? EvCheck0C_Never(???);
// ??? EvCheck0D_Never(???);
// ??? EvCheck0E_(???);
// ??? EvCheck0F_(???);
// ??? EvCheck10_(???);
// ??? SetChapterFlag(???);
// ??? ClearChapterFlag(???);
void ResetChapterFlags(void);
// ??? CheckChapterFlag(???);
// ??? SetPermanentFlag(???);
// ??? ClearPermanentFlag(???);
void ResetPermanentFlags(void);
bool CheckPermanentFlagFrom(int, void*);
bool CheckPermanentFlag(int);
void SetFlag(int);
void ClearFlag(int);
bool CheckFlag(int);
u8 *GetPermanentFlagBits();
int GetPermanentFlagBitsSize();
u8 *GetChapterFlagBits();
int GetChapterFlagBitsSize();
void EnqueueTutEvent(uintptr_t a, u8 b);
bool RunTutorialEvent(u8 type);
bool RunPhaseSwitchEvents(void);
bool CheckForCharacterEvents(u8 pidA, u8 pidB);
void StartCharacterEvent(u8, u8);
u16 sub_8083FFC(u16 itemId);
int GetAvailableTileEventCommand(s8, s8);
void StartAvailableTileEvent(s8, s8);
bool CheckForWaitEvents(void);
void RunWaitEvents(void);
bool TryCallSelectEvents(void);
bool StartDestSelectedEvent(void);
bool StartAfterUnitMovedEvent(void);
bool CheckBattleForecastTutorialEvent(void);
void StartBattleForecastTutorialEvent(void);
void StartPlayerPhaseStartTutorialEvent(void);
void ClearActiveEventRegistry(void);
void RegisterEventActivation(u32, u16);
u16 GetEventTriggerId(const void * script);
void SetFlag82(void);
bool CheckFlag82(void);
struct BattleTalkExtEnt* GetBattleQuoteEntry(u16, u16);
struct DefeatTalkEnt* GetDefeatTalkEntry(u16);
struct SupportTalkEnt* GetSupportTalkEntry(u16, u16);
u16 GetSupportTalkSong(u16, u16, u8);
struct SupportTalkEnt* GetSupportTalkList();
bool IsCharacterForceDeployed_(u16 pid);
int IsSethLArachelMyrrhInnes(u16 pid);

struct ActiveEventRegistry {
    /* 00 */ u32 scripts[10];
    /* 28 */ s16 flags[10];
    /* 3C */ s16 idx;
};

extern struct ActiveEventRegistry gActiveEventRegistry;

extern struct BattleTalkExtEnt gBattleTalkList[];
extern struct DefeatTalkEnt gDefeatTalkList[];
extern struct SupportTalkEnt gSupportTalkList[];
extern struct ForceDeploymentEnt gForceDeploymentList[];
extern u8 gPidList_SethLArachelMyrrhInnes[];

#endif // GUARD_eventinfo_H
