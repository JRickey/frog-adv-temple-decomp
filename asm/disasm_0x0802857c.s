@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802857c, 0x08028600)  (132 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802857c --end 0x8028600 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802857c: b570        push	{r4, r5, r6, lr}
@   0x0802857e: b084        sub	sp, #16
@   0x08028580: 2600        movs	r6, #0
@   0x08028582: 1c35        adds	r5, r6, #0
@   0x08028584: 3538        adds	r5, #56	@ 0x38
@   0x08028586: 4918        ldr	r1, [pc, #96]	@ (0x285e8)
@   0x08028588: 00b0        lsls	r0, r6, #2
@   0x0802858a: 1840        adds	r0, r0, r1
@   0x0802858c: 6804        ldr	r4, [r0, #0]
@   0x0802858e: 1c30        adds	r0, r6, #0
@   0x08028590: 2105        movs	r1, #5
@   0x08028592: f00b        fce3 	bl	0x33f5c
@   0x08028596: 0600        lsls	r0, r0, #24
@   0x08028598: 0900        lsrs	r0, r0, #4
@   0x0802859a: 4914        ldr	r1, [pc, #80]	@ (0x285ec)
@   0x0802859c: 1840        adds	r0, r0, r1
@   0x0802859e: 0c00        lsrs	r0, r0, #16
@   0x080285a0: 9000        str	r0, [sp, #0]
@   0x080285a2: 2006        movs	r0, #6
@   0x080285a4: 9001        str	r0, [sp, #4]
@   0x080285a6: 2003        movs	r0, #3
@   0x080285a8: 9002        str	r0, [sp, #8]
@   0x080285aa: 9003        str	r0, [sp, #12]
@   0x080285ac: 1c28        adds	r0, r5, #0
@   0x080285ae: 1c21        adds	r1, r4, #0
@   0x080285b0: 2210        movs	r2, #16
@   0x080285b2: 233b        movs	r3, #59	@ 0x3b
@   0x080285b4: f7f8        fd74 	bl	0x210a0
@   0x080285b8: 1c70        adds	r0, r6, #1
@   0x080285ba: 0600        lsls	r0, r0, #24
@   0x080285bc: 0e06        lsrs	r6, r0, #24
@   0x080285be: 2e0d        cmp	r6, #13
@   0x080285c0: d9df        bls.n	0x28582
@   0x080285c2: 490b        ldr	r1, [pc, #44]	@ (0x285f0)
@   0x080285c4: 4a0b        ldr	r2, [pc, #44]	@ (0x285f4)
@   0x080285c6: 1888        adds	r0, r1, r2
@   0x080285c8: 2202        movs	r2, #2
@   0x080285ca: 7002        strb	r2, [r0, #0]
@   0x080285cc: 4b0a        ldr	r3, [pc, #40]	@ (0x285f8)
@   0x080285ce: 18c8        adds	r0, r1, r3
@   0x080285d0: 7002        strb	r2, [r0, #0]
@   0x080285d2: 3370        adds	r3, #112	@ 0x70
@   0x080285d4: 18c8        adds	r0, r1, r3
@   0x080285d6: 7002        strb	r2, [r0, #0]
@   0x080285d8: 4808        ldr	r0, [pc, #32]	@ (0x285fc)
@   0x080285da: 1809        adds	r1, r1, r0
@   0x080285dc: 700a        strb	r2, [r1, #0]
@   0x080285de: b004        add	sp, #16
@   0x080285e0: bc70        pop	{r4, r5, r6}
@   0x080285e2: bc01        pop	{r0}
@   0x080285e4: 4700        bx	r0
@   0x080285e6: 0000        movs	r0, r0
@   0x080285e8: 7a60        ldrb	r0, [r4, #9]
@   0x080285ea: 0831        lsrs	r1, r6, #32
@   0x080285ec: 0000        movs	r0, r0
@   0x080285ee: 0125        lsls	r5, r4, #4
@   0x080285f0: 3720        adds	r7, #32
@   0x080285f2: 0300        lsls	r0, r0, #12
@   0x080285f4: 0e4f        lsrs	r7, r1, #25
@   0x080285f6: 0000        movs	r0, r0
@   0x080285f8: 0e87        lsrs	r7, r0, #26
@   0x080285fa: 0000        movs	r0, r0
@   0x080285fc: 0f2f        lsrs	r7, r5, #28

        thumb_func_start sub_0802857C
sub_0802857C: @ 0x0802857c
        .incbin "baserom.gba", 0x2857c, 0x84
        thumb_func_end sub_0802857C
