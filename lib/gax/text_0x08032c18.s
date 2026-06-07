@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08032c18, 0x080338a8)  (0xc90 bytes)
@
@ Post-peel chunk after SoundVoice_Init.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08032c18
        .type   text_08032c18, %object
text_08032c18:
        .incbin "frog_us_baserom.gba", 0x00032c18, 0x000001ec
        .size   text_08032c18, . - text_08032c18
