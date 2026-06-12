@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08033a70, 0x08033ca4)  (0x234 bytes)
@
@ Remainder of the pre-libgcc raw-bytes bucket after sub_080339F0 was peeled.

        .section .text, "ax", %progbits
        .align  2
        .global text_08033a70
        .type   text_08033a70, %object
text_08033a70:
        .thumb_func
        .global sub_08033A70
        .type   sub_08033A70, %function
sub_08033A70:
        .incbin "frog_us_baserom.gba", 0x00033a70, 0x000000b8
        .thumb_func
        .global sub_08033B28
        .type   sub_08033B28, %function
sub_08033B28:
        .incbin "frog_us_baserom.gba", 0x00033b28, 0x000000e4
        .thumb_func
        .global sub_08033C0C
        .type   sub_08033C0C, %function
sub_08033C0C:
        .incbin "frog_us_baserom.gba", 0x00033c0c, 0x00000098
        .size   text_08033a70, . - text_08033a70
