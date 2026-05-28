@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801d570, 0x0801da1c)  (0x4ac bytes)
@
@ Post-peel chunk after sub_0801D4CC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801d570
        .type   text_0801d570, %object
text_0801d570:
        .incbin "frog_us_baserom.gba", 0x0001d570, 0x000004ac
        .size   text_0801d570, . - text_0801d570
