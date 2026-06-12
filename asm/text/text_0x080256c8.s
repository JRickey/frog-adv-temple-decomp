@ Auto-emitted by peel.py — raw bytes following sub_08025644 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080256c8, 0x0802a2f0)  (0x4c28 bytes)
@
@ Post-peel chunk after sub_08025644.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_080256c8
	.type   text_080256c8, %object
text_080256c8:
	.incbin "frog_us_baserom.gba", 0x000256c8, 0x00004c28
	.size   text_080256c8, . - text_080256c8
