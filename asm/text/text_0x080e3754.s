@ Gap between sFrogStatusBarFrames (ends 0x080e3754) and
@ sFrogStatusBarTileData (starts 0x080e3a30) — 732 bytes of unrelated
@ graphics data (likely tile-index blocks referenced by entity_dispatch's
@ sSpriteFrameDescriptors[0..4] at 0x080c1128, which point to
@ 0x080e3814..0x080e38b0).
@
@ Range:  [0x080e3754, 0x080e3a30)  (0x2dc bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080e3754
        .type   text_080e3754, %object
text_080e3754:
        .incbin "frog_us_baserom.gba", 0x000e3754, 0x000002dc
        .size   text_080e3754, . - text_080e3754
