@ Auto-emitted by peel.py — raw bytes following sub_080253F0 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802543c, 0x0802a2f0)  (0x4eb4 bytes)
@
@ Post-peel chunk after sub_080253F0.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080253f0
	.type   text_080253f0, %object
text_080253f0:
	.incbin "frog_us_baserom.gba", 0x0002543c, 0x00004eb4
	.size   text_080253f0, . - text_080253f0
