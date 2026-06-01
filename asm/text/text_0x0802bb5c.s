@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802bb5c, 0x0802bf58)  (0x3fc bytes)
@
@ Pre-peel chunk before sub_0802BF58.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global sub_0802BB5C
        .thumb_func
sub_0802BB5C:
        .incbin "frog_us_baserom.gba", 0x0002bb5c, 0x00000064

        .global text_0802bbc0
        .type   text_0802bbc0, %object
text_0802bbc0:
        .incbin "frog_us_baserom.gba", 0x0002bbc0, 0x00000398
        .size   text_0802bbc0, . - text_0802bbc0
