@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801d880, 0x0801da1c)  (0x19c bytes)
@
@ Post-peel chunk after sub_0801D570.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801d880
        .type   text_0801d880, %object
text_0801d880:
        .incbin "frog_us_baserom.gba", 0x0001d880, 0x0000019c
        .size   text_0801d880, . - text_0801d880
