#include "types.h"

/* Maps a (state, dir) pair to a single direction bit (8/16/32/64), or
 * 0xFF when the pair has no mapping. The inner switches deliberately
 * fall through to the next outer case for any dir they don't handle. */
u8 Anim_GetFrameHeight(u8 state, u8 dir)
{
    switch (state) {
    case 0:
        switch (dir) {
        case 0:
            return 8;
        case 1:
            return 16;
        case 2:
            return 32;
        case 3:
            return 64;
        }
        /* fallthrough */
    case 1:
        switch (dir) {
        case 0:
            return 16;
        case 1:
            return 32;
        case 2:
            return 32;
        case 3:
            return 64;
        }
        /* fallthrough */
    case 2:
        switch (dir) {
        case 0:
            return 8;
        case 1:
            return 8;
        case 2:
            return 16;
        case 3:
            return 32;
        }
    }

    return 0xFF;
}

u8 Anim_GetFrameWidth(u8 state, u8 dir)
{
    switch (state) {
    case 0:
        switch (dir) {
        case 0:
            return 8;
        case 1:
            return 16;
        case 2:
            return 32;
        case 3:
            return 64;
        }
        /* fallthrough */
    case 1:
        switch (dir) {
        case 0:
            return 8;
        case 1:
            return 8;
        case 2:
            return 16;
        case 3:
            return 32;
        }
        /* fallthrough */
    case 2:
        switch (dir) {
        case 0:
            return 16;
        case 1:
            return 32;
        case 2:
            return 32;
        case 3:
            return 64;
        }
    }

    return 0xFF;
}
