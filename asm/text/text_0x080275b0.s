@ Auto-emitted by mapper agent — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080275b0, 0x0802a2f0)  (0x2d40 bytes)
@
@ Post-peel chunk after sub_08027584.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080275b0
	.type   text_080275b0, %object
text_080275b0:
	.incbin "frog_us_baserom.gba", 0x000275b0, 0x00002d40
	.size   text_080275b0, . - text_080275b0
