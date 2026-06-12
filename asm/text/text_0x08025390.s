@ Auto-emitted by peeling sub_0802532C — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025390, 0x0802a2f0)  (0x4f60 bytes)
@
@ Post-peel chunk after sub_08025364.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08025390
        .type   text_08025390, %object
text_08025390:
        .incbin "baserom.gba", 0x00025390, 0x00004f60
        .size   text_08025390, . - text_08025390
