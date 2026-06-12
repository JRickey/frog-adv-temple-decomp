@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080247f8, 0x0802a2f0)  (0x5af8 bytes)
@
@ Post-peel remainder after sub_080247D4.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080247f8
	.type   text_080247f8, %object
text_080247f8:
	.incbin "frog_us_baserom.gba", 0x000247f8, 0x00005af8
	.size   text_080247f8, . - text_080247f8
