@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802af10, 0x0802af4c)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802af10 --end 0x802af4c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802af10: b570        push	{r4, r5, r6, lr}
@   0x0802af12: b084        sub	sp, #16
@   0x0802af14: 2400        movs	r4, #0
@   0x0802af16: 4e0c        ldr	r6, [pc, #48]	@ (0x2af48)
@   0x0802af18: 2503        movs	r5, #3
@   0x0802af1a: 1ce0        adds	r0, r4, #3
@   0x0802af1c: 00a1        lsls	r1, r4, #2
@   0x0802af1e: 1989        adds	r1, r1, r6
@   0x0802af20: 6809        ldr	r1, [r1, #0]
@   0x0802af22: 2281        movs	r2, #129	@ 0x81
@   0x0802af24: 9200        str	r2, [sp, #0]
@   0x0802af26: 2202        movs	r2, #2
@   0x0802af28: 9201        str	r2, [sp, #4]
@   0x0802af2a: 9502        str	r5, [sp, #8]
@   0x0802af2c: 9503        str	r5, [sp, #12]
@   0x0802af2e: 2210        movs	r2, #16
@   0x0802af30: 2326        movs	r3, #38	@ 0x26
@   0x0802af32: f7f6        f8b5 	bl	0x210a0
@   0x0802af36: 1c60        adds	r0, r4, #1
@   0x0802af38: 0600        lsls	r0, r0, #24
@   0x0802af3a: 0e04        lsrs	r4, r0, #24
@   0x0802af3c: 2c03        cmp	r4, #3
@   0x0802af3e: d9ec        bls.n	0x2af1a
@   0x0802af40: b004        add	sp, #16
@   0x0802af42: bc70        pop	{r4, r5, r6}
@   0x0802af44: bc01        pop	{r0}
@   0x0802af46: 4700        bx	r0
@   0x0802af48: 7f58        ldrb	r0, [r3, #29]
@   0x0802af4a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802AF10
sub_0802AF10: @ 0x0802af10
        .incbin "baserom.gba", 0x2af10, 0x3c
        thumb_func_end sub_0802AF10
