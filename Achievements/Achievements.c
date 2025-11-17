

// to do:
// on new game, wipe shown[0], shown[1], or shown[2] - DONE
// on copy save, overwrite shown[0], shown[1], or shown[2] - DONE
#define AchMod 8
#define AchDiv 8

void SetAchievementsTo(int id)
{
    if (id)
    {
        ClearFlag(AchievementsDisabledFlag_Link);
    }
    else
    {
        SetFlag(AchievementsDisabledFlag_Link);
    }
}
void SetBgmNotifTo(int id)
{
    if (id)
    {
        ClearFlag(DisableBGMNotificationsFlag);
    }
    else
    {
        SetFlag(DisableBGMNotificationsFlag);
    }
}

int AreAchievementsEnabled()
{

    return !CheckFlag(AchievementsDisabledFlag_Link);
}
int AreBgmNotifsEnabled()
{

    return !CheckFlag(DisableBGMNotificationsFlag);
}
int CannotUnlockAchievements(void) // debugger on
{
    return false;
    // return !CheckFlag(DebugFlag_Link);
}

extern int AlwaysShowAchievement;

void SetAchievement(struct AchievementsStruct * data, int i)
{
    int bit = Modulo(i, AchMod);
    int offset = i / AchDiv;
    data->complete[offset] |= 1 << bit;
}
void ShownAchievement(struct AchievementsStruct * data, int i)
{
    int slot = gPlaySt.gameSaveSlot;
    int bit = Modulo(i, AchMod);
    int offset = i / AchDiv;
    offset += slot * Ach_Section_Size;

    data->shown[offset] |= 1 << bit;
}
int IsAchievementComplete(int i)
{
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&data[4];
    int bit = Modulo(i, AchMod);
    int offset = i / AchDiv;
    return ent->complete[offset] & (1 << bit);
}
int IsAchievementShown(int i)
{
    int slot = gPlaySt.gameSaveSlot;
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&data[4];
    int bit = Modulo(i, AchMod);
    int offset = i / AchDiv;
    offset += slot * Ach_Section_Size;
    return ent->shown[offset] & (1 << bit);
}

int IsAchievementCompletePerc(int id, struct AchievementsStruct * ent, struct AchievementsRomStruct * data)
{
    data += id;
    if (data->category == Category_Rewards_Link)
    {
        return false;
    }
    int bit = Modulo(id, AchMod);
    int offset = id / AchDiv;
    return ent->complete[offset] & (1 << bit);
}
int IsAchievementShown2(int i, struct AchievementsStruct * ent)
{
    int slot = gPlaySt.gameSaveSlot;
    int bit = Modulo(i, AchMod);
    int offset = i / AchDiv;
    offset += slot * Ach_Section_Size;
    return ent->shown[offset] & (1 << bit);
}

int IsAchievementCompleteFilter(int id, struct AchievementsStruct * ent, struct AchievementsRomStruct * data, int perc)
{

    data += id;
    int bit = Modulo(id, AchMod);
    int offset = id / AchDiv;
    if (data->category == Category_Rewards_Link)
    {
        if (IsAchievementShown2(id, ent))
        {
            return true;
        }
        if (rewardsByPercentage[id].percent <= perc)
        {
            return true;
        }
        return false;

        // return IsAchievementShown(id);
    }
    return ent->complete[offset] & (1 << bit);
}

int CountTotalAchievements()
{
    int i = 0;
    struct AchievementsRomStruct * data = gAchievementsTable;
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
    if (i < 1)
    {
        i = 1;
    }
    return i;
}

int CountCompletedAchievements()
{
    int max = CountTotalAchievements();
    struct NewBonusClaimRamStruct * tmp = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&tmp[4];
    struct AchievementsRomStruct * data = gAchievementsTable;
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
    int result = (done * 100) / max;
    return result;
}

int GetAchievementColour(int id)
{
    int everComplete = IsAchievementComplete(id);
    int doneOnThisSaveFile = IsAchievementShown(id);

    struct AchievementsRomStruct * data = gAchievementsTable;
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
    CpuFill16(0, gpBonusClaimData, Ach_SRAM_Size);
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
    CpuFill16(0xFF, gpBonusClaimData, Ach_SRAM_Size);
    SaveBonusContentData(gpBonusClaimData);
}
void LockAll(void)
{
    CpuFill16(0, gpBonusClaimData, Ach_SRAM_Size);
    SaveBonusContentData(gpBonusClaimData);
}

void ClearAchievementsForSlot(int slot)
{
    CpuFill16(0, gpBonusClaimData, Ach_SRAM_Size);
    LoadBonusContentData(gpBonusClaimData);
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * achievements = (void *)&data[4];
    slot = Ach_Section_Size * slot;
    int end = slot + Ach_Section_Size;
    for (int i = slot; i < end; ++i)
    {
        achievements->shown[i] = 0;
    }
    SaveBonusContentData(data);
}

void CopyAchievementsForSlots(int slotSrc, int slotDst)
{
    CpuFill16(0, gpBonusClaimData, Ach_SRAM_Size);
    LoadBonusContentData(gpBonusClaimData);
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * achievements = (void *)&data[4];
    slotDst = Ach_Section_Size * slotDst;
    int end = slotDst + Ach_Section_Size;
    slotSrc = Ach_Section_Size * slotSrc;
    for (; slotDst < end; ++slotDst)
    {
        achievements->shown[slotDst] = achievements->shown[slotSrc];
        slotSrc++;
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
    CpuFill16(0, gpBonusClaimData, Ach_SRAM_Size);
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
    if (CannotUnlockAchievements())
    {
        return;
    }
    int saveData = false;
    CpuFill16(0, gpBonusClaimData, Ach_SRAM_Size);
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
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_Classes_Link);
}
extern int Reward_Growths_Link;
int IsGrowthsOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_Growths_Link);
}
extern int Reward_StatCaps_Link;
int IsStatCapsOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_StatCaps_Link);
}
extern int Reward_CasualMode_Link;
int IsCasualModeOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_CasualMode_Link);
}
extern int Reward_FromGame_Link;
int IsFromGameOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_FromGame_Link);
}

extern int Reward_BonusLevels_Link;
int IsBonusLevelsOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_BonusLevels_Link);
}
extern int Reward_Recruitment_Link;
int IsRecruitmentOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_Recruitment_Link);
}
extern int Reward_FilterClasses_Link;
int IsFilterClassesOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_FilterClasses_Link);
}
extern int Reward_FilterChars_Link;
int IsFilterCharsOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_FilterChars_Link);
}
extern int Reward_Skills_Link;
int IsSkillsOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_Skills_Link);
}
extern int Reward_TimedHits_Link;
int IsTimedHitsOptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_TimedHits_Link);
}
extern int Reward_Clutter1_Link;
int IsClutter1OptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_Clutter1_Link);
}
extern int Reward_Clutter2_Link;
int IsClutter2OptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_Clutter2_Link);
}
extern int Reward_Clutter3_Link;
int IsClutter3OptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_Clutter3_Link);
}
extern int Reward_Clutter4_Link;
int IsClutter4OptionAvailable(void)
{
    if (!AreAchievementsEnabled())
    {
        return 1;
    }
    return IsAchievementComplete(Reward_Clutter4_Link);
}
