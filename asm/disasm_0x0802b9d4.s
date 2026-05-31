@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802b9d4, 0x0802ba64)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802b9d4 --end 0x802ba64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802b9d4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802b9d6: b083        sub	sp, #12
@   0x0802b9d8: 4a1e        ldr	r2, [pc, #120]	@ (0x2ba54)
@   0x0802b9da: 9801        ldr	r0, [sp, #4]
@   0x0802b9dc: 4010        ands	r0, r2
@   0x0802b9de: 2114        movs	r1, #20
@   0x0802b9e0: 4308        orrs	r0, r1
@   0x0802b9e2: 491d        ldr	r1, [pc, #116]	@ (0x2ba58)
@   0x0802b9e4: 4008        ands	r0, r1
@   0x0802b9e6: 9001        str	r0, [sp, #4]
@   0x0802b9e8: 9802        ldr	r0, [sp, #8]
@   0x0802b9ea: 4010        ands	r0, r2
@   0x0802b9ec: 9002        str	r0, [sp, #8]
@   0x0802b9ee: 481b        ldr	r0, [pc, #108]	@ (0x2ba5c)
@   0x0802b9f0: 2700        movs	r7, #0
@   0x0802b9f2: 1c05        adds	r5, r0, #0
@   0x0802b9f4: 35aa        adds	r5, #170	@ 0xaa
@   0x0802b9f6: 2613        movs	r6, #19
@   0x0802b9f8: 2100        movs	r1, #0
@   0x0802b9fa: 5e68        ldrsh	r0, [r5, r1]
@   0x0802b9fc: 2118        movs	r1, #24
@   0x0802b9fe: f008        f989 	bl	0x33d14
@   0x0802ba02: 1c04        adds	r4, r0, #0
@   0x0802ba04: 0424        lsls	r4, r4, #16
@   0x0802ba06: 1424        asrs	r4, r4, #16
@   0x0802ba08: 2102        movs	r1, #2
@   0x0802ba0a: 5e68        ldrsh	r0, [r5, r1]
@   0x0802ba0c: 2118        movs	r1, #24
@   0x0802ba0e: f008        f981 	bl	0x33d14
@   0x0802ba12: 1c01        adds	r1, r0, #0
@   0x0802ba14: 0409        lsls	r1, r1, #16
@   0x0802ba16: 1409        asrs	r1, r1, #16
@   0x0802ba18: 1c20        adds	r0, r4, #0
@   0x0802ba1a: f7e1        fc29 	bl	0xd270
@   0x0802ba1e: 0600        lsls	r0, r0, #24
@   0x0802ba20: 0e00        lsrs	r0, r0, #24
@   0x0802ba22: 2801        cmp	r0, #1
@   0x0802ba24: d005        beq.n	0x2ba32
@   0x0802ba26: 2008        movs	r0, #8
@   0x0802ba28: 8e69        ldrh	r1, [r5, #50]	@ 0x32
@   0x0802ba2a: 4308        orrs	r0, r1
@   0x0802ba2c: 2104        movs	r1, #4
@   0x0802ba2e: 4308        orrs	r0, r1
@   0x0802ba30: 8668        strh	r0, [r5, #50]	@ 0x32
@   0x0802ba32: 3538        adds	r5, #56	@ 0x38
@   0x0802ba34: 3e01        subs	r6, #1
@   0x0802ba36: 2e00        cmp	r6, #0
@   0x0802ba38: dade        bge.n	0x2b9f8
@   0x0802ba3a: 2000        movs	r0, #0
@   0x0802ba3c: 4b08        ldr	r3, [pc, #32]	@ (0x2ba60)
@   0x0802ba3e: 9000        str	r0, [sp, #0]
@   0x0802ba40: 2003        movs	r0, #3
@   0x0802ba42: a901        add	r1, sp, #4
@   0x0802ba44: 2256        movs	r2, #86	@ 0x56
@   0x0802ba46: f7f5        fd63 	bl	0x21510
@   0x0802ba4a: b003        add	sp, #12
@   0x0802ba4c: bcf0        pop	{r4, r5, r6, r7}
@   0x0802ba4e: bc01        pop	{r0}
@   0x0802ba50: 4700        bx	r0
@   0x0802ba52: 0000        movs	r0, r0
@   0x0802ba54: 0000        movs	r0, r0
@   0x0802ba56: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0802ba5a: 0000        movs	r0, r0
@   0x0802ba5c: 3720        adds	r7, #32
@   0x0802ba5e: 0300        lsls	r0, r0, #12
@   0x0802ba60: 6110        str	r0, [r2, #16]
@   0x0802ba62: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802B9D4
sub_0802B9D4: @ 0x0802b9d4
        .incbin "frog_us_baserom.gba", 0x2b9d4, 0x90
        thumb_func_end sub_0802B9D4
