@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08030c4c, 0x080315d8)  (0x0000098c bytes)
@
@ Post-peel chunk after sub_08030B34.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08030c4c
        .type   text_08030c4c, %object
text_08030c4c:
        .incbin "frog_us_baserom.gba", 0x00030c4c, 0x0000098c
        .size   text_08030c4c, . - text_08030c4c
