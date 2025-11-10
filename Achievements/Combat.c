/*
struct BattleHit {
    unsigned attributes : 19;
    unsigned info       : 5;
    signed   hpChange   : 8;
    // u8 skillID; // skillsys added
    // s8 cappedDmg;
    // s16 overDmg;
};
*/
extern struct BattleHit ** sBattleHitArray; // 2aec4
extern u8 BattleHitArrayWidth;              // 2b90a
extern struct BattleHit * GetRoundData(int roundID)
{
    u32 round = (u32)sBattleHitArray;
    round += (u32)BattleHitArrayWidth * roundID;

    return (struct BattleHit *)round;
}

void UnlockAchievementByCombat(int pid, int roundID)
{
    struct Unit * unit = GetUnitFromCharId(pid);
    struct BattleUnit * bunitA = &gBattleActor;
    struct BattleUnit * bunitB = &gBattleTarget;

    if (unit->index != bunitA->unit.index)
    {
        bunitA = &gBattleTarget;
        bunitB = &gBattleActor;
    }
    struct BattleHit * round = GetRoundData(roundID);
    int (*customFunc)(struct BattleHit *, struct BattleUnit *, struct BattleUnit *);
    for (int i = 0; i < 512; ++i)
    {
        customFunc = combatAchievements[i].customFunc;
        if ((int)customFunc == (-1))
        {
            break;
        }
        if (customFunc && customFunc(round, bunitA, bunitB))
        {

            UnlockAchievement(combatAchievements[i].id);
        }
    }
}

int Check30DmgFunc(struct BattleHit * round, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    if (round->hpChange > 3)
    {
        return true;
    }
    return false;
}
int Check50DmgFunc(struct BattleHit * round, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    if (round->hpChange > 5)
    {
        return true;
    }
    return false;
}
