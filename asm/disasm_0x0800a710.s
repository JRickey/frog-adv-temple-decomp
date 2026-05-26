@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a710, 0x0800a7a8)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a710 --end 0x800a7a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a710: b570        push	{r4, r5, r6, lr}
@   0x0800a712: 4656        mov	r6, sl
@   0x0800a714: 464d        mov	r5, r9
@   0x0800a716: 4644        mov	r4, r8
@   0x0800a718: b470        push	{r4, r5, r6}
@   0x0800a71a: 9d07        ldr	r5, [sp, #28]
@   0x0800a71c: 9e08        ldr	r6, [sp, #32]
@   0x0800a71e: 9c09        ldr	r4, [sp, #36]	@ 0x24
@   0x0800a720: 46a0        mov	r8, r4
@   0x0800a722: 9c0a        ldr	r4, [sp, #40]	@ 0x28
@   0x0800a724: 46a1        mov	r9, r4
@   0x0800a726: 9c0b        ldr	r4, [sp, #44]	@ 0x2c
@   0x0800a728: 46a2        mov	sl, r4
@   0x0800a72a: 9c0c        ldr	r4, [sp, #48]	@ 0x30
@   0x0800a72c: 0424        lsls	r4, r4, #16
@   0x0800a72e: 0c24        lsrs	r4, r4, #16
@   0x0800a730: 7001        strb	r1, [r0, #0]
@   0x0800a732: 8042        strh	r2, [r0, #2]
@   0x0800a734: 8083        strh	r3, [r0, #4]
@   0x0800a736: 7185        strb	r5, [r0, #6]
@   0x0800a738: 8286        strh	r6, [r0, #20]
@   0x0800a73a: 4641        mov	r1, r8
@   0x0800a73c: 7581        strb	r1, [r0, #22]
@   0x0800a73e: 4649        mov	r1, r9
@   0x0800a740: 75c1        strb	r1, [r0, #23]
@   0x0800a742: 4651        mov	r1, sl
@   0x0800a744: 7681        strb	r1, [r0, #26]
@   0x0800a746: 2102        movs	r1, #2
@   0x0800a748: 430c        orrs	r4, r1
@   0x0800a74a: 8684        strh	r4, [r0, #52]	@ 0x34
@   0x0800a74c: bc38        pop	{r3, r4, r5}
@   0x0800a74e: 4698        mov	r8, r3
@   0x0800a750: 46a1        mov	r9, r4
@   0x0800a752: 46aa        mov	sl, r5
@   0x0800a754: bc70        pop	{r4, r5, r6}
@   0x0800a756: bc01        pop	{r0}
@   0x0800a758: 4700        bx	r0
@   0x0800a75a: 0000        movs	r0, r0
@   0x0800a75c: 0409        lsls	r1, r1, #16
@   0x0800a75e: 0c09        lsrs	r1, r1, #16
@   0x0800a760: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x0800a762: 4311        orrs	r1, r2
@   0x0800a764: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0800a766: 4770        bx	lr
@   0x0800a768: 0409        lsls	r1, r1, #16
@   0x0800a76a: 0c09        lsrs	r1, r1, #16
@   0x0800a76c: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x0800a76e: 438a        bics	r2, r1
@   0x0800a770: 1c11        adds	r1, r2, #0
@   0x0800a772: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0800a774: 4770        bx	lr
@   0x0800a776: 0000        movs	r0, r0
@   0x0800a778: 8e80        ldrh	r0, [r0, #52]	@ 0x34
@   0x0800a77a: 4008        ands	r0, r1
@   0x0800a77c: 2800        cmp	r0, #0
@   0x0800a77e: d101        bne.n	0xa784
@   0x0800a780: 2000        movs	r0, #0
@   0x0800a782: e000        b.n	0xa786
@   0x0800a784: 2001        movs	r0, #1
@   0x0800a786: 4770        bx	lr
@   0x0800a788: 8181        strh	r1, [r0, #12]
@   0x0800a78a: 81c2        strh	r2, [r0, #14]
@   0x0800a78c: 8203        strh	r3, [r0, #16]
@   0x0800a78e: 2140        movs	r1, #64	@ 0x40
@   0x0800a790: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x0800a792: 4311        orrs	r1, r2
@   0x0800a794: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0800a796: 4770        bx	lr
@   0x0800a798: 4902        ldr	r1, [pc, #8]	@ (0xa7a4)
@   0x0800a79a: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x0800a79c: 4011        ands	r1, r2
@   0x0800a79e: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0800a7a0: 4770        bx	lr
@   0x0800a7a2: 0000        movs	r0, r0
@   0x0800a7a4: ffbf        0000 	vaddl.u<illegal width 64>	q0, d15, d0

        thumb_func_start sub_0800A710
sub_0800A710: @ 0x0800a710
        .incbin "frog_us_baserom.gba", 0xa710, 0x98
        thumb_func_end sub_0800A710
