@ Raw tail bytes after sub_080178FC.

        .section .text, "ax", %progbits
        .align  2
        .global text_08017938
        .type   text_08017938, %object
text_08017938:
        .incbin "frog_us_baserom.gba", 0x00017938, 0x00000004
        .size   text_08017938, . - text_08017938
