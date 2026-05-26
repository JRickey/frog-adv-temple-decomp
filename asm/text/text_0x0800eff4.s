@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800eff4, 0x0800f24c)  (0x258 bytes)
@
@ Pre-peel chunk before sub_0800F24C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800eff4
        .type   text_0800eff4, %object
text_0800eff4:
        .incbin "frog_us_baserom.gba", 0x0000eff4, 0x00000258
        .size   text_0800eff4, . - text_0800eff4
