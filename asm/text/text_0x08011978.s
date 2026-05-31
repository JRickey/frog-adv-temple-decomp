@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08011978, 0x08012180)  (0x808 bytes)
@
@ Post-peel chunk after sub_0801190C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08011978
        .type   text_08011978, %object
text_08011978:
        .incbin "frog_us_baserom.gba", 0x00011978, 0x00000808
        .size   text_08011978, . - text_08011978
