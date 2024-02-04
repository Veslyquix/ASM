#include "C_Code.h" // headers 


void GetCharData_ASMC(void) { 
	u32 result = 0; 
	int unitID = gEventSlots[1] & 0xFF; 

	switch (gEventSlots[3]) {
    case 0x00: ; result = (u32)GetCharacterData(unitID)->nameTextId;
    case 0x02: ; result = (u32)GetCharacterData(unitID)->descTextId;
    case 0x04: ; result = (u32)GetCharacterData(unitID)->number;
    case 0x05: ; result = (u32)GetCharacterData(unitID)->defaultClass;
    case 0x06: ; result = (u32)GetCharacterData(unitID)->portraitId;
    case 0x08: ; result = (u32)GetCharacterData(unitID)->miniPortrait;
    case 0x09: ; result = (u32)GetCharacterData(unitID)->affinity;
    case 0x0A: ; result = (u32)GetCharacterData(unitID)->sort_order;

    case 0x0B: ; result = (u32)GetCharacterData(unitID)->baseLevel;
    case 0x0C: ; result = (u32)GetCharacterData(unitID)->baseHP;
    case 0x0D: ; result = (u32)GetCharacterData(unitID)->basePow;
    case 0x0E: ; result = (u32)GetCharacterData(unitID)->baseSkl;
    case 0x0F: ; result = (u32)GetCharacterData(unitID)->baseSpd;
    case 0x10: ; result = (u32)GetCharacterData(unitID)->baseDef;
    case 0x11: ; result = (u32)GetCharacterData(unitID)->baseRes;
    case 0x12: ; result = (u32)GetCharacterData(unitID)->baseLck;
    case 0x13: ; result = (u32)GetCharacterData(unitID)->baseCon;

    case 0x14: ; result = (u32)GetCharacterData(unitID)->baseRanks[0];
    case 0x15: ; result = (u32)GetCharacterData(unitID)->baseRanks[1];
    case 0x16: ; result = (u32)GetCharacterData(unitID)->baseRanks[2];
    case 0x17: ; result = (u32)GetCharacterData(unitID)->baseRanks[3];
    case 0x18: ; result = (u32)GetCharacterData(unitID)->baseRanks[4];
    case 0x19: ; result = (u32)GetCharacterData(unitID)->baseRanks[5];
    case 0x1A: ; result = (u32)GetCharacterData(unitID)->baseRanks[6];
    case 0x1B: ; result = (u32)GetCharacterData(unitID)->baseRanks[7];

    case 0x1C: ; result = (u32)GetCharacterData(unitID)->growthHP;
    case 0x1D: ; result = (u32)GetCharacterData(unitID)->growthPow;
    case 0x1E: ; result = (u32)GetCharacterData(unitID)->growthSkl;
    case 0x1F: ; result = (u32)GetCharacterData(unitID)->growthSpd;
    case 0x20: ; result = (u32)GetCharacterData(unitID)->growthDef;
    case 0x21: ; result = (u32)GetCharacterData(unitID)->growthRes;
    case 0x22: ; result = (u32)GetCharacterData(unitID)->growthLck;

    case 0x23: ; result = (u32)GetCharacterData(unitID)->_u23;
    case 0x24: ; result = (u32)GetCharacterData(unitID)->_u24;
    case 0x25: ; result = (u32)GetCharacterData(unitID)->_u25[0]; // Unique animation IDs in FE7
    case 0x26: ; result = (u32)GetCharacterData(unitID)->_u25[1]; // Unique animation IDs in FE7
    case 0x27: ; result = (u32)GetCharacterData(unitID)->_u27;

    case 0x28: ; result = (u32)GetCharacterData(unitID)->attributes;

    case 0x2C: ; result = (u32)GetCharacterData(unitID)->pSupportData;
    case 0x30: ; result = (u32)GetCharacterData(unitID)->visit_group;

    case 0x31: ; result = (u32)GetCharacterData(unitID)->_pad_[0];
    case 0x32: ; result = (u32)GetCharacterData(unitID)->_pad_[1];
    case 0x33: ; result = (u32)GetCharacterData(unitID)->_pad_[2];
	}
	gEventSlots[0xC] = result; 

} 

void GetClassData_ASMC(void) { 
	u32 result = (u32)0; 
	int classID = gEventSlots[1] & 0xFF; 
	
	switch (gEventSlots[3]) {
    case 0x00: ; result = (u32)GetClassData(classID)->nameTextId;
    case 0x02: ; result = (u32)GetClassData(classID)->descTextId;
    case 0x04: ; result = (u32)GetClassData(classID)->number;
    case 0x05: ; result = (u32)GetClassData(classID)->promotion;
    case 0x06: ; result = (u32)GetClassData(classID)->SMSId;
    case 0x07: ; result = (u32)GetClassData(classID)->slowWalking;
    case 0x08: ; result = (u32)GetClassData(classID)->defaultPortraitId;
    case 0x0A: ; result = (u32)GetClassData(classID)->sort_order;

    case 0x0B: ; result = (u32)GetClassData(classID)->baseHP;
    case 0x0C: ; result = (u32)GetClassData(classID)->basePow;
    case 0x0D: ; result = (u32)GetClassData(classID)->baseSkl;
    case 0x0E: ; result = (u32)GetClassData(classID)->baseSpd;
    case 0x0F: ; result = (u32)GetClassData(classID)->baseDef;
    case 0x10: ; result = (u32)GetClassData(classID)->baseRes;
    case 0x11: ; result = (u32)GetClassData(classID)->baseCon;
    case 0x12: ; result = (u32)GetClassData(classID)->baseMov;

    case 0x13: ; result = (u32)GetClassData(classID)->maxHP;
    case 0x14: ; result = (u32)GetClassData(classID)->maxPow;
    case 0x15: ; result = (u32)GetClassData(classID)->maxSkl;
    case 0x16: ; result = (u32)GetClassData(classID)->maxSpd;
    case 0x17: ; result = (u32)GetClassData(classID)->maxDef;
    case 0x18: ; result = (u32)GetClassData(classID)->maxRes;
    case 0x19: ; result = (u32)GetClassData(classID)->maxCon;

    case 0x1A: ; result = (u32)GetClassData(classID)->classRelativePower;

    case 0x1B: ; result = (u32)GetClassData(classID)->growthHP;
    case 0x1C: ; result = (u32)GetClassData(classID)->growthPow;
    case 0x1D: ; result = (u32)GetClassData(classID)->growthSkl;
    case 0x1E: ; result = (u32)GetClassData(classID)->growthSpd;
    case 0x1F: ; result = (u32)GetClassData(classID)->growthDef;
    case 0x20: ; result = (u32)GetClassData(classID)->growthRes;
    case 0x21: ; result = (u32)GetClassData(classID)->growthLck;

    case 0x22: ; result = (u32)GetClassData(classID)->promotionHp;
    case 0x23: ; result = (u32)GetClassData(classID)->promotionPow;
    case 0x24: ; result = (u32)GetClassData(classID)->promotionSkl;
    case 0x25: ; result = (u32)GetClassData(classID)->promotionSpd;
    case 0x26: ; result = (u32)GetClassData(classID)->promotionDef;
    case 0x27: ; result = (u32)GetClassData(classID)->promotionRes;

    case 0x28: ; result = (u32)GetClassData(classID)->attributes;

    case 0x2C: ; result = (u32)GetClassData(classID)->baseRanks[0];
    case 0x2D: ; result = (u32)GetClassData(classID)->baseRanks[1];
    case 0x2E: ; result = (u32)GetClassData(classID)->baseRanks[2];
    case 0x2F: ; result = (u32)GetClassData(classID)->baseRanks[3];
    case 0x30: ; result = (u32)GetClassData(classID)->baseRanks[4];
    case 0x31: ; result = (u32)GetClassData(classID)->baseRanks[5];
    case 0x32: ; result = (u32)GetClassData(classID)->baseRanks[6];
    case 0x33: ; result = (u32)GetClassData(classID)->baseRanks[7];

    case 0x34: ; result = (u32)GetClassData(classID)->pBattleAnimDef;
    case 0x38: ; result = (u32)GetClassData(classID)->pMovCostTable[0]; // standard, rain, snow
    case 0x3C: ; result = (u32)GetClassData(classID)->pMovCostTable[1]; // standard, rain, snow
    case 0x40: ; result = (u32)GetClassData(classID)->pMovCostTable[2]; // standard, rain, snow

    case 0x44: ; result = (u32)GetClassData(classID)->pTerrainAvoidLookup;
    case 0x48: ; result = (u32)GetClassData(classID)->pTerrainDefenseLookup;
    case 0x4C: ; result = (u32)GetClassData(classID)->pTerrainResistanceLookup;

    case 0x50: ; result = (u32)GetClassData(classID)->_pU50;
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





