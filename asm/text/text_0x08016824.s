@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08016824, 0x08016a40)  (0x21c bytes)
@
@ Post-peel chunk after sub_08016650.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08016824
        .type   text_08016824, %object
text_08016824:
        .incbin "frog_us_baserom.gba", 0x00016824, 0x0000021c
        .size   text_08016824, . - text_08016824
