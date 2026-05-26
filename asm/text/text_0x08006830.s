@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006830, 0x08006948)  (0x118 bytes)
@
@ Post-peel chunk after sub_0800679C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006830
        .type   text_08006830, %object
text_08006830:
        .incbin "frog_us_baserom.gba", 0x00006830, 0x00000118
        .size   text_08006830, . - text_08006830
