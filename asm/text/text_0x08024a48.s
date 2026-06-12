@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024a48, 0x0802a2f0)  (0x58a8 bytes)
@
@ Post-peel remainder after sub_08024A20.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08024a48
	.type   text_08024a48, %object
text_08024a48:
	.incbin "frog_us_baserom.gba", 0x00024a48, 0x000058a8
	.size   text_08024a48, . - text_08024a48
