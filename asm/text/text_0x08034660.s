@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08034660, 0x08034760)  (0x100 bytes)
@
@ Post-peel chunk after sub_0803457C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08034660
        .type   text_08034660, %object
text_08034660:
        .incbin "frog_us_baserom.gba", 0x00034660, 0x00000100
        .size   text_08034660, . - text_08034660
