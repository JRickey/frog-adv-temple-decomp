extern void RunScrollTransitionSequence(unsigned int arg);
extern void FrogStatusBar_Update(void);

void UpdateScrollTransition(void)
{
    RunScrollTransitionSequence(2);
    FrogStatusBar_Update();
}
