@ Auto-emitted by mapper agent — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080274bc, 0x0802a2f0)  (0x2e34 bytes)
@
@ Post-peel chunk after sub_08027490.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08027490
	.type   text_08027490, %object
text_08027490:
	.incbin "frog_us_baserom.gba", 0x000274bc, 0x00002e34
	.size   text_08027490, . - text_08027490
