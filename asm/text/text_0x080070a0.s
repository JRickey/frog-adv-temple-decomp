@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080070a0, 0x08007660)  (0x5c0 bytes)
@
@ Post-peel chunk after sub_08006FEC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080070a0
        .type   text_080070a0, %object
text_080070a0:
        .incbin "frog_us_baserom.gba", 0x000070a0, 0x000005c0
        .size   text_080070a0, . - text_080070a0
