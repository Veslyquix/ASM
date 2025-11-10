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

void UnlockAchievementByCombat(int pid)
{
    struct Unit * unit = GetUnitFromCharId(pid);
    struct BattleUnit * bunit = &gBattleActor;

    if (unit->index != bunit->unit.index)
    {
        bunit = &gBattleTarget;
    }
    struct BattleHit * round = GetRoundData(0);
    brk;
    bunit->unit.def = round->hpChange;
    round = GetRoundData(1);
    bunit->unit.skl = round->hpChange;
    brk;

    return;
}
