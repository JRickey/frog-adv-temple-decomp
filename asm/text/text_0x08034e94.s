@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08034e94, 0x08035708)  (0x874 bytes)
@
@ Post-peel chunk after sub_08034BF8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08034e94
        .type   text_08034e94, %object
text_08034e94:
        .incbin "frog_us_baserom.gba", 0x00034e94, 0x00000874
        .size   text_08034e94, . - text_08034e94
