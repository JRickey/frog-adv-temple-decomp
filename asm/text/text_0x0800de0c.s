@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800de0c, 0x0800de80)  (0x74 bytes)
@
@ Post-peel chunk after WorldMap_Init.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800de0c
        .type   text_0800de0c, %object
text_0800de0c:
        .incbin "frog_us_baserom.gba", 0x0000de0c, 0x00000074
        .size   text_0800de0c, . - text_0800de0c
