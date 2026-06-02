@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080199e4, 0x08019a14)  (48 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80199e4 --end 0x8019a14 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080199e4: b510        push	{r4, lr}
@   0x080199e6: 2200        movs	r2, #0
@   0x080199e8: 4c08        ldr	r4, [pc, #32]	@ (0x19a0c)
@   0x080199ea: 4909        ldr	r1, [pc, #36]	@ (0x19a10)
@   0x080199ec: 2300        movs	r3, #0
@   0x080199ee: 1850        adds	r0, r2, r1
@   0x080199f0: 7003        strb	r3, [r0, #0]
@   0x080199f2: 1c50        adds	r0, r2, #1
@   0x080199f4: 0600        lsls	r0, r0, #24
@   0x080199f6: 0e02        lsrs	r2, r0, #24
@   0x080199f8: 2a15        cmp	r2, #21
@   0x080199fa: d9f8        bls.n	0x199ee
@   0x080199fc: 1c21        adds	r1, r4, #0
@   0x080199fe: 3120        adds	r1, #32
@   0x08019a00: 2000        movs	r0, #0
@   0x08019a02: 7008        strb	r0, [r1, #0]
@   0x08019a04: bc10        pop	{r4}
@   0x08019a06: bc01        pop	{r0}
@   0x08019a08: 4700        bx	r0
@   0x08019a0a: 0000        movs	r0, r0
@   0x08019a0c: 5330        strh	r0, [r6, r4]
@   0x08019a0e: 0300        lsls	r0, r0, #12
@   0x08019a10: 3610        adds	r6, #16
@   0x08019a12: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080199E4
sub_080199E4: @ 0x080199e4
        .incbin "frog_us_baserom.gba", 0x199e4, 0x30
        thumb_func_end sub_080199E4
