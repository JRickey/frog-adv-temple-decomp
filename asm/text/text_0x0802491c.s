@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802491c, 0x0802a2f0)  (0x59d4 bytes)
@
@ Post-peel remainder after sub_080248E4.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_0802491c
	.type   text_0802491c, %object
text_0802491c:
	.incbin "frog_us_baserom.gba", 0x0002491c, 0x000059d4
	.size   text_0802491c, . - text_0802491c
