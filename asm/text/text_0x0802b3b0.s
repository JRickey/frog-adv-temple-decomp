@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802b3b0, 0x0802b9d4)  (0x624 bytes)
@
@ Post-peel chunk split off after sub_0802B2EC was peeled from text_0x0802af10.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802b3b0
        .type   text_0802b3b0, %object
text_0802b3b0:
        .global sub_0802B3B0
        .type   sub_0802B3B0, %function
        .thumb_func
sub_0802B3B0:
        .incbin "frog_us_baserom.gba", 0x0002b3b0, 0x00000108

        .global sub_0802B4B8
        .type   sub_0802B4B8, %function
        .thumb_func
sub_0802B4B8:
        .incbin "frog_us_baserom.gba", 0x0002b4b8, 0x0000051c
        .size   text_0802b3b0, . - text_0802b3b0
