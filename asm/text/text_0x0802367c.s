@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802367c, 0x0802a2f0)  (0x6c74 bytes)
@
@ Post-peel chunk after sub_080235C8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802367c
        .type   text_0802367c, %object
text_0802367c:
        .incbin "frog_us_baserom.gba", 0x0002367c, 0x00006c74
        .size   text_0802367c, . - text_0802367c
