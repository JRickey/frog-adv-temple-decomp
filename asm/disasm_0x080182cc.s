@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801844c, 0x080184dc)  (144 bytes, thumb mode)
@ sub_080182CC (0x080182cc, 0x180 bytes) decompiled to src/engine/sub_080182cc.c.

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0801844C
sub_0801844C: @ 0x0801844c
        .incbin "frog_us_baserom.gba", 0x1844c, 0x90
        thumb_func_end sub_0801844C
