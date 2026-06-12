@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024820, 0x0802a2f0)  (0x5ad0 bytes)
@
@ Post-peel remainder after sub_080247F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08024820
	.type   text_08024820, %object
text_08024820:
	.incbin "frog_us_baserom.gba", 0x00024820, 0x00005ad0
	.size   text_08024820, . - text_08024820
