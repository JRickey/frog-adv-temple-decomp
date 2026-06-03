@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023360, 0x0802a394)  (0x7034 bytes)
@
@ Post-peel chunk after sub_08023334.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023360
        .type   text_08023360, %object
text_08023360:
        .incbin "frog_us_baserom.gba", 0x00023360, 0x00007034
        .size   text_08023360, . - text_08023360
