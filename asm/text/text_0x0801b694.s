@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801b694, 0x0801bb54)  (0x4c0 bytes)
@
@ Post-peel chunk after sub_0801B514.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801b694
        .type   text_0801b694, %object
text_0801b694:
        .incbin "frog_us_baserom.gba", 0x0001b694, 0x000004c0
        .size   text_0801b694, . - text_0801b694
