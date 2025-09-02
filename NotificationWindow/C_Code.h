
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
};
struct AchievementsRomStruct
{
    const char * str; 
};
extern struct AchievementsRomStruct achievementData[];

extern u16 recruitmentData[]; 

void DoNotificationForAchievement(int id); 
#define ACHIEVEMENT_TYPE 1 

#include "BonusClaim.c"
#include "Achievements.c"
#include "Notifications.c"