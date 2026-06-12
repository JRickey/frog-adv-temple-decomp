@ Auto-emitted by peel.py — raw bytes following sub_08025578 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080255bc, 0x0802a2f0)  (0x4d34 bytes)
@
@ Post-peel chunk after sub_08025578.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080255bc
	.type   text_080255bc, %object
text_080255bc:
	.incbin "frog_us_baserom.gba", 0x000255bc, 0x00004d34
	.size   text_080255bc, . - text_080255bc
