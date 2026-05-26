@ Head of the gap that previously ran [0x080e3754, 0x080e3a30).
@ The palette cluster sFrogSpritePalettes_E3774 (5 x 32 B = 160 B at
@ 0x080e3774..0x080e3814) has been extracted to
@ src/data/frog_sprite_palettes.c. The remaining sprite-frame region
@ [0x080e3814..0x080e3a30) is held in asm/text/text_0x080e3814.s
@ pending a future extraction pass (likely pointed at by
@ sSpriteFrameDescriptors[0..4] at 0x080c1128).
@
@ Range:  [0x080e3754, 0x080e3774)  (0x20 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080e3754
        .type   text_080e3754, %object
text_080e3754:
        .incbin "frog_us_baserom.gba", 0x000e3754, 0x00000020
        .size   text_080e3754, . - text_080e3754
