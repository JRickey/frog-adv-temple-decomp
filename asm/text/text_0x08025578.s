@ Auto-emitted by peel.py — raw bytes following sub_08025508 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025578, 0x0802a2f0)  (0x4d78 bytes)
@
@ Post-peel chunk after sub_08025508.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025578
	.type   text_08025578, %object
text_08025578:
	.incbin "frog_us_baserom.gba", 0x00025578, 0x00004d78
	.size   text_08025578, . - text_08025578
