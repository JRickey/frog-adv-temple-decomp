@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800c978, 0x0800cb80)  (0x208 bytes)
@
@ Post-peel chunk after sub_0800C4E8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800c978
        .type   text_0800c978, %object
text_0800c978:
        .incbin "frog_us_baserom.gba", 0x0000c978, 0x00000208
        .size   text_0800c978, . - text_0800c978
