.include "asm/macros.inc"
.syntax unified

.text
.align 2

@ Raw bytes from baserom.gba [0x0802af84, 0x0802b008)
.incbin "baserom.gba", 0x2af84, 0x84
