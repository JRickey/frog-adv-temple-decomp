@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800690c, 0x08006948)  (0x3c bytes)
@
@ Post-peel chunk after sub_08006830.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800690c
        .type   text_0800690c, %object
text_0800690c:
        .incbin "frog_us_baserom.gba", 0x0000690c, 0x0000003c
        .size   text_0800690c, . - text_0800690c
