@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802af10, 0x0802b008)  (0xf8 bytes)
@
@ Post-peel chunk after RoomFrogEntity_Update.
@ Trimmed at 0x0802b2ec when sub_0802B2EC was peeled.
@ Trimmed at 0x0802b008 when sub_0802B008 was peeled.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802af10
        .type   text_0802af10, %object
text_0802af10:
        .incbin "frog_us_baserom.gba", 0x0002af10, 0x000000f8
        .size   text_0802af10, . - text_0802af10
