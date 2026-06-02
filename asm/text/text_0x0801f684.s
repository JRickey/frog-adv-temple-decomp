@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801f684, 0x08020000)  (0x97c bytes)
@
@ Post-peel chunk after sub_0801F418.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801f684
        .type   text_0801f684, %object
text_0801f684:
        .incbin "frog_us_baserom.gba", 0x0001f684, 0x0000097c
        .size   text_0801f684, . - text_0801f684
