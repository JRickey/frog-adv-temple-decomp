@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002e94, 0x08002ee8)  (0x54 bytes)
@
@ Post-peel chunk after sub_08002E44.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002e94
        .type   text_08002e94, %object
text_08002e94:
        .incbin "frog_us_baserom.gba", 0x00002e94, 0x00000054
        .size   text_08002e94, . - text_08002e94
