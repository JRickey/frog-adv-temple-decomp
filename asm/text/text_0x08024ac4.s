@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024ac4, 0x0802a2f0)  (0x582c bytes)
@
@ Post-peel remainder after sub_08024A98.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08024ac4
	.type   text_08024ac4, %object
text_08024ac4:
	.incbin "frog_us_baserom.gba", 0x00024ac4, 0x0000582c
	.size   text_08024ac4, . - text_08024ac4
