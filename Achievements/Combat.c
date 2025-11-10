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
    struct BattleHit * roundNext = GetRoundData(roundID + 1);

    int (*customFunc)(
        struct BattleHit * round, struct BattleHit * roundNext, struct BattleUnit * bunitA, struct BattleUnit * bunitB);
    for (int i = 0; i < 512; ++i)
    {
        customFunc = combatAchievements[i].customFunc;
        if ((int)customFunc == (-1))
        {
            break;
        }
        if (customFunc && *customFunc)
        {
            // if (customFunc(round, bunitA, bunitB) || customFunc(round, bunitB, bunitA)) {
            if (customFunc(round, roundNext, bunitA, bunitB))
            {
                UnlockAchievement(combatAchievements[i].id);
            }
        }
    }
}
int IsPlayer(struct BattleUnit * bunitA)
{
    return UNIT_FACTION(&bunitA->unit) == FACTION_BLUE;
}
int Check30DmgFunc(
    struct BattleHit * round, struct BattleHit * roundNext, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    if (!IsPlayer(bunitA))
    {
        return false;
    }
    if (round->hpChange > 30)
    {
        return true;
    }
    return false;
}
int Check50DmgFunc(
    struct BattleHit * round, struct BattleHit * roundNext, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    if (!IsPlayer(bunitA))
    {
        return false;
    }
    if (round->hpChange > 50)
    {
        return true;
    }
    return false;
}
int Check100DmgFunc(
    struct BattleHit * round, struct BattleHit * roundNext, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    if (!IsPlayer(bunitA))
    {
        return false;
    }
    if (round->hpChange > 100)
    {
        return true;
    }
    return false;
}

int CheckOHKODmgFunc(
    struct BattleHit * round, struct BattleHit * roundNext, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    if (!IsPlayer(bunitA))
    {
        return false;
    }
    if (round->hpChange >= bunitB->hpInitial && bunitB->hpInitial >= bunitB->unit.maxHP)
    {
        return true;
    }
    return false;
}

int Check1HPSurvFunc(
    struct BattleHit * round, struct BattleHit * roundNext, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    // bunitA / bunitB are already post-battle in terms of hp etc., so display at end of battle
    if (roundNext->info & BATTLE_HIT_INFO_END) // if you want the popup to display at the end of battle
    {
        if (bunitA->unit.curHP == 1 && IsPlayer(bunitA))
        {
            return true;
        }
        if (bunitB->unit.curHP == 1 && IsPlayer(bunitB))
        {
            return true;
        }
    }
    return false;
}

int Check1HPWinFunc(
    struct BattleHit * round, struct BattleHit * roundNext, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    if (roundNext->info & BATTLE_HIT_INFO_END)
    {
        if (bunitA->unit.curHP == 1 && IsPlayer(bunitA) && bunitB->unit.curHP == 0)
        {
            return true;
        }
        if (bunitB->unit.curHP == 1 && IsPlayer(bunitB) && bunitA->unit.curHP == 0)
        {
            return true;
        }
    }
    return false;
}

int CheckWTDFunc(
    struct BattleHit * round, struct BattleHit * roundNext, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    if (roundNext->info & BATTLE_HIT_INFO_END)
    {
        if (bunitA->wTriangleHitBonus < 0 && IsPlayer(bunitA) && bunitB->unit.curHP == 0)
        {
            return true;
        }
        if (bunitB->wTriangleHitBonus < 0 && IsPlayer(bunitB) && bunitA->unit.curHP == 0)
        {
            return true;
        }
    }
    return false;
}

int DoesUnitHaveMoreOfWep(struct BattleUnit * bunit)
{
    int wep = bunit->weapon;
    int weaponSlotIndex = bunit->weaponSlotIndex;
    struct Unit * unit = &bunit->unit;
    for (int i = 0; i < 5; ++i)
    {
        if (i == weaponSlotIndex)
        {
            continue;
        }
        if (ITEM_INDEX(unit->items[i]) == ITEM_INDEX(wep))
        {
            return true;
        }
    }
    return false;
}

int CheckBrokeLastWepFunc(
    struct BattleHit * round, struct BattleHit * roundNext, struct BattleUnit * bunitA, struct BattleUnit * bunitB)
{
    if (roundNext->info & BATTLE_HIT_INFO_END)
    {
        if (bunitA->weaponBroke && DoesUnitHaveMoreOfWep(bunitA) && IsPlayer(bunitA) && bunitB->unit.curHP == 0)
        {
            return true;
        }
        if (bunitB->weaponBroke && DoesUnitHaveMoreOfWep(bunitA) && IsPlayer(bunitB) && bunitA->unit.curHP == 0)
        {
            return true;
        }
    }
    return false;
}
