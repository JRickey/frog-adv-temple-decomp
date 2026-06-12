@ Auto-emitted by mapper agent — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027510, 0x0802a2f0)  (0x2de0 bytes)
@
@ Post-peel chunk after sub_080274BC.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08027510
	.type   text_08027510, %object
text_08027510:
	.incbin "frog_us_baserom.gba", 0x00027510, 0x00002de0
	.size   text_08027510, . - text_08027510
