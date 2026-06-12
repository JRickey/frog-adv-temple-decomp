@ Raw bytes after peeled function sub_08030D8C
@ Range: [0x08030e50, 0x080315d8)  (0x788 bytes)

        .section .text, "ax", %progbits
        .align  2
        .global text_08030e50_after
        .type   text_08030e50_after, %object
text_08030e50_after:
        .incbin "baserom.gba", 0x00030e50, 0x00000788
        .size   text_08030e50_after, . - text_08030e50_after
