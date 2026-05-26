@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08200000, 0x0820c578)  (0xc578 bytes; shrunk for screen_c578 cluster)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08200000
        .type   text_08200000, %object
text_08200000:
        .incbin "frog_us_baserom.gba", 0x00200000, 0x0000c578
        .size   text_08200000, . - text_08200000
