@ Auto-emitted by wire.py (manual)
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080297f0, 0x0802a2f0)

        .section .text, "ax", %progbits
        .balign 1
        .incbin "frog_us_baserom.gba", 0x000297f0, 0x00000b00
