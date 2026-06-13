@ Auto-emitted by mapper agent — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027558, 0x08027584)  (0x2c bytes)
@
@ Post-peel chunk after sub_08027510.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08027558
	.type   text_08027558, %object
text_08027558:
	.incbin "frog_us_baserom.gba", 0x00027558, 0x0000002c
	.size   text_08027558, . - text_08027558
