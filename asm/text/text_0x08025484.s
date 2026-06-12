@ Auto-emitted by peel.py — raw bytes following sub_0802543C peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025484, 0x0802a2f0)  (0x4e6c bytes)
@
@ Post-peel chunk after sub_0802543C.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025484
	.type   text_08025484, %object
text_08025484:
	.incbin "frog_us_baserom.gba", 0x00025484, 0x00004e6c
	.size   text_08025484, . - text_08025484
