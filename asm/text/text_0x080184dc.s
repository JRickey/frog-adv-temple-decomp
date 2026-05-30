@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080184dc, 0x0801932c)  (0xe50 bytes)
@
@ Post-peel chunk after sub_080182CC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080184dc
        .type   text_080184dc, %object
text_080184dc:
        .incbin "frog_us_baserom.gba", 0x000184dc, 0x00000e50
        .size   text_080184dc, . - text_080184dc
