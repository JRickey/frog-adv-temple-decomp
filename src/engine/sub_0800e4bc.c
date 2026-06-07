#include "game.h"
#include "sound.h"
#include "types.h"

extern void Sound_Reset(void);

/* Two-player link-cable handshake state machine.
 *
 * 0x03005328 is the handshake phase byte (1 = offer, 2 = confirm); the
 * 0x03005398 link word carries the menu/cancel event; the 0x03005370 control
 * struct holds the five step bytes exchanged with the other unit (offsets
 * 0/4/8/12/16). Each (phase, event) pair plays a confirmation sound via
 * Sound_Play and advances or rolls back the step bytes. Returns 1 on every
 * path except the cancel branch (phase 2, event 16, step[12] settled at 0x3)
 * which tears the link down via Sound_Reset and returns 0.
 *
 * Matching notes (old_agbcc): the inner dispatch on the link word lowers to two
 * sparse cmp-cascades, not jump tables. -fforce-addr keeps the 0x03005370 base
 * loaded into a register before the 15-mask constant (the baserom's `mask &
 * step[N]` operand order); -fno-expensive-optimizations keeps the per-test mask
 * copy (`adds r0, mask, #0`) rather than folding it into an in-place `ands`.
 * The `zero` local materialises the phase-clear 0 ahead of the 9-stores (one
 * spare register holds it across them), and case 2's `lo` keeps step[16]'s
 * masked value in a fresh register so the control pointer wins the low register
 * the way the baserom colours that block. */

u8 AnimCtrl_RunPhase(void)
{
    u8 *phase;
    u8 *ctrl;
    u8 mask;
    u8 ret;
    u8 zero;

    ret = 1;
    phase = (u8 *)0x03005328;

    switch (*phase) {
    case 1:
        switch (*(u16 *)0x03005398) {
        case 1: {
            u8 *c;
            Sound_Play(2);
            c = (u8 *)0x03005370;
            c[4] = 3;
            c[8] = 1;
            break;
        }
        case 2: {
            u8 *c;
            Sound_Play(2);
            c = (u8 *)0x03005370;
            c[4] = 1;
            c[8] = 3;
            break;
        }
        case 64:
            Sound_Play(1);
            ctrl = (u8 *)0x03005370;
            mask = 15;
            if ((mask & ctrl[4]) == 3) {
                goto p1_accept;
            }
            goto p1_advance;
        case 16:
            Sound_Play(1);
            ctrl = (u8 *)0x03005370;
            mask = 15;
            if ((mask & ctrl[4]) != 3) {
                goto p1_advance;
            }
        p1_accept:
            zero = 0;
            ctrl[0] = 9;
            ctrl[4] = 9;
            ctrl[8] = 9;
            *phase = zero;
            break;
        p1_advance:
            mask &= ctrl[8];
            if (mask == 3) {
                ctrl[8] = 2;
                ctrl[12] = ret;
                ctrl[16] = mask;
                *phase = 2;
            }
            break;
        }
        break;

    case 2:
        switch (*(u16 *)0x03005398) {
        case 4: {
            u8 *c;
            Sound_Play(2);
            c = (u8 *)0x03005370;
            c[12] = 3;
            c[16] = 1;
            break;
        }
        case 8: {
            u8 *c;
            Sound_Play(2);
            c = (u8 *)0x03005370;
            c[12] = 1;
            c[16] = 3;
            break;
        }
        case 16: {
            u8 mask2;
            u8 lo;
            u8 *ctrl2;
            Sound_Play(1);
            ctrl2 = (u8 *)0x03005370;
            mask2 = 15;
            if ((mask2 & ctrl2[12]) == 3) {
                ret = 0;
                Sound_Reset();
                break;
            }
            lo = mask2 & ctrl2[16];
            if (lo == 3) {
                ctrl2[4] = ret;
                ctrl2[8] = lo;
                ctrl2[12] = 9;
                ctrl2[16] = 9;
                *phase = ret;
            }
            break;
        }
        }
        break;
    }

    return ret;
}
