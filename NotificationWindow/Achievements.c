

void SetAchievement(struct AchievementsStruct * data, int i)
{
    int bit = i % 8;
    int offset = i / 8;
    data[offset].complete |= 1 << bit;
}
int IsAchievementComplete(int id)
{
    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&data[4];
    ent += id / 8;
    return ent->complete & (1 << (id % 8));
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

void UnlockAchievement(int id)
{

    CpuFill16(0, gpBonusClaimData, 0x144);
    LoadBonusContentData(gpBonusClaimData);
    if (IsAchievementComplete(id))
        return;

    struct NewBonusClaimRamStruct * data = (void *)gpBonusClaimData;
    struct AchievementsStruct * achievements = (void *)&data[4];
    DoNotificationForAchievement(id);
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
