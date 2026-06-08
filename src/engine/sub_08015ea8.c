#include "gfx.h"
#include "types.h"

extern void CharLayers_Upload(unsigned int arg);
extern void BgScrollBlit(unsigned int arg);

void ScrollCamera_NopA(void)
{}

void ScrollCamera_Reset(void)
{
    CharLayers_Upload(2);
    ScrollCamera_Update(2);
    BgScrollBlit(2);
}

void ScrollCamera_NopB(void)
{}
