@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08030158, 0x080301c4)  (0x6c bytes)
@
@ Post-peel chunk after sub_0802FAB8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08030158
        .type   text_08030158, %object
text_08030158:
        .incbin "frog_us_baserom.gba", 0x00030158, 0x0000006c
        .size   text_08030158, . - text_08030158
