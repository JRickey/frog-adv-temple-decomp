@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08033948, 0x08033ca4)  (0x35c bytes)
@
@ Pre-peel chunk before __ashldi3 (libgcc, 0x08033ca4).
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08033948
        .type   text_08033948, %object
text_08033948:
        .incbin "frog_us_baserom.gba", 0x00033948, 0x0000035c
        .size   text_08033948, . - text_08033948
