@ Auto-emitted by peel.py — raw bytes following sub_080255F4 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025620, 0x0802a2f0)  (0x4cd0 bytes)
@
@ Post-peel chunk after sub_080255F4.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025620
	.type   text_08025620, %object
text_08025620:
	.incbin "frog_us_baserom.gba", 0x00025620, 0x00004cd0
	.size   text_08025620, . - text_08025620
