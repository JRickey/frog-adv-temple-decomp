@ Auto-emitted by peel.py — raw bytes for unpeel function sub_08025904.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025904, 0x080259c4)  (0xc0 bytes)
@
@ Unpeel function that sits between peels.
@
@ This file holds raw bytes only; no instructions are assembled here.

	.section .text, "ax", %progbits
	.align  2
	.global text_08025904
	.type   text_08025904, %object
text_08025904:
	.incbin "baserom.gba", 0x00025904, 0x000000c0
	.size   text_08025904, . - text_08025904
