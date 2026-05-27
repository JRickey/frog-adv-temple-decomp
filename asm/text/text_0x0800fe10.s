@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800fe10, 0x0800fe88)  (0x78 bytes)
@
@ Pre-peel chunk before sub_0800FE88; the 0xfdf4..0xfe10 prefix moved
@ into src/engine/sub_0800fd50.o as that function's extended literal pool.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800fe10
        .type   text_0800fe10, %object
text_0800fe10:
        .incbin "frog_us_baserom.gba", 0x0000fe10, 0x00000078
        .size   text_0800fe10, . - text_0800fe10
