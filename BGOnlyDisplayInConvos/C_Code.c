#include "C_Code.h" // headers
extern int DisplayOnlyBG_Flag;
int ShouldDisplayOnlyBG(void)
{
    return CheckFlag(DisplayOnlyBG_Flag);
}

void ToggleSpritesWithSelectKey(void)
{

    if (gKeyStatusPtr->newKeys & (SELECT_BUTTON))
    {
        if (CheckFlag(DisplayOnlyBG_Flag))
        {
            ClearFlag(DisplayOnlyBG_Flag);
        }
        else
        {
            SetFlag(DisplayOnlyBG_Flag);
        }
    }

    return;
}

void TalkEngine_MaybeSetSpriteBlend(void) // [30030c4..30030c7]!!
{
    if (ShouldDisplayOnlyBG())
    {
        // ArchiveCurrentPalettes();
        // WriteFadedPaletteFromArchive(0xC0, 0xC0, 0xC0, 0xFFFF0000);

        gLCDControlBuffer.bldcnt.effect = BLEND_EFFECT_ALPHA;
        gLCDControlBuffer.bldcnt.target1_obj_on = 1; // Background being blended
        gLCDControlBuffer.bldcnt.target2_bd_on = 1;  // Blend with backdrop
        gLCDControlBuffer.blendCoeffA = 4;           // Strength of first layer
        gLCDControlBuffer.blendCoeffB = 12;          // Strength of second layer

        gLCDControlBuffer.dispcnt.bg3_on = 1;
        gLCDControlBuffer.dispcnt.obj_on = 1; // If blending objects
    }
    else
    {

        SetBlendAlpha(0x10, 1);
    }
}

void EventEngine_MaybeShowOnlyBG(void)
{
    if (ShouldDisplayOnlyBG())
    {
        // gLCDControlBuffer.dispcnt.obj_on = 0;
        gLCDControlBuffer.dispcnt.bg0_on = 0;
        gLCDControlBuffer.dispcnt.bg1_on = 0;
        gLCDControlBuffer.dispcnt.bg2_on = 1;
        gLCDControlBuffer.dispcnt.bg3_on = 1;

        // Set alpha blend factors
        // gLCDControlBuffer.blendCoeffA = 2;  // Low visibility for sprites
        // gLCDControlBuffer.blendCoeffB = 14; // High visibility for background
    }
    else
    {
        gLCDControlBuffer.dispcnt.bg0_on = TRUE;
        gLCDControlBuffer.dispcnt.bg1_on = TRUE;
        gLCDControlBuffer.dispcnt.bg2_on = TRUE;
        gLCDControlBuffer.dispcnt.bg3_on = TRUE;
        gLCDControlBuffer.dispcnt.obj_on = TRUE;
    }
}
