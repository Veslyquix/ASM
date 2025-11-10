

// to do:
// on new game, wipe shown[0], shown[1], or shown[2] - DONE
// on copy save, overwrite shown[0], shown[1], or shown[2] - not done
#define AchMod 4
#define AchDiv 8
extern int DebugFlag_Link;
int CannotUnlockAchievements(void)
{
    return false;
    // return !CheckFlag(DebugFlag_Link);
}

extern int AlwaysShowAchievement;
struct AchievementsStruct
{
    u16 complete : 4;
    u16 shown0 : 4; // save 0
    u16 shown1 : 4; // save 1
    u16 shown2 : 4; // save 2
};
void SetAchievement(struct AchievementsStruct * data, int i)
{
    int bit = i % AchMod;
    int offset = i / AchDiv;
    brk;
    data[offset].complete |= 1 << bit;
}
void ShownAchievement(struct AchievementsStruct * data, int i)
{
    int slot = gPlaySt.gameSaveSlot;
    int bit = i % AchMod;
    int offset = i / AchDiv;
    switch (slot)
    {
        case 0:
        {
            data[offset].shown0 |= 1 << bit;
            break;
        }
        case 1:
        {
            data[offset].shown1 |= 1 << bit;
            break;
        }
        case 2:
        {
            data[offset].shown2 |= 1 << bit;
            break;
        }
    }
}
int IsAchievementComplete(int id)
{
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&data[4];
    ent += id / AchDiv;
    return ent->complete & (1 << (id % AchMod));
}
int IsAchievementShown(int id)
{
    int slot = gPlaySt.gameSaveSlot;
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&data[4];
    ent += id / AchDiv;
    switch (slot)
    {
        case 0:
        {
            return ent->shown0 & (1 << (id % AchMod));
        }
        case 1:
        {
            return ent->shown1 & (1 << (id % AchMod));
        }
        case 2:
        {
            return ent->shown2 & (1 << (id % AchMod));
        }
    }
    return 0;
}

int CountTotalAchievements()
{
    int i = 0;
    struct AchievementsRomStruct * data = achievementData;
    while (data->category != Category_Terminator_Link)
    {
        if (data->category == Category_Rewards_Link)
        {
            data++;
            continue;
        }

        data++;
        i++;
    }

    return i;
}

int IsAchievementCompletePerc(int id, struct AchievementsStruct * ent, struct AchievementsRomStruct * data)
{
    data += id;
    if (data->category == Category_Rewards_Link)
    {
        return false;
    }
    ent += id / AchDiv;
    return ent->complete & (1 << (id % AchMod));
}

int CountCompletedAchievements()
{
    int max = CountTotalAchievements();
    struct NewBonusClaimRamStruct * tmp = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&tmp[4];
    struct AchievementsRomStruct * data = achievementData;
    int c = 0;
    for (int i = 0; i < max; ++i)
    {
        if (IsAchievementCompletePerc(i, ent, data))
            c++;
    }
    return c;
}

int GetAchievementPercentage()
{
    int done = CountCompletedAchievements();
    int max = CountTotalAchievements();
    // brk;
    int result = (done * 100) / max;
    return result;
}

int GetAchievementColour(int id)
{
    int everComplete = IsAchievementComplete(id);
    int doneOnThisSaveFile = IsAchievementShown(id);

    struct AchievementsRomStruct * data = achievementData;
    data += id;
    if (data->category == Category_Rewards_Link)
    {
        if (doneOnThisSaveFile)
        {
            return TEXT_COLOR_SYSTEM_WHITE; // already claimed
        }
        int perc = GetAchievementPercentage();
        if (rewardsByPercentage[id].percent <= perc)
        {
            return TEXT_COLOR_SYSTEM_GOLD; // available to claim
        }
        return TEXT_COLOR_SYSTEM_GRAY; // not enough percentage completion
    }

    // not rewards
    if (everComplete && doneOnThisSaveFile)
    {
        return TEXT_COLOR_SYSTEM_GOLD;
    }

    if (!everComplete && !doneOnThisSaveFile)
    {
        return TEXT_COLOR_SYSTEM_GRAY;
    }
    return TEXT_COLOR_SYSTEM_WHITE;
}

void UnlockAllAchievements(void)
{
    CpuFill16(0, gpBonusClaimData, 0x144);
    LoadBonusContentData(gpBonusClaimData);
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    // should use up 4 bytes
    // now use the remaining 0x140 bytes for achievements
    struct AchievementsStruct * achievements = (void *)&data[4];
    for (int i = 0; i < MAX_ACHIEVEMENTS; ++i)
    {
        SetAchievement(achievements, i);
    }
    SaveBonusContentData(data);
}

void UnlockAll(void)
{
    CpuFill16(0xFF, gpBonusClaimData, 0x144);
    SaveBonusContentData(gpBonusClaimData);
}
void LockAll(void)
{
    CpuFill16(0, gpBonusClaimData, 0x144);
    SaveBonusContentData(gpBonusClaimData);
}

#define SRAM_alloc 0x140
void ClearAchievementsForSlot(int slot)
{
    CpuFill16(0, gpBonusClaimData, 0x144);
    LoadBonusContentData(gpBonusClaimData);
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * achievements = (void *)&data[4];
    for (int i = 0; i < SRAM_alloc; ++i)
    {
        achievements[i].shown0 = 0;
        achievements[i].shown1 = 0;
        achievements[i].shown2 = 0;
    }
    SaveBonusContentData(data);
}

void UnlockAchievement(int id)
{
    if (!id)
    {
        return;
    }
    if (CannotUnlockAchievements())
    {
        return;
    }
    int saveData = false;
    CpuFill16(0, gpBonusClaimData, 0x144);
    LoadBonusContentData(gpBonusClaimData);
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * achievements = (void *)&data[4];
    if (!IsAchievementShown(id))
    {
        ShownAchievement(achievements, id);
        DoNotificationForAchievement(id);
        saveData = true;
    }
    if (IsAchievementComplete(id) && !saveData)
        return;

    SetAchievement(achievements, id);
    SaveBonusContentData(data);
}
void UnlockAchievementNoMsg(int id)
{
    if (!id)
    {
        return;
    }
    int saveData = false;
    CpuFill16(0, gpBonusClaimData, 0x144);
    LoadBonusContentData(gpBonusClaimData);
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * achievements = (void *)&data[4];
    if (!IsAchievementShown(id))
    {
        ShownAchievement(achievements, id);
        saveData = true;
    }
    if (IsAchievementComplete(id) && !saveData)
        return;

    SetAchievement(achievements, id);
    SaveBonusContentData(data);
}

void CreateBonusContentData()
{
    // UnlockAchievement(0);
    // UnlockAll();
}
void UnlockAchievementByFlag(int flagID)
{
    UnlockAchievement(flagAchievements[flagID]);
}
void UnlockAchievementByRecruitment(int charID)
{
    UnlockAchievement(recruitmentAchievements[charID]);
}
void UnlockAchievementByEquip(int itemID)
{
    UnlockAchievement(equipAchievements[itemID]);
}
void UnlockAchievementByPromo(int jid)
{
    UnlockAchievement(promoAchievements[jid]);
}
void UnlockAchievementByTurnCount()
{
    int turnCount = gPlaySt.chapterTurnNumber;
    int chapterId = gPlaySt.chapterIndex;
    if (turnCount <= turnCountAchievements[chapterId].turnCount)
        UnlockAchievement(turnCountAchievements[chapterId].achievementDataID);
}
void UnlockAchievementByChapterTime()
{
    int time = (GetGameClock() - gPlaySt.time_chapter_started) / 60;
    int chapterId = gPlaySt.chapterIndex;
    if (time <= chapterTimeAchievements[chapterId].chapterTime)
        UnlockAchievement(chapterTimeAchievements[chapterId].achievementDataID);
}

void UnlockAchievementByItemUse(int item)
{
    UnlockAchievement(itemUseAchievements[item & 0xFF]);
}

extern int Reward_Classes_Link;
int IsClassesOptionAvailable(void)
{
    return IsAchievementComplete(Reward_Classes_Link);
}
extern int Reward_Growths_Link;
int IsGrowthsOptionAvailable(void)
{
    return IsAchievementComplete(Reward_Growths_Link);
}
extern int Reward_StatCaps_Link;
int IsStatCapsOptionAvailable(void)
{
    return IsAchievementComplete(Reward_StatCaps_Link);
}
extern int Reward_CasualMode_Link;
int IsCasualModeOptionAvailable(void)
{
    return IsAchievementComplete(Reward_CasualMode_Link);
}
extern int Reward_FromGame_Link;
int IsFromGameOptionAvailable(void)
{
    return IsAchievementComplete(Reward_FromGame_Link);
}

extern int Reward_BonusLevels_Link;
int IsBonusLevelsOptionAvailable(void)
{
    return IsAchievementComplete(Reward_BonusLevels_Link);
}
extern int Reward_Recruitment_Link;
int IsRecruitmentOptionAvailable(void)
{
    return IsAchievementComplete(Reward_Recruitment_Link);
}
extern int Reward_FilterClasses_Link;
int IsFilterClassesOptionAvailable(void)
{
    return IsAchievementComplete(Reward_FilterClasses_Link);
}
extern int Reward_FilterChars_Link;
int IsFilterCharsOptionAvailable(void)
{
    return IsAchievementComplete(Reward_FilterChars_Link);
}
extern int Reward_Skills_Link;
int IsSkillsOptionAvailable(void)
{
    return IsAchievementComplete(Reward_Skills_Link);
}
extern int Reward_TimedHits_Link;
int IsTimedHitsOptionAvailable(void)
{
    return IsAchievementComplete(Reward_TimedHits_Link);
}
extern int Reward_Clutter1_Link;
int IsClutter1OptionAvailable(void)
{
    return IsAchievementComplete(Reward_Clutter1_Link);
}
extern int Reward_Clutter2_Link;
int IsClutter2OptionAvailable(void)
{
    return IsAchievementComplete(Reward_Clutter2_Link);
}
extern int Reward_Clutter3_Link;
int IsClutter3OptionAvailable(void)
{
    return IsAchievementComplete(Reward_Clutter3_Link);
}
extern int Reward_Clutter4_Link;
int IsClutter4OptionAvailable(void)
{
    return IsAchievementComplete(Reward_Clutter4_Link);
}
