@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Range:  [0x08033de0, 0x08033e14)  (0x34 bytes, thumb mode)
@
@ __lshrdi3 — libgcc 64-bit logical-right-shift helper.

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start __lshrdi3
__lshrdi3: @ 0x08033de0 — libgcc 64-bit logical-right-shift helper
        .incbin "frog_us_baserom.gba", 0x00033de0, 0x00000034
        thumb_func_end __lshrdi3
