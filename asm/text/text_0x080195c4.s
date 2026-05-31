@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080195c4, 0x08019964)  (0x3a0 bytes)
@
@ Post-peel chunk after sub_08019580.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080195c4
        .type   text_080195c4, %object
text_080195c4:
        .incbin "frog_us_baserom.gba", 0x000195c4, 0x000003a0
        .size   text_080195c4, . - text_080195c4
