@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08019834, 0x08019964)  (0x130 bytes)
@
@ Post-peel chunk after sub_080196EC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08019834
        .type   text_08019834, %object
text_08019834:
        .incbin "frog_us_baserom.gba", 0x00019834, 0x00000130
        .size   text_08019834, . - text_08019834
