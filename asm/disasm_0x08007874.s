@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08007874, 0x0800793c)  (200 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8007874 --end 0x800793c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08007874: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08007876: 4657        mov	r7, sl
@   0x08007878: 464e        mov	r6, r9
@   0x0800787a: 4645        mov	r5, r8
@   0x0800787c: b4e0        push	{r5, r6, r7}
@   0x0800787e: b086        sub	sp, #24
@   0x08007880: 492b        ldr	r1, [pc, #172]	@ (0x7930)
@   0x08007882: 1c0a        adds	r2, r1, #0
@   0x08007884: 3232        adds	r2, #50	@ 0x32
@   0x08007886: 6b49        ldr	r1, [r1, #52]	@ 0x34
@   0x08007888: 7812        ldrb	r2, [r2, #0]
@   0x0800788a: 0092        lsls	r2, r2, #2
@   0x0800788c: 1852        adds	r2, r2, r1
@   0x0800788e: 3a04        subs	r2, #4
@   0x08007890: 0600        lsls	r0, r0, #24
@   0x08007892: 1600        asrs	r0, r0, #24
@   0x08007894: 0041        lsls	r1, r0, #1
@   0x08007896: 1809        adds	r1, r1, r0
@   0x08007898: 0089        lsls	r1, r1, #2
@   0x0800789a: 6812        ldr	r2, [r2, #0]
@   0x0800789c: 1852        adds	r2, r2, r1
@   0x0800789e: 2100        movs	r1, #0
@   0x080078a0: 5e50        ldrsh	r0, [r2, r1]
@   0x080078a2: 0046        lsls	r6, r0, #1
@   0x080078a4: 1836        adds	r6, r6, r0
@   0x080078a6: 04f6        lsls	r6, r6, #19
@   0x080078a8: 23b0        movs	r3, #176	@ 0xb0
@   0x080078aa: 031b        lsls	r3, r3, #12
@   0x080078ac: 18f6        adds	r6, r6, r3
@   0x080078ae: 0c36        lsrs	r6, r6, #16
@   0x080078b0: 2102        movs	r1, #2
@   0x080078b2: 5e50        ldrsh	r0, [r2, r1]
@   0x080078b4: 0045        lsls	r5, r0, #1
@   0x080078b6: 182d        adds	r5, r5, r0
@   0x080078b8: 04ed        lsls	r5, r5, #19
@   0x080078ba: 18ed        adds	r5, r5, r3
@   0x080078bc: 0c2d        lsrs	r5, r5, #16
@   0x080078be: 481d        ldr	r0, [pc, #116]	@ (0x7934)
@   0x080078c0: 8811        ldrh	r1, [r2, #0]
@   0x080078c2: 2700        movs	r7, #0
@   0x080078c4: 8101        strh	r1, [r0, #8]
@   0x080078c6: 8851        ldrh	r1, [r2, #2]
@   0x080078c8: 8141        strh	r1, [r0, #10]
@   0x080078ca: 7953        ldrb	r3, [r2, #5]
@   0x080078cc: 4698        mov	r8, r3
@   0x080078ce: 7991        ldrb	r1, [r2, #6]
@   0x080078d0: 4689        mov	r9, r1
@   0x080078d2: 7913        ldrb	r3, [r2, #4]
@   0x080078d4: 469a        mov	sl, r3
@   0x080078d6: 79d1        ldrb	r1, [r2, #7]
@   0x080078d8: 7601        strb	r1, [r0, #24]
@   0x080078da: 7a11        ldrb	r1, [r2, #8]
@   0x080078dc: 7641        strb	r1, [r0, #25]
@   0x080078de: 2100        movs	r1, #0
@   0x080078e0: 5641        ldrsb	r1, [r0, r1]
@   0x080078e2: 2302        movs	r3, #2
@   0x080078e4: 5ec2        ldrsh	r2, [r0, r3]
@   0x080078e6: 2304        movs	r3, #4
@   0x080078e8: 56c3        ldrsb	r3, [r0, r3]
@   0x080078ea: 2405        movs	r4, #5
@   0x080078ec: 5704        ldrsb	r4, [r0, r4]
@   0x080078ee: 9400        str	r4, [sp, #0]
@   0x080078f0: f7ff        f8c0 	bl	0x6a74
@   0x080078f4: 4810        ldr	r0, [pc, #64]	@ (0x7938)
@   0x080078f6: 0436        lsls	r6, r6, #16
@   0x080078f8: 1436        asrs	r6, r6, #16
@   0x080078fa: 042d        lsls	r5, r5, #16
@   0x080078fc: 142d        asrs	r5, r5, #16
@   0x080078fe: 4641        mov	r1, r8
@   0x08007900: 9100        str	r1, [sp, #0]
@   0x08007902: 2101        movs	r1, #1
@   0x08007904: 9101        str	r1, [sp, #4]
@   0x08007906: 9702        str	r7, [sp, #8]
@   0x08007908: 464b        mov	r3, r9
@   0x0800790a: 9303        str	r3, [sp, #12]
@   0x0800790c: 4651        mov	r1, sl
@   0x0800790e: 9104        str	r1, [sp, #16]
@   0x08007910: 2110        movs	r1, #16
@   0x08007912: 9105        str	r1, [sp, #20]
@   0x08007914: 2100        movs	r1, #0
@   0x08007916: 1c32        adds	r2, r6, #0
@   0x08007918: 1c2b        adds	r3, r5, #0
@   0x0800791a: f002        fef9 	bl	0xa710
@   0x0800791e: b006        add	sp, #24
@   0x08007920: bc38        pop	{r3, r4, r5}
@   0x08007922: 4698        mov	r8, r3
@   0x08007924: 46a1        mov	r9, r4
@   0x08007926: 46aa        mov	sl, r5
@   0x08007928: bcf0        pop	{r4, r5, r6, r7}
@   0x0800792a: bc01        pop	{r0}
@   0x0800792c: 4700        bx	r0
@   0x0800792e: 0000        movs	r0, r0
@   0x08007930: 6110        str	r0, [r2, #16]
@   0x08007932: 0300        lsls	r0, r0, #12
@   0x08007934: 35e0        adds	r5, #224	@ 0xe0
@   0x08007936: 0300        lsls	r0, r0, #12
@   0x08007938: 3720        adds	r7, #32
@   0x0800793a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08007874
sub_08007874: @ 0x08007874
        .incbin "frog_us_baserom.gba", 0x7874, 0xc8
        thumb_func_end sub_08007874
