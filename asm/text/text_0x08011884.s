@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08011884, 0x08012664)  (0xde0 bytes)
@
@ Post-peel chunk after sub_0801185C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08011884
        .type   text_08011884, %object
text_08011884:
        .incbin "frog_us_baserom.gba", 0x00011884, 0x00000de0
        .size   text_08011884, . - text_08011884
