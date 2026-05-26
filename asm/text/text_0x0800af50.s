@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800af50, 0x0800b7b0)  (0x860 bytes)
@
@ Post-peel chunk after sub_0800AB84.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800af50
        .type   text_0800af50, %object
text_0800af50:
        .incbin "frog_us_baserom.gba", 0x0000af50, 0x00000860
        .size   text_0800af50, . - text_0800af50
