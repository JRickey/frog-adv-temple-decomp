@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006b94, 0x0800793c)  (0xda8 bytes)
@
@ Post-peel chunk after sub_08006B88.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006b94
        .type   text_08006b94, %object
text_08006b94:
        .incbin "frog_us_baserom.gba", 0x00006b94, 0x00000da8
        .size   text_08006b94, . - text_08006b94
