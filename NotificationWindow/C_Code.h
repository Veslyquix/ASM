
//#include "include/gbafe.h" 
#include "gbafe.h" 



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

int IsAchievementComplete(int); 

extern struct AchievementsRomStruct achievementData[];

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


