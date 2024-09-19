
#include "C_Code.h" // headers 
#define PUREFUNC __attribute__((pure))
int Mod(int a, int b) PUREFUNC;

ProcPtr ReclassMenuSelect(ProcPtr parent); 


struct ProcReclassSel { // see ProcPromoSel 
    PROC_HEADER;
    s8 _u29;
    s8 _u2a;
    s8 _u2b;
    u8 jid[6];
    u16 sprite[3];
    s16 msg_desc[3];
    u16 _u3e;
    u8 stat;
    u8 main_select;
    u16 pid;
    u16 u44;
    u8 u46;
    u8 u47;
    u16 weapon;
    u8 use_wpn[3];
    u8 _u4d[3];
    u32 u50; // platform ID? 
    ProcPtr menu_proc;
    /* ... more maybe */
};
void ReclassMenuExec(struct ProcClassChgMenuSel *proc); 
const struct ProcCmd ProcScr_ReclassMenuSel[] = {
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

u8 ReclassMenuItem_OnSelect(struct MenuProc *pmenu, struct MenuItemProc *pmitem) {
    struct ProcClassChgMenuSel *parent;
    struct ProcReclassSel *gparent;
    struct ProcPromoMain *ggparent;

    parent = pmenu->proc_parent;
    gparent = parent->proc_parent;
    ggparent = gparent->proc_parent;
    if (gparent->stat == 0) {
        struct Unit *unit = GetUnitFromCharId(ggparent->pid);
        u8 classnumber = unit->pClassData->number;
        if (pmitem->itemNumber <= 1) {
            classnumber = gPromoJidLut[classnumber][pmitem->itemNumber];
            ggparent->jid = classnumber;
        } else {
            if (pmitem->itemNumber == 2) {
                switch (classnumber) {
                case CLASS_JOURNEYMAN:
                    ggparent->jid = CLASS_JOURNEYMAN_T1;
                    break;
                case CLASS_PUPIL:
                    ggparent->jid = CLASS_PUPIL_T1;
                    break;
                case CLASS_RECRUIT:
                    ggparent->jid = CLASS_RECRUIT_T1;
                    break;
                default:
                    ggparent->jid = classnumber;
                    break;
                }
            }
        }

        switch ((u8) ggparent->jid) {
        case CLASS_RANGER:
        case CLASS_RANGER_F:
            if (unit->state & US_IN_BALLISTA) {
                TryRemoveUnitFromBallista(unit);
            }
            break;
        }

        InitTextFont(&gFontClassChgMenu, (void *)BG_VRAM + 0x1000, 0x80, 0x5);
        TileMap_FillRect(TILEMAP_LOCATED(gBG0TilemapBuffer, 9, 4), 0xA, 0x6, 0);
        BG_EnableSyncByMask(BG0_SYNC_BIT);
        StartMenuExt(&Menu_PromoSubConfirm, 2, 0, 0, 0, pmenu);
    }

    return 0;
}

u8 ReclassMenuSelOnPressB(struct MenuProc *pmenu, struct MenuItemProc *pmitem) {
    struct ProcClassChgMenuSel *parent;
    struct ProcReclassSel *gparent;
    struct ProcPromoMain *ggparent;
    struct ProcPromoHandler *gggparent;

    parent = pmenu->proc_parent;
    gparent = parent->proc_parent;
    ggparent = gparent->proc_parent;
    gggparent = ggparent->proc_parent;
    if (gggparent->bmtype == PROMO_HANDLER_TYPE_TRANINEE) 
        return 0;

    if (gggparent->bmtype == PROMO_HANDLER_TYPE_BM) {
        Proc_End(parent);
        Proc_Goto(gparent, PROC_CLASSCHG_SEL_2);
        return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B;
    }

    if (gggparent->bmtype == PROMO_HANDLER_TYPE_PREP) {
        Proc_End(parent);
        Proc_Goto(gparent, PROC_CLASSCHG_SEL_2);
        return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6B;;
    }

    return 0;
}

int ReclassMenuItem_OnTextDraw(struct MenuProc *pmenu, struct MenuItemProc *pmitem)
{
    //u8 unused_stack[0x48];
    struct ProcClassChgMenuSel *parent;
    struct ProcReclassSel *gparent;

    parent = pmenu->proc_parent;
    gparent = parent->proc_parent;
    ClassChgMenuOnDrawCore(pmenu, pmitem, GetStringFromIndex(GetClassData(gparent->jid[pmitem->itemNumber])->nameTextId));
    return 0xB7; 
}

int ReclassMenuItem_OnChange(struct MenuProc *pmenu, struct MenuItemProc *pmitem)
{
    struct ProcClassChgMenuSel *parent;
    struct ProcReclassSel *gparent;

    parent = pmenu->proc_parent;
    gparent = parent->proc_parent;
    gparent->stat = 1;
    gparent->main_select = pmitem->itemNumber;
    ChangeClassDescription(gparent->msg_desc[gparent->main_select]);
    SetTalkPrintDelay(-1);
    return 0xB7; 
}

u8 ReclassMenuItem_3rdUsability(const struct MenuItemDef * _def, int _number)
{
    struct ProcClassChgMenuSel *proc = Proc_Find(ProcScr_ReclassMenuSel);
    struct ProcReclassSel *parent = proc->proc_parent;
    struct ProcPromoMain *gparent = parent->proc_parent;

    if (Check3rdTraineeEnabled()) {
        switch (GetUnitFromCharId(gparent->pid)->pClassData->number) {
        case CLASS_JOURNEYMAN:
        case CLASS_PUPIL:
        case CLASS_RECRUIT:
            return MENU_ENABLED;

        default:
            return MENU_NOTSHOWN;
        }
    }

    return MENU_NOTSHOWN;
}


const struct MenuItemDef gMenuItem_ReclassSel[] = {
    {
        "　第１兵種",
        0,
        0x6DC,  /* Discard items. Important[NL]items cannot be discarded. */
        TEXT_COLOR_SYSTEM_WHITE,
        0,
        MenuAlwaysEnabled,
        ReclassMenuItem_OnTextDraw,
        ReclassMenuItem_OnSelect,
        0,
        ReclassMenuItem_OnChange,
        0
    },
    {
        "　第３兵種",
        0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 2, MenuAlwaysEnabled,
        ReclassMenuItem_OnTextDraw, ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0
    },
    {
        "　第３兵種",
        0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 2, ReclassMenuItem_3rdUsability,
        ReclassMenuItem_OnTextDraw, ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0
    },
    {
        "　第３兵種",
        0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 3, ReclassMenuItem_3rdUsability,
        ReclassMenuItem_OnTextDraw, ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0
    },
    {
        "　第３兵種",
        0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 4, ReclassMenuItem_3rdUsability,
        ReclassMenuItem_OnTextDraw, ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0
    },
    {
        "　第３兵種",
        0, 0x6DC, TEXT_COLOR_SYSTEM_WHITE, 5, ReclassMenuItem_3rdUsability,
        ReclassMenuItem_OnTextDraw, ReclassMenuItem_OnSelect, 0, ReclassMenuItem_OnChange, 0
    },
    {0}
};

u32 ReclassMenuSelOnInit(struct MenuProc *proc)
{
    SyncMenuBgs(proc);
    return 0;
}

u32 ReclassMenuSelOnEnd(struct MenuProc *proc)
{
    SyncMenuBgs(proc);
    return 0;
}

const struct MenuDef gMenuDef_ReclassSel = {
    .rect = { 16, 2, 8, 0 },
    .menuItems = gMenuItem_ReclassSel,
    .onInit = (void(*)(struct MenuProc*)) ReclassMenuSelOnInit,
    .onEnd = (void(*)(struct MenuProc*)) ReclassMenuSelOnEnd,
    .onBPress = ReclassMenuSelOnPressB,
};

const struct MenuRect ReclassMenuRect = {
    .x = 1,
    .y = 1,
    .w = 12,
    .h = 0
};

extern void Make6C_PromotionMenuSelect(struct ProcReclassSel* proc); 
extern void sub_80CCF60(struct ProcReclassSel *proc); 
extern void sub_805AE14(void *);
//extern void LoadBattleSpritesForBranchScreen(struct ProcReclassSel *proc); 
extern void sub_80CD294(struct ProcReclassSel *proc); 
extern void sub_80CD1D4(struct ProcReclassSel *proc); 
extern void sub_80CD2CC(struct ProcReclassSel *proc); 
extern void NewCcramifyEnd(void); 
extern void PrepClassChgOnCancel(struct ProcReclassSel *proc); 

void ReclassMenuExec(struct ProcClassChgMenuSel *proc)
{
    proc->unk4C = 0;
    ResetTextFont();
    ResetText();
    SetTextFontGlyphs(0);
    InitTextFont(&gFontClassChg, (void *)BG_VRAM + 0x1400, 160, 5);
    SetTextFont(&gFontClassChg);
    proc->pmenu = StartMenuCore(
		&gMenuDef_ReclassSel,
		ReclassMenuRect,
		2,
		0,
		0,
		0,
		(struct Proc *) proc);
}




void LoadClassNameInClassReelFont2(struct ProcReclassSel *proc) {
    s8 str[0x20];
    s32 index;
    u8 idx = proc->main_select;
    u16 classNum = proc->jid[idx];
    u32 xOffs = 0x74;
    const struct ClassData *class = GetClassData(classNum);
    GetStringFromIndexInBuffer(class->nameTextId, (void*)str);
    for (index = 0; index < 0x14 && str[index] != '\0'; index++) {
        struct ClassDisplayFont *font = GetClassDisplayFontInfo(str[index]);
        if (font) {
            if (font->a) {
                PutSpriteExt(4, xOffs - font->xBase - 2, font->yBase + 6, font->a, 0x81 << 7);
                xOffs += font->width - font->xBase;
            }
        } else {
            xOffs += 4;
        }
    }

    if (proc->u44 < 0xff)
        proc->u44++;
}



void Make6C_ReclassMenuSelect(struct ProcReclassSel* proc) {
    struct ProcPromoMain *parent = proc->proc_parent;
    struct ProcPromoHandler *grandparent;
    struct Unit *unit;
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
    sub_80CD47C(0, -1, 0xfb * 2, 0x58, 6);
    ClassChgLoadUI();
    sub_80CD408(proc->u50, 0x8c * 2, 0x68);

    proc->sprite[0] = 0;
    proc->sprite[1] = 0;
    proc->sprite[2] = 0;

    for (i = 1; i < 0x40; i++) {
        //u16 classFromSwitch;

        u16 weapon;
        s32 j;
        unit = GetUnit(i);

        if (!UNIT_IS_VALID(unit))
            continue;

        if (unit->pCharacterData->number !=  proc->pid)
            continue;

        pid = unit->pClassData->number;
        weapon = GetUnitEquippedWeapon(unit);

        for (j = 0; j < 2; j++) {
            proc->jid[j] = gPromoJidLut[pid][j];
            proc->use_wpn[j] = LoadClassBattleSprite((void*)&proc->sprite[j], gPromoJidLut[pid][j], weapon);
            proc->msg_desc[j] = GetClassData(gPromoJidLut[pid][j])->descTextId;
        }

        proc->weapon = weapon;

        if (Check3rdTraineeEnabled()) {
            pid = unit->pClassData->number;
            switch (pid) {
            case CLASS_JOURNEYMAN:
                proc->jid[2] = CLASS_JOURNEYMAN_T1;
                proc->use_wpn[2] = LoadClassBattleSprite((void*)&proc->sprite[2], CLASS_JOURNEYMAN_T1, weapon);
                proc->msg_desc[2] = GetClassData(CLASS_JOURNEYMAN_T1)->descTextId;
                break;

            case CLASS_PUPIL:
                proc->jid[2] = CLASS_PUPIL_T1;
                proc->use_wpn[2] = LoadClassBattleSprite((void*)&proc->sprite[2], CLASS_PUPIL_T1, weapon);
                proc->msg_desc[2] = GetClassData(CLASS_PUPIL_T1)->descTextId;
                break;

            case CLASS_RECRUIT:
                proc->jid[2] = CLASS_RECRUIT_T1;
                proc->use_wpn[2] = LoadClassBattleSprite((void*)&proc->sprite[2], CLASS_RECRUIT_T1, weapon);
                proc->msg_desc[2] = GetClassData(CLASS_RECRUIT_T1)->descTextId;
                break;
            }
        }
        break;
    }

    if (proc->sprite[0] == 0 && proc->sprite[1] == 0) {
        proc->sprite[1] = 0;
        proc->sprite[0] = 0;
    }

    proc->stat = 1;
    proc->main_select = 0;
    LoadClassReelFontPalette((void*)proc, pid);
    LoadClassNameInClassReelFont2(proc);
    LoadObjUIGfx();

    proc->menu_proc = ReclassMenuSelect(proc);

    grandparent = parent->proc_parent;
    if (grandparent->bmtype == PROMO_HANDLER_TYPE_BM) {
        RestartMuralBackground();
        BG_EnableSyncByMask(0xf);
    }
}

void LoadBattleSpritesForBranchScreen2(struct ProcReclassSel *proc) {
    u32 a;
    u8 b;
    struct ProcReclassSel *p2;
    struct ProcReclassSel *c2;
    struct Anim *anim1;
    struct Anim *anim2;
    struct Unit copied_unit;
    void *tmp;
    u16 chara_pal;
    anim1 = gUnknown_030053A0.anim1;
    anim2 = gUnknown_030053A0.anim2;

    p2 = (void *)gUnknown_0201FADC.proc14;
    c2 = (void *)gUnknown_0201FADC.proc18;

    a = proc->stat;
    tmp = &gUnknown_030053A0;

    if (a == 1) {
        u16 _pid, _jid;
        s16 i;
        struct Unit *unit;
        const struct BattleAnimDef * battle_anim_ptr;
        u32 battle_anim_id;
        u16 ret;
        if ((s16) p2->sprite[0] <= 0x117) {
            p2->sprite[0] += 12;
            c2->sprite[0] += 12;
            anim1->xPosition += 12;
            anim2->xPosition = anim1->xPosition;
        } else {
            proc->stat = 2;
        }

        if (proc->stat == 2) {
            EndEfxAnimeDrvProc();
            sub_805AA28(&gUnknown_030053A0);
            _pid = proc->pid - 1;
            _jid = proc->jid[proc->main_select];
            chara_pal = -1;
            unit = GetUnitFromCharId(proc->pid);
            copied_unit = *unit;
            copied_unit.pClassData = GetClassData(proc->jid[proc->main_select]);
            battle_anim_ptr = copied_unit.pClassData->pBattleAnimDef;
            ret = GetBattleAnimationId(
                &copied_unit,
                battle_anim_ptr,
                (u16) GetUnitEquippedWeapon(&copied_unit),
                &battle_anim_id);
            for (i = 0; i <= 6; i++) {
                if (gAnimCharaPalConfig[(s16)_pid][i] == (s16) _jid) {
                    chara_pal = gAnimCharaPalIt[(s16)_pid][i] - 1;
                    break;
                }
            }
            sub_80CD47C((s16) ret, (s16) chara_pal, (s16) (p2->sprite[0] + 0x28), 0x58, 6);
            sub_805AE14(&gUnknown_0201FADC);
            sub_80CD408(proc->u50, p2->sprite[0], p2->msg_desc[1]);
        } else {
            goto D1AC;
        }
    }
    ++proc; --proc;
    b = proc->stat;
    tmp = &gUnknown_030053A0;
    if (b == 2) {
        if ((s16) p2->sprite[0] > 0x82) {
#ifdef NONMATCHING
            u16 off = 12;
#else
            register u16 off asm("r1") = 12;
#endif // NONMATCHING
            p2->sprite[0] -= off;
            c2->sprite[0] -= off;
            anim1->xPosition -= off;
            anim2->xPosition = anim1->xPosition;
        } else {
            proc->stat = 0;
        }
    }
D1AC:
    if ((u8) sub_805A96C(tmp)) {
        sub_805A990(tmp);
    }
    LoadClassNameInClassReelFont2((void*)proc);
    return;
}


const struct ProcCmd ProcScr_ReclassSelect[] = {
    PROC_CALL(StartMidFadeToBlack),
    PROC_REPEAT(WaitForFade),

    PROC_NAME("Reclass"),

PROC_LABEL(PROC_CLASSCHG_SEL_INIT),
    PROC_CALL(Make6C_ReclassMenuSelect),
    PROC_SLEEP(6),
    PROC_CALL(sub_80CCF60),

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
    PROC_CALL(PrepClassChgOnCancel),

PROC_LABEL(PROC_CLASSCHG_SEL_END2),
PROC_LABEL(PROC_CLASSCHG_SEL_END1),
    PROC_END,
};


ProcPtr StartPromoClassSelect(ProcPtr parent)
{
    return Proc_StartBlocking(ProcScr_ReclassSelect, parent);
}

ProcPtr ReclassMenuSelect(ProcPtr parent)
{
	return Proc_Start(ProcScr_ReclassMenuSel, parent);
}


