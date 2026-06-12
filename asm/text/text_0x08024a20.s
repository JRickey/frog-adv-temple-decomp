@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024a20, 0x0802a2f0)  (0x58d0 bytes)
@
@ Post-peel remainder after sub_080249E8.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08024a20
	.type   text_08024a20, %object
text_08024a20:
	.incbin "frog_us_baserom.gba", 0x00024a20, 0x000058d0
	.size   text_08024a20, . - text_08024a20
