@ Auto-emitted by peel.py — raw bytes following sub_08025484 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080254dc, 0x0802a2f0)  (0x4e14 bytes)
@
@ Post-peel chunk after sub_08025484.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025484
	.type   text_08025484, %object
text_08025484:
	.incbin "frog_us_baserom.gba", 0x000254dc, 0x00004e14
	.size   text_08025484, . - text_08025484
