@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004470, 0x08004508)  (0x98 bytes)
@
@ Post-peel chunk after sub_0800441C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004470
        .type   text_08004470, %object
text_08004470:
        .incbin "frog_us_baserom.gba", 0x00004470, 0x00000098
        .size   text_08004470, . - text_08004470
