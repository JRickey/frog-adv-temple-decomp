@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006600, 0x08006b88)  (0x588 bytes)
@
@ Pre-peel chunk before sub_08006B88.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006600
        .type   text_08006600, %object
text_08006600:
        .incbin "frog_us_baserom.gba", 0x00006600, 0x00000588
        .size   text_08006600, . - text_08006600
