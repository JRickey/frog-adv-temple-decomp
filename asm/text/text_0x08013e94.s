@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013e94, 0x08013fa0)  (0x10c bytes)
@
@ Post-peel chunk after sub_08013DFC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013e94
        .type   text_08013e94, %object
text_08013e94:
        .incbin "frog_us_baserom.gba", 0x00013e94, 0x0000010c
        .size   text_08013e94, . - text_08013e94
