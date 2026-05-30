@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08005960, 0x080059c4)  (0x64 bytes)
@
@ Post-peel chunk after sub_080058FC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08005960
        .type   text_08005960, %object
text_08005960:
        .incbin "frog_us_baserom.gba", 0x00005960, 0x00000064
        .size   text_08005960, . - text_08005960
