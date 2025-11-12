
// copied bmguide.c
struct AchMenuSt * const gAchMenuSt = (void *)gGenericBuffer;

// clang-format off

extern const u8 Img_Achievements[]; 
// extern const u8 gGfx_Filter[]; 
extern const u8 gGfx_ShowAll[]; 
extern const u8 gGfx_ShowToDo[]; 
extern const u8 gGfx_ShowDone[]; 
u16 const gSprite_AchievementsBannerText[] =
{
    6,
    OAM0_SHAPE_32x8, OAM1_SIZE_32x8, OAM2_CHR(0xC0),
    OAM0_SHAPE_32x8, OAM1_SIZE_32x8 + OAM1_X(32), OAM2_CHR(0xC4),
    OAM0_SHAPE_32x8, OAM1_SIZE_32x8 + OAM1_X(64), OAM2_CHR(0xC8),
    OAM0_SHAPE_32x8 + OAM0_Y(8), OAM1_SIZE_32x8, OAM2_CHR(0xCC),
    OAM0_SHAPE_32x8 + OAM0_Y(8), OAM1_SIZE_32x8 + OAM1_X(32), OAM2_CHR(0xD0),
    OAM0_SHAPE_32x8 + OAM0_Y(8), OAM1_SIZE_32x8 + OAM1_X(64), OAM2_CHR(0xD4),
};

// u16 const gSprite_AchievementsSelectButtonSort[] =
// {
    // 2,
    // OAM0_SHAPE_32x16, OAM1_SIZE_32x16, OAM2_CHR(0x92),
    // OAM0_SHAPE_32x16, OAM1_SIZE_32x16 + OAM1_X(32), OAM2_CHR(0x98),
// };
u16 const gSprite_AchievementsSelectButtonSort[] =
{
    2,
    OAM0_SHAPE_32x16, OAM1_SIZE_32x16, OAM2_CHR(0x92),
    OAM0_SHAPE_32x16, OAM1_SIZE_32x16 + OAM1_X(32), OAM2_CHR(0x86),
    // OAM0_SHAPE_16x16, OAM1_SIZE_16x16 + OAM1_X(16), OAM2_CHR(0x8A),
};
u16 const gSprite_AchievementsSelectButtonSort2[] =
{
    1,
    OAM0_SHAPE_16x16, OAM1_SIZE_16x16 + OAM1_X(16), OAM2_CHR(0x8A),
};

u16 const gSprite_AchievementsBButtonBack[] =
{
    2,
    OAM0_SHAPE_16x16, OAM1_SIZE_16x16 + OAM1_X(16), OAM2_CHR(0x96),
    OAM0_SHAPE_32x16, OAM1_SIZE_32x16 + OAM1_X(32), OAM2_CHR(0x9C),
};
 
extern char* const gTextIds_AchievementsCategoriesTopic[]; 

/*=
{
    "",
    "Recruitables",
    "Equipment"   ,
    "Promotions"     ,
    "Misc."     ,
    "Items"      ,
    "Terrain"    ,
    "Allies"     ,
    "Victory"    ,
    "Save"       ,
    "World Map"  ,
    "Other"      ,
};
*/ 

#define ShowAll 0 
#define ShowComplete 1 
#define ShowIncomplete 2 


int GetDisplayType(void) { 
    return Modulo(gAchMenuSt->displayType, 3); // filter 
}; 

void AdvanceDisplayType(void) { 
    gAchMenuSt->displayType = Modulo(gAchMenuSt->displayType + 1, 3);
}; 

// struct AchievementsRomStruct gAchievementsTable[];
// struct AchievementsRomStruct gGuideTable[];


/*
const struct AchievementsRomStruct gAchievementsTable[] = {
    {
        .category = 0x1,
        .flag = 0xB4,
        .entryName = "Testing here",
        .details = "This is a test",
    },
    
    { // terminator 
        .category = Category_Terminator_Link,
        .flag = 0,
        .entryName = "",
        .details = "",
    },
};
*/ 


// int CheckAchievementFlag(int) { 
    // return true; 
// };
// void SetAchievementFlag(int) { 
    // return; 
// };

// clang-format on

extern u8 Tsa_08B176CC[];  // tsa
extern u8 Img_08B177C0[];  // gfx
extern u8 Img_08B17864[];  // gfx
extern u16 Pal_08B17B44[]; // pal

// TODO: Implicit declarations
// void UpdateMenuScrollBarConfig(int, int, int, int);
// ProcPtr StartMenuScrollBarExt(ProcPtr, int, int, int, int);
// void achievement_8097668(void);
// void LockMenuScrollBar(void);
// void EndMenuScrollBar(void);

//! FE8U = 0x080CDF4C
bool AreAchievementsLocked(void)
{
    return false;
    // struct GuideEnt * it = gGuideTable;

    // while (1)
    // {
    // if (it->category == 12)
    // {
    // return TRUE;
    // }

    // if (CheckFlag(it->displayFlag))
    // {
    // return FALSE;
    // }

    // it++;
    // }
}

u8 MapMenu_IsAchievementsCommandAvailable(const struct MenuItemDef * def, int number)
{
    if (AreAchievementsLocked())
    {
        return MENU_NOTSHOWN;
    }

    return MENU_ENABLED;
}
const struct ProcCmd ProcScr_E_Achievements_Map[];
const struct ProcCmd ProcScr_E_Achievements_WM[];
u8 MapMenu_AchievementsCommand(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    InitBonusClaimData();
    Proc_Start(ProcScr_E_Achievements_Map, PROC_TREE_3);

    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

// s8 WorldMap_CallGuide(ProcPtr proc)
// {
// Proc_BlockEachMarked(PROC_MARK_WMSTUFF);
// Proc_StartBlocking(ProcScr_E_Achievements_WM, proc);
// return 0;
// }

int GetCategoryIdx()
{
    return gAchMenuSt->categoryIdx;
}

//! FE8U = 0x080CDF78
void AchievementSpriteDraw_Init(void)
{
    UnpackUiVArrowGfx(0xe0, 3);
    return;
}

#define AchievementBannerPalette 6
//! FE8U = 0x080CDF88
void AchievementSpriteDraw_Loop(void)
{
    int y1;
    int y2;

    GetGameClock();

    PutSprite(3, 4, 8, gSprite_AchievementsBannerText, OAM2_PAL(AchievementBannerPalette & 0xF));

    if (gAchMenuSt->state == GUIDE_STATE_0 || gAchMenuSt->state == GUIDE_STATE_1)
    {
        PutSprite(3, 112, 3, gSprite_AchievementsSelectButtonSort, OAM2_PAL(AchievementBannerPalette));       // pal 2
        PutSprite(3, 112 + 48, 3, gSprite_AchievementsSelectButtonSort2, OAM2_PAL(AchievementBannerPalette)); // pal 2
    }

    PutSprite(3, 176, 3, gSprite_AchievementsBButtonBack, OAM2_PAL(AchievementBannerPalette & 0xF));

    y1 = (gAchMenuSt->categoryIdx - gAchMenuSt->cat_offset) * 2 + 5;
    y2 = (gAchMenuSt->detailsID - gAchMenuSt->details_offset) * 2 + 5;

    switch (gAchMenuSt->state)
    {
        case GUIDE_STATE_0:
            DisplayUiHand(12, y1 * 8);

            if ((gAchMenuSt->sortMode != GUIDE_SORT_MODE_TOPIC ? gAchMenuSt->unk_3c : gAchMenuSt->unk_3d) > 6)
            {
                if (gAchMenuSt->cat_offset != 0)
                {
                    DisplayUiVArrow(32, 32, OAM2_CHR(0xE0) + OAM2_PAL(3), 1);
                }

                if (gAchMenuSt->cat_offset <
                    (gAchMenuSt->sortMode != GUIDE_SORT_MODE_TOPIC ? gAchMenuSt->unk_3c : gAchMenuSt->unk_3d) - 6)
                {
                    DisplayUiVArrow(32, 136, OAM2_CHR(0xE0) + OAM2_PAL(3), 0);
                }
            }

            break;

        case GUIDE_STATE_1:
            DisplayFrozenUiHand(12, y1 * 8);
            DisplayUiHand(80, y2 * 8);

            break;

        case GUIDE_STATE_2:
            DisplayFrozenUiHand(12, y1 * 8);

            if (gAchMenuSt->numDetailLines > 4)
            {
                if ((gAchMenuSt->detailLinesScrolled) != 0)
                {
                    DisplayUiVArrow(144, 56, OAM2_CHR(0xE0) + OAM2_PAL(3), 1);
                }

                if (gAchMenuSt->detailLinesScrolled < gAchMenuSt->numDetailLines - 4)
                {
                    DisplayUiVArrow(144, 128, OAM2_CHR(0xE0) + OAM2_PAL(3), 0);
                }
            }

            break;
    }

    UpdateMenuScrollBarConfig(10, gAchMenuSt->details_offset * 16, gAchMenuSt->entriesInCat, 6);

    return;
}

// used in Achievement_Init and PutDrawText calls
#define BoxMaxTileWidth 18 // normally 18
#define BottomMaxTileWidth 27
#define TitleTileWidth 9

#define BoxMaxWidth (BoxMaxTileWidth * 8)
#define BottomLineMaxWidth (BottomMaxTileWidth * 8)

//! FE8U = 0x080CE5BC
const char * GetStringNextLine_Achievements(const char * str, int maxWidth)
{
    if (!str || !*str)
        return NULL;

    const char * iter = str;
    int ttlWidth = 0;
    u32 width;

    while (*iter)
    {
        char c = *iter;

        // Stop at newline markers
        if (c == CHAR_NEWLINE)
            return iter + 1;

        const char * charEnd = GetCharTextLen(iter, &width);

        // Lookahead for spaces
        if (c == CHAR_SPACE)
        {
            const char * lookahead = charEnd;
            int nextWordWidth = 0;

            // Measure next word
            while (*lookahead && *lookahead != CHAR_SPACE && *lookahead != CHAR_NEWLINE)
            {
                u32 gw;
                lookahead = GetCharTextLen(lookahead, &gw);
                nextWordWidth += gw;
            }

            if (ttlWidth + width + nextWordWidth > maxWidth)
            {
                // Break here before the space and return pointer to first character of next word
                const char * nextWordStart = charEnd; // skip the space itself
                while (*nextWordStart == CHAR_SPACE)
                    nextWordStart++;
                return nextWordStart;
            }
        }

        if (ttlWidth + width > maxWidth)
        {
            // Break at this character
            return iter;
        }

        ttlWidth += width;
        iter = charEnd;
    }

    return NULL;
}

#define CHAR_SPACE 0x20
void TextDrawLineMaxWidth(const char * str, struct Text * th, int maxWidth)
{
    if (!str || !*str)
        return;

    // Skip initial newlines
    while (*str == CHAR_NEWLINE || *str == CHAR_SPACE)
        str++;

    if (!*str)
        return;

    // Compute where this line should break
    const char * lineEnd = GetStringNextLine_Achievements(str, maxWidth);
    if (!lineEnd)
        lineEnd = str + strlen(str); // draw until the end of string

    const char * iter = str;

    // Draw characters up to the break position
    while (iter < lineEnd)
    {
        if (*iter == CHAR_NEWLINE)
        {
            iter++;
            continue;
        }
        iter = Text_DrawCharacterAscii(th, iter);
    }
}

void PutDrawAchievementBodyText(struct Text * text, u16 * dest, int colorId, int x, int tileWidth, const char * string)
{

    struct Text tmpText;

    if (text == NULL)
    {
        text = &tmpText;
        InitText(text, tileWidth);
    }
    Text_SetCursor(text, x);
    Text_SetColor(text, colorId);
    TextDrawLineMaxWidth(string, text, tileWidth * 8);

    // Text_DrawString(text, str);

    PutText(text, dest);
}

void PutAchievementPercentageText()
{
    int perc = GetAchievementPercentage();
    struct Text * th = gStatScreen.text;
    ClearText(th + 0);
    Text_InsertDrawString(
        th + 0, 0, perc == 100 ? 4 : 0,
        GetStringFromIndex(0x5AA) // TODO: msgid "Success[.]"
    );

    Text_SetCursor(th + 0, 52);
    Text_SetColor(th + 0, perc == 100 ? 4 : 2);
    Text_DrawNumberOrBlank(th + 0, perc);

    Text_InsertDrawString(
        th + 0, 60, perc == 100 ? 4 : 0,
        GetStringFromIndex(0x5AE) // TODO: msgid "%[.]"
    );

    PutText(th + 0, TILEMAP_LOCATED(gBG0TilemapBuffer, 20, 2));
}

//! FE8U = 0x080CE148
void PutAchievementBottomBarText(void)
{

    ClearText(&gAchMenuSt->unk_ec);
    if (!gAchMenuSt->state) // nothing selected yet
    {
        return;
    }
    // brk; // 20201b3 188
    // gAchMenuSt has max 20 entries
    int id = gAchMenuSt->detailsEntry[gAchMenuSt->detailsID];
    if (!gAchMenuSt->entriesInCat)
    {
        return;
    }
    const char * str = gAchievementsTable[id].details;
    PutDrawAchievementBodyText(
        &gAchMenuSt->unk_ec, TILEMAP_LOCATED(gBG0TilemapBuffer, 2, 18), TEXT_COLOR_SYSTEM_WHITE, 0, BottomMaxTileWidth,
        str); // TODO: msgid "About"

    // const char * str = gAchievementsTable[gAchMenuSt->cat_topicID[gAchMenuSt->categoryIdx]].details;
    // const char * str = gAchievementsTable[gAchMenuSt->detailsEntry[proc->unk_34]].details;
    // int category = gAchMenuSt->cat_topicID[gAchMenuSt->categoryIdx];

    // int id = gAchMenuSt->detailsID;

    // Text_DrawString(&gAchMenuSt->unk_ec,
    // gTextIds_AchievementsCategoriesTopic[gAchMenuSt->cat_topicID[gAchMenuSt->categoryIdx]]);
    // Text_DrawString(&gAchMenuSt->unk_ec, str);
    if (GetStringNextLine_Achievements(str, BottomLineMaxWidth))
    {
        Text_DrawString(&gAchMenuSt->unk_ec, " ...");
    }
    BG_EnableSyncByMask(BG0_SYNC_BIT);
    return;
}

//! FE8U = 0x080CE1C0
void achievement_DrawCategory(int strIndex, int textIndex, int y)
{

    const char * str;

    ClearText(&gAchMenuSt->unk_7c[textIndex]);

    str = gTextIds_AchievementsCategoriesTopic[gAchMenuSt->cat_topicID[strIndex]];

    PutDrawText(
        &gAchMenuSt->unk_7c[textIndex], TILEMAP_LOCATED(gBG1TilemapBuffer, 2, y), TEXT_COLOR_SYSTEM_WHITE, 0,
        TitleTileWidth, str);
    return;
}

void DrawFilterText(void);
void UpdateFilterText(void);
//! FE8U = 0x080CE248
void achievement_DrawCategories(void)
{
    // DrawFilterText();
    UpdateFilterText();
    int line;
    int offset = gAchMenuSt->cat_offset;

    int a = (gAchMenuSt->sortMode != GUIDE_SORT_MODE_TOPIC) ? gAchMenuSt->unk_3c : gAchMenuSt->unk_3d;
    for (line = 0; line < 6; line++)
    {
        if (line < a)
        {
            // achievement_DrawCategory(line + offset, line, (line * 2) + 5); // unsure if it matters between these two
            // options of Modulo 6 with offset or not
            achievement_DrawCategory(line + offset, Modulo(line + offset, 6), (line * 2) + 5);
        }
    }

    return;
}

//! FE8U = 0x080CE28C
void achievement_80CE28C(void)
{
    int iy;
    int ix;

    int yBase = 160;

    for (iy = 0; iy < 12; iy++)
    {
        for (ix = 0; ix < 28; ix++)
        {
            gBG1TilemapBuffer[(yBase + 1) + ix] = 0;
        }
        yBase += 0x20;
    }

    for (ix = 0; ix < 28; ix++)
    {
        gBG0TilemapBuffer[0x241 + ix + 0x00] = 0;
        gBG0TilemapBuffer[0x241 + ix + 0x20] = 0;
    }

    return;
}

//! FE8U = 0x080CE2E4
void AchievementMenuRefresh_SyncBg1(void)
{
    BG_EnableSyncByMask(BG1_SYNC_BIT);
    return;
}

//! FE8U = 0x080CE2F0
void AchievementMenuRefresh_SyncBg0Bg1(void)
{
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT);
    return;
}

//! FE8U = 0x080CE2FC
void AchievementEntry_RedrawUp(struct GuideProc * proc)
{
    int idx = proc->unk_34;
    int textIdx = Modulo(idx, 6);

    ClearText(&gAchMenuSt->unk_b4[textIdx]);

    PutDrawAchievementBodyText(
        &gAchMenuSt->unk_b4[textIdx], TILEMAP_LOCATED(gBG1TilemapBuffer, 11, 5),
        GetAchievementColour(gAchievementsTable[gAchMenuSt->detailsEntry[idx]].flag), 0, BoxMaxTileWidth,
        gAchievementsTable[gAchMenuSt->detailsEntry[idx]].entryName);

    return;
}

//! FE8U = 0x080CE388
void AchievementEntry_RedrawDown(struct GuideProc * proc)
{
    int idx = proc->unk_34;
    int textIdx = Modulo(idx, 6);

    ClearText(&gAchMenuSt->unk_b4[textIdx]);

    PutDrawAchievementBodyText(
        &gAchMenuSt->unk_b4[textIdx], TILEMAP_LOCATED(gBG1TilemapBuffer, 11, 15),
        GetAchievementColour(gAchievementsTable[gAchMenuSt->detailsEntry[idx]].flag), 0, BoxMaxTileWidth,
        gAchievementsTable[gAchMenuSt->detailsEntry[idx]].entryName);

    return;
}

//! FE8U = 0x080CE414
void achievement_DrawMoreText(void)
{

    struct NewBonusClaimRamStruct * tmp = (void *)gpBonusClaimData;
    struct AchievementsStruct * ent = (void *)&tmp[4];
    struct AchievementsRomStruct * data = gAchievementsTable;

    int details_offset;
    int line;
    int i = 0;

    int y = 5;
    int ttlDisplayedEntries = 0;
    int perc = GetAchievementPercentage();

    for (gAchMenuSt->entriesInCat = 0; gAchievementsTable[i].category != Category_Terminator_Link; i++)
    {

        int displayType = GetDisplayType();
        if (displayType == ShowIncomplete)
        { // filter out complete ones
            if (IsAchievementCompleteFilter(i, ent, data, perc))
            {
                continue;
            }
        }
        else if (displayType == ShowComplete)
        { // filter out incomplete ones
            if (!IsAchievementCompleteFilter(i, ent, data, perc))
            {
                continue;
            }
        }

        if (gAchievementsTable[i].category == gAchMenuSt->cat_topicID[gAchMenuSt->categoryIdx])
        {
            gAchMenuSt->detailsEntry[ttlDisplayedEntries] = i;
            ttlDisplayedEntries++;
        }
    }

    gAchMenuSt->entriesInCat = ttlDisplayedEntries;
    while (gAchMenuSt->detailsID >= ttlDisplayedEntries)
    {
        if (ttlDisplayedEntries <= 0)
        {
            gAchMenuSt->detailsID = 0;
            gAchMenuSt->details_offset = 0;
            break;
        }
        gAchMenuSt->detailsID--;
    }
    gAchMenuSt->details_offset = gAchMenuSt->detailsID - 4; // idk why but this works
    if (gAchMenuSt->details_offset < 0)
    {
        gAchMenuSt->details_offset = 0;
    }

    line = details_offset = gAchMenuSt->details_offset;

    for (i = 0; i <= 5 && ttlDisplayedEntries != 0; y += 2, line++, ttlDisplayedEntries--, details_offset++, i++)
    {
        line = Modulo(line, 6);
        ClearText(&gAchMenuSt->unk_b4[line]);

        PutDrawAchievementBodyText(
            &gAchMenuSt->unk_b4[line], gBG1TilemapBuffer + TILEMAP_INDEX(11, y),
            (GetAchievementColour(gAchievementsTable[gAchMenuSt->detailsEntry[details_offset]].flag)), 0,
            BoxMaxTileWidth, gAchievementsTable[gAchMenuSt->detailsEntry[details_offset]].entryName);
    }
    PutAchievementBottomBarText();

    return;
}

//! FE8U = 0x080CE588
void AchievementEntry_DrawInitial(void)
{
    int ix;
    int iy;

    int base = 160;

    for (iy = 0; iy < 12; iy++)
    {
        for (ix = 0; ix < 19; ix++)
        {
            int x = 10 + ix;

            gBG1TilemapBuffer[x + base] = 0;
        }

        base += 0x20;
    }

    return;
}

//! FE8U = 0x080CE5F0
void MoveAchievementDetailText(int idx, int moveDirection)
{
    int detailLinesScrolled;
    int i;

    int numDetailLines = 1;

    const char * str = gAchievementsTable[idx].details;
    while (1)
    {
        str = GetStringNextLine_Achievements(str, BoxMaxWidth);
        if (str == NULL)
        {
            break;
        }

        numDetailLines++;
    }

    gAchMenuSt->numDetailLines = numDetailLines;

    detailLinesScrolled = gAchMenuSt->detailLinesScrolled;

    if (moveDirection != GUIDE_DETAILS_STAY)
    {
        if (numDetailLines > 4)
        {
            if (moveDirection == GUIDE_DETAILS_ADVANCE)
            {
                if (detailLinesScrolled + 4 <= numDetailLines - 4)
                {
                    detailLinesScrolled = detailLinesScrolled + 4;
                }
                else
                {
                    detailLinesScrolled = numDetailLines - 4;
                }
            }
            else
            {
                if (detailLinesScrolled - 4 >= 0)
                {
                    detailLinesScrolled = detailLinesScrolled - 4;
                }
                else
                {
                    detailLinesScrolled = 0;
                }
            }
        }

        if ((moveDirection != GUIDE_DETAILS_STAY) && (gAchMenuSt->detailLinesScrolled == detailLinesScrolled))
        {
            return;
        }
    }

    AchievementEntry_DrawInitial();

    gAchMenuSt->detailLinesScrolled = detailLinesScrolled;

    ClearText(gAchMenuSt->unk_b4);

    PutDrawAchievementBodyText(
        gAchMenuSt->unk_b4, TILEMAP_LOCATED(gBG1TilemapBuffer, 10, 5), TEXT_COLOR_SYSTEM_GOLD, 2, BoxMaxTileWidth,
        gAchievementsTable[idx].entryName);

    str = gAchievementsTable[idx].details;

    for (i = 0; i < detailLinesScrolled + 4; i++)
    {

        if (i != 0)
        {
            str = GetStringNextLine_Achievements(str, BoxMaxWidth);
            if (str == NULL)
            {
                break;
            }
        }

        if (i >= detailLinesScrolled)
        {
            int off;
            int textIndex = Modulo(i, 5);

            ClearText(&gAchMenuSt->unk_b4[1 + textIndex]);

            PutDrawAchievementBodyText(
                &gAchMenuSt->unk_b4[1 + textIndex],
                gBG1TilemapBuffer + 11 + ((Modulo((i - detailLinesScrolled), 4) * 0x40) + (off = 0x100)),
                TEXT_COLOR_SYSTEM_WHITE, 0, BoxMaxTileWidth, str); // - 1
        }
    }

    BG_EnableSyncByMask(BG1_SYNC_BIT);

    return;
}

extern struct ProcCmd const gProcScr_AchievementEntryListRedraw_Up[];

//! FE8U = 0x080CE750
void achievement_80CE750(ProcPtr proc, int b)
{
    struct GuideProc * child;
    int ix;
    int iy;

    int off = 0x1a0;

    switch (gAchMenuSt->state)
    {
        case GUIDE_STATE_0:
            for (iy = 0; iy < 5; iy++)
            {
                for (ix = 0; ix < 8; ix++)
                {
                    gBG1TilemapBuffer[ix + off + 0x42] = gBG1TilemapBuffer[ix + off + 0x02];
                    gBG1TilemapBuffer[ix + off + 0x62] = gBG1TilemapBuffer[ix + off + 0x22];
                }
                off = off - 0x40;
            }
            // achievement_DrawCategories();
            achievement_DrawCategory(b, Modulo(b, 6), 5);

            break;

        case GUIDE_STATE_1:
            for (iy = 0; iy < 5; iy++)
            {
                for (ix = 0; ix < 19; ix++)
                {
                    gBG1TilemapBuffer[ix + off + 0x4a] = gBG1TilemapBuffer[ix + off + 0x0a];
                    gBG1TilemapBuffer[ix + off + 0x6a] = gBG1TilemapBuffer[ix + off + 0x2a];
                }
                off = off - 0x40;
            }

            child = Proc_Start(gProcScr_AchievementEntryListRedraw_Up, proc);
            child->unk_34 = b;
    }

    BG_EnableSyncByMask(BG1_SYNC_BIT);

    return;
}

extern struct ProcCmd const gProcScr_AchievementEntryListRedraw_Down[];

//! FE8U = 0x080CE858
void achievement_80CE858(ProcPtr proc, int b)
{
    struct GuideProc * child;
    int ix;
    int iy;

    int off = 0xa0;

    switch (gAchMenuSt->state)
    {
        case GUIDE_STATE_0:
            for (iy = 0; iy < 5; iy++)
            {
                for (ix = 0; ix < 8; ix++)
                {
                    gBG1TilemapBuffer[ix + off + 0x02] = gBG1TilemapBuffer[ix + off + 0x42];
                    gBG1TilemapBuffer[ix + off + 0x22] = gBG1TilemapBuffer[ix + off + 0x62];
                }
                off = off + 0x40;
            }
            // brk;
            // achievement_DrawCategories();
            achievement_DrawCategory(b, Modulo(b, 6), 15);

            break;

        case GUIDE_STATE_1:
            for (iy = 0; iy < 5; iy++)
            {
                for (ix = 0; ix < 19; ix++)
                {
                    gBG1TilemapBuffer[ix + off + 0x0a] = gBG1TilemapBuffer[ix + off + 0x4a];
                    gBG1TilemapBuffer[ix + off + 0x2a] = gBG1TilemapBuffer[ix + off + 0x6a];
                }
                off = off + 0x40;
            }

            child = Proc_Start(gProcScr_AchievementEntryListRedraw_Down, proc);
            child->unk_34 = b;
    }

    BG_EnableSyncByMask(BG1_SYNC_BIT);

    return;
}

//! FE8U = 0x080CE95C
void AchievementDetailsRedraw_Init(struct GuideProc * proc)
{
    int textIdx;
    const char * str;
    int unk_34;

    unk_34 = proc->unk_34;
    textIdx = Modulo(unk_34, 5);

    str = gAchievementsTable[gAchMenuSt->detailsEntry[gAchMenuSt->detailsID]].details;

    while (unk_34 != 0)
    {
        str = GetStringNextLine_Achievements(str, BoxMaxWidth);
        if (str == NULL)
        {
            break;
        }

        unk_34--;
    }

    ClearText(&gAchMenuSt->unk_b4[1 + textIdx]);
    PutDrawAchievementBodyText(
        &gAchMenuSt->unk_b4[1 + textIdx], TILEMAP_LOCATED(gBG1TilemapBuffer, 11, 18), TEXT_COLOR_SYSTEM_WHITE, 0,
        BoxMaxTileWidth, str); // -1

    proc->unk_34 = 0;

    return;
}

//! FE8U = 0x080CE9E8
void AchievementDetailsRedraw_Loop(struct GuideProc * proc)
{
    int iy;
    int ix;
    int baseA;
    int baseB;

    if (proc->unk_38 == 0)
    {
        baseA = 0x1c0;
        baseB = 0x260;
        for (iy = 0; iy < 7; iy++)
        {
            for (ix = 0; ix < 19; ix++)
            {
                gBG1TilemapBuffer[baseA + 0x2a + ix] = gBG1TilemapBuffer[baseA + 0x0a + ix];
            }
            baseA -= 0x20;
        }

        if (proc->unk_34 != 0)
        {
            baseB -= 0x20;
        }

        for (ix = 0; ix < 19; ix++)
        {
            gBG1TilemapBuffer[baseA + 0x2a + ix] = gBG1TilemapBuffer[baseB + 0x0a + ix];
        }
    }
    else
    {
        baseA = 0x100;
        baseB = 0x220;
        for (iy = 0; iy < 7; iy++)
        {
            for (ix = 0; ix < 19; ix++)
            {
                gBG1TilemapBuffer[baseA + 0x0a + ix] = gBG1TilemapBuffer[baseA + 0x2a + ix];
            }
            baseA += 0x20;
        }

        if (proc->unk_34 != 0)
        {
            baseB += 0x20;
        }

        for (ix = 0; ix < 0x13; ix++)
        {
            gBG1TilemapBuffer[baseA + 0x0a + ix] = gBG1TilemapBuffer[baseB + 0x2a + ix];
        }
    }

    BG_EnableSyncByMask(BG1_SYNC_BIT);

    if (proc->unk_34 == 0)
    {
        proc->unk_34 = 1;
        return;
    }

    Proc_Break(proc);

    return;
}

//! FE8U = 0x080CEAE8
void achievement_80CEAE8(void)
{
    int i;
    u8 local[MaxEntriesPerCategory];
    int r3;
    int r4;

    for (i = 0; i < MaxEntriesPerCategory; i++)
    {
        local[i] = 0;
        gAchMenuSt->cat_topicID[i] = 0;
    }

    i = 0;
    r4 = gAchievementsTable[i].category;

    while (gAchievementsTable[i].category != Category_Terminator_Link)
    {
        // if (CheckFlag(gAchievementsTable[i].displayFlag))
        // {
        local[r4] = r4;
        // }

        i++;
        r4 = gAchievementsTable[i].category;
    }

    gAchMenuSt->unk_3d = 0;

    for (i = 0; i < Category_Terminator_Link; i++)
    {
        int tmp2;

        r4 = local[i];
        if (r4 == 0)
        {
            continue;
        }

        if (gAchMenuSt->unk_3d == 0)
        {
            gAchMenuSt->cat_topicID[0] = r4;
            gAchMenuSt->unk_3d++;
        }
        else
        {
            r3 = 0;
            tmp2 = (r3 < gAchMenuSt->unk_3d) && (gAchMenuSt->cat_topicID[0] == r4);
            if (tmp2 != 0)
            {
                continue;
            }
            gAchMenuSt->cat_topicID[gAchMenuSt->unk_3d] = r4;
            gAchMenuSt->unk_3d++;
        }
    }

    return;
}

//! FE8U = 0x080CEBA4
void achievement_80CEBA4(void)
{
    int i;
    u8 local[MaxEntriesPerCategory];
    int r3;
    int r4;

    for (i = 0; i < MaxEntriesPerCategory; i++)
    {
        local[i] |= 0xff;
        gAchMenuSt->cat_chID[i] = 0;
    }

    i = 0;
    r4 = gAchievementsTable[i].category;

    while (r4 != Category_Terminator_Link)
    {
        // if (CheckFlag(gAchievementsTable[i].displayFlag))
        // {
        // r4 = gAchievementsTable[i].chapterTitle;
        local[r4] = r4;
        // }

        i++;
        r4 = gAchievementsTable[i].category;
    }

    gAchMenuSt->unk_3c = 0;

    for (i = 0; i < Category_Terminator_Link; i++)
    {
        int tmp2;

        if (local[i] == 0xff)
        {
            continue;
        }

        r4 = local[i];

        if (gAchMenuSt->unk_3c == 0)
        {
            gAchMenuSt->cat_chID[0] = r4;
            gAchMenuSt->unk_3c++;
        }
        else
        {
            r3 = 0;
            tmp2 = (r3 < gAchMenuSt->unk_3c) && (gAchMenuSt->cat_chID[0] == r4);
            if (tmp2 != 0)
            {
                continue;
            }
            gAchMenuSt->cat_chID[gAchMenuSt->unk_3c] = r4;
            gAchMenuSt->unk_3c++;
        }
    }

    return;
}

//! FE8U = 0x080CEC68
void achievement_80CEC68(u16 off)
{
    int ix;
    int iy;

    int yBase = 160;

    for (iy = 0; iy < 12; iy++)
    {
        for (ix = 0; ix < 9; ix++)
        {
            gBG2TilemapBuffer[yBase + ix] = off + (gBG2TilemapBuffer[yBase + ix] & 0xFFF);
        }

        yBase += 32;
    }

    return;
}

// clang-format off

struct ProcCmd const gProcScr_Achievement_DrawSprites[] =
{
    PROC_NAME("E_guideSub"),

    PROC_CALL(AchievementSpriteDraw_Init),
    PROC_REPEAT(AchievementSpriteDraw_Loop),

    PROC_END,
};

// clang-format on
void achievement_8097668(void)
{
    struct MenuScrollBarProc * proc = Proc_Find(ProcScr_menu_scroll);

    if (proc)
    {
        Proc_Goto(proc, 0);
    }

    return;
}

void InitFilterText()
{
    int chr = 0x98;
    brk;
    InitSpriteTextFont(&gHelpBoxSt.font, (void *)(VRAM + 0x10000 + (chr << 5)), 0x16);
    SetTextFontGlyphs(1);
    // ApplyPalette(gPal_HelpTextBox, GetNotifObjPalID());
    return;
};

void ClearFilterText(struct Text * text)
{
    struct Font * font = gActiveFont;
    InitFilterText();
    SetTextFont(&gHelpBoxSt.font); // use our own chr_counter
    InitSpriteText(text);
    // SpriteText_DrawBackground(text);
    // SpriteText_DrawBackgroundExt(text, 0);
    SetTextFont(font);
}
const char * const FilterText[] = {
    "Show All",
    "Show Done",
    "Show To Do",
};
void DrawFilterText()
{
    struct Font * font = gActiveFont;
    SetTextFont(&gHelpBoxSt.font); // use our own chr_counter
    struct Text * th = &gStatScreen.text[1];
    ClearFilterText(th);
    char * iter = (void *)FilterText[GetDisplayType()];
    while (*iter)
    {
        iter = (void *)Text_DrawCharacterAscii(th, (void *)iter);
    }
    SetTextFont(font);
}

void UpdateFilterText(void)
{

    switch (GetDisplayType())
    {
        case ShowAll:
            Decompress(gGfx_ShowAll, gGenericBuffer + 0x200);
            break;
        case ShowComplete:
            Decompress(gGfx_ShowDone, gGenericBuffer + 0x200);
            break;
        case ShowIncomplete:
            Decompress(gGfx_ShowToDo, gGenericBuffer + 0x200);
            break;
    }
    // Copy2dChr(gGenericBuffer + 0x100, (void *)0x06011300, 4, 4);
    Copy2dChr(gGenericBuffer + 0x200, (void *)0x060110C0, 6, 2);
}

//! FE8U = 0x080CECB0
void Achievement_Init(ProcPtr proc)
{
    int i = 0;

    SetupBackgrounds(NULL);

    gAchMenuSt->state = GUIDE_STATE_0;
    gAchMenuSt->displayType = 0;
    gAchMenuSt->entriesInCat = 0;

    gAchMenuSt->sortMode = 0; // CheckFlag(0xb3);

    gAchMenuSt->categoryIdx = 0;
    gAchMenuSt->cat_offset = 0;
    gAchMenuSt->detailsID = 0;
    gAchMenuSt->details_offset = 0;

    achievement_80CEAE8(); // sort by category
    // achievement_80CEBA4(); // sort by chapter
    LoadUiFrameGraphics();

    SetDispEnable(1, 1, 1, 1, 1);

    BG_SetPosition(BG_0, 0, 0);
    BG_SetPosition(BG_1, 0, 0);
    BG_SetPosition(BG_2, 0, 0);
    BG_SetPosition(BG_3, 0, 0);

    BG_Fill(gBG0TilemapBuffer, 0);
    BG_Fill(gBG1TilemapBuffer, 0);
    BG_Fill(gBG2TilemapBuffer, 0);
    BG_Fill(gBG3TilemapBuffer, 0);

    SetWinEnable(1, 0, 0);
    SetWin0Box(0, 40, DISPLAY_WIDTH, 136);

    SetWin0Layers(1, 1, 1, 1, 1);
    SetWOutLayers(1, 0, 1, 1, 1);

    ApplyPalette(Pal_08B17B44, 0x10 + AchievementBannerPalette);
    Decompress(Img_08B17864, (void *)0x06011000);
    // DrawFilterText();
    UpdateFilterText();

    // Decompress(Img_08B177C0, (void *)0x06011800); // "Guide"
    Decompress(Img_Achievements, (void *)0x06011800); // "Guide"

    Decompress(Tsa_08B176CC, gGenericBuffer + 0x100);
    CallARM_FillTileRect(gBG2TilemapBuffer, gGenericBuffer + 0x100, 0x1000);

    ApplyPalette(gUiFramePaletteA + (gPlaySt.config.windowColor + 4) * 0x10, 2);

    ResetTextFont();

    InitText(gStatScreen.text, 9);

    InitText(&gAchMenuSt->unk_ec, BottomMaxTileWidth);

    InitText(&gAchMenuSt->unk_ac, 9);
    InitText(&gAchMenuSt->unk_e4, 18);

    for (i = 0; i < 6; i++)
    {
        InitText(&gAchMenuSt->unk_7c[i], TitleTileWidth);
        InitText(&gAchMenuSt->unk_b4[i], BoxMaxTileWidth);
    }
    // PutAchievementBottomBarText();
    PutAchievementPercentageText();

    achievement_DrawCategories();
    achievement_DrawMoreText();

    StartMuralBackgroundExt(proc, 0, 18, 2, 0);
    Proc_Start(gProcScr_Achievement_DrawSprites, proc);

    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT | BG3_SYNC_BIT);

    StartMenuScrollBarExt(proc, 224, 47, 0x800, 4);
    UpdateMenuScrollBarConfig(10, gAchMenuSt->details_offset * 16, gAchMenuSt->entriesInCat, 6);

    achievement_8097668();

    return;
}

//! FE8U = 0x080CEF10
void Achievement_SetBlend(void)
{
    SetBlendAlpha(15, 4);
    SetBlendTargetA(0, 0, 1, 0, 0);
    SetBlendTargetB(0, 0, 0, 1, 0);
    return;
}

//! FE8U = 0x080CEF48
int GetAchievementAction(ProcPtr proc)
{
    switch (gAchMenuSt->state)
    {
        case GUIDE_STATE_0:
        case GUIDE_STATE_1:
            if (gKeyStatusPtr->newKeys & SELECT_BUTTON)
            {
                return GUIDE_ACTION_SORT;
            }

            // fallthrough

            // case GUIDE_STATE_1:
            if (gKeyStatusPtr->newKeys & A_BUTTON)
            {
                return GUIDE_ACTION_A_PRESS;
            }

            if (gKeyStatusPtr->newKeys & B_BUTTON)
            {
                return GUIDE_ACTION_CANCEL;
            }

            break;

        case GUIDE_STATE_2:
            if (gKeyStatusPtr->newKeys & B_BUTTON)
            {
                return GUIDE_ACTION_CANCEL;
            }

            if (gKeyStatusPtr->newKeys & (A_BUTTON | DPAD_RIGHT))
            {
                return GUIDE_ACTION_ADVANCE_TEXT;
            }

            if (gKeyStatusPtr->newKeys & DPAD_LEFT)
            {
                return GUIDE_ACTION_REVERSE_TEXT;
            }
    }

    if (gKeyStatusPtr->repeatedKeys & (DPAD_UP | DPAD_DOWN))
    {
        return GUIDE_ACTION_1;
    }
    return 0;
}

// clang-format off

struct ProcCmd const gProcScr_AchievementCategoryRedraw[] =
{
    PROC_NAME("E_guMenu1ReWrite"),
    PROC_SLEEP(1),

    PROC_CALL(achievement_80CE28C),
    PROC_CALL(AchievementMenuRefresh_SyncBg1),
    PROC_SLEEP(1),

    PROC_CALL(achievement_DrawCategories),
    PROC_SLEEP(1),

    PROC_CALL(achievement_DrawMoreText),
    PROC_SLEEP(1),

    // PROC_CALL(PutAchievementBottomBarText),
    PROC_CALL(AchievementMenuRefresh_SyncBg0Bg1),

    PROC_END,
};

struct ProcCmd const gProcScr_AchievementEntryListRedraw_Initial[] =
{
    PROC_NAME("E_guMenu2ReWriteFirst"),
    PROC_SLEEP(1),

    PROC_CALL(AchievementEntry_DrawInitial),
    PROC_CALL(AchievementMenuRefresh_SyncBg1),
    PROC_SLEEP(1),

    PROC_CALL(achievement_DrawMoreText),
    PROC_SLEEP(1),

    // PROC_CALL(PutAchievementBottomBarText),
    PROC_CALL(AchievementMenuRefresh_SyncBg1),

    PROC_END,
};

struct ProcCmd const gProcScr_AchievementEntryListRedraw_Up[] =
{
    PROC_NAME("E_guMenu2ReWriteUp"),
    PROC_SLEEP(1),

    PROC_CALL(AchievementEntry_RedrawUp),
    PROC_CALL(PutAchievementBottomBarText),
    PROC_CALL(AchievementMenuRefresh_SyncBg1),

    PROC_END,
};

struct ProcCmd const gProcScr_AchievementEntryListRedraw_Down[] =
{
    PROC_NAME("E_guMenu2ReWriteDown"),
    PROC_SLEEP(1),

    PROC_CALL(AchievementEntry_RedrawDown),
    PROC_CALL(PutAchievementBottomBarText),
    PROC_CALL(AchievementMenuRefresh_SyncBg1),

    PROC_END,
};

struct ProcCmd const gProcScr_AchievementDetailsRedraw[] =
{
    PROC_NAME("E_guMess3ReWrite"),
    PROC_SLEEP(1),

    PROC_CALL(AchievementDetailsRedraw_Init),
    PROC_CALL(PutAchievementBottomBarText),
    PROC_REPEAT(AchievementDetailsRedraw_Loop),

    PROC_END,
};

// clang-format on
#define RewardUnavailable (-1)
#define RewardClaimed 0
#define RewardAvailable 1
int CanObtainReward(int id)
{
    if (IsAchievementShown(id)) // data for whether it's had a popup is instead used as whether it's been claimed here
    {
        return RewardClaimed; // already claimed
    }
    int perc = GetAchievementPercentage();
    if (rewardsByPercentage[id].percent <= perc)
    {
        return RewardAvailable;
    }
    return RewardUnavailable; // we don't have enough percentage completion
}

#define AchievementPopupItemIconPal 7

#define RewardTypeItem 0
#define RewardTypeGold 1
#define RewardTypeChar 2
#define RewardTypeMisc 3
void AchievementsPopup_DrawText(char * str);
void DrawNumAsString(int num);
struct NewGuideProc
{
    /* 00 */ PROC_HEADER;
    /* 2C */ int unk_2c;
    /* 3C */ int unk_3c;
    /* 34 */ int unk_34;
    /* 38 */ int unk_38;
    u8 timer;
    u8 line;
    u8 type;
    u8 pressed;
};
void HandleItemReward(struct NewGuideProc * proc, int id)
{
    LoadIconPalette(0, 0x10 + AchievementPopupItemIconPal);
    int itemId = rewardsByPercentage[id].reward.item;
    LoadIconObjectGraphics(GetItemIconId(itemId), 0x140);
    // AddItemToConvoy(MakeNewItem(itemId));

    AchievementsPopup_DrawText("Sent: ");
    gAchMenuSt->popupText[0].x += 16;
    AchievementsPopup_DrawText(GetItemName(itemId));
}
void HandleGoldReward(struct NewGuideProc * proc, int id)
{
    LoadIconPalette(0, 0x10 + AchievementPopupItemIconPal);
    int itemId = 0x9A;
    int gold = rewardsByPercentage[id].reward.item;
    // SetPartyGoldAmount(gold + GetPartyGoldAmount());
    LoadIconObjectGraphics(GetItemIconId(itemId), 0x140);

    AchievementsPopup_DrawText("Sent: ");
    gAchMenuSt->popupText[0].x += 16;
    DrawNumAsString(gold);
    AchievementsPopup_DrawText(" Gold");
}

void HandleCharReward(struct NewGuideProc * proc, int id)
{
    PlaySoundEffect(SONG_SE_SYS_WINDOW_CANSEL1);
    AchievementsPopup_DrawText("Non-functional");
}

void HandleMiscReward(struct NewGuideProc * proc, int id)
{

    AchievementsPopup_DrawText(rewardsByPercentage[id].reward.str);
}

void HandleReward(struct NewGuideProc * proc, int id)
{
    id += 1;
    struct Font * font = gActiveFont;
    gAchMenuSt->timer = 0;
    proc->pressed = false;
    proc->line = 0;
    int available = CanObtainReward(id);
    if (available == RewardAvailable)
    {
        // LockMenuScrollBar();
        UnlockAchievementNoMsg(id); // we've now claimed it

        // achievement_DrawMoreText((void *)proc);
        Proc_StartBlocking(gProcScr_AchievementCategoryRedraw, proc);
        // AchievementEntry_RedrawUp((void *)proc);

        Proc_Goto(proc, 2);
        proc->type = rewardsByPercentage[id].type;

        NotificationInitSpriteText(VRAM + (void *)0x10000 + (0x180 << 5));
        InitSpriteText(&gAchMenuSt->popupText[0]);
        SpriteText_DrawBackground(&gAchMenuSt->popupText[0]);

        switch (proc->type)
        {

            case RewardTypeItem:
            {
                HandleItemReward(proc, id);
                UnlockBonusItem(rewardsByPercentage[id].reward.bonusId);
                break;
            }
            case RewardTypeGold:
            {
                HandleGoldReward(proc, id);
                UnlockBonusItem(rewardsByPercentage[id].reward.bonusId);
                break;
            }
            case RewardTypeChar:
            {
                // HandleCharReward(proc, id);
                return;
                break;
            }
            case RewardTypeMisc:
            {
                HandleMiscReward(proc, id);
                break;
            }
        }

        PlaySoundEffect(SONG_SE_SYS_WINDOW_SELECT1);
    }
    else if (available == RewardUnavailable)
    {
        PlaySoundEffect(SONG_SE_SYS_WINDOW_CANSEL1);
    }
    else if (available == RewardClaimed)
    {
        Proc_Goto(proc, 2);
        proc->type = RewardTypeMisc;

        NotificationInitSpriteText(VRAM + (void *)0x10000 + (0x180 << 5));
        InitSpriteText(&gAchMenuSt->popupText[0]);
        SpriteText_DrawBackground(&gAchMenuSt->popupText[0]);
        AchievementsPopup_DrawText("Already claimed.");
        PlaySoundEffect(SONG_SE_SYS_WINDOW_CANSEL1);
    }
    SetTextFont(font);
}

void AchievementsPopup_DrawText(char * str)
{
    struct Font * font = gActiveFont;
    SetTextFont(&gHelpBoxSt.font); // use our own chr_counter
    struct Text * th = &gAchMenuSt->popupText[0];
    struct NotificationWindowProc proc = { 0 };
    proc.spriteText = true;
    proc.line = 0;
    while (str && *str)
    {
        str = NotificationPrintText(&proc, &th[proc.line], str);
    }
    SetTextFont(font);
}
void DrawNumAsString(int num)
{
    if (num == 0)
    {
        AchievementsPopup_DrawText("0");
        return;
    }

    int digits = 0;
    u8 digit[10];
    int tmp = num;

    // extract digits in reverse order
    while (tmp)
    {
        digit[digits++] = tmp % 10;
        tmp /= 10;
    }

    char str[11] = { 0 }; // enough for 10 digits + null terminator

    // rebuild number string in correct order
    for (int i = 0; i < digits; ++i)
    {
        str[i] = '0' + digit[digits - 1 - i];
    }

    AchievementsPopup_DrawText(str);
}

void AchievementsPopupSentTimer(struct NewGuideProc * proc)
{
    gAchMenuSt->timer++;
    // void PutSprite(int layer, int x, int y, const u16 * object, int oam2);
    int x = 24;
    int y = 60;
    // PutSprite(0, x, y, gObject_16x16, OAM2_CHR(0x280) + OAM2_PAL(2));

    // DisplayNotifBoxObj
    DisplayNotifBoxObj(x, y, 184, 1 * 16, true);
    if (proc->type == RewardTypeItem || proc->type == RewardTypeGold)
    {
        PutSprite(0, x + 28, y, gObject_16x16, OAM2_CHR(0x140) + OAM2_PAL(AchievementPopupItemIconPal & 0xF));
    }
    if (gAchMenuSt->timer > 10)
    {
        if (gKeyStatusPtr->newKeys & (B_BUTTON | A_BUTTON))
        {
            proc->pressed = true;
        }
    }
    if (gAchMenuSt->timer > 40)
    {
        if (proc->pressed)
        {
            Proc_Break(proc);
        }
    }
}

void Achievement_MainLoop(struct GuideProc * proc)
{
    struct GuideProc * proc_ = proc;
    s8 flag = 0;

    switch (GetAchievementAction(proc))
    {
        case GUIDE_ACTION_A_PRESS:
            PlaySoundEffect(SONG_SE_SYS_WINDOW_SELECT1);

            gAchMenuSt->state++;

            switch (gAchMenuSt->state)
            {
                case GUIDE_STATE_1:
                {
                    achievement_80CEC68(0x2000);
                    PutAchievementBottomBarText();
                    BG_EnableSyncByMask(BG2_SYNC_BIT);

                    break;
                }

                case GUIDE_STATE_2:
                {
                    if (gAchMenuSt->entriesInCat)
                    {
                        if (GetCategoryIdx() == 0)
                        {
                            gAchMenuSt->state--;
                            HandleReward((void *)proc, gAchMenuSt->detailsID);

                            // case for granting rewards
                            return;
                        }
                        gAchMenuSt->detailLinesScrolled = 0;
                        // SetAchievementFlag(gAchievementsTable[gAchMenuSt->detailsEntry[gAchMenuSt->detailsID]].flag);
                        MoveAchievementDetailText(gAchMenuSt->detailsEntry[gAchMenuSt->detailsID], GUIDE_DETAILS_STAY);
                        LockMenuScrollBar();

                        return;
                    }
                    else
                    {
                        gAchMenuSt->state--;
                        PlaySoundEffect(SONG_SE_SYS_WINDOW_CANSEL1);
                    }
                }

                default:
                    return;
            }

            break;

        case GUIDE_ACTION_ADVANCE_TEXT:
            MoveAchievementDetailText(gAchMenuSt->detailsEntry[gAchMenuSt->detailsID], GUIDE_DETAILS_ADVANCE);
            break;

        case GUIDE_ACTION_REVERSE_TEXT:
            MoveAchievementDetailText(gAchMenuSt->detailsEntry[gAchMenuSt->detailsID], GUIDE_DETAILS_REVERSE);
            break;

        case GUIDE_ACTION_CANCEL:
            PlaySoundEffect(SONG_SE_SYS_WINDOW_CANSEL1);

            if (gAchMenuSt->state != GUIDE_STATE_0)
            {
                gAchMenuSt->state--;

                switch (gAchMenuSt->state)
                {
                    case GUIDE_STATE_0:
                        PutAchievementBottomBarText();
                        achievement_80CEC68(0x1000);
                        BG_EnableSyncByMask(BG2_SYNC_BIT);
                        break;

                    case GUIDE_STATE_1:
                        Proc_StartBlocking(gProcScr_AchievementEntryListRedraw_Initial, proc_);
                        achievement_8097668();
                        return;

                    default:
                        return;
                }
            }
            else
            {
                Proc_Break(proc_);
                return;
            }

            break;

        case GUIDE_ACTION_SORT:
            PlaySoundEffect(SONG_SE_SYS_WINDOW_SELECT1);

            // gAchMenuSt->sortMode = (gAchMenuSt->sortMode + 1) & 1;
            AdvanceDisplayType();

            // gAchMenuSt->categoryIdx = 0;
            // gAchMenuSt->cat_offset = 0;
            // gAchMenuSt->detailsID = 0; // adjusted other things to handle these as non-zero
            // gAchMenuSt->details_offset = 0;

            Proc_StartBlocking(gProcScr_AchievementCategoryRedraw, proc_);

            break;

        case GUIDE_ACTION_1:
            switch (gAchMenuSt->state)
            {
                case GUIDE_STATE_0:
                    if (gKeyStatusPtr->repeatedKeys & DPAD_UP)
                    {
                        if (gAchMenuSt->categoryIdx != 0)
                        {
                            gAchMenuSt->categoryIdx--;

                            if (((gAchMenuSt->categoryIdx - gAchMenuSt->cat_offset) < 1) &&
                                (gAchMenuSt->cat_offset != 0))
                            {
                                gAchMenuSt->cat_offset--;
                                achievement_80CE750(proc_, gAchMenuSt->categoryIdx - 1);
                            }

                            flag = 1;
                        }

                        if (!flag)
                        {
                            return;
                        }
                    }
                    else
                    {
                        if (gAchMenuSt->categoryIdx <
                            ((gAchMenuSt->sortMode != GUIDE_SORT_MODE_TOPIC ? gAchMenuSt->unk_3c : gAchMenuSt->unk_3d) -
                             1))
                        {
                            gAchMenuSt->categoryIdx++;

                            if ((gAchMenuSt->categoryIdx - gAchMenuSt->cat_offset) > 4)
                            {
                                if (gAchMenuSt->categoryIdx <
                                    ((gAchMenuSt->sortMode != GUIDE_SORT_MODE_TOPIC ? gAchMenuSt->unk_3c
                                                                                    : gAchMenuSt->unk_3d) -
                                     1))
                                {
                                    gAchMenuSt->cat_offset++;
                                    achievement_80CE858(proc_, gAchMenuSt->categoryIdx + 1);
                                }
                            }
                            flag = 1;
                        }

                        if (!flag)
                        {
                            return;
                        }
                    }

                    Proc_Start(gProcScr_AchievementEntryListRedraw_Initial, proc_);
                    gAchMenuSt->detailsID = 0;
                    gAchMenuSt->details_offset = 0;

                    break;

                case GUIDE_STATE_1:
                    if (gKeyStatusPtr->repeatedKeys & DPAD_UP)
                    {
                        if (gAchMenuSt->detailsID != 0)
                        {
                            gAchMenuSt->detailsID--;
                            PutAchievementBottomBarText();

                            if ((gAchMenuSt->detailsID - gAchMenuSt->details_offset < 1) &&
                                (gAchMenuSt->details_offset != 0))
                            {
                                gAchMenuSt->details_offset--;
                                achievement_80CE750(proc_, gAchMenuSt->detailsID - 1);
                            }

                            flag = 1;
                        }
                    }
                    else
                    {
                        if (gAchMenuSt->detailsID < (gAchMenuSt->entriesInCat - 1))
                        {
                            gAchMenuSt->detailsID++;
                            PutAchievementBottomBarText();

                            if ((gAchMenuSt->detailsID - gAchMenuSt->details_offset > 4) &&
                                (gAchMenuSt->detailsID < gAchMenuSt->entriesInCat - 1))
                            {
                                gAchMenuSt->details_offset++;
                                achievement_80CE858(proc_, gAchMenuSt->detailsID + 1);
                            }

                            flag = 1;
                        }
                    }

                    break;

                case GUIDE_STATE_2:
                    if (gKeyStatusPtr->repeatedKeys & DPAD_UP)
                    {
                        if (gAchMenuSt->detailLinesScrolled != 0)
                        {
                            gAchMenuSt->detailLinesScrolled--;
                            proc_ = Proc_StartBlocking(gProcScr_AchievementDetailsRedraw, proc_);
                            proc_->unk_34 = gAchMenuSt->detailLinesScrolled;
                            proc_->unk_38 = 0;
                            flag = 1;
                        }
                    }
                    else
                    {
                        if (gAchMenuSt->detailLinesScrolled < gAchMenuSt->numDetailLines - 4)
                        {
                            gAchMenuSt->detailLinesScrolled++;

                            proc_ = Proc_StartBlocking(gProcScr_AchievementDetailsRedraw, proc_);
                            proc_->unk_34 = gAchMenuSt->detailLinesScrolled + 3;
                            proc_->unk_38 = 1;

                            flag = 1;
                        }
                    }
            }

            if (!flag)
            {
                return;
            }

            PlaySoundEffect(SONG_SE_SYS_CURSOR_UD1);
    }

    return;
}

//! FE8U = 0x080CF448
void Achievement_OnEnd(void)
{
    EndMuralBackground();
    Proc_EndEach(gProcScr_Achievement_DrawSprites);
    EndMenuScrollBar();
    return;
}

// clang-format off

const struct ProcCmd ProcScr_E_Achievements_Map[] =
{
    PROC_NAME("Achievements_Map"),

    PROC_CALL(LockGame),
    PROC_CALL(StartFastFadeToBlack),
    PROC_REPEAT(WaitForFade),

    PROC_CALL(BMapDispSuspend),
    PROC_YIELD,

    PROC_CALL(Achievement_Init),
    PROC_CALL(StartGreenText),

    PROC_CALL(StartFastFadeFromBlack),
    PROC_REPEAT(WaitForFade),
    PROC_GOTO(1), 
    
    PROC_LABEL(2),
    PROC_REPEAT(AchievementsPopupSentTimer), 
    // PROC_CALL(BonusClaim_DrawItemSentPopup),
    // PROC_REPEAT(BonusClaim_Loop_PopupDisplayTimer),
    // PROC_CALL(BonusClaim_ClearItemSentPopup),
    // fallthrough 

    PROC_LABEL(1), 
    PROC_CALL(Achievement_SetBlend),
    PROC_REPEAT(Achievement_MainLoop),

    PROC_CALL(StartFastFadeToBlack),
    PROC_REPEAT(WaitForFade),

    PROC_CALL(EndGreenText),

    PROC_CALL(Achievement_OnEnd),
    PROC_YIELD,

    PROC_CALL(BMapDispResume),
    PROC_CALL(RefreshBMapGraphics),

    PROC_CALL(StartFastFadeFromBlack),
    PROC_REPEAT(WaitForFade),
    PROC_CALL(UnlockGame),

    PROC_END,
};

// unused atm 
const struct ProcCmd ProcScr_E_Achievements_WM[] =
{
    PROC_NAME("Achievements_WM"),

    PROC_CALL(LockGame),

    PROC_CALL(BMapDispSuspend),
    PROC_YIELD,

    PROC_CALL(Achievement_Init),
    PROC_CALL(StartGreenText),

    PROC_CALL(StartFastFadeFromBlack),
    PROC_REPEAT(WaitForFade),

    PROC_CALL(Achievement_SetBlend),
    PROC_REPEAT(Achievement_MainLoop),

    PROC_CALL(StartFastFadeToBlack),
    PROC_REPEAT(WaitForFade),

    PROC_CALL(EndGreenText),

    PROC_CALL(Achievement_OnEnd),
    PROC_YIELD,

    PROC_CALL(BMapDispResume),
    PROC_CALL(RefreshBMapGraphics),
    PROC_CALL(UnlockGame),

    PROC_END,
};

/*
void BmAchievementTextSetAllGreen(void)
{
    const struct AchievementsRomStruct * it;

    for (it = gAchievementsTable; it->category != Category_Terminator_Link; it++)
    {
        SetAchievementFlag(it->flag);
    }
    return;
}
*/

bool BmAchievementTextShowGreenOrNormal(void)
{
    return false; 
    /* 
    const struct AchievementsRomStruct * it;

    for (it = gAchievementsTable; it->category != Category_Terminator_Link; it++)
    {
        if (CheckFlag(it->displayFlag) && !IsAchievementComplete(it->readFlag))
        {
            return FALSE;
        }
    }
    return TRUE;
    */
}

