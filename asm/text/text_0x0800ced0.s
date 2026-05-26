@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800ced0, 0x0800d028)  (0x158 bytes)
@
@ Post-peel chunk after sub_0800CE98.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800ced0
        .type   text_0800ced0, %object
text_0800ced0:
        .incbin "frog_us_baserom.gba", 0x0000ced0, 0x00000158
        .size   text_0800ced0, . - text_0800ced0
