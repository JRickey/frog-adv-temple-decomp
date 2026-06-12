@ Auto-emitted by peeling sub_0802532C — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025364, 0x0802a2f0)  (0x4f8c bytes)
@
@ Post-peel chunk after sub_0802532C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08025364
        .type   text_08025364, %object
text_08025364:
        .incbin "baserom.gba", 0x00025364, 0x00004f8c
        .size   text_08025364, . - text_08025364
