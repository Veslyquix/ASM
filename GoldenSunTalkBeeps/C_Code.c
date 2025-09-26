#include "C_Code.h" // headers

#define TALK_TEXT_BY_LINE(line) (sTalkText + ((line) + sTalkState->topTextNum) % sTalkState->lines)

// static struct TalkState sTalkStateCore;
extern struct TalkState * const sTalkState;
extern struct Text sTalkText[3];
// static int sTalkChoiceResult;
// static struct Font sTalkFont;

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

                if (!CheckTalkFlag(TALK_FLAG_SILENT))
                {
                    if (CheckTalkFlag(TALK_FLAG_7))
                    {
                        PlaySoundEffect(SONG_7A);
                    }
                    else
                    {
                        if ((GetTextDisplaySpeed() == 1) && !(GetGameClock() & 1))
                        // if ((GetTextDisplaySpeed() == 1) && (GetGameClock() & 3))
                        {
                            break;
                        }

                        if (sTalkState->instantScroll && sTalkState->unk82)
                        {
                            break;
                        }

                        sTalkState->unk82 = 1;
                        PlaySoundEffect(SONG_6E);
                        brk;
                    }
                }
        }

        if (!sTalkState->instantScroll && sTalkState->printDelay > 0)
        {
            return;
        }
    }

    return;
}
