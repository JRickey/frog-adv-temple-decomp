@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080248e4, 0x0802a2f0)  (0x5a0c bytes)
@
@ Post-peel remainder after sub_08024890.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080248e4
	.type   text_080248e4, %object
text_080248e4:
	.incbin "frog_us_baserom.gba", 0x000248e4, 0x00005a0c
	.size   text_080248e4, . - text_080248e4
