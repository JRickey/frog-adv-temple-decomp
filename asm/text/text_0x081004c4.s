@ Inter-anchor gap inside the screen_0800f014 cluster.
@ Range:  [0x081004c4, 0x08100cc4)  (0x800 B of zero padding)
@
@ Sits between sScreenTilemapBg1_FFCC4 (ends 0x081004c4) and
@ sScreenCharTilesBg1_100CC4 (starts 0x08100cc4). All bytes are 0x00;
@ no pool-load reference targets this gap in [0x08000000, 0x08036000).
@ Kept as a raw INCBIN to preserve byte layout; promote if a consumer
@ surfaces.

        .section .text, "ax", %progbits
        .align  2
        .global text_081004c4
        .type   text_081004c4, %object
text_081004c4:
        .incbin "frog_us_baserom.gba", 0x001004c4, 0x00000800
        .size   text_081004c4, . - text_081004c4
