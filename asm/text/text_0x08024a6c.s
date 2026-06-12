@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024a6c, 0x0802a2f0)  (0x5884 bytes)
@
@ Post-peel remainder after sub_08024A48.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08024a6c
	.type   text_08024a6c, %object
text_08024a6c:
	.incbin "frog_us_baserom.gba", 0x00024a6c, 0x00005884
	.size   text_08024a6c, . - text_08024a6c
