@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08012100, 0x08012180)  (0x80 bytes)
@
@ Post-peel chunk after sub_08012098.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08012100
        .type   text_08012100, %object
text_08012100:
        .incbin "frog_us_baserom.gba", 0x00012100, 0x00000080
        .size   text_08012100, . - text_08012100
