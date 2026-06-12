@ Auto-emitted by peel.py — raw bytes following sub_080259C4 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025cec, 0x0802a2f0)  (0x4604 bytes)
@
@ Post-peel chunk after sub_080259C4.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025cec
	.type   text_08025cec, %object
text_08025cec:
	.incbin "baserom.gba", 0x00025cec, 0x00004604
	.size   text_08025cec, . - text_08025cec
