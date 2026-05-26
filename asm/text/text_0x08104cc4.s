@ Tail after screen_0800f014 cluster.
@ Range:  [0x08104cc4, 0x08110000)  (raw bytes)

        .section .text, "ax", %progbits
        .align  2
        .global text_08104cc4
        .type   text_08104cc4, %object
text_08104cc4:
        .incbin "frog_us_baserom.gba", 0x00104cc4, 0x0000b33c
        .size   text_08104cc4, . - text_08104cc4
