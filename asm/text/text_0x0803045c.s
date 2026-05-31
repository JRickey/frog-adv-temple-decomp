@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0803045c, 0x080315d8)  (0x117c bytes)
@
@ Post-peel chunk after sub_0803038C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0803045c
        .type   text_0803045c, %object
text_0803045c:
        .incbin "frog_us_baserom.gba", 0x0003045c, 0x0000117c
        .size   text_0803045c, . - text_0803045c
