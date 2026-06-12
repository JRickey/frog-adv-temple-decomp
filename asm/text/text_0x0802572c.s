@ Auto-emitted by peel.py — raw bytes following sub_080256C8 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802572c, 0x0802a2f0)  (0x4bc4 bytes)
@
@ Post-peel chunk after sub_080256C8.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_0802572c
	.type   text_0802572c, %object
text_0802572c:
	.incbin "frog_us_baserom.gba", 0x0002572c, 0x00004bc4
	.size   text_0802572c, . - text_0802572c
