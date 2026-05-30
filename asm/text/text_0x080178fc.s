@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080178fc, 0x0801793c)  (0x40 bytes)
@
@ Post-peel chunk after sub_0801789C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080178fc
        .type   text_080178fc, %object
text_080178fc:
        .incbin "frog_us_baserom.gba", 0x000178fc, 0x00000040
        .size   text_080178fc, . - text_080178fc
