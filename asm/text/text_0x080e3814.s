@ Tail of the gap that previously ran [0x080e3754, 0x080e3a30) before
@ the sFrogSpritePalettes_E3774 extraction.
@
@ Holds the sprite-frame region [0x080e3814..0x080e38b0] pointed at by
@ sSpriteFrameDescriptors[0..4] at 0x080c1128 (per the existing
@ comment in text_080e3754.s before this split), plus residual unnamed
@ bytes up to the start of sFrogStatusBarTileData (0x080e3a30).
@
@ Range:  [0x080e3814, 0x080e3a30)  (0x21c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080e3814
        .type   text_080e3814, %object
text_080e3814:
        .incbin "frog_us_baserom.gba", 0x000e3814, 0x0000021c
        .size   text_080e3814, . - text_080e3814
