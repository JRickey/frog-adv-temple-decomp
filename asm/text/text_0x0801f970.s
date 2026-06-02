@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801f970, 0x08020000)  (0x690 bytes)
@
@ Post-peel chunk after sub_0801F8BC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801f970
        .type   text_0801f970, %object
text_0801f970:
        .incbin "frog_us_baserom.gba", 0x0001f970, 0x00000690
        .size   text_0801f970, . - text_0801f970
