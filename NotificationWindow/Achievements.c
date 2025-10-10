

// to do:
// on new game, wipe shown[0], shown[1], or shown[2] - DONE
// on copy save, overwrite shown[0], shown[1], or shown[2] - not done
#define AchBits (8 / 4);

extern int DebugFlag_Link;
int CannotUnlockAchievements(void)
{
    return !CheckFlag(DebugFlag_Link);
}
extern int AlwaysShowAchievement;
void SetAchievement(struct AchievementsStruct * data, int i)
{
    int bit = i % 8;
    int offset = i / AchBits;
    data[offset].complete |= 1 << bit;
}
void ShownAchievement(struct AchievementsStruct * data, int i)
{
    int slot = gPlaySt.gameSaveSlot;
    int bit = i % 8;
    int offset = i / AchBits;
    data[offset].shown[slot] |= 1 << bit;
}

int IsAchievementComplete(int id)
{
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&data[4];
    ent += id / AchBits;
    return ent->complete & (1 << (id % 8));
}
int IsAchievementShown(int id)
{
    int slot = gPlaySt.gameSaveSlot;
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&data[4];
    ent += id / AchBits;
    return ent->shown[slot] & (1 << (id % 8));
}

int GetAchievementColour(int id)
{
    int everComplete = IsAchievementComplete(id);
    int doneOnThisSaveFile = IsAchievementShown(id);

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
        achievements[i].shown[slot] = 0;
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

void CreateBonusContentData()
{
    // UnlockAchievement(0);
    // UnlockAll();
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
