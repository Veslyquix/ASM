
#include "C_Code.h" // headers
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;

static struct FaceData const * GetMugData(int id);
#define NumberOfReclassOptions 6 // max 6
extern const u8 AssetBonusPerStat[];
extern const u8 FlawLossPerStat[];
struct magClassTable
{
    u8 base;
    u8 growth;
    u8 cap;
    u8 promo;
};
extern struct magClassTable MagClassTable[];
static ProcPtr ReclassMenuSelect(ProcPtr parent);
static ProcPtr StartReclassSelect(ProcPtr parent);

extern const u8 AvatarClasses[];

static int GetReclassOption(int unitID, int classID, int ID)
{
    return AvatarClasses[ID];
}

static int IsStrMagInstalled(void)
{
    return MagClassTable[0].cap;
}

extern int PromoMain_SetupTraineeEvent_(struct ProcPromoMain * proc);
extern bool PromoTraineeEventExists(struct ProcPromoMain * proc);
extern bool sub_80CD330(struct ProcPromoMain * proc);

struct ProcReclassSel
{ // see ProcPromoSel
    PROC_HEADER;
    s8 _u29;
    s8 _u2a;
    s8 _u2b;
    u8 jid[6]; // NumberOfReclassOptions
    u16 sprite[3];
    s16 msg_desc[3]; // previously msg_desc
    u16 _u3e;
    u8 stat;
    u8 main_select;
    u16 pid;
    u16 u44;
    u8 u46;
    u8 u47;
    u16 weapon;
    u8 use_wpn[3]; // unused
    u8 _u4d[3];
    u32 u50; // platform ID?
    ProcPtr menu_proc;
    // s16 msg_desc[6]; // NumberOfReclassOptions
    /* ... more maybe */
};
static void ReclassMenuExec(struct ProcClassChgMenuSel * proc);

static const struct ProcCmd ProcScr_ReclassMenuSel[] = {
    PROC_SLEEP(6),
    PROC_NAME("Reclass Menu Select"),
    PROC_CALL(ReclassMenuExec),
    PROC_REPEAT(nullsub_80CDDD4),
    PROC_YIELD,

    PROC_LABEL(0),
    PROC_GOTO(2),

    PROC_LABEL(1),
    PROC_CALL(nullsub_61),

    PROC_LABEL(2),
    PROC_END,
};

static int AvatarSubConfirm_OnInit(struct MenuProc * proc)
{
    SyncMenuBgs(proc);
    return 0;
}
static void ReclassDrawStatChanges(struct Unit * unit, const struct ClassData * classData);
int AvatarSubConfirm_OnEnd(struct MenuProc * proc)
{
    TileMap_FillRect(TILEMAP_LOCATED(gBG0TilemapBuffer, 8, 4), 0xA, 6, 0);
    TileMap_FillRect(TILEMAP_LOCATED(gBG2TilemapBuffer, 8, 4), 0xA, 6, 0);
    SetTextFont(&gFontClassChg);
    sub_80CDA4C(proc->proc_parent);
    RedrawMenu(proc->proc_parent);
    SyncMenuBgs(proc);

    struct ProcClassChgMenuSel * parent;
    struct ProcReclassSel * gparent;

    proc = proc->proc_parent;
    parent = proc->proc_parent;
    gparent = parent->proc_parent;
    // gparent->stat = 1;
    // gparent->main_select = _proc2->itemNumber;

    struct Unit * unit = GetUnitFromCharId(gparent->pid);
    const struct ClassData * classData =
        GetClassData(GetReclassOption(gparent->pid, unit->pClassData->number, proc->itemCurrent));
    ReclassDrawStatChanges(unit, classData);

    return 0;
}

struct AvatarProc
{
    PROC_HEADER;
    u8 menuID;
    s8 pronoun;
    s8 portraitCursorID;
    s8 portraitChosen;
    s8 portraitID; // AvatarPortraits[portraitID % count];
    s8 hairID;     // (hairID % count) + (portraitID % count)
    s8 skinID;
    s8 hairColID;
    s8 eyeColID;
    s8 boon;
    s8 bane;
};

extern u16 AvatarPortraits[];
extern u8 NumHairstyles[];
int CountAvatarPortraits(void)
{
    u16 * data = AvatarPortraits;
    int c = 0;
    while (*data)
    {
        c++;
        data++;
    }
    return c;
}
int CountNumHairstyles(int fid)
{
    return NumHairstyles[fid];
}
int CountMaxHairstyles(void)
{
    u8 * data = NumHairstyles;
    int c = 0;
    while (*data)
    {
        if (*data > c)
        {
            c = *data;
        }

        data++;
    }
    return c;
}

extern u16 MugFlags[];
extern u16 HairColFlags[];
extern u16 SkinColFlags[];
extern u16 EyeColFlags[];

int CountNumHairCols(int fid)
{
    u16 * data = HairColFlags;
    int i = 0;
    while (*data)
    {
        i++;
        data++;
    }
    return i + 1;
}
int CountNumSkinTones(int fid)
{
    u16 * data = SkinColFlags;
    int i = 0;
    while (*data)
    {
        i++;
        data++;
    }
    return i + 1;
}
int CountNumEyeCols(int fid)
{
    u16 * data = EyeColFlags;
    int i = 0;
    while (*data)
    {
        i++;
        data++;
    }
    return i + 1;
}

int CountNumPronouns(void)
{
    return 3;
}
#define NumOfStats 7
int CountNumOfStats(void)
{

    int numOfEntries = NumOfStats;
    if (!IsStrMagInstalled())
    {
        numOfEntries--;
    }
    return numOfEntries;
}

extern int AvatarTotalFlags;
extern int StartingFlag_Link;
void UnsetAllAvatarFlags(struct AvatarProc * proc)
{
    for (int i = 0; i < AvatarTotalFlags; ++i)
    {
        ClearFlag(StartingFlag_Link + i);
    }
}

void SetPortraitFlag(struct AvatarProc * proc)
{
    int fid = ((proc->portraitID & 0xFF) % CountAvatarPortraits());

    int hairStyle = (proc->hairID & 0xFF) % CountNumHairstyles(fid);
    SetFlag(MugFlags[fid] + hairStyle);
}
void ClearPortraitFlag(struct AvatarProc * proc)
{
    int fid = ((proc->portraitID & 0xFF) % CountAvatarPortraits());

    int hairStyle = (proc->hairID & 0xFF) % CountNumHairstyles(fid);
    ClearFlag(MugFlags[fid] + hairStyle);
}

void IncrementPortraitFlag(struct AvatarProc * proc)
{
    ClearPortraitFlag(proc);
    proc->portraitID++;
    SetPortraitFlag(proc);
}
void DecrementPortraitFlag(struct AvatarProc * proc)
{
    ClearPortraitFlag(proc);
    proc->portraitID--;
    SetPortraitFlag(proc);
}

void SetHairFlag(struct AvatarProc * proc)
{
    int fid = ((proc->portraitID & 0xFF) % CountAvatarPortraits());
    int hairStyle = (proc->hairID & 0xFF) % CountNumHairstyles(fid);
    SetFlag(MugFlags[fid] + hairStyle);
}
void ClearHairFlag(struct AvatarProc * proc)
{
    int fid = ((proc->portraitID & 0xFF) % CountAvatarPortraits());
    int hairStyle = (proc->hairID & 0xFF) % CountNumHairstyles(fid);
    ClearFlag(MugFlags[fid] + hairStyle);
}

void IncrementHairFlag(struct AvatarProc * proc)
{
    ClearHairFlag(proc);
    proc->hairID++;
    SetHairFlag(proc);
}
void DecrementHairFlag(struct AvatarProc * proc)
{
    ClearHairFlag(proc);
    proc->hairID--;
    SetHairFlag(proc);
}

void SetHairColFlag(struct AvatarProc * proc)
{
    int count = CountAvatarPortraits();
    int fid = ((proc->portraitID & 0xFF) % count);
    int hairCol = (proc->hairColID & 0xFF) % CountNumHairCols(fid);
    SetFlag(HairColFlags[hairCol]);
}
void ClearHairColFlag(struct AvatarProc * proc)
{
    int count = CountAvatarPortraits();
    int fid = ((proc->portraitID & 0xFF) % count);
    int hairCol = (proc->hairColID & 0xFF) % CountNumHairCols(fid);
    ClearFlag(HairColFlags[hairCol]);
}

void IncrementHairColFlag(struct AvatarProc * proc)
{
    ClearHairColFlag(proc);
    proc->hairColID++;
    SetHairColFlag(proc);
}
void DecrementHairColFlag(struct AvatarProc * proc)
{
    ClearHairColFlag(proc);
    proc->hairColID--;
    SetHairColFlag(proc);
}

void SetSkinFlag(struct AvatarProc * proc)
{
    int fid = ((proc->portraitID & 0xFF) % CountAvatarPortraits());
    int skinCol = (proc->skinID & 0xFF) % CountNumSkinTones(fid);
    SetFlag(SkinColFlags[skinCol]);
}
void ClearSkinFlag(struct AvatarProc * proc)
{
    int fid = ((proc->portraitID & 0xFF) % CountAvatarPortraits());
    int skinCol = (proc->skinID & 0xFF) % CountNumSkinTones(fid);
    ClearFlag(SkinColFlags[skinCol]);
}

void IncrementSkinFlag(struct AvatarProc * proc)
{
    ClearSkinFlag(proc);
    proc->skinID++;
    SetSkinFlag(proc);
}
void DecrementSkinFlag(struct AvatarProc * proc)
{
    ClearSkinFlag(proc);
    proc->skinID--;
    SetSkinFlag(proc);
}

void SetEyeFlag(struct AvatarProc * proc)
{
    int count = CountAvatarPortraits();
    int fid = ((proc->portraitID & 0xFF) % count);
    int eyeCol = (proc->eyeColID & 0xFF) % CountNumEyeCols(fid);
    SetFlag(EyeColFlags[eyeCol]);
}
void ClearEyeFlag(struct AvatarProc * proc)
{
    int count = CountAvatarPortraits();
    int fid = ((proc->portraitID & 0xFF) % count);
    int eyeCol = (proc->eyeColID & 0xFF) % CountNumEyeCols(fid);
    ClearFlag(EyeColFlags[eyeCol]);
}

void IncrementEyeFlag(struct AvatarProc * proc)
{
    ClearEyeFlag(proc);
    proc->eyeColID++;
    SetEyeFlag(proc);
}
void DecrementEyeFlag(struct AvatarProc * proc)
{
    ClearEyeFlag(proc);
    proc->eyeColID--;
    SetEyeFlag(proc);
}

extern u16 PronounFlags[];
void UpdatePronounFlags(struct AvatarProc * proc)
{
    int count = CountNumPronouns();
    for (int i = 0; i < count; ++i)
    {
        ClearFlag(PronounFlags[i]);
    }
    int pronoun = (proc->pronoun & 0xFF) % count;
    SetFlag(PronounFlags[pronoun]);
}

#define AvRestart 0
#define AvEnd 99
#define AvName 1
#define AvPronoun 2
#define AvPortrait 3
#define AvBoon 4
#define AvBane 5
#define AvClass 6
#define AvConfirm 90

#define PronounThey 0
#define PronounHim 1
#define PronounHer 2
static void StartBlockingReclassHandler(struct AvatarProc * proc);
void AvNameEnableDisp(struct AvatarProc * proc);
void AvatarNameInput(struct AvatarProc * proc);
u8 AvPortraitIdle(struct MenuProc * menu, struct MenuItemProc * item);
const struct MenuDef gAvatarMenuDef;
const struct MenuDef gAvatarConfirmMenuDef;
const struct MenuDef gBoonMenuDef;
const struct MenuDef gBaneMenuDef;

void AvatarStartFaceAt(int id, struct AvatarProc * proc, int x, int y, int flip);

int GetAdjustedPortraitID(int fid);
const char StatNamesText[][5] = {
    // "HP", "Str", "Skl", "Spd", "Def", "Res", "Lck", "Mag",
    "HP", "Str", "Skl", "Spd", "Def", "Res", "Mag",
};

const char PronounsText[][15] = {
    "they/them",
    "he/him",
    "she/her",
};
extern const u16 AvatarPortraitBoxTSA[];
#define Unchosen (-1)
#define gBG1TilemapBuffer2D ((u16(*)[16])gBG1TilemapBuffer)
extern struct Font * gActiveFont;
void AvatarDrawMainMenu(struct AvatarProc * proc)
{
    SetBlendConfig(1, 0xD, 3, 0);

    SetBlendTargetA(0, 1, 1, 0, 0);

    SetBlendBackdropA(0);

    SetBlendTargetB(0, 0, 1, 1, 1);

    if ((int)gEventSlots[3] >= 0)
    {
        EventShowTextBgDirect(EVSUBCMD_REMOVEPORTRAITS, gEventSlots[3]);
    }

    int fid = 0; // default
    struct Font * font = gActiveFont;
    // SetTextFont(&gHelpBox.font); // use our own chr_counter
    SetTextFont(&gHelpBoxSt.font); // use our own chr_counter
    // InitSystemTextFont();
    InitTextFont(&gHelpBoxSt.font, (void *)(VRAM + 0x3000), 0x180, 0);

    if (proc->portraitChosen)
    {
        fid = AvatarPortraits[0];
    }

    struct Text * th = gStatScreen.text;
    int c = 0;
    for (int i = 0; i < 20; ++i)
    {
        InitText(&th[i], 7);
    }
#define AssetYCoord 8
#define AssetFlawXCoord 9 // 5

    // else
    // {
    // PutDrawText(&th[c], TILEMAP_LOCATED(gBG0TilemapBuffer, AssetFlawXCoord + 1, AssetYCoord), 0, 0, 5, "None");
    // c++;
    // }

    PutDrawText(&th[c], TILEMAP_LOCATED(gBG0TilemapBuffer, 20, 11), 0, 0, 7, GetTacticianName());
    c++;
    if (proc->pronoun != Unchosen)
    {
        PutDrawText(&th[c], TILEMAP_LOCATED(gBG0TilemapBuffer, 20, 13), 0, 0, 7, PronounsText[proc->pronoun % 3]);
        c++;
    }

    AvatarStartFaceAt(fid, proc, 184, 8, 0);

    EfxTmCpyBG((void *)&AvatarPortraitBoxTSA, TILEMAP_LOCATED(gBG2TilemapBuffer, 17, 0), 13, 16, -1, -1);

    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT);

    SetTextFont(font);
}
int GetAssetFlawAmount(int id);
#define Spacing 2
int AssetDraw(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    struct AvatarProc * proc = menu->proc_parent;
    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }

    Text_DrawString(&menuItem->text, GetStringFromIndex(menuItem->def->nameMsgId));
    if (proc->boon >= 0)
    {
        int amount = GetAssetFlawAmount(proc->boon);
        if (amount >= 0)
        {
            Text_InsertDrawString(
                &menuItem->text, Text_GetCursor(&menuItem->text) + Spacing, TEXT_COLOR_SYSTEM_GREEN, "+");
            Text_InsertDrawNumberOrBlank(
                &menuItem->text, Text_GetCursor(&menuItem->text) + Spacing, TEXT_COLOR_SYSTEM_GREEN,
                GetAssetFlawAmount(proc->boon));
        }
        Text_InsertDrawString(
            &menuItem->text, Text_GetCursor(&menuItem->text) + Spacing + 16, TEXT_COLOR_SYSTEM_GREEN,
            StatNamesText[proc->boon]);
    }
    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));

    return 0;
}

int FlawDraw(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    struct AvatarProc * proc = menu->proc_parent;

    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }

    Text_DrawString(&menuItem->text, GetStringFromIndex(menuItem->def->nameMsgId));
    if (proc->bane >= 0)
    {
        int amount = GetAssetFlawAmount(proc->bane);
        if (amount < 0)
        {
            Text_InsertDrawString(
                &menuItem->text, Text_GetCursor(&menuItem->text) + Spacing + 3, TEXT_COLOR_SYSTEM_GOLD, " -");

            Text_InsertDrawNumberOrBlank(
                &menuItem->text, Text_GetCursor(&menuItem->text) + Spacing, TEXT_COLOR_SYSTEM_GOLD, abs(amount));
        }
        Text_InsertDrawString(
            &menuItem->text, Text_GetCursor(&menuItem->text) + Spacing + 17, TEXT_COLOR_SYSTEM_GOLD,
            StatNamesText[proc->bane]);
    }

    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));

    return 0;
}

void AvatarHandlerRestart(struct AvatarProc * proc)
{
    LoadUiFrameGraphics();
    LoadObjUIGfx();
    ApplyUnitSpritePalettes();
    BMapDispSuspend();
    EndAllMus();
    if ((int)gEventSlots[3] < 0)
    {
        StartMu(gActiveUnit);
    }
    ResetTextFont();
    ResetText();
    SetTextFontGlyphs(0);
    struct MenuProc * menu = StartMenu(&gAvatarMenuDef, (ProcPtr)proc);
    menu->itemCurrent = proc->menuID;
    AvatarDrawMainMenu(proc);
}

void AvatarHandlerInit(struct AvatarProc * proc)
{
    UnsetAllAvatarFlags(proc);
    proc->pronoun = Unchosen;
    proc->bane = Unchosen;
    proc->boon = Unchosen;
    proc->portraitChosen = false;
    proc->menuID = 0;
    proc->portraitID = 0;
    proc->portraitCursorID = 0;
    proc->hairID = 0;
    proc->skinID = 0;
    proc->hairColID = 0;
    proc->eyeColID = 0;
}
void AvStartConfirmMenu(struct ProcPromoHandler * proc)
{
    StartMenu(&gAvatarConfirmMenuDef, (ProcPtr)proc);
}
static void ForceBMapDispResume(void)
{
    while (gBmSt.gameGfxSemaphore)
    {
        BMapDispResume();
    }
}
const struct ProcCmd ProcScr_AvatarHandler[] = {
    PROC_SLEEP(3),
    PROC_NAME("Avatar Handler"),
    PROC_CALL(AvatarHandlerInit),
    PROC_LABEL(AvRestart),
    PROC_CALL(AvatarHandlerRestart),
    PROC_SLEEP(3),

    PROC_LABEL(AvName),
    PROC_CALL(StartFastFadeToBlack),
    PROC_REPEAT(WaitForFade),
    PROC_CALL(AvatarNameInput),
    PROC_SLEEP(3),
    PROC_CALL(StartFastFadeToBlack),
    PROC_REPEAT(WaitForFade),
    PROC_SLEEP(3),
    PROC_CALL(AvNameEnableDisp),
    PROC_CALL(StartFastFadeFromBlack),
    PROC_REPEAT(WaitForFade),
    PROC_GOTO(AvRestart),

    PROC_LABEL(AvPronoun),
    PROC_SLEEP(3),
    PROC_GOTO(AvRestart),

    PROC_LABEL(AvPortrait),
    // PROC_CALL_2(AvPortraitSelection),
    // PROC_REPEAT(AvPortraitIdle),
    PROC_SLEEP(3),
    PROC_GOTO(AvRestart),

    PROC_LABEL(AvBoon),
    PROC_SLEEP(3),
    PROC_GOTO(AvRestart),

    PROC_LABEL(AvBane),
    PROC_SLEEP(3),
    PROC_GOTO(AvRestart),

    PROC_LABEL(AvClass),
    PROC_CALL(StartBlockingReclassHandler),
    PROC_SLEEP(3),
    // PROC_GOTO(AvRestart),
    PROC_GOTO(AvEnd),

    PROC_LABEL(AvConfirm),
    PROC_CALL(AvStartConfirmMenu),
    PROC_SLEEP(3),

    PROC_LABEL(AvEnd),
    PROC_CALL(ForceBMapDispResume),
    PROC_END,
};

void CallUpdatePronounFlags(void)
{
    struct AvatarProc * proc = Proc_Find(ProcScr_AvatarHandler);
    if (proc)
    {
        UpdatePronounFlags(proc);
    }
}

u8 AvatarConfirm_OnYesPress(struct Proc * menu)
{
    Proc_Goto(menu->proc_parent, AvEnd);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
};
u8 AvatarConfirm_OnBPress(struct Proc * menu)
{
    Proc_Goto(menu->proc_parent, AvRestart);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B | MENU_ACT_CLEAR;
};

const struct MenuItemDef YesNoSelectionMenuItems[] = {
    { "はい", 0x843, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarConfirm_OnYesPress, 0, 0, 0 }, // Yes >
    { "いいえ", 0x844, 0, 0, 0x33, MenuAlwaysEnabled, 0, (void *)AvatarConfirm_OnBPress, 0, 0, 0 }, // No
    MenuItemsEnd
};
const struct MenuDef gAvatarConfirmMenuDef = {
    { 24, 14, 5, 0 }, 0, YesNoSelectionMenuItems, 0, 0, 0, (void *)AvatarConfirm_OnBPress, 0, 0
};

u8 AvatarPronoun_OnThey(struct Proc * menu)
{
    struct AvatarProc * proc = menu->proc_parent;
    proc->pronoun = PronounThey;
    Proc_Goto(menu->proc_parent, AvRestart);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B | MENU_ACT_CLEAR;
};
u8 AvatarPronoun_OnHim(struct Proc * menu)
{
    struct AvatarProc * proc = menu->proc_parent;
    proc->pronoun = PronounHim;
    Proc_Goto(menu->proc_parent, AvRestart);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B | MENU_ACT_CLEAR;
};
u8 AvatarPronoun_OnHer(struct Proc * menu)
{
    struct AvatarProc * proc = menu->proc_parent;
    proc->pronoun = PronounHer;
    Proc_Goto(menu->proc_parent, AvRestart);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B | MENU_ACT_CLEAR;
};

u8 AvatarPortrait_OnSelection(struct Proc * menu)
{
    struct AvatarProc * proc = menu->proc_parent;
    proc->portraitChosen = true;
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B | MENU_ACT_CLEAR;
};

const struct MenuItemDef PronounSelectionMenuItems[] = {
    { "はい", 0x31, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPronoun_OnThey, 0, 0, 0 }, // They/Them
    { "はい", 0x32, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPronoun_OnHim, 0, 0, 0 },  // he/him
    { "はい", 0x33, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPronoun_OnHer, 0, 0, 0 },  // she/her
    MenuItemsEnd
};
const struct MenuDef gAvatarPronounMenuDef = {
    { 1, 1, 8, 0 }, 0, PronounSelectionMenuItems, 0, 0, 0, (void *)AvatarConfirm_OnBPress, 0, 0
};

const struct MenuItemDef PortraitSelectionMenuItems[] = {
    { "はい", 0x2C, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPortrait_OnSelection, (void *)AvPortraitIdle, 0,
      0 }, // Portrait
    { "はい", 0x2E, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPortrait_OnSelection, (void *)AvPortraitIdle, 0,
      0 }, // Hair Style
    { "はい", 0x2F, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPortrait_OnSelection, (void *)AvPortraitIdle, 0,
      0 }, // Hair Colour
    { "はい", 0x29, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPortrait_OnSelection, (void *)AvPortraitIdle, 0,
      0 }, // Eye Colour
    { "はい", 0x30, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPortrait_OnSelection, (void *)AvPortraitIdle, 0,
      0 }, // Skin Tone
    MenuItemsEnd
};
const struct MenuDef gAvatarPortraitMenuDef = {
    { 14, 1, 8, 0 }, 0, PortraitSelectionMenuItems, 0, 0, 0, (void *)AvatarConfirm_OnBPress, 0, 0
};

void AvatarNameInput(struct AvatarProc * proc)
{
    EndAllMus();
    // https://github.com/FireEmblemUniverse/fireemblem8u/blob/9a135d8ee8e7196523ab8190fa1471e67b143a00/src/eventscr.c#L866
    // StartTacticianNameSelect is usually preceded by REMOVEPORTRAITS, linked above (as part of TextStart)
    StartTacticianNameSelect(proc);
}

void AvNameEnableDisp(struct AvatarProc * proc)
{
    SetupBackgrounds(NULL);
    if ((int)gEventSlots[3] < 0)
    {
        RefreshBMapGraphics();
        RefreshEntityBmMaps();
        RenderBmMap();
        RefreshUnitSprites();
    }

    // BMapDispResume(); // so units aren't hidden
    SetDispEnable(TRUE, TRUE, TRUE, TRUE, TRUE);
}

int IsImgValid(const void * data, const u8 * imgData)
{
    if (!data || !imgData)
    {
        return false;
    }
    if ((u32)data < 0x8000000 || (u32)data > 0x9FFFFFF || (u32)imgData < 0x8000000 || (u32)imgData > 0x9FFFFFF)
    {
        return false;
    }
    return true;
}

int CanDisplayPortrait(int id)
{
    const struct FaceData * data = GetMugData(id);
    return IsImgValid(data, data->img);
    // hack portraits might be uncompressed, so don't worry about checking for lz77 compression
    // const struct FaceData * data = GetMugData(id);
    // return IsImgValidLZ77(data, (const u8 *)data->img);
}
void PortraitAdjustPal(struct AvatarProc * proc, u16 * buffer);
extern struct TalkState sTalkStateCore;
static struct TalkState * const pTalkState = &sTalkStateCore;

extern struct FaceVramEntry sFaceConfig[4];
void StartFaceFadeInCustom(struct FaceProc * proc, struct AvatarProc * avatarProc)
{
    const struct FaceData * info = GetPortraitData(proc->faceId);

    SetBlackPal(sFaceConfig[proc->faceSlot].paletteId + 0x10);
    // PortraitAdjustPal(avatarProc, (void *)gEkrKakudaiSomeBufLeft);
    StartPalFade(info->pal, sFaceConfig[proc->faceSlot].paletteId + 0x10, 12, proc);
    // StartPalFade((void *)gEkrKakudaiSomeBufLeft, sFaceConfig[proc->faceSlot].paletteId + 0x10, 12, proc);

    return;
}

void AvatarStartFaceAt(int id, struct AvatarProc * proc, int x, int y, int flip)
{
    EndFaceById(0);
    if (id < 0)
    {
        id = 0;
    }
    if (CanDisplayPortrait(id))
    {
        pTalkState->faces[pTalkState->activeFaceSlot] =
            StartFace(0, id, x, y, FACE_DISP_KIND(FACE_96x80) | flip); // blink
        // SetFaceBlinkControlById(0, 0);
        // StartFaceFadeInCustom(pTalkState->faces[pTalkState->activeFaceSlot], proc);
        StartFaceFadeIn(pTalkState->faces[pTalkState->activeFaceSlot]);

        // SetTalkFaceLayer(pTalkState->activeFaceSlot, CheckTalkFlag(TALK_FLAG_4));
        SetTalkFaceLayer(pTalkState->activeFaceSlot, 1);
        // StartFace(0, id, 48, 16, 0);
    }
}

void AvatarStartFace(int id, struct AvatarProc * proc)
{
    int x = 48;
    int y = 80;
    AvatarStartFaceAt(id, proc, x, y, FACE_DISP_FLIPPED);

} // 859133c T sTalkState

void PortraitAdjustPal(struct AvatarProc * proc, u16 * buffer)
{
    int fid = GetAdjustedPortraitID(AvatarPortraits[0]);
    const struct FaceData * data = GetPortraitData(fid);
    const u16 * palOriginal = data->pal;
    for (int i = 0; i < 16; ++i)
    {
        buffer[i] = palOriginal[i];
    }
    return;
}

void AvPortraitAdjustPal(struct AvatarProc * proc)
{
    // AvatarStartFace(0x100, proc);
    // return;
    // u16 pal[16];
    PortraitAdjustPal(proc, (void *)gEkrKakudaiSomeBufLeft);

    ApplyPalette((void *)gEkrKakudaiSomeBufLeft, 0x16);
}

#define NumOfPortraitMenuOptions 5
enum
{
    Portrait_Style,
    Portrait_Hairstyle,
    Portrait_Haircolour,
    Portrait_Eyecolour,
    Portrait_Skintone,
};
u8 AvPortraitIdle(struct MenuProc * menu, struct MenuItemProc * item)
{
    struct AvatarProc * proc = menu->proc_parent;
    // portrait style, hair style, hair colour, skin tone
    u16 keys = gKeyStatusPtr->repeatedKeys;

    proc->portraitCursorID = menu->itemCurrent;

    if (keys & DPAD_LEFT)
    {
        switch (proc->portraitCursorID % NumOfPortraitMenuOptions)
        {

            case Portrait_Style:
            {
                DecrementPortraitFlag(proc);
                AvatarStartFace(AvatarPortraits[0], proc);
                break;
            }
            case Portrait_Hairstyle:
            {
                DecrementHairFlag(proc);
                AvatarStartFace(AvatarPortraits[0], proc);
                break;
            }
            case Portrait_Haircolour:
            {
                DecrementHairColFlag(proc);
                AvPortraitAdjustPal(proc);
                break;
            }
            case Portrait_Eyecolour:
            {
                DecrementEyeFlag(proc);
                AvPortraitAdjustPal(proc);
                break;
            }
            case Portrait_Skintone:
            {
                DecrementSkinFlag(proc);
                AvPortraitAdjustPal(proc);
                break;
            }
        }
    }

    if (keys & DPAD_RIGHT)
    {
        switch (proc->portraitCursorID % NumOfPortraitMenuOptions)
        {

            case Portrait_Style:
            {
                IncrementPortraitFlag(proc);
                AvatarStartFace(AvatarPortraits[0], proc);
                break;
            }
            case Portrait_Hairstyle:
            {
                IncrementHairFlag(proc);
                AvatarStartFace(AvatarPortraits[0], proc);
                break;
            }
            case Portrait_Haircolour:
            {
                IncrementHairColFlag(proc);
                AvPortraitAdjustPal(proc);
                break;
            }
            case Portrait_Eyecolour:
            {
                IncrementEyeFlag(proc);
                AvPortraitAdjustPal(proc);
                break;
            }
            case Portrait_Skintone:
            {
                IncrementSkinFlag(proc);
                AvPortraitAdjustPal(proc);
                break;
            }
        }
    }

    // randomly talk or blink
    int time = GetGameClock();
    switch ((time & 0x1FF) >> 7)
    {
        case 0:
        case 2:
        {
            SetTalkFaceMouthMove(0);
            break;
        }
        case 1:
        {
            SetTalkFaceNoMouthMove(0);
            SetTalkFaceDisp(0, 1); // smile
            break;
        }
        case 3:
        {
            SetTalkFaceNoMouthMove(0);
            SetTalkFaceDisp(0, 0); // neutral
            break;
        }
    }
    return 0;
}

u8 AvatarBPress(struct MenuProc * menu)
{
    Proc_Goto(menu->proc_parent, AvConfirm);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B | MENU_ACT_CLEAR;
};
void UpdateMenuID(struct MenuProc * menu)
{
    BG_Fill(gBG2TilemapBuffer, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT);
    EndFaceById(0);
    struct AvatarProc * proc = menu->proc_parent;
    proc->menuID = menu->itemCurrent;
}
u8 AvatarReturnToMenu(struct MenuProc * menu)
{
    // UpdateMenuID(menu); // submenu will be on a different ID
    Proc_Goto(menu->proc_parent, AvRestart);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B | MENU_ACT_CLEAR;
};

u8 AvatarNameSelect(struct MenuProc * menu)
{
    UpdateMenuID(menu);
    Proc_Goto(menu->proc_parent, AvName);

    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
};

u8 AvatarPronounSelect(struct MenuProc * menu)
{
    UpdateMenuID(menu);
    Proc_Goto(menu->proc_parent, AvPronoun);
    StartMenu(&gAvatarPronounMenuDef, (ProcPtr)menu->proc_parent);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
};
u8 AvatarPortraitSelect(struct MenuProc * menu)
{
    UpdateMenuID(menu);
    StartMenu(&gAvatarPortraitMenuDef, (ProcPtr)menu->proc_parent);
    AvatarStartFace(AvatarPortraits[0], menu->proc_parent);
    Proc_Goto(menu->proc_parent, AvPortrait);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
};

u8 AvatarBoonSelect(struct MenuProc * menu)
{
    UpdateMenuID(menu);
    Proc_Goto(menu->proc_parent, AvBoon);
    StartMenu(&gBoonMenuDef, (ProcPtr)menu->proc_parent);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
};

u8 AvatarBaneSelect(struct MenuProc * menu)
{
    UpdateMenuID(menu);
    Proc_Goto(menu->proc_parent, AvBane);
    StartMenu(&gBaneMenuDef, (ProcPtr)menu->proc_parent);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
};
int CanSelectClass(void);
u8 AvatarClassSelect(struct MenuProc * menu)
{
    if (CanSelectClass())
    {
        UpdateMenuID(menu);
        Proc_Goto(menu->proc_parent, AvClass);
        return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
    }
    return MENU_ACT_SND6B;
};

int BoonCommandDraw(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    struct AvatarProc * proc = menu->proc_parent;
    if (menuItem->itemNumber == proc->boon)
    {
        Text_SetColor(&menuItem->text, TEXT_COLOR_SYSTEM_GREEN);
    }

    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }

    Text_DrawString(&menuItem->text, GetStringFromIndex(menuItem->def->nameMsgId));

    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));

    return 0;
}
int BaneCommandDraw(struct MenuProc * menu, struct MenuItemProc * menuItem)
{
    struct AvatarProc * proc = menu->proc_parent;
    if (menuItem->itemNumber == proc->bane)
    {
        Text_SetColor(&menuItem->text, TEXT_COLOR_SYSTEM_GOLD);
    }

    if (menuItem->availability == MENU_DISABLED)
    {
        Text_SetColor(&menuItem->text, 1);
    }

    Text_DrawString(&menuItem->text, GetStringFromIndex(menuItem->def->nameMsgId));

    PutText(&menuItem->text, BG_GetMapBuffer(menu->frontBg) + TILEMAP_INDEX(menuItem->xTile, menuItem->yTile));

    return 0;
}

u8 BoonSelect(struct MenuProc * menu)
{
    struct AvatarProc * proc = menu->proc_parent;
    proc->boon = menu->itemCurrent;
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B | MENU_ACT_CLEAR;
};
u8 DisplayIfStrMag()
{

    if (IsStrMagInstalled())
    {
        return MENU_ENABLED;
    }
    return MENU_NOTSHOWN;
}
const struct MenuItemDef gAvatarBoonItems[] = {
    { "はい", 0x4E9, 0, 0, 0x32, MenuAlwaysEnabled, BoonCommandDraw, (void *)BoonSelect, 0, 0, 0 }, // Hp
    { "はい", 0x4FE, 0, 0, 0x32, MenuAlwaysEnabled, BoonCommandDraw, (void *)BoonSelect, 0, 0, 0 }, // Str

    { "はい", 0x4EC, 0, 0, 0x32, MenuAlwaysEnabled, BoonCommandDraw, (void *)BoonSelect, 0, 0, 0 }, // Skl
    { "はい", 0x4ED, 0, 0, 0x32, MenuAlwaysEnabled, BoonCommandDraw, (void *)BoonSelect, 0, 0, 0 }, // Spd

    { "はい", 0x4EF, 0, 0, 0x32, MenuAlwaysEnabled, BoonCommandDraw, (void *)BoonSelect, 0, 0, 0 }, // Def
    { "はい", 0x4F0, 0, 0, 0x32, MenuAlwaysEnabled, BoonCommandDraw, (void *)BoonSelect, 0, 0, 0 }, // Res
    // { "はい", 0x4EE, 0, 0, 0x32, MenuAlwaysEnabled, BoonCommandDraw, (void *)BoonSelect, 0, 0, 0 }, // Luck
    { "はい", 0x4FF, 0, 0, 0x32, (void *)DisplayIfStrMag, BoonCommandDraw, (void *)BoonSelect, 0, 0, 0 }, // Mag
    MenuItemsEnd
};

const struct MenuDef gBoonMenuDef = { { 1, 1, 8, 0 }, 0, gAvatarBoonItems, 0, 0, 0, (void *)AvatarReturnToMenu, 0, 0 };
u8 BaneSelect(struct MenuProc * menu)
{
    struct AvatarProc * proc = menu->proc_parent;
    proc->bane = menu->itemCurrent;
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B | MENU_ACT_CLEAR;
};

const struct MenuItemDef gAvatarBaneItems[] = {
    { "はい", 0x4E9, 0, 0, 0x32, MenuAlwaysEnabled, BaneCommandDraw, (void *)BaneSelect, 0, 0, 0 }, // Hp
    { "はい", 0x4FE, 0, 0, 0x32, MenuAlwaysEnabled, BaneCommandDraw, (void *)BaneSelect, 0, 0, 0 }, // Str

    { "はい", 0x4EC, 0, 0, 0x32, MenuAlwaysEnabled, BaneCommandDraw, (void *)BaneSelect, 0, 0, 0 }, // Skl
    { "はい", 0x4ED, 0, 0, 0x32, MenuAlwaysEnabled, BaneCommandDraw, (void *)BaneSelect, 0, 0, 0 }, // Spd

    { "はい", 0x4EF, 0, 0, 0x32, MenuAlwaysEnabled, BaneCommandDraw, (void *)BaneSelect, 0, 0, 0 }, // Def
    { "はい", 0x4F0, 0, 0, 0x32, MenuAlwaysEnabled, BaneCommandDraw, (void *)BaneSelect, 0, 0, 0 }, // Res
    // { "はい", 0x4EE, 0, 0, 0x32, MenuAlwaysEnabled, BaneCommandDraw, (void *)BaneSelect, 0, 0, 0 }, // Luck
    { "はい", 0x4FF, 0, 0, 0x32, (void *)DisplayIfStrMag, BaneCommandDraw, (void *)BaneSelect, 0, 0, 0 }, // Mag
    MenuItemsEnd
};

const struct MenuDef gBaneMenuDef = { { 1, 1, 8, 0 }, 0, gAvatarBaneItems, 0, 0, 0, (void *)AvatarReturnToMenu, 0, 0 };

int CanSelectClass(void)
{
    struct AvatarProc * proc = Proc_Find(ProcScr_AvatarHandler);
    if (!*GetTacticianName() || !proc->portraitChosen || proc->pronoun == Unchosen || proc->bane == Unchosen ||
        proc->boon == Unchosen)
    {
        return false;
    }
    return true;
}
int AvatarClassUsability(const struct MenuItemDef * def, int number)
{

    if (CanSelectClass())
    {
        return MENU_ENABLED;
    }
    return MENU_DISABLED;
}
extern struct Font gDefaultFont;
void ResetTextCursorForMenu(struct MenuProc * menu) // sub_80CDA4C
{
    int i = 0;
    for (; i < menu->itemCount; i++)
    {
        ClearText(&menu->menuItems[i]->text);
        Text_SetCursor(&menu->menuItems[i]->text, 0);
    }
    if (CanSelectClass())
    {
        menu->menuItems[5]->availability = MENU_ENABLED; /// ahhhhhh
    }
}

void RedrawAvatarMainMenu(struct AvatarProc * proc, struct MenuProc * menu)
{
    ResetTextCursorForMenu(menu);
    RedrawMenu(menu);
    SyncMenuBgs(menu);
}

// sizeof(StatNamesText);

u8 AssetOnIdle(struct MenuProc * menu, struct MenuItemProc * item)
{
    struct AvatarProc * proc = menu->proc_parent;
    int id = proc->boon;
    int numOfEntries = CountNumOfStats();
    if (!IsStrMagInstalled())
    {
        numOfEntries--;
    }
    u16 keys = gKeyStatusPtr->repeatedKeys;
    if (keys & DPAD_LEFT)
    {
        proc->boon--;
        if (proc->boon < 0)
        {
            proc->boon = numOfEntries - 1;
        }
    }

    if (keys & DPAD_RIGHT)
    {
        proc->boon++;
        if (proc->boon >= numOfEntries)
        {
            proc->boon = 0;
        }
    }

    if (id != proc->boon)
    {
        RedrawAvatarMainMenu(proc, menu);
    }
    return 0;
}
u8 FlawOnIdle(struct MenuProc * menu, struct MenuItemProc * item)
{
    struct AvatarProc * proc = menu->proc_parent;
    u16 keys = gKeyStatusPtr->repeatedKeys;
    int id = proc->bane;
    int numOfEntries = CountNumOfStats();
    if (keys & DPAD_LEFT)
    {
        proc->bane--;
        if (proc->bane < 0)
        {
            proc->bane = numOfEntries - 1;
        }
    }

    if (keys & DPAD_RIGHT)
    {
        proc->bane++;
        if (proc->bane >= numOfEntries)
        {
            proc->bane = 0;
        }
    }

    if (id != proc->bane)
    {
        RedrawAvatarMainMenu(proc, menu);
    }

    return 0;
}
const struct MenuItemDef gAvatarMenuItems[] = {
    { "はい", 0x4E5, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarNameSelect, 0, 0, 0 },    // Name
    { "はい", 0x2B, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPronounSelect, 0, 0, 0 },  // Pronouns
    { "はい", 0x2C, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarPortraitSelect, 0, 0, 0 }, // Portrait
    { "はい", 0x2D, 0, 0, 0x32, MenuAlwaysEnabled, AssetDraw, (void *)AvatarBoonSelect, (void *)AssetOnIdle, 0,
      0 }, // Boon
    { "はい", 0x34, 0, 0, 0x32, MenuAlwaysEnabled, FlawDraw, (void *)AvatarBaneSelect, (void *)FlawOnIdle, 0,
      0 },                                                                                              // Bane
    { "はい", 0x4E6, 0, 0, 0x32, (void *)AvatarClassUsability, 0, (void *)AvatarClassSelect, 0, 0, 0 }, // Class
    // { "はい", 0x848, 0, 0, 0x32, MenuAlwaysEnabled, 0, (void *)AvatarBPress, 0, 0, 0 },            // Exit
    MenuItemsEnd
};
// const struct MenuDef gAvatarMenuDef = { { 1, 1, 10, 0 }, 0, gAvatarMenuItems, 0, 0, 0, (void *)AvatarBPress, 0, 0 };
const struct MenuDef gAvatarMenuDef = { { 1, 1, 10, 0 }, 0, gAvatarMenuItems, 0, 0, 0, 0, 0, 0 };

static bool StartAndWaitReclassSelect(struct ProcPromoMain * proc);
static void ReclassHandlerIdle(struct ProcPromoHandler * proc);
static const struct ProcCmd ProcScr_ReclassHandler[] = {
    PROC_SLEEP(3), PROC_NAME("Reclass Handler"),
    PROC_LABEL(0), PROC_CALL(PromoHandler_SetInitStat),
    PROC_LABEL(1), PROC_REPEAT(ReclassHandlerIdle),

    PROC_LABEL(7), PROC_END,
};

static void StartBlockingReclassHandler(struct AvatarProc * proc)
{
    EndAllMus();
    struct ProcPromoHandler * new_proc = Proc_StartBlocking(ProcScr_ReclassHandler, proc);
    new_proc->bmtype = PROMO_HANDLER_TYPE_PREP;
    new_proc->u32 = 0;
    struct Unit * unit = GetUnit(gActionData.subjectIndex);
    new_proc->pid = unit->pCharacterData->number;
    new_proc->unit = GetUnit(gActionData.subjectIndex);
    new_proc->item_slot = gActionData.itemSlotIndex;
}

extern void sub_805AE14(void *);
static void ClassChgOnCancel(struct ProcPromoSel * proc)
{
    struct ProcPromoMain * parent;
    struct ProcPromoHandler * gparent;
    struct ProcPrepItemUse * ggparent;
    parent = proc->proc_parent;
    gparent = parent->proc_parent;
    ggparent = gparent->proc_parent;
    if (gparent->bmtype == PROMO_HANDLER_TYPE_PREP) // this is actually battle map
    {
        Proc_End(proc);
        Proc_End(parent);
        Proc_End(gparent);
        sub_805AA28(&gUnknown_030053A0);
        sub_805AE14(&gUnknown_0201FADC);
        EndEfxAnimeDrvProc();
        gActionData.unitActionType = 0;
        Proc_Goto(ggparent, PROC_LABEL_PREPITEMUSE_CONFIRM);
        BMapDispResume();
        RefreshBMapGraphics();
        RefreshEntityBmMaps();
        RenderBmMap();
        RefreshUnitSprites();
        EndAllMus();
        // StartMu(gActiveUnit);
    }
}

// stuff below here is pretty much all copied from my Reclass hack

static void SetLevelFunc(ProcPtr proc)
{
    if (!Proc_Find(ProcScr_ReclassHandler))
    {
        Proc_Break(proc);
    }
    gEkrLvupPostLevel = gActiveUnit->level;
}

static const struct ProcCmd ProcScr_SetLevel[] = {
    PROC_SLEEP(0),
    PROC_NAME("Reclass Set Level"),
    PROC_REPEAT(SetLevelFunc),
    PROC_END,
};

static void ReclassPostConfirmWaitBanimEnd(struct ProcClassChgPostConfirm * proc)
{
    gEkrLvupPostLevel = gActiveUnit->level;
    int game_lock = proc->game_lock;
    if (game_lock == GetGameLock())
        Proc_Break(proc);
}
static void ReclassChgExecPromotionReal(struct ProcClassChgPostConfirm * proc);
static const struct ProcCmd ProcScr_ReclassChgReal[] = { PROC_NAME("Reclassing Active"),
                                                         PROC_WHILE(MusicProc4Exists),
                                                         PROC_CALL(ReclassChgExecPromotionReal),
                                                         PROC_REPEAT(ReclassPostConfirmWaitBanimEnd),
                                                         PROC_SLEEP(0x8),
                                                         PROC_CALL(sub_80CDE98),
                                                         PROC_SLEEP(0x5),
                                                         PROC_WHILE(MusicProc4Exists),
                                                         PROC_END };

static void ExecUnitReclass(struct Unit * unit, u8 classId, int itemIdx, s8 unk);
static void ReclassChgExecPromotionReal(struct ProcClassChgPostConfirm * proc)
{
    struct ProcPromoMain * parent = proc->proc_parent;
    struct ProcPromoHandler * gparent = parent->proc_parent;

    struct Unit * unit = GetUnitFromCharId(parent->pid);

    if (unit == NULL)
    {
        Proc_End(proc);
        return;
    }

    proc->game_lock = GetGameLock();
    SetWinEnable(0, 0, 0);
    ExecUnitReclass(unit, parent->jid, -1, 0);

    if (gparent->bmtype != PROMO_HANDLER_TYPE_PREP)
        gBattleStats.config = BATTLE_CONFIG_PROMOTION_PREP | BATTLE_CONFIG_PROMOTION;
    else
        gBattleStats.config = BATTLE_CONFIG_PROMOTION;

    BeginBattleAnimations();
}

extern void sub_80CDE98(struct ProcClassChgPostConfirm * proc);
//{
//    struct ProcPromoMain *parent = proc->proc_parent;
//    GetUnitFromCharId(parent->pid);
//}

static void ExecReclassChgReal(struct ProcPromoMain * proc)
{
    int slot;
    struct ProcPromoHandler * parent = proc->proc_parent;
    gUnknown_03005398 = -1;
    EndCgText();

    ResetDialogueScreen();
    APProc_DeleteAll();
    EndMuralBackground_();

    gLCDControlBuffer.bg0cnt.priority = 0;
    gLCDControlBuffer.bg1cnt.priority = 1;
    gLCDControlBuffer.bg2cnt.priority = 2;
    gLCDControlBuffer.bg3cnt.priority = 3;

    SetBlendConfig(3, 0, 0, 0x10);
    SetBlendTargetA(1, 1, 1, 1, 1);

    EndAllProcChildren(proc);

    Proc_StartBlocking(ProcScr_ReclassChgReal, proc);

    if (parent->bmtype != PROMO_HANDLER_TYPE_TRANINEE)
    {
        slot = parent->item_slot;
        if (slot != -1)
            UnitUpdateUsedItem(parent->unit, slot);
    }
}

int GetAssetFlawAmount(int id)
{
    struct AvatarProc * proc = Proc_Find(ProcScr_AvatarHandler);
    int result = 0;
    if (!proc)
    {
        return 0;
    }
    if (proc->boon == id)
    {
        result += AssetBonusPerStat[id];
    }
    if (proc->bane == id)
    {
        result -= FlawLossPerStat[id];
    }
    return result;
}

static int GetStatDiff(int id, struct Unit * unit, const struct ClassData * oldClass, const struct ClassData * newClass)
{
    int result = 0;

    switch (id)
    {
        case 0:
        {
            result = newClass->baseHP - oldClass->baseHP;
            break;
        }
        case 1:
        {
            result = newClass->basePow - oldClass->basePow;
            break;
        }
        case 2:
        {
            result = newClass->baseSkl - oldClass->baseSkl;
            break;
        }
        case 3:
        {
            result = newClass->baseSpd - oldClass->baseSpd;
            break;
        }
        case 4:
        {
            result = newClass->baseDef - oldClass->baseDef;
            break;
        }
        case 5:
        {
            result = newClass->baseRes - oldClass->baseRes;
            break;
        }
        case 6:
        {
            result = newClass->baseCon - oldClass->baseCon;
            break;
        }
        case 7:
        {
            result = newClass->baseMov - oldClass->baseMov;
            break;
        }
        case 8:
        {
            if (!IsStrMagInstalled())
            {
                break;
            }
            result = MagClassTable[newClass->number].base - MagClassTable[oldClass->number].base;
            break;
        }
        default:
    }
    int tmp = 0;
    switch (id)
    {
        case 0:
        {
            tmp = unit->maxHP;
            break;
        }
        case 1:
        {
            tmp = unit->pow;
            break;
        }
        case 2:
        {
            tmp = unit->skl;
            break;
        }
        case 3:
        {
            tmp = unit->spd;
            break;
        }
        case 4:
        {
            tmp = unit->def;
            break;
        }
        case 5:
        {
            tmp = unit->res;
            break;
        }
        case 6:
        {
            tmp = oldClass->baseCon;
            break;
        }
        case 7:
        {
            tmp = oldClass->baseMov;
            break;
        }
        case 8:
        {
            if (!IsStrMagInstalled())
            {
                break;
            }
            tmp = unit->_u3A;
            break;
        }
        default:
    }

    if ((tmp + result) < 0)
    {
        result = 0;
    }
    return result;
}

static int GetNewStat(int id, struct Unit * unit, const struct ClassData * oldClass, const struct ClassData * newClass)
{
    int stat = GetStatDiff(id, unit, oldClass, newClass);
    stat += GetAssetFlawAmount(id);
    int tmp = 0;
    switch (id)
    {
        case 0:
        {
            tmp = unit->maxHP;
            break;
        }
        case 1:
        {
            tmp = unit->pow;
            break;
        }
        case 2:
        {
            tmp = unit->skl;
            break;
        }
        case 3:
        {
            tmp = unit->spd;
            break;
        }
        case 4:
        {
            tmp = unit->def;
            break;
        }
        case 5:
        {
            tmp = unit->res;
            break;
        }
        case 6:
        {
            tmp = oldClass->baseCon;
            break;
        }
        case 7:
        {
            tmp = oldClass->baseMov;
            break;
        }
        case 8:
        {
            if (!IsStrMagInstalled())
            {
                break;
            }
            tmp = unit->_u3A;
            break;
        }
        default:
    }
    stat += tmp;
    if (stat < 0)
    {
        stat = 0;
    }
    if (id == 0 && stat < 1)
    {
        stat = 1; // min 1 hp
    }
    return stat;
}

static void ApplyUnitReclass(struct Unit * unit, u8 classId)
{
    const struct ClassData * newClass = GetClassData(classId);

    int baseClassId = unit->pClassData->number;
    // int promClassId = newClass->number;

    const struct ClassData * oldClass = GetClassData(baseClassId);

    int i;

    int tmp;
    unit->maxHP += GetStatDiff(0, unit, oldClass, newClass) + GetAssetFlawAmount(0);
    unit->pow += GetStatDiff(1, unit, oldClass, newClass) + GetAssetFlawAmount(1);
    unit->skl += GetStatDiff(2, unit, oldClass, newClass) + GetAssetFlawAmount(2);
    unit->spd += GetStatDiff(3, unit, oldClass, newClass) + GetAssetFlawAmount(3);
    unit->def += GetStatDiff(4, unit, oldClass, newClass) + GetAssetFlawAmount(4);
    unit->res += GetStatDiff(5, unit, oldClass, newClass) + GetAssetFlawAmount(5);
    tmp = unit->_u3A; // handle mag separately because _u3A is unsigned
    tmp += GetStatDiff(8, unit, oldClass, newClass) + GetAssetFlawAmount(6);
    if (tmp < 0)
    {
        tmp = 0;
    }
    unit->_u3A = tmp;

    if (unit->maxHP <= 1)
    {
        unit->maxHP = 1;
    }
    if (unit->pow < 0)
    {
        unit->pow = 0;
    }
    if (unit->skl < 0)
    {
        unit->skl = 0;
    }
    if (unit->spd < 0)
    {
        unit->spd = 0;
    }
    if (unit->def < 0)
    {
        unit->def = 0;
    }
    if (unit->res < 0)
    {
        unit->res = 0;
    }
    // unit->lck += newClass->baseLck - oldClass->basePow;
    // unit->_u3A += newClass->basePow - oldClass->basePow; // mag

    // Remove base class' base wexp from unit wexp
    for (i = 0; i < 8; ++i)
    {
        tmp = unit->ranks[i] - oldClass->baseRanks[i];
        if (tmp >= 0)
        {
            unit->ranks[i] = tmp;
        }
    }

    // Update unit class
    unit->pClassData = newClass;

    // Add promoted class' base wexp to unit wexp
    for (i = 0; i < 8; ++i)
    {
        int wexp = unit->ranks[i];
        tmp = newClass->baseRanks[i];

        if (!tmp)
        {
            unit->ranks[i] = 0;
            continue;
        } // if new class has no rank, set to 0
        wexp += tmp;

        if (wexp > WPN_EXP_S)
            wexp = WPN_EXP_S;

        unit->ranks[i] = wexp;
    }

    // unit->level = 1;
    // unit->exp   = 0;
    UnitCheckStatCaps(unit);
    unit->curHP += newClass->promotionHp;

    if (unit->curHP > GetUnitMaxHp(unit))
        unit->curHP = GetUnitMaxHp(unit);
}

static int CanClassEquipWeapon(int weapon, int reclassID)
{
    weapon &= 0xFF; // id only
    int weaponType = GetItemData(weapon)->weaponType;
    return GetClassData(reclassID)->baseRanks[weaponType];
}

static void ExecUnitReclass(struct Unit * unit, u8 classId, int itemIdx, s8 unk)
{

    if (itemIdx != -1)
    {
        gBattleActor.weaponBefore = gBattleTarget.weaponBefore = unit->items[itemIdx];
    }

    int weapon = GetUnitEquippedWeapon(unit);
    if (!CanClassEquipWeapon(weapon, classId))
    {
        weapon = 0;
    }
    gBattleActor.weapon = gBattleTarget.weapon = weapon;
    // gBattleActor.weaponBefore = weapon;

    InitBattleUnitWithoutBonuses(&gBattleTarget, unit);

    ApplyUnitReclass(unit, classId);

    InitBattleUnitWithoutBonuses(&gBattleActor, unit);

    GenerateBattleUnitStatGainsComparatively(&gBattleActor, &gBattleTarget.unit);
    // save from battle?
    // struct Unit* actor  = GetUnit(gBattleActor.unit.index);
    // UpdateUnitFromBattle(actor, &gBattleActor);
    // BattleApplyUnitUpdates();
    SetBattleUnitTerrainBonusesAuto(&gBattleActor);
    SetBattleUnitTerrainBonusesAuto(&gBattleTarget);

    if (unk)
    {
        unit->state |= US_HAS_MOVED;
    }

    if (itemIdx != -1)
    {
        UnitUpdateUsedItem(unit, itemIdx);
    }

    gBattleHitArray[0].attributes = 0;
    gBattleHitArray[0].info = BATTLE_HIT_INFO_END;
    gBattleHitArray[0].hpChange = 0;

    gBattleStats.config = BATTLE_CONFIG_PROMOTION;

    return;
}

static const struct ProcCmd ProcScr_ReclassMain[] = {
    PROC_NAME("Reclass Main"),

    PROC_LABEL(PROMOMAIN_LABEL_START),
    PROC_CALL(PromoMain_InitScreen),
    PROC_SLEEP(3),

    PROC_LABEL(PROMOMAIN_LABEL_1),
    PROC_CALL(PromoMain_HandleType),

    PROC_LABEL(PROMOMAIN_LABEL_TRAINEE),
    PROC_WHILE(PromoMain_SetupTraineeEvent_),
    PROC_WHILE(PromoTraineeEventExists),
    PROC_CALL(PromoHandleTraineePostType),

    PROC_LABEL(PROMOMAIN_LABEL_SEL_EN),
    PROC_WHILE(StartAndWaitReclassSelect),
    PROC_SLEEP(5),
    PROC_REPEAT(sub_80CD330),

    PROC_LABEL(PROMOMAIN_LABEL_POST_SEL),
    PROC_CALL(ExecReclassChgReal),
    PROC_SLEEP(2),

    PROC_LABEL(6),
    PROC_CALL(PromoMain_HandlePrepEndEffect),

    PROC_LABEL(7),
    PROC_LABEL(8),
    PROC_CALL(PromoMain_OnEnd),
    PROC_END,
};

static bool StartAndWaitReclassSelect(struct ProcPromoMain * proc)
{
    struct ProcPromoMain * _proc = (struct ProcPromoMain *)proc;
    switch (_proc->stat)
    {
        case PROMO_MAIN_STAT_SELECTION:
            return false;

        case PROMO_MAIN_STAT_TRAINEE_EVENT:
        case PROMO_MAIN_STAT_INIT:
            proc->sel_en = StartReclassSelect(proc);
            _proc->stat = PROMO_MAIN_STAT_SELECTION;
            return false;

        default:
            return true;
    }
}

static u8 ReclassSubConfirmMenuOnSelect(struct MenuProc * proc, struct MenuItemProc * b)
{
    if (b->itemNumber == 0)
    {
        CallUpdatePronounFlags();
        ProcPtr found;
        EndMenu(proc);
        EndMenu(proc->proc_parent);
        found = Proc_Find(ProcScr_ReclassMain);
        if (gEventSlots[3] >= 0)
        {
            RegisterFillTile(NULL, (void *)(VRAM + 0x400 * 32), 20000);
            // RegisterBlankTile(0x400);
            BG_Fill(gBG3TilemapBuffer, 0);
            BG_EnableSyncByMask(BG3_SYNC_BIT);
        }

        EndAllProcChildren(found);
        // SetDispEnable(TRUE, TRUE, TRUE, FALSE, TRUE);
        ClassChgLoadEfxTerrain();
        Proc_Goto(found, PROMOMAIN_LABEL_POST_SEL);
    }
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A;
}

static u8 ReclassMenuSel_OnBPress(struct MenuProc * _proc, struct MenuItemProc * _proc2)
{
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B;
}

static const struct MenuItemDef MenuItem_ReclassSubConfirm[] = {
    { "　決定", 0x23, /* Change */
      0, TEXT_COLOR_SYSTEM_WHITE, 0, MenuAlwaysEnabled, NULL, ReclassSubConfirmMenuOnSelect, NULL, NULL },
    { "　やめる", 0x24, /* Cancel */
      0, TEXT_COLOR_SYSTEM_WHITE, 1, MenuAlwaysEnabled, NULL, ReclassSubConfirmMenuOnSelect, NULL, NULL },
    { 0 },
};

static const struct MenuDef Menu_ReclassSubConfirm = { { 9, 4, 6, 0 },
                                                       1,
                                                       MenuItem_ReclassSubConfirm,
                                                       (void (*)(struct MenuProc *))AvatarSubConfirm_OnInit,
                                                       (void (*)(struct MenuProc *))AvatarSubConfirm_OnEnd,
                                                       NULL,
                                                       ReclassMenuSel_OnBPress,
                                                       NULL,
                                                       MenuStdHelpBox };

static u8 ReclassMenuItem_OnSelect(struct MenuProc * pmenu, struct MenuItemProc * pmitem)
{
    struct ProcClassChgMenuSel * parent;
    struct ProcReclassSel * gparent;
    struct ProcPromoMain * ggparent;

    parent = pmenu->proc_parent;
    gparent = parent->proc_parent;
    ggparent = gparent->proc_parent;
    if (gparent->stat == 0)
    {
        struct Unit * unit = GetUnitFromCharId(ggparent->pid);
        u8 classnumber = unit->pClassData->number;
        int id = pmitem->itemNumber;
        if (id < NumberOfReclassOptions)
        {
            classnumber = GetReclassOption(ggparent->pid, classnumber, id);
        }
        ggparent->jid = classnumber;

        if (unit->state & US_IN_BALLISTA)
        {
            TryRemoveUnitFromBallista(unit);
        }

        InitTextFont(&gFontClassChgMenu, (void *)BG_VRAM + 0x1000, 0x80, 0x5);
        TileMap_FillRect(TILEMAP_LOCATED(gBG0TilemapBuffer, 9, 4), 0xA, 0x6, 0);
        BG_EnableSyncByMask(BG0_SYNC_BIT);
        StartMenuExt(&Menu_ReclassSubConfirm, 2, 0, 0, 0, pmenu);
    }

    return 0;
}

static u8 ReclassMenuSelOnPressB(struct MenuProc * pmenu, struct MenuItemProc * pmitem)
{
    struct ProcClassChgMenuSel * parent;
    struct ProcReclassSel * gparent;
    struct ProcPromoMain * ggparent;
    struct ProcPromoHandler * gggparent;

    parent = pmenu->proc_parent;
    gparent = parent->proc_parent;
    ggparent = gparent->proc_parent;
    gggparent = ggparent->proc_parent;
    if (gggparent->bmtype == PROMO_HANDLER_TYPE_TRANINEE)
        return 0;

    if (gggparent->bmtype == PROMO_HANDLER_TYPE_BM)
    {
        Proc_End(parent);
        Proc_Goto(gparent, PROC_CLASSCHG_SEL_2);
        return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B;
    }

    if (gggparent->bmtype == PROMO_HANDLER_TYPE_PREP)
    {
        Proc_End(parent);
        Proc_Goto(gparent, PROC_CLASSCHG_SEL_2);
        return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B;
    }

    return 0;
}

static void ReclassMenuOnDrawCore(struct MenuProc * pmenu, struct MenuItemProc * pmitem, char * str)
{
    // u8 unused_stack[32];
    u16 * mapbuf;
    if (pmitem->def->color)
        Text_SetColor(&pmitem->text, pmitem->def->color);

    if (pmitem->availability == MENU_DISABLED)
        Text_SetColor(&pmitem->text, TEXT_COLOR_SYSTEM_GRAY);

    // ClearTextPart(&pmitem->text, 0, 20);
    ClearTextPart(&pmitem->text, 0, 12);
    Text_SetCursor(&pmitem->text, 8);
    Text_DrawString(&pmitem->text, str);
    mapbuf = BG_GetMapBuffer(pmenu->frontBg);

    PutText(&pmitem->text, &mapbuf[pmitem->yTile * 32 + pmitem->xTile]);
}

static int ReclassMenuItem_OnTextDraw(struct MenuProc * pmenu, struct MenuItemProc * pmitem)
{
    // u8 unused_stack[0x48];
    struct ProcClassChgMenuSel * parent;
    struct ProcReclassSel * gparent;

    parent = pmenu->proc_parent;
    gparent = parent->proc_parent;
    ReclassMenuOnDrawCore(
        pmenu, pmitem, GetStringFromIndex(GetClassData(gparent->jid[pmitem->itemNumber])->nameTextId));
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_CLEAR | MENU_ACT_SND6A;
}

static int ClassHasMagicRank(const struct ClassData * data)
{ // UnitHasMagicRank
    int combinedRanks = 0;

    combinedRanks |= data->baseRanks[ITYPE_STAFF];
    combinedRanks |= data->baseRanks[ITYPE_ANIMA];
    combinedRanks |= data->baseRanks[ITYPE_LIGHT];
    combinedRanks |= data->baseRanks[ITYPE_DARK];

    return combinedRanks ? TRUE : FALSE;
}

static const char stats[][16] = {
    "HP", "Str", "Skl", "Spd", "Def", "Res", "Con", "Mov", "Mgc",
};

static void DrawStatDiff(int x, int y, int id, struct Unit * unit, const struct ClassData * classData)
{
    struct Text * th = gStatScreen.text;
    const struct ClassData * oldClass = unit->pClassData;
    // int num = GetStatDiff(id, unit, oldClass, classData);
    int num = GetNewStat(id, unit, oldClass, classData);
    // PutDrawText(&th[id], TILEMAP_LOCATED(gBG0TilemapBuffer, x, y), 0, 0, 2, stats[id]);
    if (ClassHasMagicRank(classData) && (id == 1) && (!IsStrMagInstalled()))
    {
        id += 7;
    }
    if (num >= 0)
    {
        PutDrawText(&th[id], TILEMAP_LOCATED(gBG0TilemapBuffer, x, y), 0, 0, 3, stats[id]); // "+"
        Text_InsertDrawString(&th[id], 18, th[id].colorId, " ");                            // th[id].x + 8
    }
    // else
    // {
    // PutDrawText(&th[id], TILEMAP_LOCATED(gBG0TilemapBuffer, x, y), 0, 0, 3, stats[id]); // "-"
    // Text_InsertDrawString(&th[id], 19, th[id].colorId, " ");
    // th[id].x++;
    // }
    th[id].x++;

    Text_InsertDrawNumberOrBlank(&th[id], th[id].x + 3, th[id].colorId, ABS(num));
    // PutNumber(TILEMAP_LOCATED(gBG0TilemapBuffer, x+3, y), 0, ABS(num));
}

struct SpecialCharSt
{
    s8 color;
    s8 id;
    s16 chr_position;
};
extern u16 Pal_SpinningArrow[];
extern struct Font * gActiveFont;
extern struct SpecialCharSt sSpecialCharStList[64];

static void ReclassDrawStatChanges(struct Unit * unit, const struct ClassData * classData)
{
    struct Text * th = gStatScreen.text;
    InitTextFont(&gDefaultFont, (void *)(VRAM + 0x4400), 0x220, 0);
    sSpecialCharStList[0].color = -1; // redraw numbers !!
    for (int i = 0; i < 10; ++i)
    {
        InitText(&th[i], 6);
    }
    SetTextFontGlyphs(0);

    int x = 12;
    int y = 12;
    TileMap_FillRect(TILEMAP_LOCATED(gBG0TilemapBuffer, x, y), 8, 2, 0);
    BG_EnableSyncByMask(BG0_SYNC_BIT);

    int c = 0;
    LoadIconPalette(1, 3); // loaded already if non prep
    for (int i = 0; i < 8; ++i)
    {
        if (classData->baseRanks[i])
        {
            DrawIcon(gBG0TilemapBuffer + TILEMAP_INDEX(x + (c * 2), y), 0x70 + i, TILEREF(0, 3));
            c++;
        }
    }

    y = 4;

    DrawUiFrame(
        BG_GetMapBuffer(2),                  // back BG
        11, y - 1, 6, 10, TILEREF(0, 0), 0); // style as 0 ?
    DrawUiFrame(
        BG_GetMapBuffer(2),                  // back BG
        24, y - 1, 6, 10, TILEREF(0, 0), 0); // style as 0 ?
    BG_EnableSyncByMask(BG2_SYNC_BIT);
    SetBlendTargetA(0, 0, 1, 0, 0);

    DrawStatDiff(12, y + 0, 0, unit, classData);
    DrawStatDiff(25, y + 0, 1, unit, classData); // Str or Mag
    DrawStatDiff(12, y + 2, 2, unit, classData);
    DrawStatDiff(25, y + 2, 3, unit, classData);
    DrawStatDiff(12, y + 4, 4, unit, classData);
    DrawStatDiff(25, y + 4, 5, unit, classData);
    DrawStatDiff(12, y + 6, 6, unit, classData);
    if (IsStrMagInstalled())
    {
        DrawStatDiff(25, y + 6, 8, unit, classData); // mag
    }
    else
    {
        DrawStatDiff(25, y + 6, 7, unit, classData); // mov
    }

    // PutDrawText(&th[0], TILEMAP_LOCATED(gBG0TilemapBuffer, 13, 1), 0, 0, 5, "HP");
    // PutDrawText(&th[1], TILEMAP_LOCATED(gBG0TilemapBuffer, 8, 3), 0, 0, 5, "Str");
    // PutDrawText(&th[2], TILEMAP_LOCATED(gBG0TilemapBuffer, 8, 5), 0, 0, 5, "Skl");
    // PutDrawText(&th[3], TILEMAP_LOCATED(gBG0TilemapBuffer, 8, 7), 0, 0, 5, "Spd");
    // PutDrawText(&th[4], TILEMAP_LOCATED(gBG0TilemapBuffer, 8, 9), 0, 0, 5, "Def");
    // PutDrawText(&th[5], TILEMAP_LOCATED(gBG0TilemapBuffer, 8, 11), 0, 0, 5, "Res");
    // PutDrawText(&th[6], TILEMAP_LOCATED(gBG0TilemapBuffer, 8, 13), 0, 0, 5, "Lck");
    // PutDrawText(&th[7], TILEMAP_LOCATED(gBG0TilemapBuffer, 8, 15), 0, 0, 5, "Mag");

    // PutDrawText(struct Text* text, u16* dest, int colorId, int x, int tileWidth, const char* string);
}
extern int ClassDescEnabledAvatar;
static int ReclassMenuItem_OnChange(struct MenuProc * pmenu, struct MenuItemProc * pmitem)
{
    struct ProcClassChgMenuSel * parent;
    struct ProcReclassSel * gparent;

    parent = pmenu->proc_parent;
    gparent = parent->proc_parent;
    gparent->stat = 1;
    gparent->main_select = pmitem->itemNumber;

    struct Unit * unit = GetUnitFromCharId(gparent->pid);
    const struct ClassData * classData =
        GetClassData(GetReclassOption(gparent->pid, unit->pClassData->number, pmenu->itemCurrent));
    ReclassDrawStatChanges(unit, classData);
    int msg_desc = classData->descTextId; // pmenu->itemCurrent
    // ChangeClassDescription(gparent->msg_desc[gparent->main_select]);
    if (ClassDescEnabledAvatar)
    {
        ChangeClassDescription(msg_desc);
    }
    SetTalkPrintDelay(-1);
    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_CLEAR | MENU_ACT_SND6A;
}

static u8 ReclassMenuItem_Usability(const struct MenuItemDef * _def, int _number)
{
    struct ProcClassChgMenuSel * proc = Proc_Find(ProcScr_ReclassMenuSel);
    struct ProcReclassSel * parent = proc->proc_parent;
    struct ProcPromoMain * gparent = parent->proc_parent;
    if (GetReclassOption(gparent->pid, GetUnitFromCharId(gparent->pid)->pClassData->number, _number))
    {
        return MENU_ENABLED;
    }
    return MENU_NOTSHOWN;
}

static const struct MenuItemDef gMenuItem_ReclassSel[] = {
    { "　第１兵種", 0, 0x6DC, /* Discard items. Important[NL]items cannot be discarded. */
      TEXT_COLOR_SYSTEM_WHITE, 0, MenuAlwaysEnabled, ReclassMenuItem_OnTextDraw, ReclassMenuItem_OnSelect, 0,
      ReclassMenuItem_OnChange, 0 },
    { "　第３兵種", 0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 1, ReclassMenuItem_Usability, ReclassMenuItem_OnTextDraw,
      ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0 },
    { "　第３兵種", 0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 2, ReclassMenuItem_Usability, ReclassMenuItem_OnTextDraw,
      ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0 },
    { "　第３兵種", 0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 3, ReclassMenuItem_Usability, ReclassMenuItem_OnTextDraw,
      ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0 },
    { "　第３兵種", 0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 4, ReclassMenuItem_Usability, ReclassMenuItem_OnTextDraw,
      ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0 },
    { "　第３兵種", 0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 5, ReclassMenuItem_Usability, ReclassMenuItem_OnTextDraw,
      ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0 },
    { 0 }
};

static u32 ReclassMenuSelOnInit(struct MenuProc * proc)
{
    SyncMenuBgs(proc);
    return 0;
}

static u32 ReclassMenuSelOnEnd(struct MenuProc * proc)
{
    SyncMenuBgs(proc);
    return 0;
}

static const struct MenuDef gMenuDef_ReclassSel = {
    .rect = { 16, 1, 8, 0 },
    .menuItems = gMenuItem_ReclassSel,
    .onInit = (void (*)(struct MenuProc *))ReclassMenuSelOnInit,
    .onEnd = (void (*)(struct MenuProc *))ReclassMenuSelOnEnd,
    .onBPress = ReclassMenuSelOnPressB,
};

static const struct MenuRect ReclassMenuRect = { .x = 1,
                                                 .y = 0,
                                                 .w = 10, // InitText uses this for tile width
                                                 .h = 0 };

extern void Make6C_PromotionMenuSelect(struct ProcReclassSel * proc);
extern void sub_80CCF60(struct ProcReclassSel * proc);

// extern void LoadBattleSpritesForBranchScreen(struct ProcReclassSel *proc);
extern void sub_80CD294(struct ProcReclassSel * proc);
extern void sub_80CD1D4(struct ProcReclassSel * proc);
extern void sub_80CD2CC(struct ProcReclassSel * proc);
extern void NewCcramifyEnd(void);
extern void PrepClassChgOnCancel(struct ProcReclassSel * proc);

static void ReclassMenuExec(struct ProcClassChgMenuSel * proc)
{
    proc->unk4C = 0;
    ResetTextFont();
    ResetText();
    SetTextFontGlyphs(0);
    // InitTextFont(&gFontClassChg, (void *)BG_VRAM + 0x1400, 0xA0, 5);
    InitTextFont(&gFontClassChg, (void *)BG_VRAM + 0x3400, 0x1A0, 5);
    // InitTextFont(&gFontClassChg, (void *)BG_VRAM + 0x1000, 160, 5);
    SetTextFont(&gFontClassChg);
    proc->pmenu = StartMenuCore(&gMenuDef_ReclassSel, ReclassMenuRect, 2, 0, 0, 0, (struct Proc *)proc);
}

extern int ClassNameTopEnabledAvatar;
static void LoadClassNameInClassReelFont2(struct ProcReclassSel * proc)
{
    if (!ClassNameTopEnabledAvatar)
    {
        return;
    }
    s8 str[0x20];
    s32 index;
    u8 idx = proc->main_select;
    u16 classNum = proc->jid[idx];
    u32 xOffs = 0x74;
    const struct ClassData * class = GetClassData(classNum);
    GetStringFromIndexInBuffer(class->nameTextId, (void *)str);
    for (index = 0; index < 0x14 && str[index] != '\0'; index++)
    {
        struct ClassDisplayFont * font = GetClassDisplayFontInfo(str[index]);
        if (font)
        {
            if (font->a)
            { // font->yBase + y is where to draw on screen
                PutSpriteExt(4, xOffs - font->xBase - 2, font->yBase + 0, font->a, 0x81 << 7);
                xOffs += font->width - font->xBase;
            }
        }
        else
        {
            xOffs += 4;
        }
    }

    if (proc->u44 < 0xff)
        proc->u44++;
}

extern u8 * sUnknown_08A30800[];
extern u16 * sUnknown_08A30978[];
extern int BottomMenuBGEnabledAvatar; // behind class text description
static void ReclassChgLoadUI(void)
{
    if (!BottomMenuBGEnabledAvatar)
    {
        return;
    }
    // asm("mov r11, r11");
    u8 * src = *sUnknown_08A30800;
    u32 off = GetBackgroundTileDataOffset(BG_2); // 0x3800?
    // off = 0x800;
    Decompress(src, (void *)VRAM + 0x3000 + off);
    RegisterTsaWithOffset(
        gBG2TilemapBuffer, *sUnknown_08A30978, TILEREF(0x180, 0) + 0x1000); // vanilla 0x1180, text rework 0x11c0 fsr
}

extern int PlatformYPosAvatar;
static void Make6C_ReclassMenuSelect(struct ProcReclassSel * proc)
{
    struct ProcPromoMain * parent = proc->proc_parent;
    struct ProcPromoHandler * grandparent;
    struct Unit * unit;
    int i;
    int pid = 0;

    parent->stat = PROMO_MAIN_STAT_2;
    proc->pid = parent->pid;
    proc->u50 = 9;
    BG_Fill(gBG0TilemapBuffer, 0);
    BG_Fill(gBG1TilemapBuffer, 0);
    BG_Fill(gBG2TilemapBuffer, 0);
    LoadUiFrameGraphics();
    LoadObjUIGfx();
    sub_80CD47C(0, -1, 0xfb * 2, PlatformYPosAvatar, 6);
    ReclassChgLoadUI();
    // ClassChgLoadUI();
    sub_80CD408(proc->u50, 0x8c * 2, PlatformYPosAvatar + 0x10);

    proc->sprite[0] = 0;
    proc->sprite[1] = 0;
    proc->sprite[2] = 0;

    for (i = 1; i < 0x40; i++)
    {
        // u16 classFromSwitch;

        u16 weapon;
        s32 j;
        unit = GetUnit(i);

        if (!UNIT_IS_VALID(unit))
            continue;

        if (unit->pCharacterData->number != proc->pid)
            continue;

        pid = unit->pClassData->number;
        weapon = GetUnitEquippedWeapon(unit);

        int maybeWep = 0;

        // for (j = 0; j < 2; j++) {
        for (j = 0; j < NumberOfReclassOptions; j++)
        {
            int reclassID = GetReclassOption(proc->pid, pid, j);
            proc->jid[j] = reclassID;
            maybeWep = 0;
            if (CanClassEquipWeapon(weapon, reclassID))
            {
                maybeWep = weapon;
            }
            // proc->use_wpn[j] =

            // LoadClassBattleSprite((void*)&proc->sprite[j], ReclassTable[pid][j], weapon);
            if (j < 2)
            {
                proc->msg_desc[j] = GetClassData(reclassID)->descTextId; // i dunno
            }
            if (reclassID)
            {
                LoadClassBattleSprite((void *)&proc->sprite[j], reclassID, maybeWep);
            }
        }

        proc->weapon = weapon;
        break;
    }

    if (proc->sprite[0] == 0 && proc->sprite[1] == 0)
    {
        proc->sprite[1] = 0;
        proc->sprite[0] = 0;
    }

    proc->stat = 1;
    proc->main_select = 0;
    LoadClassReelFontPalette((void *)proc, pid);
    LoadClassNameInClassReelFont2(proc);
    LoadObjUIGfx();

    proc->menu_proc = ReclassMenuSelect(proc);

    grandparent = parent->proc_parent;
    if (grandparent->bmtype == PROMO_HANDLER_TYPE_BM)
    {
        RestartMuralBackground();
        BG_EnableSyncByMask(0xf);
    }
}

#define NONMATCHING
static void LoadBattleSpritesForBranchScreen2(struct ProcReclassSel * proc)
{
    u32 a;
    u8 b;
    struct ProcReclassSel * p2;
    struct ProcReclassSel * c2;
    struct Anim * anim1;
    struct Anim * anim2;
    struct Unit copied_unit;
    void * tmp;
    u16 chara_pal;
    anim1 = gUnknown_030053A0.anim1;
    anim2 = gUnknown_030053A0.anim2;

    p2 = (void *)gUnknown_0201FADC.proc14;
    c2 = (void *)gUnknown_0201FADC.proc18;

    a = proc->stat;
    tmp = &gUnknown_030053A0;

    if (a == 1)
    {
        u16 _pid, _jid;
        s16 i;
        struct Unit * unit;
        const struct BattleAnimDef * battle_anim_ptr;
        u32 battle_anim_id;
        u16 ret;
        if ((s16)p2->sprite[0] <= 0x117)
        {
            p2->sprite[0] += 12;
            c2->sprite[0] += 12;
            anim1->xPosition += 12;
            anim2->xPosition = anim1->xPosition;
        }
        else
        {
            proc->stat = 2;
        }

        if (proc->stat == 2)
        {
            EndEfxAnimeDrvProc();
            sub_805AA28(&gUnknown_030053A0);
            _pid = proc->pid - 1;
            _jid = proc->jid[proc->main_select];
            chara_pal = -1;
            unit = GetUnitFromCharId(proc->pid);
            copied_unit = *unit;
            copied_unit.pClassData = GetClassData(proc->jid[proc->main_select]);
            battle_anim_ptr = copied_unit.pClassData->pBattleAnimDef;
            int weapon = GetUnitEquippedWeapon(&copied_unit);
            if (!CanClassEquipWeapon(weapon, proc->jid[proc->main_select]))
            {
                weapon = 0;
            }

            ret = GetBattleAnimationId(&copied_unit, battle_anim_ptr, (u16)weapon, &battle_anim_id);
            for (i = 0; i <= 6; i++)
            {
                if (gAnimCharaPalConfig[(s16)_pid][i] == (s16)_jid)
                {
                    chara_pal = gAnimCharaPalIt[(s16)_pid][i] - 1;
                    break;
                }
            }
            sub_80CD47C((s16)ret, (s16)chara_pal, (s16)(p2->sprite[0] + 0x28), PlatformYPosAvatar, 6);
            sub_805AE14(&gUnknown_0201FADC);
            sub_80CD408(proc->u50, p2->sprite[0], p2->msg_desc[1]); // I dunno
            // sub_80CD408(proc->u50, 0x8c * 2, PlatformYPosAvatar+0x10);
        }
        else
        {
            goto D1AC;
        }
    }
    ++proc;
    --proc;
    b = proc->stat;
    tmp = &gUnknown_030053A0;
    if (b == 2)
    {
        if ((s16)p2->sprite[0] > 0x82)
        {
#ifdef NONMATCHING
            u16 off = 12;
#else
            register u16 off asm("r1") = 12;
#endif // NONMATCHING
            p2->sprite[0] -= off;
            c2->sprite[0] -= off;
            anim1->xPosition -= off;
            anim2->xPosition = anim1->xPosition;
        }
        else
        {
            proc->stat = 0;
        }
    }
D1AC:
    if ((u8)sub_805A96C(tmp))
    {
        sub_805A990(tmp);
    }
    LoadClassNameInClassReelFont2((void *)proc);
    return;
}

static void Reclasssub_80CCF60(struct ProcReclassSel * proc)
{
    u16 tmp;

    ResetTextFont();
    ResetText();
    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT | BG3_SYNC_BIT);
    InitTalk(0x100, 2, 0);
    if (ClassDescEnabledAvatar)
    {

        ChangeClassDescription(proc->msg_desc[proc->main_select]);
    }

    SetTalkPrintDelay(-1);

    gLCDControlBuffer.bg0cnt.priority = 0;
    gLCDControlBuffer.bg1cnt.priority = 2;
    gLCDControlBuffer.bg2cnt.priority = 1;
    gLCDControlBuffer.bg3cnt.priority = 3;

    BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG2_SYNC_BIT | BG3_SYNC_BIT);

    tmp = REG_BG0CNT;
    tmp &= 0xFFFC;
    REG_BG0CNT = tmp + 1;
    tmp = REG_BG1CNT;
    tmp &= 0xFFFC;
    REG_BG1CNT = tmp + 1;
    tmp = REG_BG2CNT;
    tmp &= 0xFFFC;
    REG_BG2CNT = tmp + 1;
    tmp = REG_BG3CNT;
    tmp &= 0xFFFC;
    REG_BG3CNT = tmp + 1;
}

static const struct ProcCmd ProcScr_ReclassSelect[] = {
    PROC_CALL(StartMidFadeToBlack),
    PROC_REPEAT(WaitForFade),

    PROC_NAME("Reclass Select"),

    PROC_LABEL(PROC_CLASSCHG_SEL_INIT),
    PROC_CALL(Make6C_ReclassMenuSelect),
    PROC_SLEEP(6),
    PROC_CALL(Reclasssub_80CCF60),

    PROC_LABEL(PROC_CLASSCHG_SEL_1),
    PROC_CALL(StartMidFadeFromBlack),
    PROC_REPEAT(WaitForFade),
    PROC_REPEAT(LoadBattleSpritesForBranchScreen2),
    PROC_GOTO(PROC_CLASSCHG_SEL_END1),

    /* Pre End */
    PROC_LABEL(PROC_CLASSCHG_SEL_2),
    PROC_CALL(sub_80CD294),
    PROC_CALL(StartMidFadeToBlack),
    PROC_REPEAT(WaitForFade),

    /* On End */
    PROC_LABEL(PROC_CLASSCHG_SEL_4),
    PROC_CALL(sub_80CD1D4),
    PROC_CALL(sub_80CD2CC),
    PROC_SET_END_CB(NewCcramifyEnd),
    PROC_CALL(StartMidFadeToBlack),
    PROC_REPEAT(WaitForFade),
    PROC_CALL(ClassChgOnCancel),

    PROC_LABEL(PROC_CLASSCHG_SEL_END2),
    PROC_LABEL(PROC_CLASSCHG_SEL_END1),
    PROC_END,
};

static ProcPtr StartReclassSelect(ProcPtr parent)
{
    return Proc_StartBlocking(ProcScr_ReclassSelect, parent);
}

static ProcPtr ReclassMenuSelect(ProcPtr parent)
{
    return Proc_Start(ProcScr_ReclassMenuSel, parent);
}

static struct ProcPromoMain * Make6C_ReclassMain(ProcPtr proc)
{
    return Proc_StartBlocking(ProcScr_ReclassMain, proc);
}

static void MakeReclassScreen(struct ProcPromoHandler * proc, u8 pid, u8 terrain);
static u32 ReclassHandler_SetupAndStartUI(struct ProcPromoHandler * proc)
{
    Proc_Start(ProcScr_SetLevel, (void *)3);
    struct Unit * unit;
    u8 classNumber;
    u32 terrain = TERRAIN_PLAINS;

    switch (gPlaySt.chapterModeIndex)
    {
        case CHAPTER_MODE_EIRIKA:
        default:
            terrain = TERRAIN_PLAINS;
            break;

        case CHAPTER_MODE_EPHRAIM:
            // terrain = TERRAIN_DESERT;
            break;
    }
    unit = GetUnitFromCharId(proc->pid);
    classNumber = unit->pClassData->number;
    int reclassID_A = GetReclassOption(proc->pid, classNumber, 0);
    int reclassID_B = GetReclassOption(proc->pid, classNumber, 1);
    // if no options, end
    // if 1 option, reclass into that without the menu?
    // if >1 option, show menu

    if (proc->bmtype == PROMO_HANDLER_TYPE_BM)
    {
        proc->bmtype = PROMO_HANDLER_TYPE_BM;
        proc->sel_en = 1;

        /* If no class to reclass into, end the handler proc */
        if (!reclassID_A && !reclassID_B)
            return PROMO_HANDLER_STAT_END;

        // if (reclassID_A && !reclassID_B) {
        // proc->jid = reclassID_A;
        // proc->sel_en = 0;
        // }

        // if (!reclassID_A && reclassID_B) {
        // proc->jid = reclassID_B;
        // proc->sel_en = 0;
        // }

        MakeReclassScreen(proc, proc->pid, terrain);
        return PROMO_HANDLER_STAT_IDLE;
    }
    else if (proc->bmtype == PROMO_HANDLER_TYPE_PREP)
    {
        proc->bmtype = PROMO_HANDLER_TYPE_PREP;
        proc->sel_en = 1;

        if (!reclassID_A && !reclassID_B)
        {
            BMapDispResume();
            RefreshBMapGraphics();
            return PROMO_HANDLER_STAT_END;
        }
        // if (reclassID_A && !reclassID_B) {
        // proc->jid = reclassID_A;
        // proc->sel_en = 0;
        // }
        // if (!reclassID_A && reclassID_B) {
        // proc->jid = reclassID_B;
        // proc->sel_en = 0;
        // }
        MakeReclassScreen(proc, proc->pid, terrain);
        return PROMO_HANDLER_STAT_IDLE;
    }
    else
        return PROMO_HANDLER_STAT_END;
}

static void ReclassHandlerIdle(struct ProcPromoHandler * proc)
{
    switch (proc->stat)
    {
        case PROMO_HANDLER_STAT_IDLE:
        default:
            return;

        case PROMO_HANDLER_STAT_INIT:
            proc->stat = ReclassHandler_SetupAndStartUI(proc);
            break;

        case PROMO_HANDLER_STAT_END:
            Proc_Break(proc);
            break;
    }
}

static void MakeReclassScreen(struct ProcPromoHandler * proc, u8 pid, u8 terrain)
{
    struct ProcPromoMain * child;

    /* set callback stat */
    proc->stat = PROMO_HANDLER_STAT_INIT;

    child = Make6C_ReclassMain(proc);
    proc->promo_main = child;
    child->pid = pid;
    child->terrain = terrain;
}

// asmc or whatever
extern struct ProcCmd sProc_Menu[];
int StartBmAvatar(ProcPtr proc)
{
    // struct Unit * unit = gActiveUnit;
    if (UNIT_IS_VALID(gActiveUnit))
    {
        gActiveUnit->state &= ~US_HIDDEN;
    }
    struct Unit * unit = GetUnitStructFromEventParameter(gEventSlots[1]);
    if (!UNIT_IS_VALID(unit))
    {
        return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_CLEAR | MENU_ACT_SND6B;
    }
    gActiveUnit = unit;
    gActiveUnitId = unit->index;

    gActionData.xMove = unit->xPos;
    gActionData.yMove = unit->yPos;

    gActionData.subjectIndex = unit->index;
    // deplete the used item when reclassing if it's being used via IER or juna fruit etc
    // if (gActionData.unitActionType != 0x1A)
    // {
    gActionData.itemSlotIndex = -1; // don't deplete the item if being called in a different way
    // }
    gActionData.unitActionType = 0;
    gActionData.moveCount = 0;

    gBmSt.taken_action = 0;
    gBmSt.unk3F = 0xFF;

    sub_802C334();

    gActiveUnit->xPos = gActionData.xMove;
    gActiveUnit->yPos = gActionData.yMove;
    UnitFinalizeMovement(gActiveUnit);
    ResetTextFont();
    gBattleActor.weaponBefore = gBattleTarget.weaponBefore =
        GetUnit(gActionData.subjectIndex)->items[gActionData.itemSlotIndex];

    int weapon = GetUnitEquippedWeapon(GetUnit(gActionData.subjectIndex));
    if (!CanClassEquipWeapon(weapon, gActiveUnit->pClassData->number))
    {
        weapon = 0;
    }
    gBattleActor.weapon = gBattleTarget.weapon = weapon;

    gBattleTarget.statusOut = -1;
    // struct ProcPromoHandler * new_proc;
    struct MenuProc * menu = Proc_Find(sProc_Menu);
    // asm("mov r11, r11");
    if (menu)
    { // if a menu is active, don't block it. Instead, end it
        // EndAllMenus();
        Proc_Start(ProcScr_AvatarHandler, (void *)3);
        //        new_proc = Proc_StartBlocking(ProcScr_ReclassHandler, proc);
    }
    else
    {
        Proc_StartBlocking(ProcScr_AvatarHandler, proc);
    }

    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_CLEAR | MENU_ACT_SND6A;
}
#include "Face.c"
