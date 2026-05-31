@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080229f0, 0x0802a394)  (0x79a4 bytes)
@
@ Post-peel chunk after sub_080229CC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080229f0
        .type   text_080229f0, %object
text_080229f0:
        .incbin "frog_us_baserom.gba", 0x000229f0, 0x000079a4
        .size   text_080229f0, . - text_080229f0
