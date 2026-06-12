@ Auto-emitted by peel.py — raw bytes following sub_0802572C peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025904, 0x0802a2f0)  (0x49ec bytes)
@
@ Post-peel chunk after sub_0802572C.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025904
	.type   text_08025904, %object
text_08025904:
	.incbin "frog_us_baserom.gba", 0x00025904, 0x000049ec
	.size   text_08025904, . - text_08025904
