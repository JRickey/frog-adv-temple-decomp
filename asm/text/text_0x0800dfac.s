@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800dfac, 0x0800dffc)  (0x50 bytes)
@
@ Post-peel chunk after sub_0800DF9C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800dfac
        .type   text_0800dfac, %object
text_0800dfac:
        .incbin "frog_us_baserom.gba", 0x0000dfac, 0x00000050
        .size   text_0800dfac, . - text_0800dfac
