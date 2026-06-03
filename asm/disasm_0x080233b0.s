@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080233b0, 0x080233d4)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80233b0 --end 0x80233d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080233b0: b500        push	{lr}
@   0x080233b2: b081        sub	sp, #4
@   0x080233b4: 4905        ldr	r1, [pc, #20]	@ (0x233cc)
@   0x080233b6: 4b06        ldr	r3, [pc, #24]	@ (0x233d0)
@   0x080233b8: 2000        movs	r0, #0
@   0x080233ba: 9000        str	r0, [sp, #0]
@   0x080233bc: 204e        movs	r0, #78	@ 0x4e
@   0x080233be: 220b        movs	r2, #11
@   0x080233c0: f7fe        f8a6 	bl	0x21510
@   0x080233c4: b001        add	sp, #4
@   0x080233c6: bc01        pop	{r0}
@   0x080233c8: 4700        bx	r0
@   0x080233ca: 0000        movs	r0, r0
@   0x080233cc: 1d38        adds	r0, r7, #4
@   0x080233ce: 0831        lsrs	r1, r6, #32
@   0x080233d0: 6110        str	r0, [r2, #16]
@   0x080233d2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080233B0
sub_080233B0: @ 0x080233b0
        .incbin "frog_us_baserom.gba", 0x233b0, 0x24
        thumb_func_end sub_080233B0
