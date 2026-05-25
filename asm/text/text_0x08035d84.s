@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08035d84, 0x08040000)  (0xa27c bytes)
@
@ Post-peel chunk after sub_08035D7C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08035d84
        .type   text_08035d84, %object
text_08035d84:
        .incbin "frog_us_baserom.gba", 0x00035d84, 0x0000a27c
        .size   text_08035d84, . - text_08035d84
