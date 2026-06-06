@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006a0c, 0x08006a74)  (0x68 bytes)
@
@ Post-peel chunk after EventFlags_ClearBit.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006a0c
        .type   text_08006a0c, %object
text_08006a0c:
        .incbin "frog_us_baserom.gba", 0x00006a0c, 0x00000068
        .size   text_08006a0c, . - text_08006a0c
