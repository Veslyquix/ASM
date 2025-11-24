
//#include "include/gbafe.h" 
#include "gbafe.h" 


#define Ach_SRAM_Size 0x144 
#define Ach_Section_Size 0x50 
#define Ach_Max (Ach_Section_Size*8) // 640 


struct AchMenuSaveSt
{ 
    u32 displayType : 2; 
    u32 categoryIdx : 5; 
    u32 cat_offset : 5; 
    u32 detailsID : 6; 
    u32 details_offset : 6; 
}; 
extern struct AchMenuSaveSt gAchMenuSaveSt; // = 0x2022280 after gOpAnimSt;
// struct AchMenuSaveSt * const gAchMenuSaveSt = (void *)gGenericBuffer;
// struct AchMenuSt * const gAchMenuSt = (void *)gGenericBuffer;
void InitAchievementMenuSt(void); 
int AreAchievementsEnabled(); 

#define MaxEntriesPerCategory 60 
struct AchMenuSt
{
    s8 displayType; 
    /* 29 */ s8 categoryIdx;
    /* 2A */ s8 cat_offset; // unk_2a 
    /* 2B */ s8 detailsID; // unk_2b details ID id 
    /* 2C */ s8 details_offset; // unk_2c 
    /* 2D */ u8 unk_2d;
    /* 2E */ s8 detailLinesScrolled;
    /* 2F */ u8 state;
    /* 30 */ u8 sortMode;
    /* 3C */ u8 unk_3c;
    /* 3D */ u8 unk_3d;
    /* 3E */ u8 entriesInCat; // unk_3e 
    /* 3F */ u8 numDetailLines;
             u8 timer; // Vesly added 
    /* 40 */ u8 cat_chID[60]; // unk_40 CategoriesChapter 
    /* 54 */ u8 cat_topicID[60]; // unk_54 CategoriesTopic
    /* 68 */ u8 detailsEntry[60]; // unk_68 detailsID entry gives you the guide entry 
            struct Text popupText[5]; 
    /* 7C */ struct Text unk_7c[6];
    /* AC */ struct Text unk_ac;
    /* B4 */ struct Text unk_b4[6];
    /* E4 */ struct Text unk_e4;
    /* EC */ struct Text unk_ec;
};
struct AchMenuSt * const gAchMenuSt = (void *)gGenericBuffer;
extern struct ClassData* classTablePoin[]; 

#define BONUS_CLAIM_NUM_ENTRIES 32

#define MAX_ITEMS 32
#define availableBonusIdWords ((MAX_ITEMS + 31) / 32)
#define MAX_ACHIEVEMENTS 1000

struct BonusClaimEnt
{
    /* 00 */ u8 unseen;
    /* 01 */ u8 kind; // 2 = gold, 0/1 = items
    /* 02 */ u8 itemId;
    /* 03 */ char str[0x11]; // Only used in FE8
};

extern const struct BonusClaimEnt bonusData[];
extern u32* DebuggerProcCmd;
struct NewBonusClaimRamStruct
{
    u8 viewable;
};


struct AchievementsRomStruct
{
    const char * entryName; 
    const char * details; 
    /* 08 */ u16 category; // title
    /* 0A */ u16 flag; 
};

// based on GuideEnt / gGuideTable 
// struct AchievementsEnt
// {

    // /* 00 */ char* itemName;
    // /* 04 */ char* details;
    // /* 08 */ u16 category; // title
    // unused /* 01 */ u8 chapterTitle; // when sorting 
    // /* 0A */ u16 flag; 
// };

struct RewardsStruct
{
    u16 id;
    u8 percent;
    u8 type;

    union
    {
        struct
        {
            u16 item;
            u16 bonusId;
        };
        char* str;
    } reward;
};

extern int __aeabi_idivmod(int a, int b);
static int Modulo(int a, int b)
{
    if (!b) { return 0; } 
    return __aeabi_idivmod(a, b); // uses swi 6
}

#define QueueSize 10
struct NotificationWindowProc
{
    PROC_HEADER;
    u8 finishedPrinting;
    u8 showingBgm;
    u8 delayFrames;
    char * str;
    char * strOriginal;
    s16 id;
    u16 bgm;

    s16 unitClock;
    u8 line;
    u8 lines;
    u8 spriteText;
    u8 active;

    u8 fastPrint;
    u8 initDelay; 

    u8 colour[4]; // up to 0x41
    s16 queue[QueueSize];
    s8 type[QueueSize];
};


int CheckInBattleAnim(void);
void NotificationSetFastPrint(struct NotificationWindowProc * proc); 
extern const int DisableBGMNotificationsFlag;
extern int DebugFlag_Link;
extern int AchievementsDisabledFlag_Link;

void UnlockBonusItem(int id);
void UnlockAchievement(int id); 
void UnlockAchievementNoMsg(int id); 
void RestartNotificationProc(struct PlayerInterfaceProc * parent); 
void DisplayNotifBoxObj(int x, int y, int w, int h, int hideHelpText); 
void NotificationInitSpriteText(void * vram); 
void NotificationWindow_Init(struct NotificationWindowProc * proc);
void NotificationWindow_Loop_Display(struct NotificationWindowProc * proc);
void NotificationWindow_LoopDrawText(struct NotificationWindowProc * proc);
void NotificationWindowDraw(struct NotificationWindowProc * proc);
void NotificationWindowClean(struct NotificationWindowProc * proc);
char * NotificationPrintText(struct NotificationWindowProc * proc, struct Text * th, const char * str);
void NotificationIdleWhileMenuEtc(struct NotificationWindowProc * proc);
void NotificationWindow_Idle(struct NotificationWindowProc * proc);
void StartNotificationProc(int id, int type);
int CountStrLines(const char * str);
int GetNotificationStringTextLenASCII_Wrapped(const char * str);
int IsAchievementComplete(int); 
void UnlockAll(void);
void LockAll(void);
struct AchievementsStruct
{
    u8 complete[Ach_Section_Size];
    u8 shown[Ach_Section_Size * 3];
};
int IsAchievementCompleteFilter(int id, struct AchievementsStruct * ent, struct AchievementsRomStruct * data, int perc); 


int GetAchievementColour(int id);
int GetAchievementPercentage(); 
int CountCompletedAchievements(); 
int CountTotalAchievements(); 
extern int Category_Terminator_Link; 
extern int Category_Rewards_Link; 

// extern struct AchievementsRomStruct achievementData[];
extern struct AchievementsRomStruct gAchievementsTable[]; 

struct combatStruct {
    int (*customFunc)(struct BattleHit *round, struct BattleHit *roundNext, struct BattleUnit *bunitA, struct BattleUnit *bunitB);
    u16 id;
    u16 pad;
};
extern struct combatStruct combatAchievements[];
extern u16 flagAchievements[]; 
extern u16 recruitmentAchievements[]; 
extern u16 equipAchievements[]; 
extern u16 itemUseAchievements[]; 
extern u16 promoAchievements[]; 
extern struct RewardsStruct rewardsByPercentage[]; 

struct turnCountStruct { 
    u16 achievementDataID; 
    u16 turnCount; 
}; 
struct chapterTimeStruct { 
    u16 achievementDataID; 
    u16 chapterTime; 
}; 

extern struct turnCountStruct turnCountAchievements[]; 
extern struct chapterTimeStruct chapterTimeAchievements[]; 

void DoNotificationForAchievement(int id); 
#define ACHIEVEMENT_TYPE 1 

#include "BonusClaim.c"
#include "Achievements.c"
#include "Combat.c"
#include "Notifications.c"
#include "AchievementsMenu.c" 
#include "Autohooks.c" 


