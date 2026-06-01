#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_0802C200(u32 a0);
extern void text_0802bdbc(void);

void sub_0802CA64(void)
{
    sub_0802C200(0x58);
}

void sub_0802CA70(void)
{
    text_0802bdbc();
    sub_0802C200(0x5B);
}
