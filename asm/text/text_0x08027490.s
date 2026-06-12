@ Auto-emitted by mapper agent — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027490, 0x0802a2f0)  (0x2e60 bytes)
@
@ Post-peel chunk after sub_08027458.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08027490
	.type   text_08027490, %object
text_08027490:
	.incbin "frog_us_baserom.gba", 0x00027490, 0x00002e60
	.size   text_08027490, . - text_08027490
