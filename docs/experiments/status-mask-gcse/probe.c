typedef unsigned short u16;
typedef unsigned int u32;
static inline u16 bit(unsigned int index)
{
    return 1 << index;
}
void bitmask(u16 *p)
{
    u32 status = *p;
    u32 mask = bit(15);
    if (mask & status) {
        u32 value = 2 | status;
        mask--;
        value &= mask;
        *p = value;
    }
}
static inline u16 statebit(void)
{
    return 0x8000;
}
void exact(u16 *p)
{
    u32 status = *p;
    u32 mask = statebit();
    if (mask & status) {
        u32 value = 2 | status;
        mask--;
        value &= mask;
        *p = value;
    }
}
