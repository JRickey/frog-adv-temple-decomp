@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024844, 0x0802a2f0)  (0x5aac bytes)
@
@ Post-peel remainder after sub_08024820.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08024844
	.type   text_08024844, %object
text_08024844:
	.incbin "frog_us_baserom.gba", 0x00024844, 0x00005aac
	.size   text_08024844, . - text_08024844
