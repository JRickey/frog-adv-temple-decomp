@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080247d4, 0x0802a2f0)  (0x5b1c bytes)
@
@ Post-peel remainder after sub_080247AC.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080247d4
	.type   text_080247d4, %object
text_080247d4:
	.incbin "frog_us_baserom.gba", 0x000247d4, 0x00005b1c
	.size   text_080247d4, . - text_080247d4
