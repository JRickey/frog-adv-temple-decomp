@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080004c4, 0x0800072c)  (0x268 bytes)
@
@ Pre-peel chunk before sub_0800072C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080004c4
        .type   text_080004c4, %object
text_080004c4:
        .incbin "frog_us_baserom.gba", 0x000004c4, 0x00000268
        .size   text_080004c4, . - text_080004c4
