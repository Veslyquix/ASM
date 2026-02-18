
struct FaceDataWithPad
{
    /* 00 */ const u8 * img;
    /* 04 */ const u8 * imgChibi;
    /* 08 */ const u16 * pal;
    /* 0C */ const u8 * imgMouth;
    /* 10 */ const u8 * imgCard;
    /* 14 */ u8 xMouth, yMouth;
    /* 16 */ u8 xEyes, yEyes;
    /* 18 */ u8 blinkKind;
    u8 pad[7]; // make it size 0x20 which fixes issues with ram overlapping fsr
};

#define NumFaceDataSlots 4
#define PaletteSpace (NumFaceDataSlots * 0x10)
extern struct FaceDataWithPad FaceDataRam[NumFaceDataSlots]; // 1. 0x1C bytes ram * NumFaceDataSlots for the most
                                                             // recent calls to GetPortraitData
extern u16 FacePalRam[]; // 2. 0x20 bytes ram * NumFaceDataSlots for the 16 colour palette
// extern u16 FacePalRam[0x10 * NumFaceDataSlots]; // 3. fids
// extern u16 FacePalRam[0x10 * NumFaceDataSlots + NumFaceDataSlots]; // 3. slots

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

extern struct FaceData const * DynamicPortraits(int id);
int GetAdjustedPortraitID(int fid)
{
    const struct FaceData * data = DynamicPortraits(fid);
    int newFid = ((int)data - (int)GetMugData(0)) / 0x1C; // calc which ID it is now
    return newFid;
}
/*
// This didn't work, but searching through multiple instances of the same proc script
// could be useful in the future
int FindSlotFromLoadedFids(int fid)
{
    struct FaceProc * face;
    struct ProcFindIterator procIter;
    Proc_FindBegin(&procIter, gProcScr_E_FACE);

    for (int i = 0; i < 4; ++i)
    {
        face = Proc_FindNext(&procIter);
        if (!face)
        {
            return i;
        }
        if (face->faceId == fid)
        {
            return i;
        }
    }
    return (-1);
}
*/

int IsFidCurrentlyLoaded(int fid)
{
    struct FaceProc * face;
    struct ProcFindIterator procIter;

    Proc_FindBegin(&procIter, gProcScr_E_FACE);

    while ((face = Proc_FindNext(&procIter)))
    {
        if (face->faceId == fid)
            return 1;
    }

    return 0;
}

void ClearUnusedFaceSlots(void)
{
    int base = PaletteSpace;

    for (int i = 0; i < NumFaceDataSlots; ++i)
    {
        int fid = FacePalRam[base + i];

        if (fid != 0 && !IsFidCurrentlyLoaded(fid))
        {
            // Clear slot
            FacePalRam[base + i] = 0;

            // Optional: clear palette memory here too
            // CpuFill16(0, PaletteRamAddressForSlot(i), 0x20);
        }
    }
}

void UpdateMostRecentFids(int slot)
{
    int base = PaletteSpace + NumFaceDataSlots;

    // Shift down
    for (int i = NumFaceDataSlots - 1; i > 0; --i)
        FacePalRam[base + i] = FacePalRam[base + i - 1];

    // Put newest in front
    FacePalRam[base + 0] = slot;
}

// I don't know if this makes sense
// the idea is to allocate ram for the adjusted palette for the 4 most
// recent results from GetPortraitData
int FindSlotFromFid(int fid)
{
    int base = PaletteSpace;
    ClearUnusedFaceSlots();
    int slot;
    // Check if fid already loaded
    for (int i = 0; i < NumFaceDataSlots; ++i)
    {
        if (FacePalRam[base + i] == fid)
        {
            UpdateMostRecentFids(i);
            return i;
        }
    }

    // Look for empty slot
    for (int i = 0; i < NumFaceDataSlots; ++i)
    {
        if (FacePalRam[base + i] == 0)
        {
            FacePalRam[base + i] = fid;
            UpdateMostRecentFids(i);
            return i;
        }
    }

    // No empty slot, reuse least recently used
    int lruBase = base + NumFaceDataSlots;
    slot = FacePalRam[lruBase + NumFaceDataSlots - 1];

    FacePalRam[base + slot] = fid;
    UpdateMostRecentFids(slot);

    return slot;
}

const struct FaceData * NewGetPortraitData(int fid)
{
    // put portrait data into ram and edit the palette pointer
    // and the palette, also now in ram, as desired
    // const struct FaceData * data = GetMugData(fid);
    const struct FaceData * data = DynamicPortraits(fid);
    int newFid = ((int)data - (int)GetMugData(0)) / 0x1C; // calc which ID it is now
    // so we don't have to edit the DynamicPortraits asm
    int faceSlot = FindSlotFromFid(fid);
    int palOffset = 16 * faceSlot;

    CpuFastCopy(data, (void *)&FaceDataRam[faceSlot], 0x1C); // src, dst, bytes
    CpuFastCopy(data->pal, (void *)&FacePalRam[palOffset], 0x10);
    const u16 * basePal;
    FaceDataRam[faceSlot].pal = (void *)&FacePalRam[palOffset];
    struct PortraitPalReplacementStruct * palReplacements = &PortraitPalReplacements[0];
    int tmp;
    while (palReplacements->fidA && palReplacements->fidA != 0xFFFF)
    {

        if (palReplacements->fidA <= newFid && palReplacements->fidB >= newFid && CheckFlag(palReplacements->flag))
        {
            basePal = data->pal;
            FacePalRam[palOffset] = 0xFFFF;
            for (int i = 0; i < 15; ++i)
            {
                tmp = palReplacements->pal[i];
                if (tmp != (-1) && basePal[i + 1] != tmp)
                {
                    FacePalRam[palOffset + i + 1] = tmp; // don't adjust pal ID 0, as it is transparent
                }
            }
        }
        palReplacements++;
    }
    return (void *)&FaceDataRam[faceSlot];
}
