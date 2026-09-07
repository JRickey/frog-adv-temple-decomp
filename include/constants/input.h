#ifndef GUARD_CONSTANTS_INPUT_H
#define GUARD_CONSTANTS_INPUT_H

/* Values returned by Input_Poll (src/system/init1.c) and parked in
 * gIwram_5398: the just-pressed KEY_* bits remapped so that each pad input
 * lands in a single, screen-code-friendly bit (D-pad in the low nibble,
 * A/B/START/SELECT above it). These are NOT the raw REG_KEYINPUT bits. */
enum InputCode {
    INPUT_UP = 0x01,
    INPUT_DOWN = 0x02,
    INPUT_LEFT = 0x04,
    INPUT_RIGHT = 0x08,
    INPUT_A = 0x10,
    INPUT_B = 0x20,
    INPUT_START = 0x40,
    INPUT_SELECT = 0x80,
    INPUT_L = 0x100,
    INPUT_R = 0x200,
};

#endif /* GUARD_CONSTANTS_INPUT_H */
