@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801b71c, 0x0801b954)  (0x238 bytes)
@
@ Code bucket (shrunk to make room for sub_0801B954 peel).
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801b71c
        .type   text_0801b71c, %object
text_0801b71c:
        .thumb_func
        .global sub_0801B71C
        .type   sub_0801B71C, %function
sub_0801B71C:
        .incbin "frog_us_baserom.gba", 0x0001b71c, 0x00000238
        .size   sub_0801B71C, . - sub_0801B71C
        .size   text_0801b71c, . - text_0801b71c
