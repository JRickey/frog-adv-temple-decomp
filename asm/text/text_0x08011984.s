@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08011984, 0x08012180)  (0x7fc bytes)
@
@ Post-peel chunk after sub_08011978.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08011984
        .type   text_08011984, %object
text_08011984:
        .incbin "frog_us_baserom.gba", 0x00011984, 0x000007fc
        .size   text_08011984, . - text_08011984
