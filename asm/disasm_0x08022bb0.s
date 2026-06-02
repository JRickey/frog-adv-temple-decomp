@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022bb0, 0x08022bcc)  (28 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022bb0 --end 0x8022bcc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022bb0: b500        push	{lr}
@   0x08022bb2: 4805        ldr	r0, [pc, #20]	@ (0x22bc8)
@   0x08022bb4: 3031        adds	r0, #49	@ 0x31
@   0x08022bb6: 2100        movs	r1, #0
@   0x08022bb8: 7001        strb	r1, [r0, #0]
@   0x08022bba: f7ff        fee1 	bl	0x22980
@   0x08022bbe: f7ff        ff05 	bl	0x229cc
@   0x08022bc2: bc01        pop	{r0}
@   0x08022bc4: 4700        bx	r0
@   0x08022bc6: 0000        movs	r0, r0
@   0x08022bc8: 6110        str	r0, [r2, #16]
@   0x08022bca: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08022BB0
sub_08022BB0: @ 0x08022bb0
        .incbin "frog_us_baserom.gba", 0x22bb0, 0x1c
        thumb_func_end sub_08022BB0
