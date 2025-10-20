
//#include "include/gbafe.h" 
#include "gbafe.h" 

#define MaxEntriesPerCategory 60 
struct NewGuideSt
{
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
            struct Text popupText; 
    /* 7C */ struct Text unk_7c[6];
    /* AC */ struct Text unk_ac;
    /* B4 */ struct Text unk_b4[6];
    /* E4 */ struct Text unk_e4;
    /* EC */ struct Text unk_ec;
};

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

struct NewBonusClaimRamStruct
{
    u8 viewable;
};

struct AchievementsStruct
{
    u8 complete;
    u8 shown[3]; // save file 0, 1, or 2 
};
struct AchievementsRomStruct
{
    const char * str; 
    const char * details; 
    /* 08 */ u16 category; // title
    /* 0A */ u16 flag; 
};
extern int __aeabi_idivmod(int a, int b);
static int Modulo(int a, int b)
{
    return __aeabi_idivmod(a, b); // uses swi 6
}

#define QueueSize 10
struct NotificationWindowProc
{
    PROC_HEADER;
    u8 finishedPrinting;
    u8 showingBgm;
    s8 delayFrames;
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

    u8 colour[4]; // up to 0x41
    u16 queue[QueueSize];
    u8 type[QueueSize];
};

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
int GetAchievementColour(int id);
int GetAchievementPercentage(); 
int CountCompletedAchievements(); 
int CountTotalAchievements(); 
extern int Category_Terminator_Link; 
extern int Category_Rewards_Link; 

extern struct AchievementsRomStruct achievementData[];

extern u16 flagAchievements[]; 
extern u16 recruitmentAchievements[]; 
extern u16 equipAchievements[]; 
extern u16 promoAchievements[]; 

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
#include "Notifications.c"
#include "AchievementsMenu.c" 
#include "Autohooks.c" 


