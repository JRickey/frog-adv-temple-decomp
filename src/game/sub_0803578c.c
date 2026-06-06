#include "types.h"

void *Memcpy(void *dst, const void *src, u32 count)
{
    u8 *d = (u8 *)dst;
    const u8 *s = (const u8 *)src;

    if (count > 15 && (((u32)s | (u32)d) & 3) == 0) {
        u32 *p = (u32 *)d;

        while (count > 15) {
            *p++ = *(u32 *)s;
            s += 4;
            *p++ = *(u32 *)s;
            s += 4;
            *p++ = *(u32 *)s;
            s += 4;
            *p++ = *(u32 *)s;
            s += 4;
            count -= 16;
        }
        while (count > 3) {
            *p++ = *(u32 *)s;
            s += 4;
            count -= 4;
        }
        d = (u8 *)p;
    }

    count--;
    if (count != (u32)-1) {
        u32 sentinel = (u32)-1;
        do {
            *d++ = *s++;
            count--;
        } while (count != sentinel);
    }

    return dst;
}
