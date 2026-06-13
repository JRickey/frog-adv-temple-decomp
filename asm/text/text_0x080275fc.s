@ Auto-emitted by mapper agent — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080275fc, 0x0802a2f0)  (0x2cf4 bytes)
@
@ Post-peel chunk after sub_080275B0.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080275fc
	.type   text_080275fc, %object
text_080275fc:
	.incbin "frog_us_baserom.gba", 0x000275fc, 0x00002cf4
	.size   text_080275fc, . - text_080275fc
