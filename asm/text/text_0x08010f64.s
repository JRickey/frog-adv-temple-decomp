@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08010f64, 0x0801129c)  (0x338 bytes)
@
@ Post-peel chunk after sub_08010DD8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08010f64
        .type   text_08010f64, %object
text_08010f64:
        .incbin "frog_us_baserom.gba", 0x00010f64, 0x00000338
        .size   text_08010f64, . - text_08010f64
