@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006b94, 0x08006ba4)  (0x10 bytes)
@
@ Pre-peel chunk before sub_08006BA4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006b94
        .type   text_08006b94, %object
text_08006b94:
        .incbin "frog_us_baserom.gba", 0x00006b94, 0x00000010
        .size   text_08006b94, . - text_08006b94
