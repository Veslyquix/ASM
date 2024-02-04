#include "C_Code.h" // headers 


void GetCharData_ASMC(void) { 
	u32 result = 0; 
	int unitID = gEventSlots[1] & 0xFF; 

	switch (gEventSlots[3]) {
    case 0x00: ; result = (u32)GetCharacterData(unitID)->nameTextId; break;
    case 0x02: ; result = (u32)GetCharacterData(unitID)->descTextId; break;
    case 0x04: ; result = (u32)GetCharacterData(unitID)->number; break;
    case 0x05: ; result = (u32)GetCharacterData(unitID)->defaultClass; break;
    case 0x06: ; result = (u32)GetCharacterData(unitID)->portraitId; break;
    case 0x08: ; result = (u32)GetCharacterData(unitID)->miniPortrait; break;
    case 0x09: ; result = (u32)GetCharacterData(unitID)->affinity; break;
    case 0x0A: ; result = (u32)GetCharacterData(unitID)->sort_order; break;

    case 0x0B: ; result = (u32)GetCharacterData(unitID)->baseLevel; break;
    case 0x0C: ; result = (u32)GetCharacterData(unitID)->baseHP; break;
    case 0x0D: ; result = (u32)GetCharacterData(unitID)->basePow; break;
    case 0x0E: ; result = (u32)GetCharacterData(unitID)->baseSkl; break;
    case 0x0F: ; result = (u32)GetCharacterData(unitID)->baseSpd; break;
    case 0x10: ; result = (u32)GetCharacterData(unitID)->baseDef; break;
    case 0x11: ; result = (u32)GetCharacterData(unitID)->baseRes; break;
    case 0x12: ; result = (u32)GetCharacterData(unitID)->baseLck; break;
    case 0x13: ; result = (u32)GetCharacterData(unitID)->baseCon; break;

    case 0x14: ; result = (u32)GetCharacterData(unitID)->baseRanks[0]; break;
    case 0x15: ; result = (u32)GetCharacterData(unitID)->baseRanks[1]; break;
    case 0x16: ; result = (u32)GetCharacterData(unitID)->baseRanks[2]; break;
    case 0x17: ; result = (u32)GetCharacterData(unitID)->baseRanks[3]; break;
    case 0x18: ; result = (u32)GetCharacterData(unitID)->baseRanks[4]; break;
    case 0x19: ; result = (u32)GetCharacterData(unitID)->baseRanks[5]; break;
    case 0x1A: ; result = (u32)GetCharacterData(unitID)->baseRanks[6]; break;
    case 0x1B: ; result = (u32)GetCharacterData(unitID)->baseRanks[7]; break;

    case 0x1C: ; result = (u32)GetCharacterData(unitID)->growthHP; break;
    case 0x1D: ; result = (u32)GetCharacterData(unitID)->growthPow; break;
    case 0x1E: ; result = (u32)GetCharacterData(unitID)->growthSkl; break;
    case 0x1F: ; result = (u32)GetCharacterData(unitID)->growthSpd; break;
    case 0x20: ; result = (u32)GetCharacterData(unitID)->growthDef; break;
    case 0x21: ; result = (u32)GetCharacterData(unitID)->growthRes; break;
    case 0x22: ; result = (u32)GetCharacterData(unitID)->growthLck; break;

    case 0x23: ; result = (u32)GetCharacterData(unitID)->_u23; break;
    case 0x24: ; result = (u32)GetCharacterData(unitID)->_u24; break;
    case 0x25: ; result = (u32)GetCharacterData(unitID)->_u25[0]; break; // Unique animation IDs in FE7
    case 0x26: ; result = (u32)GetCharacterData(unitID)->_u25[1]; break; // Unique animation IDs in FE7
    case 0x27: ; result = (u32)GetCharacterData(unitID)->_u27; break;

    case 0x28: ; result = (u32)GetCharacterData(unitID)->attributes; break;

    case 0x2C: ; result = (u32)GetCharacterData(unitID)->pSupportData; break;
    case 0x30: ; result = (u32)GetCharacterData(unitID)->visit_group; break;

    case 0x31: ; result = (u32)GetCharacterData(unitID)->_pad_[0]; break;
    case 0x32: ; result = (u32)GetCharacterData(unitID)->_pad_[1]; break;
    case 0x33: ; result = (u32)GetCharacterData(unitID)->_pad_[2]; break;
	}
	gEventSlots[0xC] = result; 

} 

void GetClassData_ASMC(void) { 
	u32 result = (u32)0; 
	int classID = gEventSlots[1] & 0xFF; 
	
	switch (gEventSlots[3]) {
    case 0x00: ; result = (u32)GetClassData(classID)->nameTextId; break;
    case 0x02: ; result = (u32)GetClassData(classID)->descTextId; break;
    case 0x04: ; result = (u32)GetClassData(classID)->number; break;
    case 0x05: ; result = (u32)GetClassData(classID)->promotion; break;
    case 0x06: ; result = (u32)GetClassData(classID)->SMSId; break;
    case 0x07: ; result = (u32)GetClassData(classID)->slowWalking; break;
    case 0x08: ; result = (u32)GetClassData(classID)->defaultPortraitId; break;
    case 0x0A: ; result = (u32)GetClassData(classID)->sort_order; break;

    case 0x0B: ; result = (u32)GetClassData(classID)->baseHP; break;
    case 0x0C: ; result = (u32)GetClassData(classID)->basePow; break;
    case 0x0D: ; result = (u32)GetClassData(classID)->baseSkl; break;
    case 0x0E: ; result = (u32)GetClassData(classID)->baseSpd; break;
    case 0x0F: ; result = (u32)GetClassData(classID)->baseDef; break;
    case 0x10: ; result = (u32)GetClassData(classID)->baseRes; break;
    case 0x11: ; result = (u32)GetClassData(classID)->baseCon; break;
    case 0x12: ; result = (u32)GetClassData(classID)->baseMov; break;

    case 0x13: ; result = (u32)GetClassData(classID)->maxHP; break;
    case 0x14: ; result = (u32)GetClassData(classID)->maxPow; break;
    case 0x15: ; result = (u32)GetClassData(classID)->maxSkl; break;
    case 0x16: ; result = (u32)GetClassData(classID)->maxSpd; break;
    case 0x17: ; result = (u32)GetClassData(classID)->maxDef; break;
    case 0x18: ; result = (u32)GetClassData(classID)->maxRes; break;
    case 0x19: ; result = (u32)GetClassData(classID)->maxCon; break;

    case 0x1A: ; result = (u32)GetClassData(classID)->classRelativePower; break;

    case 0x1B: ; result = (u32)GetClassData(classID)->growthHP; break;
    case 0x1C: ; result = (u32)GetClassData(classID)->growthPow; break;
    case 0x1D: ; result = (u32)GetClassData(classID)->growthSkl; break;
    case 0x1E: ; result = (u32)GetClassData(classID)->growthSpd; break;
    case 0x1F: ; result = (u32)GetClassData(classID)->growthDef; break;
    case 0x20: ; result = (u32)GetClassData(classID)->growthRes; break;
    case 0x21: ; result = (u32)GetClassData(classID)->growthLck; break;

    case 0x22: ; result = (u32)GetClassData(classID)->promotionHp; break;
    case 0x23: ; result = (u32)GetClassData(classID)->promotionPow; break;
    case 0x24: ; result = (u32)GetClassData(classID)->promotionSkl; break;
    case 0x25: ; result = (u32)GetClassData(classID)->promotionSpd; break;
    case 0x26: ; result = (u32)GetClassData(classID)->promotionDef; break;
    case 0x27: ; result = (u32)GetClassData(classID)->promotionRes; break;

    case 0x28: ; result = (u32)GetClassData(classID)->attributes; break;

    case 0x2C: ; result = (u32)GetClassData(classID)->baseRanks[0]; break;
    case 0x2D: ; result = (u32)GetClassData(classID)->baseRanks[1]; break;
    case 0x2E: ; result = (u32)GetClassData(classID)->baseRanks[2]; break;
    case 0x2F: ; result = (u32)GetClassData(classID)->baseRanks[3]; break;
    case 0x30: ; result = (u32)GetClassData(classID)->baseRanks[4]; break;
    case 0x31: ; result = (u32)GetClassData(classID)->baseRanks[5]; break;
    case 0x32: ; result = (u32)GetClassData(classID)->baseRanks[6]; break;
    case 0x33: ; result = (u32)GetClassData(classID)->baseRanks[7]; break;

    case 0x34: ; result = (u32)GetClassData(classID)->pBattleAnimDef; break;
    case 0x38: ; result = (u32)GetClassData(classID)->pMovCostTable[0]; break; // standard, rain, snow
    case 0x3C: ; result = (u32)GetClassData(classID)->pMovCostTable[1]; break; // standard, rain, snow
    case 0x40: ; result = (u32)GetClassData(classID)->pMovCostTable[2]; break; // standard, rain, snow

    case 0x44: ; result = (u32)GetClassData(classID)->pTerrainAvoidLookup; break;
    case 0x48: ; result = (u32)GetClassData(classID)->pTerrainDefenseLookup; break;
    case 0x4C: ; result = (u32)GetClassData(classID)->pTerrainResistanceLookup; break;

    case 0x50: ; result = (u32)GetClassData(classID)->_pU50; break;
	}
	gEventSlots[0xC] = result; 

} 

void GetItemData_ASMC(void) { 
	u32 result = 0; 
	int item = gEventSlots[1] & 0xFF; 
	
	switch (gEventSlots[3]) {
    case 00: ; result = GetItemData(item)->nameTextId; break; 
    case 02: ; result = GetItemData(item)->descTextId; break; 
    case 04: ; result = GetItemData(item)->useDescTextId; break; 

    case 06: ; result = GetItemData(item)->number; break; 
    case 07: ; result = GetItemData(item)->weaponType; break; 

    case 0x08: ; result = GetItemData(item)->attributes; break; 

    case 0x0C: ; result = (u32)GetItemData(item)->pStatBonuses; break; 
    case 0x10: ; result = (u32)GetItemData(item)->pEffectiveness; break; 

    case 0x14: ; result = GetItemData(item)->maxUses; break; 

    case 0x15: ; result = GetItemData(item)->might; break; 
    case 0x16: ; result = GetItemData(item)->hit; break; 
    case 0x17: ; result = GetItemData(item)->weight; break; 
    case 0x18: ; result = GetItemData(item)->crit; break; 

    case 0x19: ; result = GetItemData(item)->encodedRange; break; 

    case 0x1A: ; result = GetItemData(item)->costPerUse; break; 
    case 0x1C: ; result = GetItemData(item)->weaponRank; break; 
    case 0x1D: ; result = GetItemData(item)->iconId; break; 
    case 0x1E: ; result = GetItemData(item)->useEffectId; break; 
    case 0x1F: ; result = GetItemData(item)->weaponEffectId; break; 
    case 0x20: ; result = GetItemData(item)->weaponExp; break; 
	}
	gEventSlots[0xC] = result; 

} 





