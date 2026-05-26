@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006bb4, 0x08007660)  (0xaac bytes)
@
@ Pre-peel chunk before sub_08007660.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006bb4
        .type   text_08006bb4, %object
text_08006bb4:
        .incbin "frog_us_baserom.gba", 0x00006bb4, 0x00000aac
        .size   text_08006bb4, . - text_08006bb4
