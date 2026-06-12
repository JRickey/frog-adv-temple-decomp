@ Auto-emitted by peel.py — raw bytes following sub_080255BC peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080255f4, 0x0802a2f0)  (0x4cfc bytes)
@
@ Post-peel chunk after sub_080255BC.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080255f4
	.type   text_080255f4, %object
text_080255f4:
	.incbin "frog_us_baserom.gba", 0x000255f4, 0x00004cfc
	.size   text_080255f4, . - text_080255f4
