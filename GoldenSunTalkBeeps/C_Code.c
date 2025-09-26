#include "C_Code.h" // headers

#define TALK_TEXT_BY_LINE(line) (sTalkText + ((line) + sTalkState->topTextNum) % sTalkState->lines)

// static struct TalkState sTalkStateCore;
extern struct TalkState * const sTalkState;
extern struct Text sTalkText[3];
// static int sTalkChoiceResult;
// static struct Font sTalkFont;

extern int SongTableStartID_Link;
extern int SongTableNumberOfBoops;
#define CHAR_NEWLINE 0x01
#define CHAR_A 0x03
#define CHAR_SPACE 0x20
int ShouldDoVanillaBoops()
{
    return false;
}

int GetBoopFirstID()
{ // if some flag is on, use a different voice?
    return SongTableStartID_Link;
}
int GetNumberOfBoops()
{
    return SongTableNumberOfBoops;
}

int HandleBoops()
{
    if (!ShouldDoVanillaBoops())
    {
        if (!CheckTalkFlag(TALK_FLAG_SILENT))
        {
            if (CheckTalkFlag(TALK_FLAG_7))
            {
                PlaySoundEffect(SONG_7A);
            }
            else
            {
                if (!((*sTalkState->str == CHAR_SPACE) || (*sTalkState->str == CHAR_NEWLINE) ||
                      (*sTalkState->str == CHAR_A))) // only boop after a space, newline, or [A]
                {
                    return true;
                }

                if (sTalkState->instantScroll && sTalkState->unk82)
                {
                    return true;
                }

                sTalkState->unk82 = 1;
                int sfxID = GetBoopFirstID() + NextRN_N(GetNumberOfBoops());
                PlaySoundEffect(sfxID);
            }
        }
        return false;
    }
    else // vanilla behaviour
    {

        if (!CheckTalkFlag(TALK_FLAG_SILENT))
        {
            if (CheckTalkFlag(TALK_FLAG_7))
            {
                PlaySoundEffect(SONG_7A);
            }
            else
            {
                if ((GetTextDisplaySpeed() == 1) && !(GetGameClock() & 1))
                {
                    return true;
                }

                if (sTalkState->instantScroll && sTalkState->unk82)
                {
                    return true;
                }

                sTalkState->unk82 = 1;
                PlaySoundEffect(SONG_6E);
            }
        }
    }
    return false;
}

//! FE8U = 0x08006C34
void Talk_OnIdle(ProcPtr proc)
{

    if (IsTalkFaceMoving())
    {
        return;
    }

    if (!sTalkState->instantScroll)
    {
        sTalkState->printClock++;

        if (sTalkState->printClock < sTalkState->printDelay)
        {
            return;
        }
    }

    sTalkState->printClock = 0;

    while (1)
    {
        SetTalkFaceNoMouthMove(sTalkState->activeFaceSlot);

        switch (TalkInterpret(proc))
        {
            case 0:
                Proc_Break(proc);
                return;

            case 2:
                if (sTalkState->instantScroll || sTalkState->printDelay <= 0)
                {
                    break;
                }

                return;

            case 3:
                sTalkState->printClock = sTalkState->printDelay;
                sTalkState->instantScroll = 0;

                return;

            case 1:
            default:
            {
                if (!(CheckTalkFlag(TALK_FLAG_SPRITE)))
                {
                    if (TalkPrepNextChar(proc) == 1)
                    {
                        return;
                    }
                }
                else
                {
                    if (TalkSpritePrepNextChar(proc) == 1)
                    {
                        return;
                    }
                }

                sTalkState->str = Text_DrawCharacter(TALK_TEXT_BY_LINE(sTalkState->lineActive), sTalkState->str);
                HandleBoops();
                break;
            }
        }

        if (!sTalkState->instantScroll && sTalkState->printDelay > 0)
        {
            return;
        }
    }

    return;
}
