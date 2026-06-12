@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08033948, 0x080339f0)  (0xa8 bytes)
@
@ Pre-peel prefix; sub_080339F0 at 0x080339f0 was peeled out.

        .section .text, "ax", %progbits
        .align  2
        .global text_08033948
        .type   text_08033948, %object
text_08033948:
        .incbin "frog_us_baserom.gba", 0x00033948, 0x000000a8
        .size   text_08033948, . - text_08033948
