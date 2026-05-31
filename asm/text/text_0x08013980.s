@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013980, 0x08013c60)  (0x2e0 bytes)
@
@ Post-peel chunk after sub_08013920.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013980
        .type   text_08013980, %object
text_08013980:
        .incbin "frog_us_baserom.gba", 0x00013980, 0x000002e0
        .size   text_08013980, . - text_08013980
