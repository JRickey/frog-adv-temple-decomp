@ Tail of the 0x080e0000 bucket after the ui-status-bar cluster
@ [0x080e3550, 0x080e3ab4) was extracted into src/data/ui_status_bar.c
@ and src/data/ui_status_bar_tiles.c.
@ Range:  [0x080e3ab4, 0x080f0000)  (0xc54c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080e3ab4
        .type   text_080e3ab4, %object
text_080e3ab4:
        .incbin "frog_us_baserom.gba", 0x000e3ab4, 0x0000c54c
        .size   text_080e3ab4, . - text_080e3ab4
