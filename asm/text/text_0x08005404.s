@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08005404, 0x080054a8)  (0xa4 bytes)
@
@ Post-peel chunk after Gate_FinishScene.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08005404
        .type   text_08005404, %object
text_08005404:
        .incbin "frog_us_baserom.gba", 0x00005404, 0x000000a4
        .size   text_08005404, . - text_08005404

@ Thumb function alias so C code can BL to this address correctly.
        .thumb_func
        .global Entity_UpdateHitAndDraw
        .set    Entity_UpdateHitAndDraw, text_08005404
