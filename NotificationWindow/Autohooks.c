
// the entirety of BonusClaim.c replaces functions, too
void EquipUnitItemSlot(struct Unit * unit, int itemSlot)
{
    int item = unit->items[itemSlot];

    switch (itemSlot) // compiler was using memmove and causing a crash, so I swapped to a switch case
    {
        case 4:
            unit->items[4] = unit->items[3]; // no break;
        case 3:
            unit->items[3] = unit->items[2];
        case 2:
            unit->items[2] = unit->items[1];
        case 1:
            unit->items[1] = unit->items[0];
    }

    unit->items[0] = item;

    if (UNIT_FACTION(unit) == FACTION_BLUE)
    {
        UnlockAchievementByEquip(ITEM_INDEX(item));
    }
}

void UnitChangeFaction(struct Unit * unit, int faction)
{
    struct Unit * newUnit = GetFreeUnit(faction);

    if (gActiveUnit == unit)
        gActiveUnit = newUnit;

    CopyUnit(unit, newUnit);
    ClearUnit(unit);

    if (newUnit->exp == UNIT_EXP_DISABLED)
    {
        if ((faction == FACTION_BLUE) && (newUnit->level != UNIT_LEVEL_MAX))
            newUnit->exp = 0;
        else
            newUnit->exp = UNIT_EXP_DISABLED;
    }

    newUnit->state = newUnit->state & ~US_DROP_ITEM;

    if (newUnit->rescue)
        GetUnit(newUnit->rescue)->rescue = newUnit->index;

    if (faction == FACTION_BLUE)
    {
        UnlockAchievementByRecruitment(newUnit->pCharacterData->number);
    }
}

//! FE8U = 0x0808CB34
void TerrainDisplay_Init_asdf(struct PlayerInterfaceProc * proc) // start
{
    proc->windowQuadrant = -1;
    proc->isRetracting = false;
    proc->showHideClock = 0;
    proc->cursorQuadrant = 1;

    InitTextDb(proc->texts, 5);

    RestartNotificationProc(proc);
    // CreateBonusContentData();

    return;
}
