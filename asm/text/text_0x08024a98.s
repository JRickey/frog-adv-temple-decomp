@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024a98, 0x0802a2f0)  (0x5858 bytes)
@
@ Post-peel remainder after sub_08024A6C.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08024a98
	.type   text_08024a98, %object
text_08024a98:
	.incbin "frog_us_baserom.gba", 0x00024a98, 0x00005858
	.size   text_08024a98, . - text_08024a98
