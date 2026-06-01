@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d880, 0x0801da1c)  (412 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d880 --end 0x801da1c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d880: b570        push	{r4, r5, r6, lr}
@   0x0801d882: b081        sub	sp, #4
@   0x0801d884: 4849        ldr	r0, [pc, #292]	@ (0x1d9ac)
@   0x0801d886: 2400        movs	r4, #0
@   0x0801d888: 7044        strb	r4, [r0, #1]
@   0x0801d88a: 2180        movs	r1, #128	@ 0x80
@   0x0801d88c: 04c9        lsls	r1, r1, #19
@   0x0801d88e: 2280        movs	r2, #128	@ 0x80
@   0x0801d890: 0112        lsls	r2, r2, #4
@   0x0801d892: 1c10        adds	r0, r2, #0
@   0x0801d894: 8008        strh	r0, [r1, #0]
@   0x0801d896: 310e        adds	r1, #14
@   0x0801d898: 4a45        ldr	r2, [pc, #276]	@ (0x1d9b0)
@   0x0801d89a: 1c10        adds	r0, r2, #0
@   0x0801d89c: 8008        strh	r0, [r1, #0]
@   0x0801d89e: 4845        ldr	r0, [pc, #276]	@ (0x1d9b4)
@   0x0801d8a0: 8004        strh	r4, [r0, #0]
@   0x0801d8a2: 3002        adds	r0, #2
@   0x0801d8a4: 8004        strh	r4, [r0, #0]
@   0x0801d8a6: 4668        mov	r0, sp
@   0x0801d8a8: 8004        strh	r4, [r0, #0]
@   0x0801d8aa: 31c6        adds	r1, #198	@ 0xc6
@   0x0801d8ac: 6008        str	r0, [r1, #0]
@   0x0801d8ae: 2080        movs	r0, #128	@ 0x80
@   0x0801d8b0: 0480        lsls	r0, r0, #18
@   0x0801d8b2: 6048        str	r0, [r1, #4]
@   0x0801d8b4: 4d40        ldr	r5, [pc, #256]	@ (0x1d9b8)
@   0x0801d8b6: 608d        str	r5, [r1, #8]
@   0x0801d8b8: 6888        ldr	r0, [r1, #8]
@   0x0801d8ba: 4668        mov	r0, sp
@   0x0801d8bc: 8004        strh	r4, [r0, #0]
@   0x0801d8be: 6008        str	r0, [r1, #0]
@   0x0801d8c0: 483e        ldr	r0, [pc, #248]	@ (0x1d9bc)
@   0x0801d8c2: 6048        str	r0, [r1, #4]
@   0x0801d8c4: 608d        str	r5, [r1, #8]
@   0x0801d8c6: 6888        ldr	r0, [r1, #8]
@   0x0801d8c8: 4668        mov	r0, sp
@   0x0801d8ca: 8004        strh	r4, [r0, #0]
@   0x0801d8cc: 6008        str	r0, [r1, #0]
@   0x0801d8ce: 483c        ldr	r0, [pc, #240]	@ (0x1d9c0)
@   0x0801d8d0: 6048        str	r0, [r1, #4]
@   0x0801d8d2: 608d        str	r5, [r1, #8]
@   0x0801d8d4: 6888        ldr	r0, [r1, #8]
@   0x0801d8d6: 4668        mov	r0, sp
@   0x0801d8d8: 8004        strh	r4, [r0, #0]
@   0x0801d8da: 6008        str	r0, [r1, #0]
@   0x0801d8dc: 4839        ldr	r0, [pc, #228]	@ (0x1d9c4)
@   0x0801d8de: 6048        str	r0, [r1, #4]
@   0x0801d8e0: 608d        str	r5, [r1, #8]
@   0x0801d8e2: 6888        ldr	r0, [r1, #8]
@   0x0801d8e4: 4668        mov	r0, sp
@   0x0801d8e6: 8004        strh	r4, [r0, #0]
@   0x0801d8e8: 6008        str	r0, [r1, #0]
@   0x0801d8ea: 4837        ldr	r0, [pc, #220]	@ (0x1d9c8)
@   0x0801d8ec: 6048        str	r0, [r1, #4]
@   0x0801d8ee: 608d        str	r5, [r1, #8]
@   0x0801d8f0: 6888        ldr	r0, [r1, #8]
@   0x0801d8f2: 4668        mov	r0, sp
@   0x0801d8f4: 8004        strh	r4, [r0, #0]
@   0x0801d8f6: 6008        str	r0, [r1, #0]
@   0x0801d8f8: 4834        ldr	r0, [pc, #208]	@ (0x1d9cc)
@   0x0801d8fa: 6048        str	r0, [r1, #4]
@   0x0801d8fc: 608d        str	r5, [r1, #8]
@   0x0801d8fe: 6888        ldr	r0, [r1, #8]
@   0x0801d900: 4668        mov	r0, sp
@   0x0801d902: 8004        strh	r4, [r0, #0]
@   0x0801d904: 6008        str	r0, [r1, #0]
@   0x0801d906: 4832        ldr	r0, [pc, #200]	@ (0x1d9d0)
@   0x0801d908: 6048        str	r0, [r1, #4]
@   0x0801d90a: 608d        str	r5, [r1, #8]
@   0x0801d90c: 6888        ldr	r0, [r1, #8]
@   0x0801d90e: 4668        mov	r0, sp
@   0x0801d910: 8004        strh	r4, [r0, #0]
@   0x0801d912: 6008        str	r0, [r1, #0]
@   0x0801d914: 482f        ldr	r0, [pc, #188]	@ (0x1d9d4)
@   0x0801d916: 6048        str	r0, [r1, #4]
@   0x0801d918: 608d        str	r5, [r1, #8]
@   0x0801d91a: 6888        ldr	r0, [r1, #8]
@   0x0801d91c: 4668        mov	r0, sp
@   0x0801d91e: 8004        strh	r4, [r0, #0]
@   0x0801d920: 6008        str	r0, [r1, #0]
@   0x0801d922: 482d        ldr	r0, [pc, #180]	@ (0x1d9d8)
@   0x0801d924: 6048        str	r0, [r1, #4]
@   0x0801d926: 608d        str	r5, [r1, #8]
@   0x0801d928: 6888        ldr	r0, [r1, #8]
@   0x0801d92a: 4668        mov	r0, sp
@   0x0801d92c: 8004        strh	r4, [r0, #0]
@   0x0801d92e: 6008        str	r0, [r1, #0]
@   0x0801d930: 482a        ldr	r0, [pc, #168]	@ (0x1d9dc)
@   0x0801d932: 6048        str	r0, [r1, #4]
@   0x0801d934: 608d        str	r5, [r1, #8]
@   0x0801d936: 6888        ldr	r0, [r1, #8]
@   0x0801d938: 4668        mov	r0, sp
@   0x0801d93a: 8004        strh	r4, [r0, #0]
@   0x0801d93c: 6008        str	r0, [r1, #0]
@   0x0801d93e: 4828        ldr	r0, [pc, #160]	@ (0x1d9e0)
@   0x0801d940: 6048        str	r0, [r1, #4]
@   0x0801d942: 608d        str	r5, [r1, #8]
@   0x0801d944: 6888        ldr	r0, [r1, #8]
@   0x0801d946: 4668        mov	r0, sp
@   0x0801d948: 8004        strh	r4, [r0, #0]
@   0x0801d94a: 6008        str	r0, [r1, #0]
@   0x0801d94c: 4825        ldr	r0, [pc, #148]	@ (0x1d9e4)
@   0x0801d94e: 6048        str	r0, [r1, #4]
@   0x0801d950: 608d        str	r5, [r1, #8]
@   0x0801d952: 6888        ldr	r0, [r1, #8]
@   0x0801d954: 4e24        ldr	r6, [pc, #144]	@ (0x1d9e8)
@   0x0801d956: 4b25        ldr	r3, [pc, #148]	@ (0x1d9ec)
@   0x0801d958: 4825        ldr	r0, [pc, #148]	@ (0x1d9f0)
@   0x0801d95a: 6802        ldr	r2, [r0, #0]
@   0x0801d95c: 0050        lsls	r0, r2, #1
@   0x0801d95e: 1880        adds	r0, r0, r2
@   0x0801d960: 00c0        lsls	r0, r0, #3
@   0x0801d962: 3304        adds	r3, #4
@   0x0801d964: 18c0        adds	r0, r0, r3
@   0x0801d966: 6802        ldr	r2, [r0, #0]
@   0x0801d968: 4668        mov	r0, sp
@   0x0801d96a: 8004        strh	r4, [r0, #0]
@   0x0801d96c: 6008        str	r0, [r1, #0]
@   0x0801d96e: 4821        ldr	r0, [pc, #132]	@ (0x1d9f4)
@   0x0801d970: 6048        str	r0, [r1, #4]
@   0x0801d972: 608d        str	r5, [r1, #8]
@   0x0801d974: 6888        ldr	r0, [r1, #8]
@   0x0801d976: 600a        str	r2, [r1, #0]
@   0x0801d978: 481f        ldr	r0, [pc, #124]	@ (0x1d9f8)
@   0x0801d97a: 6048        str	r0, [r1, #4]
@   0x0801d97c: 481f        ldr	r0, [pc, #124]	@ (0x1d9fc)
@   0x0801d97e: 6088        str	r0, [r1, #8]
@   0x0801d980: 6888        ldr	r0, [r1, #8]
@   0x0801d982: 600e        str	r6, [r1, #0]
@   0x0801d984: 481e        ldr	r0, [pc, #120]	@ (0x1da00)
@   0x0801d986: 6048        str	r0, [r1, #4]
@   0x0801d988: 481e        ldr	r0, [pc, #120]	@ (0x1da04)
@   0x0801d98a: 6088        str	r0, [r1, #8]
@   0x0801d98c: 6888        ldr	r0, [r1, #8]
@   0x0801d98e: 481e        ldr	r0, [pc, #120]	@ (0x1da08)
@   0x0801d990: 6008        str	r0, [r1, #0]
@   0x0801d992: 481e        ldr	r0, [pc, #120]	@ (0x1da0c)
@   0x0801d994: 6048        str	r0, [r1, #4]
@   0x0801d996: 481e        ldr	r0, [pc, #120]	@ (0x1da10)
@   0x0801d998: 6088        str	r0, [r1, #8]
@   0x0801d99a: 6888        ldr	r0, [r1, #8]
@   0x0801d99c: 491d        ldr	r1, [pc, #116]	@ (0x1da14)
@   0x0801d99e: 4a1e        ldr	r2, [pc, #120]	@ (0x1da18)
@   0x0801d9a0: 1c10        adds	r0, r2, #0
@   0x0801d9a2: 8008        strh	r0, [r1, #0]
@   0x0801d9a4: b001        add	sp, #4
@   0x0801d9a6: bc70        pop	{r4, r5, r6}
@   0x0801d9a8: bc01        pop	{r0}
@   0x0801d9aa: 4700        bx	r0
@   0x0801d9ac: 34a0        adds	r4, #160	@ 0xa0
@   0x0801d9ae: 0300        lsls	r0, r0, #12
@   0x0801d9b0: 1f08        subs	r0, r1, #4
@   0x0801d9b2: 0000        movs	r0, r0
@   0x0801d9b4: 001c        movs	r4, r3
@   0x0801d9b6: 0400        lsls	r0, r0, #16
@   0x0801d9b8: 0400        lsls	r0, r0, #16
@   0x0801d9ba: 8100        strh	r0, [r0, #8]
@   0x0801d9bc: 0800        lsrs	r0, r0, #32
@   0x0801d9be: 0200        lsls	r0, r0, #8
@   0x0801d9c0: 1000        asrs	r0, r0, #32
@   0x0801d9c2: 0200        lsls	r0, r0, #8
@   0x0801d9c4: 1800        adds	r0, r0, r0
@   0x0801d9c6: 0200        lsls	r0, r0, #8
@   0x0801d9c8: 2000        movs	r0, #0
@   0x0801d9ca: 0200        lsls	r0, r0, #8
@   0x0801d9cc: 2800        cmp	r0, #0
@   0x0801d9ce: 0200        lsls	r0, r0, #8
@   0x0801d9d0: 3000        adds	r0, #0
@   0x0801d9d2: 0200        lsls	r0, r0, #8
@   0x0801d9d4: 3800        subs	r0, #0
@   0x0801d9d6: 0200        lsls	r0, r0, #8
@   0x0801d9d8: 4000        ands	r0, r0
@   0x0801d9da: 0200        lsls	r0, r0, #8
@   0x0801d9dc: 4800        ldr	r0, [pc, #0]	@ (0x1d9e0)
@   0x0801d9de: 0200        lsls	r0, r0, #8
@   0x0801d9e0: 5000        str	r0, [r0, r0]
@   0x0801d9e2: 0200        lsls	r0, r0, #8
@   0x0801d9e4: 5800        ldr	r0, [r0, r0]
@   0x0801d9e6: 0200        lsls	r0, r0, #8
@   0x0801d9e8: 7ab6        ldrb	r6, [r6, #10]
@   0x0801d9ea: 080e        lsrs	r6, r1, #32
@   0x0801d9ec: 1254        asrs	r4, r2, #9
@   0x0801d9ee: 080c        lsrs	r4, r1, #32
@   0x0801d9f0: 34b0        adds	r4, #176	@ 0xb0
@   0x0801d9f2: 0300        lsls	r0, r0, #12
@   0x0801d9f4: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801d9f8: 8000        strh	r0, [r0, #0]
@   0x0801d9fa: 0600        lsls	r0, r0, #24
@   0x0801d9fc: 2000        movs	r0, #0
@   0x0801d9fe: 8000        strh	r0, [r0, #0]
@   0x0801da00: 8020        strh	r0, [r4, #0]
@   0x0801da02: 0600        lsls	r0, r0, #24
@   0x0801da04: 0340        lsls	r0, r0, #13
@   0x0801da06: 8000        strh	r0, [r0, #0]
@   0x0801da08: 3774        adds	r7, #116	@ 0x74
@   0x0801da0a: 080e        lsrs	r6, r1, #32
@   0x0801da0c: 01c0        lsls	r0, r0, #7
@   0x0801da0e: 0500        lsls	r0, r0, #20
@   0x0801da10: 0010        movs	r0, r2
@   0x0801da12: 8000        strh	r0, [r0, #0]
@   0x0801da14: 01e2        lsls	r2, r4, #7
@   0x0801da16: 0500        lsls	r0, r0, #20
@   0x0801da18: 037d        lsls	r5, r7, #13

        thumb_func_start sub_0801D880
sub_0801D880: @ 0x0801d880
        .incbin "frog_us_baserom.gba", 0x1d880, 0x19c
        thumb_func_end sub_0801D880
