@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024070, 0x08024094)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024070 --end 0x8024094 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024070: b500        push	{lr}
@   0x08024072: b081        sub	sp, #4
@   0x08024074: 4905        ldr	r1, [pc, #20]	@ (0x2408c)
@   0x08024076: 4b06        ldr	r3, [pc, #24]	@ (0x24090)
@   0x08024078: 2000        movs	r0, #0
@   0x0802407a: 9000        str	r0, [sp, #0]
@   0x0802407c: 2014        movs	r0, #20
@   0x0802407e: 2202        movs	r2, #2
@   0x08024080: f7fd        fa46 	bl	0x21510
@   0x08024084: b001        add	sp, #4
@   0x08024086: bc01        pop	{r0}
@   0x08024088: 4700        bx	r0
@   0x0802408a: 0000        movs	r0, r0
@   0x0802408c: 2148        movs	r1, #72	@ 0x48
@   0x0802408e: 0831        lsrs	r1, r6, #32
@   0x08024090: 6110        str	r0, [r2, #16]
@   0x08024092: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08024070
sub_08024070: @ 0x08024070
        .incbin "frog_us_baserom.gba", 0x24070, 0x24
        thumb_func_end sub_08024070
