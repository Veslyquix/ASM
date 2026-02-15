
struct FaceData
{
    /* 00 */ const u8 * img;
    /* 04 */ const u8 * imgChibi;
    /* 08 */ const u16 * pal;
    /* 0C */ const u8 * imgMouth;
    /* 10 */ const u8 * imgCard;
    /* 14 */ u8 xMouth, yMouth;
    /* 16 */ u8 xEyes, yEyes;
    /* 18 */ u8 blinkKind;
};
// Because users repoint these tables, use pointers to them instead of the vanilla address of tables
extern struct FaceData const * const sPortrait_data;

// this is a copy of GetPortraitData that uses a pointer to portrait_data
static struct FaceData const * GetMugData(int id)
{
    return sPortrait_data + id;
}
struct PortraitPalReplacementStruct
{
    u16 fidA; // range of portraits affected
    u16 fidB;
    u16 flag;
    s16 pal[15];
};
extern struct PortraitPalReplacementStruct PortraitPalReplacements[];

extern struct FaceData Font_Sio_02000C60_Reused;
extern u16 Sio_02000C80_Reused[];
extern struct FaceData const * DynamicPortraits(int id);
const struct FaceData * NewGetPortraitData(int fid)
{
    // put portrait data into ram and edit the palette pointer
    // and the palette, also now in ram, as desired
    // const struct FaceData * data = GetMugData(fid);
    const struct FaceData * data = DynamicPortraits(fid);
    int newFid = ((int)data - (int)GetMugData(0)) / 0x1C; // calc which ID it is now
    // so we don't have to edit the DynamicPortraits asm

    CpuFastCopy(data, (void *)&Font_Sio_02000C60_Reused, 0x1C); // src, dst, bytes
    CpuFastCopy(data->pal, (void *)&Sio_02000C80_Reused, 0x10);
    const u16 * basePal;
    Font_Sio_02000C60_Reused.pal = (void *)&Sio_02000C80_Reused;
    struct PortraitPalReplacementStruct * palReplacements = &PortraitPalReplacements[0];
    int tmp;
    while (palReplacements->fidA && palReplacements->fidA != 0xFFFF)
    {
        brk;
        if (palReplacements->fidA <= newFid && palReplacements->fidB >= newFid && CheckFlag(palReplacements->flag))
        {
            basePal = data->pal;
            Sio_02000C80_Reused[0] = 0xFFFF;
            for (int i = 0; i < 15; ++i)
            {
                // brk;
                tmp = palReplacements->pal[i];
                if (tmp != (-1) && basePal[i + 1] != tmp)
                {
                    Sio_02000C80_Reused[i + 1] = tmp; // don't adjust pal ID 0, as it is transparent
                }
            }
        }
        palReplacements++;
    }
    return &Font_Sio_02000C60_Reused;
}
