@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080142d4, 0x08015a00)  (0x172c bytes)
@
@ Post-peel chunk after sub_08014140.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080142d4
        .type   text_080142d4, %object
text_080142d4:
        .incbin "frog_us_baserom.gba", 0x000142d4, 0x0000172c
        .size   text_080142d4, . - text_080142d4
