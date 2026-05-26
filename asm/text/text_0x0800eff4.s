@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800eff4, 0x08010000)  (0x100c bytes)
@
@ Post-peel chunk after sub_0800EF90.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800eff4
        .type   text_0800eff4, %object
text_0800eff4:
        .incbin "frog_us_baserom.gba", 0x0000eff4, 0x0000100c
        .size   text_0800eff4, . - text_0800eff4
