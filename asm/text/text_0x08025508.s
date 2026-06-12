@ Auto-emitted by peel.py — raw bytes following sub_080254DC peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025508, 0x0802a2f0)  (0x4de8 bytes)
@
@ Post-peel chunk after sub_080254DC.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025508
	.type   text_08025508, %object
text_08025508:
	.incbin "frog_us_baserom.gba", 0x00025508, 0x00004de8
	.size   text_08025508, . - text_08025508
