#pragma once

#include "global.h"
#include "proc.h"

struct EkrDragonStatus {

    /* 00 */ u8 type;
    /* 01 */ u8 unk01;
    /* 02 */ u16 attr;
    /* 04 */ ProcPtr proc;
    /* 08 */ u32 unk08;
    /* 0C */ struct Anim *anim;
};

enum dragonstatus_type {
    EKRDRGON_TYPE_NORMAL = 0,
    EKRDRGON_TYPE_DRACO_ZOMBIE,
    EKRDRGON_TYPE_DEMON_KING,
    EKRDRGON_TYPE_MYRRH
};

enum dragonstatue_attr {
    EKRDRGON_ATTR_START = 1 << 0,
    EKRDRGON_ATTR_BANIMFX_PREPARED = 1 << 1,
    EKRDRGON_ATTR_BANIMFINISH = 1 << 2,
    EKRDRGON_ATTR_END = 1 << 3,
    EKRDRGON_ATTR_B12 = 1 << 12,
    EKRDRGON_ATTR_B13 = 1 << 13,
};

extern struct EkrDragonStatus gEkrDragonStatusLeft, gEkrDragonStatusRight;

struct ProcEkrDragon {
    PROC_HEADER;

    /* 29 */ u8 _pad_29[0x2C - 0x29];

    /* 2C */ s16 timer;
    /* 2E */ s16 tcounter;

    /* 30 */ u8 _pad_30[0x50 - 0x30];

    /* 50 */ ProcPtr fxproc;

    /* 54 */ u8 _pad_54[0x5C - 0x54];

    /* 5C */ struct Anim *anim;
};

struct EkrDracoZombiTsaSet {
    /* 00 */ u16 *tsa;
    /* 04 */ u8 time;
    /* 05 */ s8 lox;
    /* 06 */ u8 loy;
    /* 07 */ u8 type;
};

extern struct EkrDracoZombiTsaSet gEkrDracoZombiTsaSetLut[15];

struct ProcEfxDKfx {
    PROC_HEADER;

    /* 29 */ u8 finished;
    /* 2A */ s16 unk2A;
    /* 2C */ s16 timer;
    /* 2E */ s16 unk2E;
    /* 30 */ s16 unk30;
    /* 32 */ s16 unk32;

    /* 34 */ STRUCT_PAD(0x34, 0x3A);

    /* 3A */ u16 unk3A;

    /* 3C */ STRUCT_PAD(0x3C, 0x44);

    /* 44 */ u32 frame;
    /* 48 */ const s16 *frame_lut;
    /* 4C */ u16 **tsa_set;
    /* 50 */ u32 unk50;
    /* 54 */ u32 round_cur;
    /* 58 */ u32 unk58;
    /* 5C */ struct Anim *anim;
    /* 60 */ struct Anim *anim2;
};

struct EkrDragonQuakePriv {
    /* 00 */ u8 _pad_00[0x32 - 0x00];
    /* 32 */ u16 unk32;
    /* 34 */ u8 _pad_34[0x3A - 0x34];
    /* 3A */ u16 unk3A;
};

struct ProcEkrDragonQuake {
    PROC_HEADER;

    /* 29 */ s8 unk29;
    /* 2A */ s8 unk2A;
    /* 2C */ s16 unk2C;
    /* 2E */ s16 unk2E;

    /* 30 */ u8 _pad_30[0x5C - 0x30];

    /* 5C */ struct EkrDragonQuakePriv *priv;
    /* 60 */ ProcPtr subproc;
};

struct ProcEfxDKBody1 {
    PROC_HEADER;

    /* 29 */ u8 _pad_29[0x4C - 0x29];

    /* 4C */ struct ProcEfxDKfx *fxproc;
    /* 50 */ u32 unk50;
    /* 54 */ int timer;
    /* 58 */ u32 xPos;
    /* 5C */ u32 yPos;
    /* 60 */ u32 unk60;
    /* 64 */ s16 unk64;
};

struct ProcEfxDKBody4 {
    PROC_HEADER;

    /* 29 */ u8 _pad_29[0x44 - 0x29];

    /* 44 */ int round_type;

    /* 48 */ u8 _pad_48[0x5C -0x48];

    /* 5C */ struct Anim *anim;
};

struct ProcEkrDragonTunkFace;

struct ProcEkrDragonTunk {
    PROC_HEADER;
    /* 29 */ u8 finished;
    STRUCT_PAD(0x2A, 0x2C);
    /* 2C */ s16 timer1;
    /* 2E */ s16 unk2E;
    /* 30 */ s16 timer2;
    /* 32 */ s16 unk32;
    STRUCT_PAD(0x34, 0x3A);
    /* 3A */ s16 unk3A;
    /* 3C */ s16 unk3C;
    STRUCT_PAD(0x3E, 0x54);
    /* 54 */ struct EkrDragonQuakePriv *qproc;
    /* 58 */ u32 unk58;
    /* 5C */ struct Anim *anim;
    /* 60 */ void *unk60;
    /* 64 */ struct ProcEkrDragonTunkFace *fproc;
};

struct ProcEkrDragonTunkFace {
    PROC_HEADER;
    STRUCT_PAD(0x29, 0x32);
    /* 32 */ s16 xPos;
    STRUCT_PAD(0x34, 0x3A);
    /* 3A */ s16 yPos;
    STRUCT_PAD(0x3C, 0x5C);
    /* 5C */ struct Anim *anim;
};

struct ProcEkrWhiteOUT {
    PROC_HEADER;
    STRUCT_PAD(0x29, 0x2C);
    /* 2C */ s16 timer;
    STRUCT_PAD(0x2E, 0x44);
    /* 44 */ int max_time1;
    /* 48 */ int max_time2;
    /* 4C */ int max_time3;
};

struct Proc08801800 {
    PROC_HEADER;
    STRUCT_PAD(0x29, 0x58);
    /* 58 */ int timer;
};

struct Proc08801810 {
    PROC_HEADER;
    STRUCT_PAD(0x29, 0x58);
    int timer1;
    int timer2;
};

struct Proc08801840 {
    PROC_HEADER;
    STRUCT_PAD(0x29, 0x58);
    int timer;
    STRUCT_PAD(0x5C, 0x64);
    s16 ref;
};

struct ProcSelfThunderBG {
    PROC_HEADER;
    STRUCT_PAD(0x29, 0x2C);
    s16 timer;
    STRUCT_PAD(0x2E, 0x44);
    int frame;
    STRUCT_PAD(0x48, 0x5C);
    struct Anim *anim;
};

struct EfxSelfThunderBGFrame {
    int duration;
    u16 *img;
    u16 *tsa1;
    u16 *tsa2;
    u16 *pal;
};

extern CONST_DATA struct EfxSelfThunderBGFrame gEfxSelfThunderBGFrames[];

// extern ??? gEkrDragonStatusLeft
// extern ??? gEkrDragonStatusRight
extern u16 gEkrDragonPalBackup[0x40 / sizeof(u16)];
extern u16 gEkrSomePalBuf[0x20];

extern u16 Img_EfxDracoZombie[];
extern u16 Tsa_EfxDracoZombieBaseLeft[];
extern u16 Tsa_EfxDracoZombieBaseRight[];
extern u16 Tsa_EfxDracoZombie1[];
extern u16 Tsa_EfxDracoZombie2[];
extern u16 Tsa_EfxDracoZombie3[];
extern u16 Tsa_EfxDracoZombie4[];
extern u16 Tsa_EfxDracoZombie5[];
extern u16 Pal_EfxDracoZombie[];
extern u16 Pal_08791D7C[];
extern u16 Img_08791D9C[];
extern u16 Pal_08792194[];
extern u32 BanimScr_08792928[];
extern u32 BanimScr_08792958[];
extern u32 BanimScr_08792988[];
extern u16 Img_DemonLightSprites_EyeFlash[];
extern u16 Pal_DemonLightSprites_EyeFlash[];
extern u32 gUnknown_087A5240[];
extern u32 gUnknown_087A536C[];
extern u16 Img_DemonLightSprites[];
extern u16 Pal_DemonLightSprites[];
extern u32 gUnknown_087A5940[];
extern u32 gUnknown_087A5958[];
extern u32 gUnknown_087A5970[];
extern u32 gUnknown_087A5B5C[];
extern u32 gUnknown_087A5B74[];
extern u32 gUnknown_087A5B8C[];
extern u16 Img_DemonLightSprites_087A5BA4[];
extern u16 Img_DemonLightSprites_087A5E9C[];
extern u16 Pal_DemonLightSprites_087A61EC[];
extern u32 gUnknown_087A6674[];
extern u32 gUnknown_087A6AEC[];
extern u32 gUnknown_087A6F64[];
extern u32 gUnknown_087A73E0[];
extern u16 Img_087A73F4[];
extern u16 Img_087A7F38[];
extern u16 Img_087A8A74[];
extern u16 Img_087A9598[];
extern u16 Img_087AA02C[];
extern u16 Img_087AAAA8[];
extern u16 Img_087AB558[];
extern u16 Img_087ABFF0[];
extern u16 Img_087ACAC8[];
extern u16 Img_087AD54C[];
extern u16 Img_087ADFEC[];
extern u16 Img_087AEA74[];
extern u16 Img_087AF518[];
extern u16 Img_087B0070[];
extern u16 Img_087B0C00[];
extern u16 Img_087B1728[];
extern u16 Pal_087B2230[];
extern u16 Pal_087B2250[];
extern u16 Pal_087B2270[];
extern u16 Pal_087B2290[];
extern u16 Pal_087B22B0[];
extern u16 Pal_087B22D0[];
extern u16 Pal_087B22F0[];
extern u16 Pal_087B2310[];
extern u16 Pal_087B2330[];
extern u16 Pal_087B2350[];
extern u16 Pal_087B2370[];
extern u16 Pal_087B2390[];
extern u16 Pal_087B23B0[];
extern u16 Pal_087B23D0[];
extern u16 Pal_087B23F0[];
extern u16 Pal_087B2410[];
extern u16 Tsa_087B2430[];
extern u16 Tsa_087B26A4[];
extern u16 Tsa_087B291C[];
extern u16 Tsa_087B2B90[];
extern u16 Tsa_087B2E04[];
extern u16 Tsa_087B307C[];
extern u16 Tsa_087B32F0[];
extern u16 Tsa_087B3568[];
extern u16 Tsa_087B37DC[];
extern u16 Tsa_087B3A54[];
extern u16 Tsa_087B3CC8[];
extern u16 Tsa_087B3F40[];
extern u16 Tsa_087B41B4[];
extern u16 Tsa_087B4428[];
extern u16 Tsa_087B46A0[];
extern u16 Tsa_087B4914[];
extern u16 Img_087B4B88[];
extern u16 Img_087B5678[];
extern u16 Img_087B6198[];
extern u16 Img_087B6D54[];
extern u16 Img_087B7AEC[];
extern u16 Img_087B8968[];
extern u16 Img_087B98FC[];
extern u16 Img_087BA910[];
extern u16 Img_087BBAA4[];
extern u16 Img_087BCCD8[];
extern u16 Img_087BDF0C[];
extern u16 Img_087BF05C[];
extern u16 Img_087BFEF4[];
extern u16 Img_087C0A18[];
extern u16 Img_087C15E4[];
extern u16 Img_087C2308[];
extern u16 Pal_087C2D34[];
extern u16 Pal_087C2D54[];
extern u16 Pal_087C2D74[];
extern u16 Pal_087C2D94[];
extern u16 Pal_087C2DB4[];
extern u16 Pal_087C2DD4[];
extern u16 Pal_087C2DF4[];
extern u16 Pal_087C2E14[];
extern u16 Pal_087C2E34[];
extern u16 Pal_087C2E54[];
extern u16 Pal_087C2E74[];
extern u16 Pal_087C2E94[];
extern u16 Pal_087C2EB4[];
extern u16 Pal_087C2ED4[];
extern u16 Pal_087C2EF4[];
extern u16 Pal_087C2F14[];
extern u16 Tsa_087C2F34[];
extern u16 Tsa_087C31A4[];
extern u16 Tsa_087C341C[];
extern u16 Tsa_087C3694[];
extern u16 Tsa_087C38F0[];
extern u16 Tsa_087C3B38[];
extern u16 Tsa_087C3D74[];
extern u16 Tsa_087C3FA8[];
extern u16 Tsa_087C41E0[];
extern u16 Tsa_087C4420[];
extern u16 Tsa_087C4660[];
extern u16 Tsa_087C48AC[];
extern u16 Tsa_087C4AF0[];
extern u16 Tsa_087C4CA0[];
extern u16 Tsa_087C4E64[];
extern u16 Tsa_087C5034[];
extern u16 Img_087C5190[];
extern u16 Img_087C56E4[];
extern u16 Img_087C619C[];
extern u16 Img_087C6CF4[];
extern u16 Img_087C7678[];
extern u16 Img_087C810C[];
extern u16 Img_087C86BC[];
extern u16 Img_087C8C80[];
extern u16 Pal_087C9290[];
extern u16 Pal_087C92B0[];
extern u16 Pal_087C92D0[];
extern u16 Pal_087C92F0[];
extern u16 Pal_087C9310[];
extern u16 Pal_087C9330[];
extern u16 Pal_087C9350[];
extern u16 Pal_087C9370[];
extern u16 Tsa_087C9390[];
extern u16 Tsa_087C9464[];
extern u16 Tsa_087C9600[];
extern u16 Tsa_087C9818[];
extern u16 Tsa_087C9A2C[];
extern u16 Tsa_087C9BEC[];
extern u16 Tsa_087C9CF4[];
extern u16 Tsa_087C9E04[];
extern u16 Img_087C9F18[];
extern u16 Img_087CA68C[];
extern u16 Img_087CAE60[];
extern u16 Img_087CB630[];
extern u16 Img_087CBDF4[];
extern u16 Pal_087CC55C[];
extern u16 Pal_087CC57C[];
extern u16 Pal_087CC59C[];
extern u16 Pal_087CC5BC[];
extern u16 Pal_087CC5DC[];
extern u16 Tsa_087CC5FC[];
extern u16 Tsa_087CC734[];
extern u16 Tsa_087CC878[];
extern u16 Tsa_087CC9B8[];
extern u16 Tsa_087CCAD8[];
extern u16 Img_087CCBF8[];
extern u16 Img_087CD738[];
extern u16 Img_087CE274[];
extern u16 Img_087CED98[];
extern u16 Img_087CF824[];
extern u16 Img_087D0298[];
extern u16 Img_087D0D3C[];
extern u16 Img_087D17C0[];
extern u16 Img_087D2294[];
extern u16 Img_087D2D18[];
extern u16 Img_087D37B8[];
extern u16 Img_087D4238[];
extern u16 Img_087D4CE4[];
extern u16 Img_087D5834[];
extern u16 Img_087D63BC[];
extern u16 Img_087D6EE4[];
extern u16 Pal_087D79E8[];
extern u16 Pal_087D7A08[];
extern u16 Pal_087D7A28[];
extern u16 Pal_087D7A48[];
extern u16 Pal_087D7A68[];
extern u16 Pal_087D7A88[];
extern u16 Pal_087D7AA8[];
extern u16 Pal_087D7AC8[];
extern u16 Pal_087D7AE8[];
extern u16 Pal_087D7B08[];
extern u16 Pal_087D7B28[];
extern u16 Pal_087D7B48[];
extern u16 Pal_087D7B68[];
extern u16 Pal_087D7B88[];
extern u16 Pal_087D7BA8[];
extern u16 Pal_087D7BC8[];
extern u16 Tsa_087D7BE8[];
extern u16 Tsa_087D7E5C[];
extern u16 Tsa_087D80D4[];
extern u16 Tsa_087D8348[];
extern u16 Tsa_087D85BC[];
extern u16 Tsa_087D8834[];
extern u16 Tsa_087D8AA8[];
extern u16 Tsa_087D8D20[];
extern u16 Tsa_087D8F94[];
extern u16 Tsa_087D920C[];
extern u16 Tsa_087D9480[];
extern u16 Tsa_087D96F8[];
extern u16 Tsa_087D996C[];
extern u16 Tsa_087D9BE0[];
extern u16 Tsa_087D9E58[];
extern u16 Tsa_087DA0CC[];
extern u16 Img_087DA340[];
extern u16 Img_087DAE40[];
extern u16 Img_087DB960[];
extern u16 Img_087DC518[];
extern u16 Img_087DD288[];
extern u16 Img_087DE0C8[];
extern u16 Img_087DF030[];
extern u16 Img_087E002C[];
extern u16 Img_087E1190[];
extern u16 Img_087E238C[];
extern u16 Img_087E358C[];
extern u16 Img_087E466C[];
extern u16 Img_087E54B4[];
extern u16 Img_087E5FD4[];
extern u16 Img_087E6B90[];
extern u16 Img_087E78A0[];
extern u16 Pal_087E82CC[];
extern u16 Pal_087E82EC[];
extern u16 Pal_087E830C[];
extern u16 Pal_087E832C[];
extern u16 Pal_087E834C[];
extern u16 Pal_087E836C[];
extern u16 Pal_087E838C[];
extern u16 Pal_087E83AC[];
extern u16 Pal_087E83CC[];
extern u16 Pal_087E83EC[];
extern u16 Pal_087E840C[];
extern u16 Pal_087E842C[];
extern u16 Pal_087E844C[];
extern u16 Pal_087E846C[];
extern u16 Pal_087E848C[];
extern u16 Pal_087E84AC[];
extern u16 Tsa_087E84CC[];
extern u16 Tsa_087E873C[];
extern u16 Tsa_087E89B4[];
extern u16 Tsa_087E8C2C[];
extern u16 Tsa_087E8E88[];
extern u16 Tsa_087E90D0[];
extern u16 Tsa_087E9314[];
extern u16 Tsa_087E9554[];
extern u16 Tsa_087E9798[];
extern u16 Tsa_087E99E0[];
extern u16 Tsa_087E9C28[];
extern u16 Tsa_087E9E78[];
extern u16 Tsa_087EA0C0[];
extern u16 Tsa_087EA268[];
extern u16 Tsa_087EA41C[];
extern u16 Tsa_087EA5D0[];
extern u16 Img_087EA72C[];
extern u16 Img_087EAC80[];
extern u16 Img_087EB704[];
extern u16 Img_087EC054[];
extern u16 Img_087EC944[];
extern u16 Img_087ED2B0[];
extern u16 Img_087ED828[];
extern u16 Img_087EDDC0[];
extern u16 Pal_087EE3A0[];
extern u16 Pal_087EE3C0[];
extern u16 Pal_087EE3E0[];
extern u16 Pal_087EE400[];
extern u16 Pal_087EE420[];
extern u16 Pal_087EE440[];
extern u16 Pal_087EE460[];
extern u16 Pal_087EE480[];
extern u16 Tsa_087EE4A0[];
extern u16 Tsa_087EE578[];
extern u16 Tsa_087EE710[];
extern u16 Tsa_087EE8F8[];
extern u16 Tsa_087EEAF4[];
extern u16 Tsa_087EECA8[];
extern u16 Tsa_087EEDAC[];
extern u16 Tsa_087EEEB0[];
extern u16 Img_087EEFBC[];
extern u16 Img_087EF730[];
extern u16 Img_087EFF04[];
extern u16 Img_087F06D4[];
extern u16 Img_087F0E98[];
extern u16 Pal_087F1600[];
extern u16 Pal_087F1620[];
extern u16 Pal_087F1640[];
extern u16 Pal_087F1660[];
extern u16 Pal_087F1680[];
extern u16 Tsa_087F16A0[];
extern u16 Tsa_087F17D8[];
extern u16 Tsa_087F191C[];
extern u16 Tsa_087F1A54[];
extern u16 Tsa_087F1B74[];
extern u16 Img_087F1C94[];
extern u16 Img_087F2464[];
extern u16 Img_087F2E40[];
extern u16 Pal_087F3C14[];
extern u16 Pal_087F3C34[];
extern u16 Pal_087F3C54[];
extern u16 Tsa_087F3C74[];
extern u16 Tsa_087F3D60[];
extern u16 Tsa_087F3E88[];
extern u32 BanimScr_DemoKingTunkFace[];
extern u32 BanimScr_087F4314[];
extern struct ProcCmd ProcScr_EkrDK[];
extern struct ProcCmd ProcScr_ekrDragonBaseHide[];
extern struct ProcCmd ProcScr_ekrDragonBaseAppear[];
extern struct ProcCmd ProcScr_ekrDragonBodyAnime[];
extern u16 *TsaSet_DKBody[];
extern struct ProcCmd ProcScr_EkrDemoKingAtkRavagerCritical[];
extern struct ProcCmd ProcScr_EkrDemoKingAtkRavagerNormal[];
extern struct ProcCmd ProcScr_EkrDemoKingBodyShake[];
extern struct ProcCmd ProcScr_EkrDemoKingAtk[];
extern struct ProcCmd ProcScr_ekrDragonBodvBlack[];
extern struct ProcCmd ProcScr_087F4518[];
extern struct ProcCmd ProcScr_ekrDragonTunkFace[];
extern struct ProcCmd ProcScr_ekrDragonTunk[];
extern struct ProcCmd ProcScr_ekrWhiteOUT[];
extern u16 Tsa_087F45D0[];
extern u16 Img_DemonKingBG[];
extern u16 Tsa_DemonKingBG1[];
extern u16 Tsa_DemonKingBG2[];
extern u16 Tsa_DemonKingBG3[];
extern u16 Pal_DemonKingBG[];
extern u16 Img_DemoKingTunkFace[];
extern u16 Img_DemoKingTunkFace2[];
extern u16 Pal_DemoKingTunkFace[];
extern struct ProcCmd ProcScr_08801810[];
extern struct ProcCmd ProcScr_08801840[];
extern u16 gUnknown_08801858[];
extern u16 gUnknown_08801860[];
extern struct ProcCmd ProcScr_ekrSelfThunder[];
extern struct ProcCmd ProcScr_ekrSelfThunderBG[];
extern s16 *gUnknown_08801AAC[];
extern u8 *gUnknown_08801AB4[];

extern const s16 gUnknown_080E8318[];
extern const s16 BnaimFrames_DkDemonLightNormal[];
extern const s16 BnaimFrames_DkDemonLightCritical[];
extern const s16 BnaimFrames_DkRavagerNormal[];
extern const s16 BnaimFrames_DkRavagerCritical[];
extern const s16 gUnknown_080E838E[];

struct EkrDragonStatus *GetEkrDragonStatus(struct Anim *anim);
u16 GetEkrDragonStatusAttr(struct Anim *anim); /* 1 << 2 seems to be the end of the battle */
void AddEkrDragonStatusAttr(struct Anim *anim, u16 attr_bitfile);
u32 GetEkrDragonStatusType(struct Anim *anim);
// ??? GetEkrDragonStatusType_(???);
void SetEkrDragonStatusType(struct Anim *anim, u8 type);
int GetEkrDragonStatusUnk1(void);
void SetEkrDragonStatusUnk1(int);
void ResetEkrDragonStatus(void);
u32 GetBanimDragonStatusType(void);
// ??? EkrDragonTmCpyHFlip(???);
void EkrDragonTmCpyExt(int, int);
void EkrDragonTmCpyWithDistance(void);
bool CheckEfrDragonStatusAttrPrepared(struct Anim *anim);
bool CheckEfrDragonStatusAttrEnd(struct Anim *anim);
// ??? Fill16_EkrTsaBuffer(???);
// ??? EkrDZ_CustomBgFadeIn(???);
void EfxDracoZombiePrepareTSA(int x, int y, s8 pos);
// ??? EfxDracoZombiePrepareImg(???);
// ??? EkrDZ_MonsterFlyIntoScreen(???);
// ??? EkrDZ_PrepareBanimfx(???);
// ??? EkrDZ_TriggerPreparedFlag(???);
// ??? EkrDZ_IdleInBattle(???);
// ??? EkrDZ_ReloadCustomBg(???);
// ??? EkrDZ_ReloadCustomBgAndFadeOut(???);
// ??? EkrDZ_SetDragonStatAttrEndBit(???);
void NewEkrDragonDracoZombie(struct Anim *anim);
void SetEkrDragonStatusAttrFinished(struct Anim *anim);
void SetEkrDragonStatusAttrBit12(struct Anim *anim);
void SetEkrDragonStatusAttrBit13(struct Anim *anim);
bool CheckEkrDragonDeadEffectMaybe(struct Anim *anim);
bool CheckEkrDragonStatusAttrBit13(struct Anim *anim);
void SetAnimStateHiddenForDragon(void);
void sub_807027C(struct Anim *anim);
u16 *sub_80702D0(void);
// ??? sub_80702FC(???);
// ??? sub_807032C(???);
void sub_807035C(struct Anim *anim);
void NewEkrDragonQuakeTree3(struct EkrDragonQuakePriv *priv, int, int);
void NewEkrDragonQuake(struct EkrDragonQuakePriv *priv, int, int, ProcPtr);
// ??? EkrDragonQuakeMain(???);
// ??? NewEkrWhiteINOUT(???);
// ??? sub_80705A8(???);
// ??? sub_8070618(???);
// ??? sub_8070670(???);
// ??? sub_80706E0(???);
// ??? sub_8070710(???);
// ??? sub_80707C0(???);
// ??? sub_80707FC(???);
void sub_8070874(void);
void sub_80708A0(void);
void NewEkrDragonManakete(struct Anim *anim);
void EkrMyr_PrepareBanimfx(struct ProcEkrDragon * proc);
void EkrMyr_WaitForTransform(struct ProcEkrDragon * proc);
void EkrMyr_TrigerForPrepared(struct ProcEkrDragon * proc);
void EkrMyr_InBattleIdle(struct ProcEkrDragon * proc);
void EkrMyr_ReturnToLoli(struct ProcEkrDragon * proc);
void sub_8070AE4(struct ProcEkrDragon * proc);
void RegisterEkrDragonStatusType(void);
// ??? sub_8076598(???);
int CheckEkrWpnDemonLight(struct Anim *anim);
void EkrDKStartBaseHide(struct ProcEkrDragon * proc);
void EkrDK_CustomBgFadeIn(struct ProcEkrDragon * proc);
void Fill16_EkrTsaBuffer_(u32 val);
void EkrDK_BgMovement(struct ProcEkrDragon * proc);
void EkrDK_PrepareBanimfx(struct ProcEkrDragon * proc);
void PrepareDemonKingBGFx(struct ProcEkrDragon * proc);
void EkrDK_IdleInBattle(struct ProcEkrDragon * proc);
void EkrDK_WaitForFadeOut(struct ProcEkrDragon * proc);
void EkrDK_ReloadTerrainEtc(struct ProcEkrDragon * proc);
void EkrDK_ReloadCustomBgAndFadeOut(struct ProcEkrDragon * proc);
void EkrDK_SetDragonStatusBit3(struct ProcEkrDragon * proc);
ProcPtr NewEkrDragonBaseHide(struct Anim *anim);
ProcPtr NewEkrDragonBaseHide(struct Anim *anim);
void EkrDragonBaseHideMain(struct ProcEfxDKfx * proc);
void EkrDragonBaseHide_Nop(struct ProcEfxDKfx * proc);
ProcPtr NewEkrDragonBaseAppear(struct Anim *anim);
void EkrDragonBaseAppearMain(struct ProcEfxDKfx * proc);
void EkrDragonBaseAppear_Nop(struct ProcEfxDKfx * proc);
void EkrDKHandler_NewDragonAnime(struct ProcEkrDragon * proc);
ProcPtr NewEkrDragonBodyAnime(struct Anim *anim);
void EfxDKUpdateFrontAnimPostion(struct ProcEfxDKfx * proc);
void sub_8076C10(struct ProcEfxDKBody1 * proc);
void sub_8076C34(struct ProcEfxDKBody1 * proc);
void sub_8076C54(struct ProcEfxDKBody1 * proc);
void sub_8076D60(struct ProcEfxDKBody1 * proc);
void sub_8076DE8(struct ProcEfxDKBody1 * proc);
void sub_8076E00(struct ProcEfxDKBody1 * proc);
void sub_8076E84(struct ProcEfxDKBody1 * proc);
void sub_8076F08(struct ProcEfxDKBody1 * proc);
void sub_8076F28(struct ProcEfxDKBody1 * proc);
void sub_8076F48(struct ProcEfxDKBody1 * proc);
void sub_8076FD0(struct ProcEfxDKBody1 * proc);
void sub_8076FD4(struct ProcEfxDKBody1 * proc);
void EkrDragonBodyAnimeSet54(struct Anim *anim);
void EkrDragonBodyAnimeMain(struct ProcEfxDKfx * proc);
void NewEkrDemoKingAtk(struct Anim *anim, int round_type);
void EkrDemoKingAtkMain(struct ProcEfxDKBody4 * proc);
ProcPtr NewEkrDragonBodvBlack(struct Anim *anim);
void sub_80772E4(int val);
void EkrDragonBodyBlackMain(struct ProcEfxDKfx * proc);
void nop_8077394(void);
void sub_8077398(void);
void sub_80773BC(struct ProcEfxDKfx * proc);
void sub_80773E4(struct ProcEfxDKfx * proc);
void sub_8077460(struct ProcEfxDKfx * proc);
void sub_8077474(int arg1, int arg2);
void sub_807750C(int arg1, int arg2);
ProcPtr NewProc087F4518(struct Anim *anim);
ProcPtr NewEkrDragonTunkFace(struct Anim *anim);
void EkrDragonTunkFaceRegisterAnim(struct ProcEfxDKfx * proc);
void EkrDragonTunkFaceIdle(struct ProcEfxDKfx * proc);
void EkrDragonTunkFaceRegisterAnim2(struct ProcEfxDKfx * proc);
void sub_807766C(struct ProcEfxDKfx * proc);
void sub_8077678(struct ProcEfxDKfx * proc);
void sub_8077684(struct ProcEfxDKfx * proc);
void sub_80776B0(struct ProcEfxDKfx * proc);
void EfxTmDecompress(int arg1, int arg2, const u16 *tsa);
void EfxBG3TmSetPosition(int arg1, int arg2);
ProcPtr NewEkrDragonTunk(struct Anim *anim);
void DemonKingDeadWhiteOut(struct ProcEkrDragonTunk * proc);
void sub_807789C(struct ProcEkrDragonTunk * proc);
void sub_8077AA8(void);
void NewEkrWhiteOUT(int, int, int);
void EkrWhiteOutFadeIn(struct ProcEkrWhiteOUT * proc);
void EkrWhiteOutDelay(struct ProcEkrWhiteOUT * proc);
void EkrWhiteOutFadeOut(struct ProcEkrWhiteOUT * proc);
void EkrWhiteOutOnEnd(struct ProcEkrWhiteOUT * proc);
void sub_8077C54(s16, s16);
void sub_8077D30(struct Proc08801800 * proc);
void sub_8077D38(struct Proc08801800 * proc);
void sub_8077D80(s16 *buf1, s16 *buf2, int val1, int val2);
void sub_8077DB4(int, int);
void sub_8077DC8(void);
void sub_8077E64(struct Proc08801810 * proc);
void sub_8077E6C(struct Proc08801810 * proc);
void sub_8077E9C(void);
void sub_8077EAC(int arg1, int arg2);
void sub_8077EEC(int, ProcPtr parent);
void sub_8077F04(struct Proc08801840 * proc);
void sub_8077F10(struct Proc08801840 * proc);
void sub_8077F9C(u16 *buf, int);
void CopyPalWithFade(const u16 *src, u16 *dst, int ref);
void NewEkrSelfThunder(struct Anim *anim);
void EkrSelfThunderMain(struct ProcEfxDKfx * proc);
void EfxSelfThunderBGUpdateAnimTSA(struct Anim *anim, const u16 *tsa_close, const u16 *tsa_far);
void NewEkrSelfThunderBG(struct Anim *anim);
void EfxSelfThunderBGUpdateAnim(struct ProcSelfThunderBG * proc, u16 *img, u16 *tsa_close, u16 *tsa_far, u16 *pal);
void EfxSelfThunderBGOnInit(struct ProcSelfThunderBG * proc);
void EfxSelfThunderBGMain(struct ProcSelfThunderBG * proc);
