@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080247ac, 0x0802a2f0)  (0x5b44 bytes)
@
@ Post-peel remainder after sub_08024534.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080247ac
	.type   text_080247ac, %object
text_080247ac:
	.incbin "frog_us_baserom.gba", 0x000247ac, 0x00005b44
	.size   text_080247ac, . - text_080247ac
