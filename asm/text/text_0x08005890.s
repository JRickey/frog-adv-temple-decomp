@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08005890, 0x080059c4)  (0x134 bytes)
@
@ Post-peel chunk after sub_0800586C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08005890
        .type   text_08005890, %object
text_08005890:
        .incbin "frog_us_baserom.gba", 0x00005890, 0x00000134
        .size   text_08005890, . - text_08005890
