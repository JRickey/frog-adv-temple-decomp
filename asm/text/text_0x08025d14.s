@ Auto-emitted by peel.py — raw bytes following sub_08025CEC peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025d14, 0x0802a2f0)  (0x45dc bytes)
@
@ Post-peel chunk after sub_08025CEC.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025d14
	.type   text_08025d14, %object
text_08025d14:
	.incbin "baserom.gba", 0x00025d14, 0x000045dc
	.size   text_08025d14, . - text_08025d14
