@ Auto-emitted by peeler — raw bytes after sub_080273F4.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027458, 0x0802a2f0)  (0x2e98 bytes)
@
@ Post-peel chunk after sub_080273F4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027458
        .type   text_08027458, %object
text_08027458:
        .incbin "frog_us_baserom.gba", 0x27458, 0x2e98
        .size   text_08027458, . - text_08027458
