#include "C_Code.h"

extern const u8 PreventTradingList[];
int CanItemBeTraded(int id)
{
    id &= 0xFF;
    // asm("mov r11, r11");
    for (const u8 * list = PreventTradingList; *list; list++)
    {
        if (id == *list)
        {
            return false;
        }
    }
    return true;
}

void PlayErrorSfx(void)
{
    if (!(gPlaySt.config.disableSoundEffects))
        m4aSongNumStart(0x6C);
}

u8 SendToConvoyMenu_NormalEffect(struct MenuProc * proc_menu, struct MenuItemProc * proc_cmd)
{
    int item = gActiveUnit->items[proc_cmd->itemNumber];

    if (CanItemBeTraded(item))
    {
        AddItemToConvoy(item);
        gActionData.item = item;
        UnitRemoveItem(gActiveUnit, proc_cmd->itemNumber);
        UnitAddItem(gActiveUnit, gBmSt.um_tmp_item);
        return MENU_ACT_ENDFACE | MENU_ACT_CLEAR | MENU_ACT_SND6A | MENU_ACT_END | MENU_ACT_SKIPCURSOR;
    }
    PlayErrorSfx();
    return MENU_ACT_SKIPCURSOR;
}

u8 MenuCommand_SendItemToConvoy(struct MenuProc * proc_menu, struct MenuItemProc * proc_cmd)
{
    int item = gBmSt.um_tmp_item;

    if (CanItemBeTraded(item))
    {
        AddItemToConvoy(gBmSt.um_tmp_item);
        gActionData.item = gBmSt.um_tmp_item;
        return MENU_ACT_ENDFACE | MENU_ACT_CLEAR | MENU_ACT_SND6A | MENU_ACT_END | MENU_ACT_SKIPCURSOR;
    }
    PlayErrorSfx();
    return MENU_ACT_SKIPCURSOR;
}

u8 SendToConvoyMenu_Selected(struct MenuProc * proc_menu, struct MenuItemProc * proc_cmd)
{
    int item = gActiveUnit->items[proc_cmd->itemNumber];
    if (CanItemBeTraded(item))
    {

        gActionData.item = item;
        gActionData.unk08 = proc_cmd->itemNumber;
        LoadHelpBoxGfx(NULL, -1);
        /* maybe draw hand? */
        sub_808AA04(0x8, proc_cmd->itemNumber * 0x10 + 0x20, 0x84B, proc_menu);
        return 0;
    }
    PlayErrorSfx();
    return 0;
}

u8 SendToConvoyMenu_Selected2(struct MenuProc * proc_menu, struct MenuItemProc * proc_cmd)
{
    int item = gBmSt.um_tmp_item;

    if (CanItemBeTraded(item))
    {
        gActionData.item = item;
        gActionData.unk08 = UNIT_ITEM_COUNT;
        LoadHelpBoxGfx(NULL, -1);
        /* maybe draw hand? */
        sub_808AA04(0x8, proc_cmd->itemNumber * 0x10 + 0x20, 0x84B, proc_menu);
        return 0;
    }
    PlayErrorSfx();
    return 0;
}

// int ConvoyMenuProc_SendToConvoyReal(ProcPtr proc)
// {
// return AddItemToConvoy(gBmSt.itemUnk2E);
// }

extern const u8 ConvoyCapacity;
s8 PrepItemScreen_GiveAll(struct Unit * unit)
{
    int i;

    int unitItemCount = GetUnitItemCount(unit);
    int convoyItemCount = GetConvoyItemCount_();
    int item;
    int skippedItems = 0;

    for (i = 0; (i < unitItemCount) && (i + convoyItemCount < ConvoyCapacity); i++)
    {
        item = unit->items[skippedItems];
        if (CanItemBeTraded(item))
        {

            AddItemToConvoy(item);
            UnitRemoveItem(unit, skippedItems);
        }
        else
        {
            skippedItems++;
        }
    }

    if (i > 0)
        return true;

    return false;
}

void TrySendItemSupplyViaPrep(int item, struct PrepItemSupplyProc * proc)
{
    if (!CanItemBeTraded(item))
    {
        PlayErrorSfx();
        return;
    }
    proc->unit->items[proc->unitInvIdx] = 0;
    UnitRemoveInvalidItems(proc->unit);

    proc->currentPage = GetPrepPageForItem(item);
    AddItemToConvoy(item);
}

void TradeMenu_ApplyItemSwap(struct TradeMenuProc * proc)
{
    u16 * pItemA = &proc->units[proc->hoverColumn]->items[proc->hoverRow];
    u16 * pItemB = &proc->units[proc->selectedColumn]->items[proc->selectedRow];

    if (!CanItemBeTraded(*pItemA) || !CanItemBeTraded(*pItemB))
    {
        if (&proc->units[proc->hoverColumn] != &proc->units[proc->selectedColumn])
        {
            PlayErrorSfx();
            return;
        }
    }

    u16 swp = *pItemA;
    *pItemA = *pItemB;
    *pItemB = swp;

    proc->hasTraded = TRUE;

    gActionData.unitActionType = UNIT_ACTION_TRADED;

    UnitRemoveInvalidItems(proc->units[0]);
    UnitRemoveInvalidItems(proc->units[1]);

    TradeMenu_RefreshItemText(proc);
}

void PrepItemTrade_ApplyItemSwap(struct Unit * unitA, int itemSlotA, struct Unit * unitB, int itemSlotB)
{

    if (!CanItemBeTraded(unitA->items[itemSlotA]) || !CanItemBeTraded(unitB->items[itemSlotB]))
    {
        if (unitA != unitB)
        {
            PlayErrorSfx();
            return;
        }
    }

    u16 itemTmp = unitA->items[itemSlotA];
    unitA->items[itemSlotA] = unitB->items[itemSlotB];
    unitB->items[itemSlotB] = itemTmp;

    UnitRemoveInvalidItems(unitA);
    UnitRemoveInvalidItems(unitB);

    return;
}
