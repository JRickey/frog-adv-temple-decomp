@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020414, 0x080204a4)  (0x90 bytes)
@
@ Post-peel chunk after sub_080202F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020414
        .type   text_08020414, %object
text_08020414:
        .incbin "frog_us_baserom.gba", 0x00020414, 0x00000090
        .size   text_08020414, . - text_08020414
