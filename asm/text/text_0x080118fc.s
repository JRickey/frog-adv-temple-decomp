@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080118fc, 0x08012180)  (0x884 bytes)
@
@ Post-peel chunk after sub_080118D8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080118fc
        .type   text_080118fc, %object
text_080118fc:
        .incbin "frog_us_baserom.gba", 0x000118fc, 0x00000884
        .size   text_080118fc, . - text_080118fc
