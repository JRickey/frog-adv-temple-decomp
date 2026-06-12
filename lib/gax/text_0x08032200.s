@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08032200, 0x080323cc)  (0x1cc bytes)
@
@ Post-peel chunk after SoundSystem_IsActive.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08032200
        .type   text_08032200, %object
text_08032200:
        .incbin "frog_us_baserom.gba", 0x00032200, 0x000001cc
        .size   text_08032200, . - text_08032200
