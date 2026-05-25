@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802e724, 0x0802e934)  (0x210 bytes)
@
@ Post-peel chunk after sub_0802E684.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802e724
        .type   text_0802e724, %object
text_0802e724:
        .incbin "frog_us_baserom.gba", 0x0002e724, 0x00000210
        .size   text_0802e724, . - text_0802e724
