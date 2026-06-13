#include "C_Code.h"
void StartShopScreen(struct Unit * unit, const u16 * inventory, u8 shopType, ProcPtr parent)
{
    struct ProcShop * proc;
    const u16 * shopItems;
    int i;

    EndPlayerPhaseSideWindows();

    if (parent)
        proc = Proc_StartBlocking(gProcScr_Shop, parent);
    else
        proc = Proc_Start(gProcScr_Shop, PROC_TREE_3);

    proc->shopType = shopType;
    proc->unit = unit;

    shopItems = gDefaultShopInventory;
    if (inventory != 0)
        shopItems = inventory;

    for (i = 0; i <= SHOP_ITEMS_MAX_AMT; i++)
        proc->shopItems[i] = MakeNewItem(*shopItems++);

    UpdateShopItemCounts(proc);
}

void UpdateShopItemCounts(struct ProcShop * proc)
{
    int i;
    for (i = 0; proc->shopItems[i] != 0; i++)
        ;

    proc->shopItemCount = i;
    proc->unitItemCount = GetUnitItemCount(proc->unit);
}
void ShopDrawBuyItemLine(struct ProcShop * proc, int itemIndex)
{
    u16 item;
    int index = DivRem(itemIndex, 6);

    SetTextFont(0);
    InitSystemTextFont();

    BG_EnableSyncByMask(BG2_SYNC_BIT);

    ClearText(&gShopItemTexts[index]);

    item = proc->shopItems[itemIndex];

    if (item != 0)
        DrawShopItemPriceLine(
            &gShopItemTexts[index], item, proc->unit, gBG2TilemapBuffer + TILEMAP_INDEX(7, (itemIndex * 2 & 0x1F)));
}
void ShopDrawSellItemLine(struct ProcShop * proc, int itemIndex)
{
    u16 item;

    int index = DivRem(itemIndex, 6);

    SetTextFont(0);
    InitSystemTextFont();

    BG_EnableSyncByMask(BG2_SYNC_BIT);

    ClearText(&gShopItemTexts[index]);

    item = proc->shopItems[itemIndex];

    if (item != 0)
        DrawShopItemLine(
            &gShopItemTexts[index], item, proc->unit, gBG2TilemapBuffer + TILEMAP_INDEX(7, (itemIndex * 2 & 0x1F)));
}
void Shop_Loop_BuyKeyHandler(struct ProcShop * proc)
{
    u8 head_loc;
    u32 cursor_at_head;
    int price;
    int a;
    int b;

    Shop_TryMoveHandPage();

    BG_SetPosition(2, 0, ShopSt_GetBg2Offset());

    head_loc = proc->head_loc;
    cursor_at_head = ShopSt_GetHeadLoc() != head_loc;

    proc->head_loc = ShopSt_GetHeadLoc();
    proc->hand_loc = ShopSt_GetHandLoc();

    proc->head_idx = proc->head_loc;
    proc->hand_idx = proc->hand_loc;

    a = proc->head_loc;
    a *= 16;

    b = ((proc->hand_loc * 16)) - 72;

    DisplayUiHand(56, a - b);

    if ((proc->helpTextActive != 0) && (cursor_at_head != 0))
    {
        a = (proc->head_loc * 16);
        b = ((proc->hand_loc * 16) - 72);
        StartItemHelpBox(56, a - b, proc->shopItems[proc->head_loc]);
    }
    DisplayShopUiArrows();

    if (IsShopPageScrolling() != 0)
        return;

    if (proc->helpTextActive != 0)
    {
        if (gKeyStatusPtr->newKeys & (B_BUTTON | R_BUTTON))
        {
            proc->helpTextActive = 0;
            CloseHelpBox();
        }
        return;
    }

    if (gKeyStatusPtr->newKeys & R_BUTTON)
    {
        proc->helpTextActive = 1;
        a = (proc->head_loc * 16);
        b = ((proc->hand_loc * 16) - 72);
        StartItemHelpBox(56, a - b, proc->shopItems[proc->head_loc]);
        return;
    }

    price = GetItemPurchasePrice(proc->unit, proc->shopItems[proc->head_loc]);

    if (gKeyStatusPtr->newKeys & A_BUTTON)
    {
        if (price > (int)GetPartyGoldAmount())
        {
            StartShopDialogue(0x8B2, proc);
            // SHOP_TYPE_ARMORY: "You don't have the money![.][A]"
            // SHOP_TYPE_VENDOR: "You're short of funds.[A]"
            // SHOP_TYPE_SECRET_SHOP: "Heh! Not enough money![A]"

            Proc_Goto(proc, 1);
        }
        else
        {
            SetTalkNumber(price);
            StartShopDialogue(0x8B5, proc);
            // SHOP_TYPE_ARMORY: "How does [.][G] gold[.][NL]sound to you?[.][Yes]"
            // SHOP_TYPE_VENDOR: "That's worth [.][G] gold.[NL]Is that all right?[Yes]"
            // SHOP_TYPE_SECRET_SHOP: "That is worth [G] gold.[NL]Is that acceptable?[.][Yes]"

            Proc_Break(proc);
        }
        return;
    }

    if (gKeyStatusPtr->newKeys & B_BUTTON)
    {
        PlaySoundEffect(SONG_SE_SYS_WINDOW_CANSEL1);
        Proc_Goto(proc, PL_SHOP_SELL_NOITEM);
        return;
    }
}

void Shop_TryAddItemToInventory(struct ProcShop * proc)
{
    if (proc->unitItemCount >= UNIT_ITEM_COUNT)
    {
        if (HasConvoyAccess())
        {
            StartShopDialogue(0x8BE, proc);
            // SHOP_TYPE_ARMORY: "Looks like you're full.[.][A][NL2][NL]Send it to storage?[.][NL][Yes]"
            // SHOP_TYPE_VENDOR: "Your hands are full.[A][NL2][NL]Send it to storage?[.][NL][Yes]"
            // SHOP_TYPE_SECRET_SHOP: "Your hands are full.[A][NL2][NL]Send it to storage?[.][NL][Yes]"
        }
        else
        {
            StartShopDialogue(0x8C1, proc);
            // SHOP_TYPE_ARMORY: "Looks like you're full.[.][A]"
            // SHOP_TYPE_VENDOR: "Your hands are full.[A]"
            // SHOP_TYPE_SECRET_SHOP: "Your hands are full.[A]"

            Proc_Goto(proc, PL_SHOP_BUY_FULL_NO_INEVNTORY);
        }
        return;
    }

    UnitAddItem(proc->unit, proc->shopItems[proc->head_loc]);
    HandleShopBuyAction(proc);

    Proc_Goto(proc, PL_SHOP_BUY_DONE);
}
void Shop_AddItemToConvoy(struct ProcShop * proc)
{
    AddItemToConvoy(proc->shopItems[proc->head_loc]);
    HandleShopBuyAction(proc);
}
void Shop_Loop_UnkKeyHandler(struct ProcShop * proc)
{
    u8 head_loc;
    u32 cursor_at_head;
    int a;
    int b;

    Shop_TryMoveHandPage();

    BG_SetPosition(BG_2, 0, ShopSt_GetBg2Offset());

    head_loc = proc->head_loc;
    cursor_at_head = ShopSt_GetHeadLoc() != head_loc;

    proc->head_loc = ShopSt_GetHeadLoc();
    proc->hand_loc = ShopSt_GetHandLoc();

    proc->head_idx = proc->head_loc;
    proc->hand_idx = proc->hand_loc;

    a = proc->head_loc;
    a *= 16;

    b = ((proc->hand_loc * 16)) - 0x48;

    DisplayUiHand(56, a - b);

    if ((proc->helpTextActive) && (cursor_at_head != 0))
    {
        a = (proc->head_loc * 16);
        b = ((proc->hand_loc * 16) - 0x48);
        StartItemHelpBox(56, a - b, proc->shopItems[proc->head_loc]);
    }

    DisplayShopUiArrows();

    if (IsShopPageScrolling())
        return;

    if (proc->helpTextActive)
    {
        if (gKeyStatusPtr->newKeys & (B_BUTTON | R_BUTTON))
        {
            proc->helpTextActive = 0;
            CloseHelpBox();
        }
        return;
    }

    if (gKeyStatusPtr->newKeys & R_BUTTON)
    {
        proc->helpTextActive = TRUE;
        a = (proc->head_loc * 16);
        b = ((proc->hand_loc * 16) - 0x48);
        StartItemHelpBox(56, a - b, proc->shopItems[proc->head_loc]);
        return;
    }

    if (gKeyStatusPtr->newKeys & (A_BUTTON | B_BUTTON))
    {
        PlaySoundEffect(SONG_SE_SYS_WINDOW_CANSEL1);
        Proc_Goto(proc, 12);
        return;
    }
}
void DrawShopSoldItems(struct ProcShop * proc)
{
    int item;
    int index;
    int i;

    SetTextFont(0);
    InitSystemTextFont();

    for (i = proc->hand_idx; i < proc->hand_idx + SHOP_TEXT_LINES; i++)
    {
        index = DivRem(i, SHOP_TEXT_LINES + 1);
        ClearText(&gShopItemTexts[index]);
    }

    for (i = proc->hand_idx; i < proc->hand_idx + SHOP_TEXT_LINES; i++)
    {
        index = DivRem(i, SHOP_TEXT_LINES + 1);
        item = proc->shopItems[i];

        if (item == 0)
            break;

        DrawShopItemPriceLine(
            &gShopItemTexts[index], item, proc->unit, gBG2TilemapBuffer + TILEMAP_INDEX(7, ((i * 2) & 0x1F)));
    }
    BG_SetPosition(BG_2, 0, (proc->hand_idx * 0x10) - 0x48);
    BG_EnableSyncByMask(BG2_SYNC_BIT);
}
void HandleShopBuyAction(struct ProcShop * proc)
{
    PlaySeDelayed(0xB9, 8);

    gActionData.unitActionType = UNIT_ACTION_SHOPPED;

    SetPartyGoldAmount(GetPartyGoldAmount() - GetItemPurchasePrice(proc->unit, proc->shopItems[proc->head_loc]));

    UpdateShopItemCounts(proc);
    DrawShopSoldItems(proc);

    DisplayGoldBoxText(TILEMAP_LOCATED(gBG0TilemapBuffer, 27, 6));
}
