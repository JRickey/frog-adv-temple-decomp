@ Auto-emitted by peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802486c, 0x0802a2f0)  (0x5a84 bytes)
@
@ Post-peel remainder after sub_08024844.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_0802486c
	.type   text_0802486c, %object
text_0802486c:
	.incbin "frog_us_baserom.gba", 0x0002486c, 0x00005a84
	.size   text_0802486c, . - text_0802486c
