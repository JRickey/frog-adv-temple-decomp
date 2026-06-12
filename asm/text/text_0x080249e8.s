@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802 49e8, 0x0802a2f0)  (0x5908 bytes)
@
@ Post-peel remainder after sub_080249A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080249e8
	.type   text_080249e8, %object
text_080249e8:
	.incbin "frog_us_baserom.gba", 0x000249e8, 0x00005908
	.size   text_080249e8, . - text_080249e8
