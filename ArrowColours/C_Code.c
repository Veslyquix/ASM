#include "C_Code.h" // headers 

//#define RedArrowFlag 0xB1 
//const u8 BlueArrowPal[] = { 0x74, 0x57, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24, 0x77, 0x45, 0x7F, 0xA5, 0x7F, 0xEE, 0x7F, 0xF1, 0x7F, 0xF7, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x86, 0x56, 0x4A, 0x67 } ; //gUnknown_08A0328C
//const u8 RedArrowPal[] = { 0x74, 0x57, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 0x00, 0x1F, 0x00 } ; 

extern u8 ArrowPaletteList[]; 

void PathArrowDisp_Init(u8 a) {
    Decompress(gUnknown_08A03054, (void *) OBJ_VRAM0 + 0x5E00);
    //ApplyPalette(BlueArrowPal, 0x13); // default 
    int flag; 
    for (int i = 0; i < 255; ++i) { 
        flag = ArrowPaletteList[i * 34] | (ArrowPaletteList[(i * 34) + 1] << 8); 
        if (!flag || CheckFlag(flag)) { 
            ApplyPalette(&ArrowPaletteList[(i*34) + 2], 0x13);
            break; 
        } 
    } 
    

    if (a == 0) {
        gpPathArrowProc->maxMov =
            gActiveUnit->movBonus + gActiveUnit->pClassData->baseMov - gActionData.moveCount;
        CutOffPathLength(0);
        AddPointToPathArrowProc(gActiveUnit->xPos, gActiveUnit->yPos);
        gpPathArrowProc->pathCosts[0] = gpPathArrowProc->maxMov;
        // This seems strange. But passing -1 to a signed argument doesn't seem to match
        SetLastCoords(0xFFFF, 0xFFFF);
        UpdatePathArrowWithCursor();
    }
}


