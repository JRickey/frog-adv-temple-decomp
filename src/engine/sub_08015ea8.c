extern void CharLayers_Upload(unsigned int arg);
extern void ScrollCamera_Update(unsigned int arg);
extern void BgScrollBlit(unsigned int arg);

void sub_08015EA4(void)
{}

void ScrollCamera_Reset(void)
{
    CharLayers_Upload(2);
    ScrollCamera_Update(2);
    BgScrollBlit(2);
}

void sub_08015EC0(void)
{}
