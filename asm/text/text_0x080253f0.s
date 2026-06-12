@ Auto-emitted by peel.py — raw bytes following sub_08025390 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080253f0, 0x0802a2f0)  (0x4f00 bytes)
@
@ Post-peel chunk after sub_08025390.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080253f0
	.type   text_080253f0, %object
text_080253f0:
	.incbin "frog_us_baserom.gba", 0x000253f0, 0x00004f00
	.size   text_080253f0, . - text_080253f0
