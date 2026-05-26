@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0820d778, 0x08210000)  (0x2888 bytes; tail after screen_c578 cluster)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0820d778
        .type   text_0820d778, %object
text_0820d778:
        .incbin "frog_us_baserom.gba", 0x0020d778, 0x00002888
        .size   text_0820d778, . - text_0820d778
