@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801f8bc, 0x0801f970)  (180 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801f8bc --end 0x801f970 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801f8bc: b530        push	{r4, r5, lr}
@   0x0801f8be: b084        sub	sp, #16
@   0x0801f8c0: 0600        lsls	r0, r0, #24
@   0x0801f8c2: 0e05        lsrs	r5, r0, #24
@   0x0801f8c4: 4910        ldr	r1, [pc, #64]	@ (0x1f908)
@   0x0801f8c6: 4668        mov	r0, sp
@   0x0801f8c8: 220a        movs	r2, #10
@   0x0801f8ca: f015        ff5f 	bl	0x3578c
@   0x0801f8ce: 480f        ldr	r0, [pc, #60]	@ (0x1f90c)
@   0x0801f8d0: 9903        ldr	r1, [sp, #12]
@   0x0801f8d2: 4001        ands	r1, r0
@   0x0801f8d4: 2002        movs	r0, #2
@   0x0801f8d6: 4301        orrs	r1, r0
@   0x0801f8d8: 4a0d        ldr	r2, [pc, #52]	@ (0x1f910)
@   0x0801f8da: 4011        ands	r1, r2
@   0x0801f8dc: 23c0        movs	r3, #192	@ 0xc0
@   0x0801f8de: 009b        lsls	r3, r3, #2
@   0x0801f8e0: 4319        orrs	r1, r3
@   0x0801f8e2: 480c        ldr	r0, [pc, #48]	@ (0x1f914)
@   0x0801f8e4: 4001        ands	r1, r0
@   0x0801f8e6: 2080        movs	r0, #128	@ 0x80
@   0x0801f8e8: 04c0        lsls	r0, r0, #19
@   0x0801f8ea: 4301        orrs	r1, r0
@   0x0801f8ec: 480a        ldr	r0, [pc, #40]	@ (0x1f918)
@   0x0801f8ee: 4001        ands	r1, r0
@   0x0801f8f0: 20d0        movs	r0, #208	@ 0xd0
@   0x0801f8f2: 0340        lsls	r0, r0, #13
@   0x0801f8f4: 4301        orrs	r1, r0
@   0x0801f8f6: 9103        str	r1, [sp, #12]
@   0x0801f8f8: 2d01        cmp	r5, #1
@   0x0801f8fa: d017        beq.n	0x1f92c
@   0x0801f8fc: 2d01        cmp	r5, #1
@   0x0801f8fe: dc0d        bgt.n	0x1f91c
@   0x0801f900: 2d00        cmp	r5, #0
@   0x0801f902: d010        beq.n	0x1f926
@   0x0801f904: e01f        b.n	0x1f946
@   0x0801f906: 0000        movs	r0, r0
@   0x0801f908: e804        081b 			@ <UNDEFINED> instruction: 0xe804081b
@   0x0801f90c: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801f910: 00ff        lsls	r7, r7, #3
@   0x0801f912: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801f916: 00ff        lsls	r7, r7, #3
@   0x0801f918: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801f91c: 2d02        cmp	r5, #2
@   0x0801f91e: d009        beq.n	0x1f934
@   0x0801f920: 2d03        cmp	r5, #3
@   0x0801f922: d00b        beq.n	0x1f93c
@   0x0801f924: e00f        b.n	0x1f946
@   0x0801f926: 4011        ands	r1, r2
@   0x0801f928: 4319        orrs	r1, r3
@   0x0801f92a: e00b        b.n	0x1f944
@   0x0801f92c: 4011        ands	r1, r2
@   0x0801f92e: 20e0        movs	r0, #224	@ 0xe0
@   0x0801f930: 00c0        lsls	r0, r0, #3
@   0x0801f932: e006        b.n	0x1f942
@   0x0801f934: 4011        ands	r1, r2
@   0x0801f936: 20b0        movs	r0, #176	@ 0xb0
@   0x0801f938: 0100        lsls	r0, r0, #4
@   0x0801f93a: e002        b.n	0x1f942
@   0x0801f93c: 4011        ands	r1, r2
@   0x0801f93e: 20f0        movs	r0, #240	@ 0xf0
@   0x0801f940: 0100        lsls	r0, r0, #4
@   0x0801f942: 4301        orrs	r1, r0
@   0x0801f944: 9103        str	r1, [sp, #12]
@   0x0801f946: ac03        add	r4, sp, #12
@   0x0801f948: 4908        ldr	r1, [pc, #32]	@ (0x1f96c)
@   0x0801f94a: 1c20        adds	r0, r4, #0
@   0x0801f94c: 2202        movs	r2, #2
@   0x0801f94e: f7f9        fecd 	bl	0x196ec
@   0x0801f952: 1c20        adds	r0, r4, #0
@   0x0801f954: 2105        movs	r1, #5
@   0x0801f956: 2204        movs	r2, #4
@   0x0801f958: 2302        movs	r3, #2
@   0x0801f95a: f7f8        fdbf 	bl	0x184dc
@   0x0801f95e: 1c28        adds	r0, r5, #0
@   0x0801f960: f000        f806 	bl	0x1f970
@   0x0801f964: b004        add	sp, #16
@   0x0801f966: bc30        pop	{r4, r5}
@   0x0801f968: bc02        pop	{r1}
@   0x0801f96a: 4708        bx	r1
@   0x0801f96c: 8398        strh	r0, [r3, #28]
@   0x0801f96e: 081d        lsrs	r5, r3, #32

        thumb_func_start sub_0801F8BC
sub_0801F8BC: @ 0x0801f8bc
        .incbin "frog_us_baserom.gba", 0x1f8bc, 0xb4
        thumb_func_end sub_0801F8BC
