@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024970, 0x0802a2f0)  (0x5980 bytes)
@
@ Post-peel remainder after sub_0802491C.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08024970
	.type   text_08024970, %object
text_08024970:
	.incbin "frog_us_baserom.gba", 0x00024970, 0x00005980
	.size   text_08024970, . - text_08024970
