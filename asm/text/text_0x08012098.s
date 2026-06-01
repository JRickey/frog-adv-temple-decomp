@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08012098, 0x08012180)  (0xe8 bytes)
@
@ Post-peel chunk after sub_08011E40.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08012098
        .type   text_08012098, %object
text_08012098:
        .incbin "frog_us_baserom.gba", 0x00012098, 0x000000e8
        .size   text_08012098, . - text_08012098
