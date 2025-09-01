#define brk asm("mov r11, r11");

extern struct BonusClaimEnt gBonusClaimData[50];
extern u8 bonusclaim_maybe_not_pad1[0x18];
extern struct BonusClaimEnt gBonusClaimDataUpdated[50];
extern u8 bonusclaim_maybe_not_pad2[0x18];
extern struct BonusClaimItemEnt gBonusClaimItemList[0x80];
extern struct BonusClaimConfig gBonusClaimConfig[0x40];
extern int gBonusClaimItemCounts[0x40];
extern struct Text gBonusClaimText[0x121]; // maybe lower

// struct BonusClaimEnt * const gpBonusClaimData = gBonusClaimData;
// struct BonusClaimEnt * const gpBonusClaimDataUpdated = gBonusClaimDataUpdated;
// struct BonusClaimItemEnt * const gpBonusClaimItemList = gBonusClaimItemList;
// int * const gpBonusClaimItemCount = gBonusClaimItemCounts;
// struct Text * const gpBonusClaimText = gBonusClaimText;
// struct BonusClaimConfig * const gpBonusClaimConfig = gBonusClaimConfig;

int LoadBonusContentData(void *);

// MSa_SaveBonusClaim
// default EMS seems to save 4 bytes for bonus content data that's been claimed
// although the global sram for it is still in the link arena sram at like 0xE007200ish

static const u8 iid_bonus[] = {
    ITEM_BOOSTER_HP,  ITEM_BOOSTER_POW, ITEM_BOOSTER_SKL, ITEM_BOOSTER_SPD, ITEM_BOOSTER_LCK,
    ITEM_BOOSTER_DEF, ITEM_BOOSTER_RES, ITEM_BOOSTER_MOV, ITEM_BOOSTER_CON,
};

#define BONUS_CLAIM_NUM_ENTRIES 16

#define MAX_ITEMS 32
#define availableBonusIdWords ((MAX_ITEMS + 31) / 32)

struct BonusClaimEnt
{
    /* 00 */ u8 unseen;
    /* 01 */ u8 kind; // 2 = gold, 0/1 = items
    /* 02 */ u8 itemId;
    /* 03 */ char str[0x11]; // Only used in FE8
};

extern const struct BonusClaimEnt bonusData[];

struct NewBonusClaimRamStruct
{
    u8 unseen;
};

struct NewBonusClaimProc
{
    /* 00 */ PROC_HEADER;

    /* 29 */ u8 menuIndex;
    /* 2A */ u8 submenuIndex;
    /* 2B */ u8 targets;
    /* 2C */ s16 unk_2c;
    /* 2E */ s8 unk_2e;
    /* 30 */ int timer;
    /* 34 */ ProcPtr unk_34;
    /* 38 */ u32 availableBonusIds[availableBonusIdWords];
};

struct ProcCmd const ProcScr_BonusClaim[];

void SetBonusClaimBit(int i, struct NewBonusClaimProc * proc)
{
    if (!proc)
    {
        return;
    }
    int offset = i / 32;
    int bit = i % 32;
    proc->availableBonusIds[offset] |= 1 << bit;
}

int GetBonusClaimOffset(int id)
{
    struct NewBonusClaimProc * proc = (void *)Proc_Find(ProcScr_BonusClaim);
    if (!proc)
        return id;

    int i = 0;     // physical index
    int found = 0; // how many available IDs we've seen

    while (1)
    {
        int offset = i / 32;
        int bit = i % 32;
        u32 data = proc->availableBonusIds[offset];

        if (data & (1 << bit)) // this slot is available
        {
            if (found == id)
                return i; // found the id-th available one
            found++;
        }

        i++;
    }
}

// for (int i = 0; i < id; ++i)
// {

// bit = i % 32;
// if (!bit)
// {
// offset = i / 32;
// data = proc->availableBonusIds[offset];
// }
// if (!(data & (1 << bit)))
// count++;
// }

void SetBonusDataItem(struct NewBonusClaimRamStruct * data, int itemID, const char * str)
{
    data->unseen = true; // "viewable" would be better name
    // data->kind = BONUSKIND_ITEM0;
    // data->itemId = itemID;

    // Clear the buffer
    // for (int i = 0; i < 0x11; i++)
    // {
    // data->str[i] = 0;
    // }

    // int len = strlen(str);
    // if (len >= 0x11)
    // {
    // return; // too long, skip
    // }

    // CopyString(data->str, str);
}
// vanilla only supports 3000g and 5000g items
void SetBonusData3000Gold(struct NewBonusClaimRamStruct * data, const char * str)
{
    SetBonusDataItem(data, ITEM_3000G, str);
    // data->kind = BONUSKIND_MONEY;
}
void SetBonusData5000Gold(struct NewBonusClaimRamStruct * data, const char * str)
{
    SetBonusDataItem(data, ITEM_5000G, str);
    // data->kind = BONUSKIND_MONEY;
}

void CreateBonusContentData()
{

    struct NewBonusClaimRamStruct data[BONUS_CLAIM_NUM_ENTRIES] = { 0 };
    for (int i = 6; i < BONUS_CLAIM_NUM_ENTRIES; ++i)
    {
        SetBonusDataItem(&data[i], i + 1, "enjoy :)");
    }
    SetBonusData3000Gold(&data[2], "Monies");
    // SetBonusData5000Gold(&data[1], "Im rich");

    SaveBonusContentData(data);
}

const char * GetBonusClaimStr(int id)
{
    return bonusData[id].str;
}
int GetBonusClaimItem(int id)
{

    return bonusData[id].itemId;
}

int GetBonusClaimType(int id)
{
    return bonusData[id].kind;
}

int IsBonusClaimUnseen(int id)
{
    struct NewBonusClaimRamStruct * ent = (void *)gpBonusClaimData;
    ent += id;
    return ent->unseen;
}

//! FE8U = 0x080B0638
// void PutChapterBannerSprites(void)
// {
// PutSpriteExt(4, 24, 8, *SpriteArray_08A209F0, 0x8000);
// PutSpriteExt(4, 24, 16, *SpriteArray_08A209E4, 0x9000);
// return;
// }

//! FE8U = 0x080B0674
void sub_80B0674(void)
{
    u32 flags = (-(gPlaySt.chapterStateBits & 0x40) >> 0x1f) & 4;

    if (gPlaySt.config.controller == 0)
    {
        if (gPlaySt.chapterModeIndex == CHAPTER_MODE_COMMON)
            flags |= 0x10;

        if (gPlaySt.chapterModeIndex == CHAPTER_MODE_EIRIKA)
            flags |= 0x20;

        if (gPlaySt.chapterModeIndex == CHAPTER_MODE_EPHRAIM)
            flags |= 0x40;
    }
    else
    {
        if (gPlaySt.chapterModeIndex == CHAPTER_MODE_EPHRAIM)
            flags |= 0x40;
        else
            flags |= 0x20;
    }

    sub_80895B4(flags | 1, 0x18);
    sub_80895B4(flags, 0x19);

    EnablePaletteSync();

    PutChapterTitleBG(0xac0);
    PutChapterTitleGfx(0xb40, GetChapterTitleExtra(&gPlaySt));

    return;
}

//! FE8U = 0x080B06FC
void sub_80B06FC(void)
{

    u16 vcount = REG_VCOUNT + 1;

    if (vcount > 160)
    {
        vcount = 0;
    }

    if ((vcount & 1) == 0)
    {
        if (vcount < 100)
        {
            REG_BLDCNT = 200;
            // TODO: In "bb.c", REG_BLDY matches as vu8, but here it is vu16
            (*(vu16 *)REG_ADDR_BLDY) = ((100 - vcount) * 16) / 100;
        }

        if (vcount == 0)
        {
            REG_BG0VOFS = gLCDControlBuffer.bgoffset[0].y;
        }

        if (vcount == 120)
        {
            REG_BG0VOFS = 4;
        }
    }

    return;
}

//! FE8U = 0x080B0760
s8 InitBonusClaimData()
{
    int i;

    int count = 0;
    struct NewBonusClaimProc * proc = (void *)Proc_Find(ProcScr_BonusClaim);
    for (i = 0; i < availableBonusIdWords; ++i)
    {
        proc->availableBonusIds[i] = 0;
    }
    int reachedStartId = false;
    struct NewBonusClaimRamStruct * data = (void *)&gpBonusClaimData[0];

    CpuFill16(0, gpBonusClaimItemList, 0x80);
    CpuFill16(0, gpBonusClaimData, 0x144);

    if (LoadBonusContentData(gpBonusClaimData) != 0)
    {
        CpuFastCopy(gpBonusClaimData, gpBonusClaimDataUpdated, 0x144);

        for (i = 0; i < BONUS_CLAIM_NUM_ENTRIES; i++)
        {
            struct NewBonusClaimRamStruct * ent = &data[i];
            struct NewBonusClaimRamStruct * ent2;
            int type = GetBonusClaimType(i);
            int itemId = GetBonusClaimItem(i);

            // if ((ent->unseen & 3) == 0)
            // {
            // continue;
            // }

            switch (type)
            {
                case BONUSKIND_ITEM1:
                    if ((gPlaySt.unk_2B_00) == 0)
                    {
                        continue;
                    }

                case BONUSKIND_ITEM0:
                case BONUSKIND_MONEY:

                    if (((1 << i) & GetBonusContentClaimFlags()) != 0)
                    {
                        gpBonusClaimItemList[i].claimable = 0;
                    }
                    else
                    {
                        gpBonusClaimItemList[i].claimable = 1;
                    }

                    if ((ent->unseen & 3) != 0 && itemId)
                    {
                        // gpBonusClaimItemList[count].unk_00 = i;
                        SetBonusClaimBit(i, (void *)proc);
                        reachedStartId = true;
                        count++;
                    }
                    else if (!reachedStartId)
                    {
                        proc->menuIndex++;
                    }

                    break;
            }

            ent2 = &data[i];
            if ((ent2->unseen & 3) == 1)
            {
                struct NewBonusClaimRamStruct * ent3 = &data[i];
                ent3->unseen = (ent3->unseen & 0xfc) + 2;
            }
        }

        *gpBonusClaimItemCount = count;

        SaveBonusContentData(gpBonusClaimDataUpdated);
    }

    if (count == 0)
    {
        return 0;
    }

    return 1;
}

//! FE8U = 0x080B0894
void DrawBonusClaimItemText(int idx)
{
    int unk1;
    s8 claimable;
    int bonusId;
    int itemId;
    int color;
    // struct BonusClaimEnt * ent;
    struct NewBonusClaimRamStruct * ent2;

    struct Text * th = gpBonusClaimText + ((idx % 6) << 1);

    unk1 = idx * 2;
    unk1 &= 0x1f;

    claimable = gpBonusClaimItemList[idx].claimable;
    // bonusId = GetBonusClaimOffset(idx);
    bonusId = GetBonusClaimOffset(idx);
    // bonusId = gpBonusClaimItemList[idx].unk_00;

    // ent = gpBonusClaimData;
    // ent += bonusID;
    int type = GetBonusClaimType(bonusId);
    itemId = GetBonusClaimItem(bonusId);

    color = TEXT_COLOR_SYSTEM_WHITE;

    TileMap_FillRect(gBG2TilemapBuffer + ((unk1) * 0x20), 0x14, 1, 0);

    ClearText(th);

    if (idx >= 0x20)
    {
        return;
    }

    int unseen = IsBonusClaimUnseen(bonusId);
    if ((unseen & 3) == 0)
    {
        return;
    }

    if ((unseen & 3) == 1)
    {
        color = TEXT_COLOR_SYSTEM_GREEN;
    }

    if (claimable == 0)
    {
        color = TEXT_COLOR_SYSTEM_GRAY;
    }

    switch (type)
    {
        case BONUSKIND_ITEM0:
        case BONUSKIND_ITEM1:
            PutDrawText(th, gBG2TilemapBuffer + (unk1 * 0x20) + 2, color, 0, 0, GetItemName(itemId));

            PutNumberOrBlank(
                gBG2TilemapBuffer + (unk1 * 0x20) + 0xA, color == 0 ? TEXT_COLOR_SYSTEM_BLUE : color,
                GetItemMaxUses(itemId));

            DrawIcon(gBG2TilemapBuffer + (unk1 * 0x20), GetItemIconId(itemId), 0x4000);

            break;

        case BONUSKIND_MONEY:
            PutDrawText(th, gBG2TilemapBuffer + (unk1 * 0x20) + 2, color, 0, 0, GetItemName(itemId));

            DrawIcon(gBG2TilemapBuffer + (unk1 * 0x20), GetItemIconId(itemId), 0x4000);

            break;
    }

    th++;

    ClearText(th);

    PutDrawText(
        th, gBG2TilemapBuffer + 12 + unk1 * 0x20, color == 0 ? TEXT_COLOR_SYSTEM_GOLD : color, 0, 0,
        GetBonusClaimStr(bonusId));

    BG_EnableSyncByMask(4);

    return;
}

// This custom function does not work because whether items are claimed or not is saved in the save slot, and this does
// not update that. This would need to use WriteGameSave instead of SaveBonusContentData
// void SetBonusItemUnclaimed(int idx)
// {
// struct BonusClaimItemEnt * ent = &gpBonusClaimItemList[idx];
// int itemFlag = ent->unk_00;
// SetBonusContentClaimFlags(GetBonusContentClaimFlags() & ~(1 << itemFlag));
// ent->claimable = true;
// return;
// }

//! FE8U = 0x080B0A24
void SetBonusItemClaimed(int idx)
{
    struct BonusClaimItemEnt * ent = &gpBonusClaimItemList[idx];

    // int itemFlag = ent->unk_00;
    int itemFlag = GetBonusClaimOffset(idx);

    SetBonusContentClaimFlags((1 << itemFlag) | GetBonusContentClaimFlags());

    ent->claimable = false;

    return;
}

//! FE8U = 0x080B0A50
void SetupBonusClaimTargets(struct BonusClaimProc * proc)
{
    int i, count = 0;

    ResetUnitSprites();
    for (i = 1; i < 0x40; i++)
    {
        struct Unit * unit = GetUnit(i);

        if (!UNIT_IS_VALID(unit))
            continue;

        if (unit->state & (US_DEAD | US_BIT16))
            continue;

        if (unit->pCharacterData->number != CHARACTER_EIRIKA && unit->pCharacterData->number != CHARACTER_EPHRAIM)
            continue;

        (gpBonusClaimConfig + count)->unit = unit;
        count++;
        UseUnitSprite(GetUnitSMSId(unit));
    }

    proc->targets = count + 1;
    ApplyUnitSpritePalettes();
    ForceSyncUnitSpriteSheet();
}

//! FE8U = 0x080B0ABC
// void sub_80B0ABC(void)
// {
// DrawUiFrame2(3, 6, 24, 12, 0);
// BG_EnableSyncByMask(3);
// return;
// }

//! FE8U = 0x080B0ADC
void BonusClaim_Init(struct BonusClaimProc * proc)
{
    int i;

    SetupBackgrounds(0);

    ApplyPalettes(Pal_CommGameBgScreenInShop, 0xC, 2);
    ApplyPalette(Pal_08A295B4, 0xE);
    Decompress(Img_CommGameBgScreen, (void *)0x06008000);

    CallARM_FillTileRect(gBG3TilemapBuffer, Tsa_CommGameBgScreenInShop, 0xc000);

    BG_EnableSyncByMask(8);

    LoadUiFrameGraphics();
    ResetText();
    ResetIconGraphics_();
    LoadIconPalettes(4);
    LoadObjUIGfx();

    sub_80B0674();
    sub_80B0ABC();

    gLCDControlBuffer.dispcnt.win0_on = 0;
    gLCDControlBuffer.dispcnt.win1_on = 1;
    gLCDControlBuffer.dispcnt.objWin_on = 0;

    gLCDControlBuffer.wincnt.win1_enableBg0 = 1;
    gLCDControlBuffer.wincnt.win1_enableBg1 = 1;
    gLCDControlBuffer.wincnt.win1_enableBg2 = 1;
    gLCDControlBuffer.wincnt.win1_enableBg3 = 1;
    gLCDControlBuffer.wincnt.win1_enableObj = 1;

    gLCDControlBuffer.wincnt.wout_enableBg0 = 1;
    gLCDControlBuffer.wincnt.wout_enableBg1 = 1;
    gLCDControlBuffer.wincnt.wout_enableBg2 = 0; // 2; 2 is what decomp says but it's only 1 bit
    gLCDControlBuffer.wincnt.wout_enableBg3 = 1;
    gLCDControlBuffer.wincnt.wout_enableObj = 1;

    gLCDControlBuffer.win1_left = 0;
    gLCDControlBuffer.win1_top = 56;
    gLCDControlBuffer.win1_right = 240;
    gLCDControlBuffer.win1_bottom = 136;

    gLCDControlBuffer.bg0cnt.priority = 0;
    gLCDControlBuffer.bg1cnt.priority = 2;
    gLCDControlBuffer.bg2cnt.priority = 0;
    gLCDControlBuffer.bg3cnt.priority = 3;
    proc->menuIndex = 0;
    InitBonusClaimData();
    proc->menuIndex = 0;

    for (i = 0; i <= 5 && i < *gpBonusClaimItemCount; i++)
    {
        struct Text * th = gpBonusClaimText + i * 2;
        InitText(th, 7);
        th++;
        InitText(th, 10);
        DrawBonusClaimItemText(i + proc->menuIndex);
    }

    for (i = 0; i < 2; i++)
    {
        InitText(gpBonusClaimText + 12 + i, 6);
    }

    InitText(gpBonusClaimText + 14, 15);

    StartParallelWorker(PutChapterBannerSprites, proc);

    BG_EnableSyncByMask(2);

    SetPrimaryHBlankHandler(sub_80B06FC);

    proc->unk_2c = 0;
    proc->unk_2e = 0;
    proc->submenuIndex = 0;
    proc->targets = 2;

    proc->unk_34 = NULL;

    BG_SetPosition(2, -40, (proc->unk_2c - 56) & 0xff);

    ResetSysHandCursor(proc);
    DisplaySysHandCursorTextShadow(0x600, 1);
    ShowSysHandCursor(40, proc->menuIndex * 16 + 56 - proc->unk_2c, 19, 0x800);

    StartGreenText(proc);

    StartMenuScrollBar(proc);

    PutMenuScrollBarAt(200, 0x40);

    InitMenuScrollBarImg(0x200, 2);

    UpdateMenuScrollBarConfig(8, proc->unk_2c, *gpBonusClaimItemCount, 5);

    StartUiCursorHand(proc);

    SetupBonusClaimTargets(proc);

    LoadHelpBoxGfx((void *)0x06013800, 5);

    return;
}

//! FE8U = 0x080B0D38
void BonusClaim_Loop_MainKeyHandler(struct BonusClaimProc * proc)
{
    u16 tmp;
    struct NewBonusClaimRamStruct * ent;

    int curIdx = proc->menuIndex;

    if (proc->unk_2e == 0)
    {
        if (gKeyStatusPtr->newKeys & A_BUTTON)
        {
            // int bonusId = gpBonusClaimItemList[curIdx].unk_00;
            int bonusId = GetBonusClaimOffset(curIdx);

            if (((1 << bonusId) & GetBonusContentClaimFlags()) != 0)
            {
                StartBonusClaimHelpBox(-1, -1, 0x88F, proc); // TODO: msgid "Already used"
                return;
            }

            if (proc->targets != 0)
            {
                // struct BonusClaimEnt * ent2 = gpBonusClaimData;
                // ent2 += bonusId;
                int itemID = GetBonusClaimItem(bonusId);
                int type = GetBonusClaimType(bonusId);

                switch (type)
                {
                    case BONUSKIND_ITEM0:
                    case BONUSKIND_ITEM1:
                        Proc_Goto(proc, 1);
                        PlaySoundEffect(SONG_SE_SYS_WINDOW_SELECT1);

                    default:
                        return;

                    case BONUSKIND_MONEY:
                        if (itemID == ITEM_3000G)
                        {
                            sub_8024E20(3000);
                        }

                        // ent = &gpBonusClaimData[bonusId];
                        if (itemID == ITEM_5000G)
                        {
                            sub_8024E20(5000);
                        }

                        SetBonusItemClaimed(proc->menuIndex);
                        DrawBonusClaimItemText(proc->menuIndex);

                        Proc_Goto(proc, 2);

                        return;
                }
            }

            PlaySoundEffect(SONG_6C);

            return;
        }

        if (gKeyStatusPtr->newKeys & B_BUTTON)
        {
            Proc_Break(proc);
            PlaySoundEffect(SONG_SE_SYS_WINDOW_CANSEL1);
            return;
        }

        if (gKeyStatusPtr->repeatedKeys & DPAD_UP)
        {
            curIdx -= 1;
        }

        if (gKeyStatusPtr->repeatedKeys & DPAD_DOWN)
        {
            curIdx += 1;
        }

        if (proc->menuIndex != curIdx)
        {
            if (curIdx >= 0)
            {

                if (curIdx >= *gpBonusClaimItemCount)
                {
                    return;
                }

                PlaySoundEffect(SONG_SE_SYS_CURSOR_UD1);

                proc->menuIndex = curIdx;

                if ((proc->menuIndex * 16 - proc->unk_2c == 0) && (proc->menuIndex != 0))
                {
                    proc->unk_2e = -1;
                    DrawBonusClaimItemText(proc->menuIndex - 1);
                }
                else if ((proc->menuIndex * 16 - proc->unk_2c == 64) && (proc->menuIndex < *gpBonusClaimItemCount - 1))
                {
                    proc->unk_2e = 1;
                    DrawBonusClaimItemText(proc->menuIndex + 1);
                }
                else
                {
                    ShowSysHandCursor(40, proc->menuIndex * 16 + 56 - proc->unk_2c, 19, 0x800);
                }
            }
            else
            {
                return;
            }
        }

        if (proc->unk_2e == 0)
        {
            return;
        }
    }

    if (proc->unk_2e < 0)
    {
        proc->unk_2c -= 4;
    }

    if (proc->unk_2e > 0)
    {
        proc->unk_2c += 4;
    }

    tmp = (proc->unk_2c);
    tmp &= 0xf;

    if (tmp == 0)
    {
        proc->unk_2e = 0;
    }

    BG_SetPosition(2, -40, (proc->unk_2c - 56) & 0xff);

    UpdateMenuScrollBarConfig(8, proc->unk_2c, *gpBonusClaimItemCount, 5);

    return;
}

//! FE8U = 0x080B0F94
void BonusClaim_DrawTargetUnitSprites(struct BonusClaimProc * proc)
{
    int i;

    for (i = 0; i < proc->targets - 1; i++)
    {
        struct Unit * unit = gpBonusClaimConfig[i].unit;

        if (gpBonusClaimConfig[i].hasInventorySpace != 0)
            PutUnitSpriteForClassId(0, 96, 48 + i * 16, 0xc400, unit->pClassData->number);
        else
            PutUnitSpriteForClassId(0, 96, 48 + i * 16, 0xf400, unit->pClassData->number);
    }
    SyncUnitSpriteSheet();
}

//! FE8U = 0x080B1008
void sub_80B1008(struct BonusClaimProc * proc)
{

    if (proc->unk_34 != NULL)
    {
        Proc_End(proc->unk_34);
        proc->unk_34 = NULL;
    }

    return;
}

//! FE8U = 0x080B1020
void BonusClaim_StartSelectTargetSubMenu(struct BonusClaimProc * proc)
{
    int i;

    struct Text * th = gpBonusClaimText + 12;
    int sl = proc->targets;
    int tmp = (proc->targets * 2);

    DrawUiFrame2(11, 5, 14, tmp + 2, 1);

    gLCDControlBuffer.dispcnt.win0_on = 1;
    gLCDControlBuffer.dispcnt.win1_on = 1;
    gLCDControlBuffer.dispcnt.objWin_on = 0;

    gLCDControlBuffer.wincnt.win0_enableBg0 = 1;
    gLCDControlBuffer.wincnt.win0_enableBg1 = 1;
    gLCDControlBuffer.wincnt.win0_enableBg2 = 0;
    gLCDControlBuffer.wincnt.win0_enableBg3 = 1;
    gLCDControlBuffer.wincnt.win0_enableObj = 1;

    gLCDControlBuffer.win0_left = 88;
    gLCDControlBuffer.win0_top = 40;
    gLCDControlBuffer.win0_right = 200;
    gLCDControlBuffer.win0_bottom = (tmp + 7) * 8;

    SetUiCursorHandConfig(0, 40, proc->menuIndex * 16 + 56 - proc->unk_2c, 1);

    ShowSysHandCursor(92, proc->submenuIndex * 16 + 48, 12, 0x800);

    for (i = 0; i < sl; th++, i++)
    {
        int count;
        int color = 0;
        struct Unit * unit = gpBonusClaimConfig[i].unit;
        u16 * tm = gBG0TilemapBuffer + 14;

        ClearText(th);
        Text_SetCursor(th, 0);

        if (i == sl - 1)
        {
            count = GetConvoyItemCount();
            color = (count == CONVOY_ITEM_COUNT) ? TEXT_COLOR_SYSTEM_GRAY : TEXT_COLOR_SYSTEM_WHITE;
            Text_SetParams(th, 0, color);
            Text_DrawString(th, GetStringFromIndex(0x308)); // TODO: msgid "Supply"
        }
        else
        {
            count = GetUnitItemCount(unit);
            color = (count == UNIT_ITEM_COUNT) ? TEXT_COLOR_SYSTEM_GRAY : TEXT_COLOR_SYSTEM_WHITE;
            Text_SetParams(th, 0, color);
            Text_DrawString(th, GetStringFromIndex(unit->pCharacterData->nameTextId));
        }

        if (color == 0)
            gpBonusClaimConfig[i].hasInventorySpace = 1;
        else
            gpBonusClaimConfig[i].hasInventorySpace = 0;

        PutText(th, tm + 0xc0 + 0x40 * i);

        PutNumber(tm + 0xc9 + 0x40 * i, color == 0 ? TEXT_COLOR_SYSTEM_BLUE : TEXT_COLOR_SYSTEM_GRAY, count);
    }

    proc->unk_34 = StartParallelWorker(BonusClaim_DrawTargetUnitSprites, proc);
}

//! FE8U = 0x080B11E4
s8 TryClaimBonusItem(struct BonusClaimProc * proc)
{
    int itemId;

    int tmp = proc->submenuIndex;
    struct BonusClaimConfig * base = gpBonusClaimConfig;
    struct BonusClaimConfig * unk = base - (-tmp);

    struct BonusClaimItemEnt * itemEnt = gpBonusClaimItemList + proc->menuIndex;
    // int bonusId = itemEnt->unk_00;
    int bonusId = GetBonusClaimOffset(proc->menuIndex);

    // struct BonusClaimEnt * ent = gpBonusClaimData;
    // ent += tmp2;

    itemId = GetBonusClaimItem(bonusId);
    // itemId = ent->itemId;

    if (unk->hasInventorySpace == 0)
        return false;

    SetBonusItemClaimed(proc->menuIndex);
    DrawBonusClaimItemText(proc->menuIndex);

    if (proc->submenuIndex == proc->targets - 1)
        AddItemToConvoy(MakeNewItem(itemId));
    else
        UnitAddItem(gpBonusClaimConfig[proc->submenuIndex].unit, MakeNewItem(itemId));

    return true;
}

//! FE8U = 0x080B1288
void BonusClaim_Loop_SelectTargetKeyHandler(struct BonusClaimProc * proc)
{
    int tmp = proc->submenuIndex;

    if (gKeyStatusPtr->newKeys & A_BUTTON)
    {
        if (TryClaimBonusItem(proc) != 0)
        {
            Proc_Goto(proc, 2);
            return;
        }

        StartBonusClaimHelpBox(-1, -1, 0x890, proc);
        return;
    }

    if (gKeyStatusPtr->newKeys & B_BUTTON)
    {
        Proc_Break(proc);
        PlaySoundEffect(SONG_SE_SYS_WINDOW_CANSEL1);
        return;
    }

    if (gKeyStatusPtr->repeatedKeys & DPAD_UP)
    {
        tmp--;
    }

    if (gKeyStatusPtr->repeatedKeys & DPAD_DOWN)
    {
        tmp++;
    }

    if (((tmp != proc->submenuIndex) && (-1 < tmp)) && (tmp < proc->targets))
    {
        PlaySoundEffect(SONG_SE_SYS_CURSOR_UD1);
        proc->submenuIndex = tmp;
        ShowSysHandCursor(92, proc->submenuIndex * 16 + 48, 12, 0x800);
    }

    return;
}

//! FE8U = 0x080B1350
void BonusClaim_EndSelectTargetSubMenu(struct BonusClaimProc * proc)
{
    sub_80B1008(proc);

    gLCDControlBuffer.dispcnt.win0_on = 0;
    gLCDControlBuffer.dispcnt.win1_on = 1;
    gLCDControlBuffer.dispcnt.objWin_on = 0;

    BG_Fill(gBG1TilemapBuffer, 0);
    BG_Fill(gBG0TilemapBuffer, 0);

    sub_80B0ABC();

    BG_EnableSyncByMask(3);

    sub_80ACA84(0);

    ShowSysHandCursor(40, proc->menuIndex * 16 + 56 - proc->unk_2c, 19, 0x800);

    return;
}

//! FE8U = 0x080B13BC
void BonusClaim_DrawItemSentPopup(struct BonusClaimProc * proc)
{
    const char * itemNameStr;
    const char * otherStr;
    int width;
    int x;
    struct Text * th;
    char buf[32];
    struct NewBonusClaimRamStruct * ent;
    struct NewBonusClaimRamStruct * ent2;
    int itemId;

    // int bonusId = proc->menuIndex;
    // int bonusId = gpBonusClaimItemList[proc->menuIndex].unk_00;
    int bonusId = GetBonusClaimOffset(proc->menuIndex);

    // ent = gpBonusClaimData;
    // ent += idx;
    // itemId = ent->itemId;
    itemId = GetBonusClaimItem(bonusId);

    th = gpBonusClaimText + 14;

    gLCDControlBuffer.dispcnt.win0_on = 0;
    gLCDControlBuffer.dispcnt.win1_on = 1;
    gLCDControlBuffer.dispcnt.objWin_on = 0;

    BG_Fill(gBG0TilemapBuffer, 0);
    BG_Fill(gBG1TilemapBuffer, 0);

    sub_80B0ABC();

    BG_EnableSyncByMask(3);

    sub_80B1008(proc);

    WriteGameSave(ReadLastGameSaveId());

    proc->timer = 0;
    sub_80ACA84(0);

    ShowSysHandCursor(40, proc->menuIndex * 16 + 56 - proc->unk_2c, 19, 0x800);

    ClearText(th);
    Text_SetParams(th, 0, TEXT_COLOR_SYSTEM_WHITE);
    Text_SetCursor(th, 0);

    itemNameStr = GetItemName(itemId);
    otherStr = GetStringFromIndexInBuffer(0x883, buf); // TODO: msgid "Sent[.]"

    width = ((GetStringTextLen(itemNameStr) + GetStringTextLen(otherStr) + 7) / 8) + 4;
    x = 15 - width / 2;

    Text_DrawString(th, itemNameStr);
    Text_DrawString(th, otherStr);

    PutText(th, gBG0TilemapBuffer + x + 0x143);

    DrawIcon(gBG0TilemapBuffer + x + 0x141, GetItemIconId(itemId), 0x4000);

    int type = GetBonusClaimType(bonusId);
    switch (type)
    {
        case BONUSKIND_ITEM0:
        case BONUSKIND_ITEM1:
            PlaySoundEffect(SONG_5A);
            break;
        case BONUSKIND_MONEY:
            PlaySoundEffect(SONG_SE_MONEY);
            break;
    }

    DrawUiFrame(gBG1TilemapBuffer, x, 10, width, 3, 0, 1);

    gLCDControlBuffer.dispcnt.win0_on = 1;
    gLCDControlBuffer.dispcnt.win1_on = 1;
    gLCDControlBuffer.dispcnt.objWin_on = 0;

    gLCDControlBuffer.wincnt.win0_enableBg0 = 1;
    gLCDControlBuffer.wincnt.win0_enableBg1 = 1;
    gLCDControlBuffer.wincnt.win0_enableBg2 = 0;
    gLCDControlBuffer.wincnt.win0_enableBg3 = 1;
    gLCDControlBuffer.wincnt.win0_enableObj = 0;

    gLCDControlBuffer.win0_left = x * 8;
    gLCDControlBuffer.win0_top = 80;
    gLCDControlBuffer.win0_right = (x + width) * 8;
    gLCDControlBuffer.win0_bottom = 104;

    BG_EnableSyncByMask(3);

    BG_SetPosition(0, 0, -4);

    return;
}

//! FE8U = 0x080B15E8
void BonusClaim_Loop_PopupDisplayTimer(struct BonusClaimProc * proc)
{
    proc->timer++;

    if ((proc->timer > 30) && (gKeyStatusPtr->newKeys & (A_BUTTON | B_BUTTON)))
    {
        Proc_Break(proc);
        return;
    }

    if (proc->timer > 120)
        Proc_Break(proc);
}

//! FE8U = 0x080B1620
void BonusClaim_ClearItemSentPopup(void)
{
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_Fill(gBG1TilemapBuffer, 0);
    sub_80B0ABC();
    BG_EnableSyncByMask(3);
    gLCDControlBuffer.dispcnt.win0_on = 0;
    gLCDControlBuffer.dispcnt.win1_on = 1;
    gLCDControlBuffer.dispcnt.objWin_on = 0;
    BG_SetPosition(0, 0, 0);
}

//! FE8U = 0x080B166C
void BonusClaim_OnEnd(struct BonusClaimProc * proc)
{
    EndGreenText();
    EndAllProcChildren(proc);
    SetPrimaryHBlankHandler(NULL);
}

struct ProcCmd const ProcScr_BonusClaim[] = {
    // renamed gProcScr_BonusClaim to avoid autohook
    PROC_SLEEP(0),

    PROC_CALL(BonusClaim_Init),

    PROC_CALL_ARG(NewFadeIn, 8),
    PROC_WHILE(FadeInExists),

    // fallthrough

    PROC_LABEL(0),
    PROC_REPEAT(BonusClaim_Loop_MainKeyHandler),

    PROC_GOTO(100),

    PROC_LABEL(1),
    PROC_CALL(BonusClaim_StartSelectTargetSubMenu),
    PROC_REPEAT(BonusClaim_Loop_SelectTargetKeyHandler),
    PROC_CALL(BonusClaim_EndSelectTargetSubMenu),

    PROC_GOTO(0),

    PROC_LABEL(2),
    PROC_CALL(BonusClaim_DrawItemSentPopup),
    PROC_REPEAT(BonusClaim_Loop_PopupDisplayTimer),
    PROC_CALL(BonusClaim_ClearItemSentPopup),

    PROC_GOTO(0),

    PROC_LABEL(100),
    PROC_CALL_ARG(NewFadeOut, 8),
    PROC_WHILE(FadeOutExists),

    PROC_CALL(BonusClaim_OnEnd),

    PROC_END,
};

//! FE8U = 0x080B1688
void StartBonusClaimScreen(ProcPtr parent) // exactly long enough for autohook
{
    Proc_StartBlocking(ProcScr_BonusClaim, parent);
}

//! FE8U = 0x080AA550
void sub_80AA550(struct ProcBonusClaimMenu * proc)
{
    int i;

    // CpuFill16(0, _gpBonusClaimData, 0x144);

    // if (LoadBonusContentData(_gpBonusClaimData) == 0)
    // {
    // Proc_Goto(proc, 10);
    // return;
    // }

    proc->unk_5c = 0;
    proc->unk_58 = 0;
    // struct NewBonusClaimRamStruct * data = (void*)_gpBonusClaimData;

    // for (i = 0; i < 0x10; i++)
    // {
    // struct NewBonusClaimRamStruct * ent = data + i;

    // if ((ent->unseen & 3) != 1)
    // {
    // continue;
    // }
    // }

    if ((proc->unk_58 == 0) && (proc->unk_5c == 0))
    {
        Proc_Goto(proc, 10);
        return;
    }

    LoadHelpBoxGfx(OBJ_VRAM0 + OBJCHR_SAVEMENU_SLOTSEL_HELPBOX * TILE_SIZE_4BPP, OBJPAL_SAVEMENU_SLOTSEL_HELPBOX);
}

bool IsExtraBonusClaimEnabled(void)
{
    struct PlaySt playSt;
    struct NewBonusClaimRamStruct * buf1;
    int i, ret;

    if (LoadBonusContentData((void *)gGenericBuffer))
    {

        ret = 0;
        buf1 = (void *)gGenericBuffer;

        for (i = 0; i < 0x10; i++)
        {
            if (!buf1[i].unseen)
                continue;
            ret = true;
        }

        if (0 == ret)
            return false;
        else
            return true;
    }
    return 0;
}
