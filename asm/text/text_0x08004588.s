@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004588, 0x080045ec)  (0x64 bytes)
@
@ Post-peel chunk after sub_08004508.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004588
        .type   text_08004588, %object
text_08004588:
        .incbin "frog_us_baserom.gba", 0x00004588, 0x00000064
        .size   text_08004588, . - text_08004588
