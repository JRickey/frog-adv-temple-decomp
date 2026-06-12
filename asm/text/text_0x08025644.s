@ Auto-emitted by peel.py — raw bytes following sub_08025620 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025644, 0x0802a2f0)  (0x4cac bytes)
@
@ Post-peel chunk after sub_08025620.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025644
	.type   text_08025644, %object
text_08025644:
	.incbin "frog_us_baserom.gba", 0x00025644, 0x00004cac
	.size   text_08025644, . - text_08025644
