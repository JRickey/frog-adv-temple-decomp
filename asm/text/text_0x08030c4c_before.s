@ Raw bytes before peeled function sub_08030D8C
@ Range: [0x08030c4c, 0x08030d8c)  (0x140 bytes)

        .section .text, "ax", %progbits
        .align  2
        .global text_08030c4c_before
        .type   text_08030c4c_before, %object
text_08030c4c_before:
        .incbin "baserom.gba", 0x00030c4c, 0x00000140
        .size   text_08030c4c_before, . - text_08030c4c_before
