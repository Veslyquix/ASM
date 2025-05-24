#include "c_code.h"
struct PidStatsChar // total size 0x10
{
    u8 lossAmt;
    u8 skill[4];
};

void SilentGiveSkill(int charID, int skillID)
{
    struct PidStatsChar * pidStats = (struct PidStatsChar *)GetPidStats(charID);
    if (!pidStats)
    {
        return;
    }
    for (int i = 0; i < 4; ++i)
    {
        if (!pidStats->skill[i])
        {
            pidStats->skill[i] = skillID;
        }
    }
}
void SilentSetSkill(int charID, int skillID, int offset)
{
    struct PidStatsChar * pidStats = (struct PidStatsChar *)GetPidStats(charID);
    if (!pidStats)
    {
        return;
    }
    pidStats->skill[offset] = skillID;
}

void SilentRemoveSkillOffset(int charID, int offset)
{
    struct PidStatsChar * pidStats = (struct PidStatsChar *)GetPidStats(charID);
    if (!pidStats)
    {
        return;
    }
    pidStats->skill[offset] = 0;
}
void SilentRemoveSkill(int charID, int skillID)
{
    struct PidStatsChar * pidStats = (struct PidStatsChar *)GetPidStats(charID);
    if (!pidStats)
    {
        return;
    }
    for (int i = 0; i < 4; ++i)
    {
        if (pidStats->skill[i] == skillID)
        {
            pidStats->skill[i] = 0;
        }
    }
}

void SilentRemoveSkills(int charID)
{
    struct PidStatsChar * pidStats = (struct PidStatsChar *)GetPidStats(charID);
    if (!pidStats)
    {
        return;
    }
    for (int i = 0; i < 4; ++i)
    {
        pidStats->skill[i] = 0;
    }
}

void SilentGiveSkill_ASMC(void)
{
    int charID = gEventSlots[1];
    int skillID = gEventSlots[2];
    SilentGiveSkill(charID, skillID);
}
void SilentGiveSkill_Active(void)
{
    int charID = gActiveUnit->pCharacterData->number;
    int skillID = gEventSlots[2];
    SilentGiveSkill(charID, skillID);
}
void SilentSetSkill_ASMC(void)
{
    int charID = gEventSlots[1];
    int skillID = gEventSlots[2];
    int offset = gEventSlots[3];
    SilentSetSkill(charID, skillID, offset);
}
