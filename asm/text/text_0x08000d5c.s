@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08000d5c, 0x08000eb8)  (0x15c bytes)
@
@ Post-peel chunk after sub_08000D50.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08000d5c
        .type   text_08000d5c, %object
text_08000d5c:
        .incbin "frog_us_baserom.gba", 0x00000d5c, 0x0000015c
        .size   text_08000d5c, . - text_08000d5c
