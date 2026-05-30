@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002814, 0x08002844)  (0x30 bytes)
@
@ Post-peel chunk after sub_08002808.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002814
        .type   text_08002814, %object
text_08002814:
        .incbin "frog_us_baserom.gba", 0x00002814, 0x00000030
        .size   text_08002814, . - text_08002814
