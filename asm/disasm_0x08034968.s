@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08034968, 0x080349d8)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8034968 --end 0x80349d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08034968: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0803496a: b084        sub	sp, #16
@   0x0803496c: 9000        str	r0, [sp, #0]
@   0x0803496e: 9101        str	r1, [sp, #4]
@   0x08034970: 9202        str	r2, [sp, #8]
@   0x08034972: 9303        str	r3, [sp, #12]
@   0x08034974: 9b00        ldr	r3, [sp, #0]
@   0x08034976: 4817        ldr	r0, [pc, #92]	@ (0x349d4)
@   0x08034978: 4684        mov	ip, r0
@   0x0803497a: 1c1a        adds	r2, r3, #0
@   0x0803497c: 4002        ands	r2, r0
@   0x0803497e: 0c1b        lsrs	r3, r3, #16
@   0x08034980: 9902        ldr	r1, [sp, #8]
@   0x08034982: 1c08        adds	r0, r1, #0
@   0x08034984: 4664        mov	r4, ip
@   0x08034986: 4020        ands	r0, r4
@   0x08034988: 0c09        lsrs	r1, r1, #16
@   0x0803498a: 1c15        adds	r5, r2, #0
@   0x0803498c: 4345        muls	r5, r0
@   0x0803498e: 1c14        adds	r4, r2, #0
@   0x08034990: 434c        muls	r4, r1
@   0x08034992: 1c1a        adds	r2, r3, #0
@   0x08034994: 4342        muls	r2, r0
@   0x08034996: 434b        muls	r3, r1
@   0x08034998: 0c28        lsrs	r0, r5, #16
@   0x0803499a: 1824        adds	r4, r4, r0
@   0x0803499c: 18a4        adds	r4, r4, r2
@   0x0803499e: 4294        cmp	r4, r2
@   0x080349a0: d202        bcs.n	0x349a8
@   0x080349a2: 2080        movs	r0, #128	@ 0x80
@   0x080349a4: 0240        lsls	r0, r0, #9
@   0x080349a6: 181b        adds	r3, r3, r0
@   0x080349a8: 0c20        lsrs	r0, r4, #16
@   0x080349aa: 181f        adds	r7, r3, r0
@   0x080349ac: 4661        mov	r1, ip
@   0x080349ae: 400c        ands	r4, r1
@   0x080349b0: 0420        lsls	r0, r4, #16
@   0x080349b2: 400d        ands	r5, r1
@   0x080349b4: 1c06        adds	r6, r0, #0
@   0x080349b6: 432e        orrs	r6, r5
@   0x080349b8: 1c39        adds	r1, r7, #0
@   0x080349ba: 1c30        adds	r0, r6, #0
@   0x080349bc: 9b00        ldr	r3, [sp, #0]
@   0x080349be: 9c03        ldr	r4, [sp, #12]
@   0x080349c0: 1c1a        adds	r2, r3, #0
@   0x080349c2: 4362        muls	r2, r4
@   0x080349c4: 9d01        ldr	r5, [sp, #4]
@   0x080349c6: 9c02        ldr	r4, [sp, #8]
@   0x080349c8: 1c2b        adds	r3, r5, #0
@   0x080349ca: 4363        muls	r3, r4
@   0x080349cc: 18d2        adds	r2, r2, r3
@   0x080349ce: 18b9        adds	r1, r7, r2
@   0x080349d0: b004        add	sp, #16
@   0x080349d2: bdf0        pop	{r4, r5, r6, r7, pc}
@   0x080349d4: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0

        thumb_func_start __muldi3
__muldi3: @ 0x08034968 — libgcc 64-bit integer multiply helper
        .incbin "frog_us_baserom.gba", 0x34968, 0x70
        thumb_func_end __muldi3
