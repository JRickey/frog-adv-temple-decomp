@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080339ac, 0x080339f0)  (0x44 bytes)
@
@ Pre-peel prefix; sub_080339F0 at 0x080339f0 was peeled out.
@ sub_08033948 at 0x08033948 was peeled out (100 bytes, thumb).

        .section .text, "ax", %progbits
        .align  2
        .global text_080339ac
        .type   text_080339ac, %object
text_080339ac:
        .incbin "frog_us_baserom.gba", 0x000339ac, 0x00000044
        .size   text_080339ac, . - text_080339ac
