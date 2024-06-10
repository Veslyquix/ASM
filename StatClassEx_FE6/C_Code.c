#define FE6 
#include "headers/prelude.h"
#include "headers/gbafe.h" 
#include "headers/unit.h"

#define ALIGN(m) __attribute__((aligned (m)))
#define BITPACKED __attribute__((aligned(4), packed))

extern u32 WriteAndVerifySramFast(void const * src, void * dest, u32 size); 
extern void (ReadSramFast)(void const * src, void * dest, u32 size); 
#ifdef FE6 
enum
{
    // flags for GameSavePackedUnit::flags

    SAVEUNIT_FLAG_DEAD       = 1 << 0,
    SAVEUNIT_FLAG_UNDEPLOYED = 1 << 1,
    SAVEUNIT_FLAG_SOLOANIM1  = 1 << 2,
    SAVEUNIT_FLAG_SOLOANIM2  = 1 << 3,
};



struct GameSavePackedUnit // 0x28 
{
    /* 00 */ //u32 pid    : 8;//7;
    /*    */ //u32 jid    : 8;//7;
    /*    */ u32 level  : 7;//5;
    /*    */ u32 flags  : 6;
    /*    */ u32 exp    : 7;
    /* 04 */ u32 x      : 6;
    /*    */ u32 y      : 6;
    /*    */ u32 max_hp : 7; //6;
    /*    */ u32 pow    : 6; //5;
    /*    */ u32 skl    : 6; //5;
    /*    */ u32 spd    : 6; //5;
    /*    */ u32 def    : 6; //5;
    /*    */ u32 res    : 6; //5;
    /*    */ u32 lck    : 6; //5;
    /*    */ u32 con    : 5; //5;
    /*    */ u32 mov    : 5; //5;
    /*    */ u32 item_a : 14;
    /*    */ u32 item_b : 14;
    /*    */ u32 item_c : 14; // 127 bits after this line 
    /*    */ u32 item_d : 14;
    /*    */ u32 item_e : 14;
			 u32 pid : 8; // 11 bits more than before, but 2 bytes were unused 
			 u32 jid : 8; 
			 
    /* 16 */ u8 wexp[UNIT_WEAPON_EXP_COUNT];
    /* 1E */ u8 supports[UNIT_SUPPORT_COUNT];
} BITPACKED;

struct SuspendSavePackedUnit // 0x34 
{
    /* 00 */ u8 pid;
    /* 01 */ u8 jid;
    /* 02 */ u8 ai_a;
    /* 03 */ u8 rescue;
    /* 04 */ u32 flags : 16;
    /* 06 */ u32 item_a : 14; // -10 bits, then +9 bits 
	
	u32 item_b : 14; 
	u32 item_c : 14; 
	u32 max_hp : 7; 
	u32 hp : 7; 
	u32 exp : 7; 
	u32 ai_flags : 8; 
    /* 08 */ //u16 item_b;
    /* 0A */ //u16 item_c;
    /* 0C */ //u8 max_hp;
    /* 0D */ //u8 hp;
    /* 0E */ //u8 exp;
    /* 0F */ //u8 ai_flags;
    /* 28 */ u32 level           : 7; //5;
    /*    */ u32 x               : 6;
    /*    */ u32 y               : 6;
    /*    */ u32 pow             : 6; //5;
    /*    */ u32 skl             : 6; //5;
    /*    */ u32 spd             : 6; //5;
    /* 2C */ u32 def             : 6; //5;
    /*    */ u32 res             : 6; //5;
    /*    */ u32 lck             : 6; //5;
    /*    */ u32 bonus_con       : 5; //5;
    /*    */ u32 status          : 3;
    /*    */ u32 status_duration : 3;
    /*    */ u32 torch           : 3;
    /*    */ u32 barrier         : 3;
    /* 30 */ u32 bonus_mov       : 4;
    /*    */ u32 item_d          : 14;
    /*    */ u32 item_e          : 14;
    /* 22 */ u32 ai_a_pc : 8;
    /* 23 */ u32 ai_b : 8;
    /* 24 */ u32 ai_config : 16;
    /* 26 */ u32 ai_b_pc : 8;
    /* 27 */ u32 ai_counter : 8;
    /* 10 */ u8 wexp[UNIT_WEAPON_EXP_COUNT];
    /* 18 */ u8 supports[UNIT_SUPPORT_COUNT];

} BITPACKED;

void WriteGameSavePackedUnit(struct Unit * unit, void * sram_dst)
{
    struct GameSavePackedUnit save_unit;
    struct Unit unit_tmp;
    int i;

    if (unit->pinfo == NULL)
    {
        unit = &unit_tmp;
        ClearUnit(unit);
        save_unit.pid = 0;
        save_unit.jid = 0;
    }
    else
    {
        save_unit.pid = unit->pinfo->id;
        save_unit.jid = unit->jinfo->id;
    }

    save_unit.level = (unit->level < 128) ? unit->level : 127;
    save_unit.exp = unit->exp;
    save_unit.x = unit->x;
    save_unit.y = unit->y;
    save_unit.max_hp = (unit->max_hp < 128) ? unit->max_hp : 127;
    save_unit.pow = (unit->pow < 64) ? unit->pow : 63;
    save_unit.skl = (unit->skl < 64) ? unit->skl : 63;
    save_unit.spd = (unit->spd < 64) ? unit->spd : 63;
    save_unit.def = (unit->def < 64) ? unit->def : 63;
    save_unit.res = (unit->res < 64) ? unit->res : 63;
    save_unit.lck = (unit->lck < 64) ? unit->lck : 63;
    save_unit.con = unit->bonus_con;
    save_unit.mov = unit->bonus_mov;

    save_unit.item_a = unit->items[0];
    save_unit.item_b = unit->items[1];
    save_unit.item_c = unit->items[2];
    save_unit.item_d = unit->items[3];
    save_unit.item_e = unit->items[4];

    save_unit.flags = 0;

    if (UNIT_FLAG_DEAD & unit->flags)
        save_unit.flags |= SAVEUNIT_FLAG_DEAD;

    if (UNIT_FLAG_NOT_DEPLOYED & unit->flags)
        save_unit.flags |= SAVEUNIT_FLAG_UNDEPLOYED;

    if (UNIT_FLAG_SOLOANIM_1 & unit->flags)
        save_unit.flags |= SAVEUNIT_FLAG_SOLOANIM1;

    if (UNIT_FLAG_SOLOANIM_2 & unit->flags)
        save_unit.flags |= SAVEUNIT_FLAG_SOLOANIM2;

    for (i = 0; i < UNIT_WEAPON_EXP_COUNT; i++)
        save_unit.wexp[i] = unit->wexp[i];

    for (i = 0; i < UNIT_SUPPORT_COUNT; i++)
        save_unit.supports[i] = unit->supports[i];

    WriteAndVerifySramFast(&save_unit, sram_dst, sizeof(struct GameSavePackedUnit));
}

void ReadGameSavePackedUnit(void const * sram_src, struct Unit * unit)
{
    int i;
    struct GameSavePackedUnit save_unit;

    ReadSramFast(sram_src, &save_unit, sizeof(struct GameSavePackedUnit));

	
    unit->pinfo = GetPInfo(save_unit.pid);
    unit->jinfo = GetJInfo(save_unit.jid);
	if (!save_unit.pid) { unit->pinfo = NULL; } 
	if (!save_unit.jid) { unit->jinfo = NULL; } 

    unit->level = save_unit.level;
    unit->exp = save_unit.exp;
    unit->x = save_unit.x;
    unit->y = save_unit.y;
    unit->max_hp = save_unit.max_hp;
    unit->pow = save_unit.pow;
    unit->skl = save_unit.skl;
    unit->spd = save_unit.spd;
    unit->def = save_unit.def;
    unit->res = save_unit.res;
    unit->lck = save_unit.lck;
    unit->bonus_con = save_unit.con;
    unit->bonus_mov = save_unit.mov;

    unit->items[0] = save_unit.item_a;
    unit->items[1] = save_unit.item_b;
    unit->items[2] = save_unit.item_c;
    unit->items[3] = save_unit.item_d;
    unit->items[4] = save_unit.item_e;

    if (unit->exp > 99)
        unit->exp = -1;

    unit->flags = 0;

    if (save_unit.flags & SAVEUNIT_FLAG_DEAD)
        unit->flags |= UNIT_FLAG_DEAD | UNIT_FLAG_HIDDEN;

    if (save_unit.flags & SAVEUNIT_FLAG_UNDEPLOYED)
        unit->flags |= UNIT_FLAG_NOT_DEPLOYED | UNIT_FLAG_HIDDEN;

    if (save_unit.flags & SAVEUNIT_FLAG_SOLOANIM1)
        unit->flags |= UNIT_FLAG_SOLOANIM_1;

    if (save_unit.flags & SAVEUNIT_FLAG_SOLOANIM2)
        unit->flags |= UNIT_FLAG_SOLOANIM_2;

    for (i = 0; i < UNIT_WEAPON_EXP_COUNT; i++)
        unit->wexp[i] = save_unit.wexp[i];

    for (i = 0; i < UNIT_SUPPORT_COUNT; i++)
        unit->supports[i] = save_unit.supports[i];

    SetUnitHp(unit, GetUnitMaxHp(unit));

    if (unit->exp == 0x7F)
        unit->exp = -1;

    if (unit->x == 0x3F)
        unit->x = -1;

    if (unit->y == 0x3F)
        unit->y = -1;
}

void EncodeSuspendSavePackedUnit(struct Unit * unit, void * buf)
{
    int i;
    struct SuspendSavePackedUnit * suspend_unit = (struct SuspendSavePackedUnit *)buf;

    if (unit->pinfo == NULL)
    {
        suspend_unit->pid = 0;
        return;
    }

    suspend_unit->pid = unit->pinfo->id;
    suspend_unit->jid = unit->jinfo->id;
    suspend_unit->level = (unit->level < 128) ? unit->level : 127;
    suspend_unit->exp = unit->exp;
    suspend_unit->flags = unit->flags;
    suspend_unit->x = unit->x;
    suspend_unit->y = unit->y;
    suspend_unit->max_hp = (unit->max_hp < 128) ? unit->max_hp : 127;
    suspend_unit->hp = (unit->hp < 128) ? unit->hp : 127;
    suspend_unit->pow = (unit->pow < 64) ? unit->pow : 63;
    suspend_unit->skl = (unit->skl < 64) ? unit->skl : 63;
    suspend_unit->spd = (unit->spd < 64) ? unit->spd : 63;
    suspend_unit->def = (unit->def < 64) ? unit->def : 63;
    suspend_unit->res = (unit->res < 64) ? unit->res : 63;
    suspend_unit->lck = (unit->lck < 64) ? unit->lck : 63;
    suspend_unit->bonus_con = unit->bonus_con;
    suspend_unit->status = unit->status;
    suspend_unit->status_duration = unit->status_duration;
    suspend_unit->torch = unit->torch;
    suspend_unit->barrier = unit->barrier;
    suspend_unit->rescue = unit->rescue;
    suspend_unit->bonus_mov = unit->bonus_mov;
    suspend_unit->item_a = unit->items[0];
    suspend_unit->item_b = unit->items[1];
    suspend_unit->item_c = unit->items[2];
    suspend_unit->item_d = unit->items[3];
    suspend_unit->item_e = unit->items[4];

    for (i = 0; i < UNIT_WEAPON_EXP_COUNT; i++)
        suspend_unit->wexp[i] = unit->wexp[i];

    for (i = 0; i < UNIT_SUPPORT_COUNT; i++)
        suspend_unit->supports[i] = unit->supports[i];

    suspend_unit->ai_a = unit->ai_a;
    suspend_unit->ai_a_pc = unit->ai_a_pc;
    suspend_unit->ai_b = unit->ai_b;
    suspend_unit->ai_b_pc = unit->ai_b_pc;
    suspend_unit->ai_config = unit->ai_config;
    suspend_unit->ai_counter = unit->ai_counter;
    suspend_unit->ai_flags = unit->ai_flags;
}

void ReadSuspendSavePackedUnit(void const * sram_src, struct Unit * unit)
{
    struct SuspendSavePackedUnit suspend_unit;
    int i;

    ReadSramFast(sram_src, &suspend_unit, sizeof(struct SuspendSavePackedUnit));

    unit->pinfo = GetPInfo(suspend_unit.pid);
    unit->jinfo = GetJInfo(suspend_unit.jid);

    unit->level = suspend_unit.level;
    unit->exp = suspend_unit.exp;
    unit->flags =suspend_unit.flags;
    unit->x = suspend_unit.x;
    unit->y = suspend_unit.y;
    unit->max_hp = suspend_unit.max_hp;
    unit->hp = suspend_unit.hp;
    unit->pow = suspend_unit.pow;
    unit->skl = suspend_unit.skl;
    unit->spd = suspend_unit.spd;
    unit->def = suspend_unit.def;
    unit->res = suspend_unit.res;
    unit->lck = suspend_unit.lck;
    unit->bonus_con = suspend_unit.bonus_con;
    unit->status = suspend_unit.status;
    unit->status_duration = suspend_unit.status_duration;
    unit->torch = suspend_unit.torch;
    unit->barrier = suspend_unit.barrier;
    unit->rescue = suspend_unit.rescue;
    unit->bonus_mov = suspend_unit.bonus_mov;
    unit->items[0] = suspend_unit.item_a;
    unit->items[1] = suspend_unit.item_b;
    unit->items[2] = suspend_unit.item_c;
    unit->items[3] = suspend_unit.item_d;
    unit->items[4] = suspend_unit.item_e;

    for (i = 0; i < UNIT_WEAPON_EXP_COUNT; i++)
        unit->wexp[i] = suspend_unit.wexp[i];

    for (i = 0; i < UNIT_SUPPORT_COUNT; i++)
        unit->supports[i] = suspend_unit.supports[i];

    unit->ai_a = suspend_unit.ai_a;
    unit->ai_a_pc = suspend_unit.ai_a_pc;
    unit->ai_b = suspend_unit.ai_b;
    unit->ai_b_pc = suspend_unit.ai_b_pc;
    unit->ai_config = suspend_unit.ai_config;
    unit->ai_counter = suspend_unit.ai_counter;
    unit->ai_flags = suspend_unit.ai_flags;

    if (unit->exp == 0x7F)
        unit->exp = -1;

    if (unit->x == 0x3F)
        unit->x = -1;

    if (unit->y == 0x3F)
        unit->y = -1;
}



#endif 












