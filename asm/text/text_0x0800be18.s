@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800be18, 0x0800cd88)  (0xf70 bytes)
@
@ Post-peel chunk after sub_0800B918.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800be18
        .type   text_0800be18, %object
text_0800be18:
        .incbin "frog_us_baserom.gba", 0x0000be18, 0x00000f70
        .size   text_0800be18, . - text_0800be18
