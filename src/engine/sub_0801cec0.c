#include "macros.h"
#include "types.h"

s32 sub_0801CEC0(const char *str, u8 len)
{
    u32 i;
    u32 result;
    u32 digit;
    u8 val;
    u8 j;

    result = 0;
    i = 0;

    if (result >= len)
        goto done;

    for (;;) {
        s32 saved_exp;

        digit = (u8)(str[i] - 0x30);

        if (digit > 9)
            goto error;

        {
            s32 exp;
            val = digit;
            j = 0;
            exp = len - i;
            exp--;

            if (j < exp) {
                saved_exp = exp;
                do {
                    val = (u8)(val * 10);
                    j = (u8)(j + 1);
                } while (j < saved_exp);
            }
        }

        result += val;
        i = (u8)(i + 1);

        if (i >= len)
            break;
    }

done:
    return result;

error:
    return -1;
}
