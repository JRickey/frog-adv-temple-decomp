@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801549c, 0x080155f0)  (340 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801549c --end 0x80155f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801549c: b530        push	{r4, r5, lr}
@   0x0801549e: b082        sub	sp, #8
@   0x080154a0: 4805        ldr	r0, [pc, #20]	@ (0x154b8)
@   0x080154a2: 7801        ldrb	r1, [r0, #0]
@   0x080154a4: 1c04        adds	r4, r0, #0
@   0x080154a6: 2904        cmp	r1, #4
@   0x080154a8: d900        bls.n	0x154ac
@   0x080154aa: e090        b.n	0x155ce
@   0x080154ac: 0088        lsls	r0, r1, #2
@   0x080154ae: 4903        ldr	r1, [pc, #12]	@ (0x154bc)
@   0x080154b0: 1840        adds	r0, r0, r1
@   0x080154b2: 6800        ldr	r0, [r0, #0]
@   0x080154b4: 4687        mov	pc, r0
@   0x080154b6: 0000        movs	r0, r0
@   0x080154b8: 3610        adds	r6, #16
@   0x080154ba: 0300        lsls	r0, r0, #12
@   0x080154bc: 54c0        strb	r0, [r0, r3]
@   0x080154be: 0801        lsrs	r1, r0, #32
@   0x080154c0: 54d4        strb	r4, [r2, r3]
@   0x080154c2: 0801        lsrs	r1, r0, #32
@   0x080154c4: 54e4        strb	r4, [r4, r3]
@   0x080154c6: 0801        lsrs	r1, r0, #32
@   0x080154c8: 54ea        strb	r2, [r5, r3]
@   0x080154ca: 0801        lsrs	r1, r0, #32
@   0x080154cc: 5534        strb	r4, [r6, r4]
@   0x080154ce: 0801        lsrs	r1, r0, #32
@   0x080154d0: 5568        strb	r0, [r5, r5]
@   0x080154d2: 0801        lsrs	r1, r0, #32
@   0x080154d4: 4802        ldr	r0, [pc, #8]	@ (0x154e0)
@   0x080154d6: 7824        ldrb	r4, [r4, #0]
@   0x080154d8: 0123        lsls	r3, r4, #4
@   0x080154da: 181b        adds	r3, r3, r0
@   0x080154dc: e015        b.n	0x1550a
@   0x080154de: 0000        movs	r0, r0
@   0x080154e0: 7da8        ldrb	r0, [r5, #22]
@   0x080154e2: 0830        lsrs	r0, r6, #32
@   0x080154e4: f7fd        fbe2 	bl	0x12cac
@   0x080154e8: e00a        b.n	0x15500
@   0x080154ea: 4b0d        ldr	r3, [pc, #52]	@ (0x15520)
@   0x080154ec: 7898        ldrb	r0, [r3, #2]
@   0x080154ee: 9000        str	r0, [sp, #0]
@   0x080154f0: 480c        ldr	r0, [pc, #48]	@ (0x15524)
@   0x080154f2: 9001        str	r0, [sp, #4]
@   0x080154f4: 6818        ldr	r0, [r3, #0]
@   0x080154f6: 6859        ldr	r1, [r3, #4]
@   0x080154f8: 689a        ldr	r2, [r3, #8]
@   0x080154fa: 68db        ldr	r3, [r3, #12]
@   0x080154fc: f7fe        fbb0 	bl	0x13c60
@   0x08015500: 4909        ldr	r1, [pc, #36]	@ (0x15528)
@   0x08015502: 480a        ldr	r0, [pc, #40]	@ (0x1552c)
@   0x08015504: 7800        ldrb	r0, [r0, #0]
@   0x08015506: 0103        lsls	r3, r0, #4
@   0x08015508: 185b        adds	r3, r3, r1
@   0x0801550a: 7898        ldrb	r0, [r3, #2]
@   0x0801550c: 9000        str	r0, [sp, #0]
@   0x0801550e: 4808        ldr	r0, [pc, #32]	@ (0x15530)
@   0x08015510: 9001        str	r0, [sp, #4]
@   0x08015512: 6818        ldr	r0, [r3, #0]
@   0x08015514: 6859        ldr	r1, [r3, #4]
@   0x08015516: 689a        ldr	r2, [r3, #8]
@   0x08015518: 68db        ldr	r3, [r3, #12]
@   0x0801551a: f7fe        fba1 	bl	0x13c60
@   0x0801551e: e056        b.n	0x155ce
@   0x08015520: 7d98        ldrb	r0, [r3, #22]
@   0x08015522: 0830        lsrs	r0, r6, #32
@   0x08015524: 6580        str	r0, [r0, #88]	@ 0x58
@   0x08015526: 0300        lsls	r0, r0, #12
@   0x08015528: 7da8        ldrb	r0, [r5, #22]
@   0x0801552a: 0830        lsrs	r0, r6, #32
@   0x0801552c: 3610        adds	r6, #16
@   0x0801552e: 0300        lsls	r0, r0, #12
@   0x08015530: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08015532: 0300        lsls	r0, r0, #12
@   0x08015534: 480a        ldr	r0, [pc, #40]	@ (0x15560)
@   0x08015536: 7821        ldrb	r1, [r4, #0]
@   0x08015538: 010b        lsls	r3, r1, #4
@   0x0801553a: 181b        adds	r3, r3, r0
@   0x0801553c: 7898        ldrb	r0, [r3, #2]
@   0x0801553e: 9000        str	r0, [sp, #0]
@   0x08015540: 4808        ldr	r0, [pc, #32]	@ (0x15564)
@   0x08015542: 9001        str	r0, [sp, #4]
@   0x08015544: 6818        ldr	r0, [r3, #0]
@   0x08015546: 6859        ldr	r1, [r3, #4]
@   0x08015548: 689a        ldr	r2, [r3, #8]
@   0x0801554a: 68db        ldr	r3, [r3, #12]
@   0x0801554c: f7fe        fb88 	bl	0x13c60
@   0x08015550: 2800        cmp	r0, #0
@   0x08015552: d001        beq.n	0x15558
@   0x08015554: 20ff        movs	r0, #255	@ 0xff
@   0x08015556: 7020        strb	r0, [r4, #0]
@   0x08015558: f7fc        f994 	bl	0x11884
@   0x0801555c: e037        b.n	0x155ce
@   0x0801555e: 0000        movs	r0, r0
@   0x08015560: 7da8        ldrb	r0, [r5, #22]
@   0x08015562: 0830        lsrs	r0, r6, #32
@   0x08015564: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08015566: 0300        lsls	r0, r0, #12
@   0x08015568: f7fd        fba0 	bl	0x12cac
@   0x0801556c: 481a        ldr	r0, [pc, #104]	@ (0x155d8)
@   0x0801556e: 491b        ldr	r1, [pc, #108]	@ (0x155dc)
@   0x08015570: 6800        ldr	r0, [r0, #0]
@   0x08015572: 6849        ldr	r1, [r1, #4]
@   0x08015574: 1a40        subs	r0, r0, r1
@   0x08015576: 2807        cmp	r0, #7
@   0x08015578: d91a        bls.n	0x155b0
@   0x0801557a: 4c19        ldr	r4, [pc, #100]	@ (0x155e0)
@   0x0801557c: 4d19        ldr	r5, [pc, #100]	@ (0x155e4)
@   0x0801557e: 79a0        ldrb	r0, [r4, #6]
@   0x08015580: 8829        ldrh	r1, [r5, #0]
@   0x08015582: 4288        cmp	r0, r1
@   0x08015584: d301        bcc.n	0x1558a
@   0x08015586: 2000        movs	r0, #0
@   0x08015588: 71a0        strb	r0, [r4, #6]
@   0x0801558a: 686b        ldr	r3, [r5, #4]
@   0x0801558c: 4a16        ldr	r2, [pc, #88]	@ (0x155e8)
@   0x0801558e: 79a0        ldrb	r0, [r4, #6]
@   0x08015590: 1c41        adds	r1, r0, #1
@   0x08015592: 71a1        strb	r1, [r4, #6]
@   0x08015594: 0600        lsls	r0, r0, #24
@   0x08015596: 0d80        lsrs	r0, r0, #22
@   0x08015598: 18c0        adds	r0, r0, r3
@   0x0801559a: 6800        ldr	r0, [r0, #0]
@   0x0801559c: 6010        str	r0, [r2, #0]
@   0x0801559e: 68a8        ldr	r0, [r5, #8]
@   0x080155a0: 6050        str	r0, [r2, #4]
@   0x080155a2: 89ad        ldrh	r5, [r5, #12]
@   0x080155a4: 0868        lsrs	r0, r5, #1
@   0x080155a6: 2180        movs	r1, #128	@ 0x80
@   0x080155a8: 0609        lsls	r1, r1, #24
@   0x080155aa: 4308        orrs	r0, r1
@   0x080155ac: 6090        str	r0, [r2, #8]
@   0x080155ae: 6890        ldr	r0, [r2, #8]
@   0x080155b0: 490e        ldr	r1, [pc, #56]	@ (0x155ec)
@   0x080155b2: 480b        ldr	r0, [pc, #44]	@ (0x155e0)
@   0x080155b4: 7800        ldrb	r0, [r0, #0]
@   0x080155b6: 0103        lsls	r3, r0, #4
@   0x080155b8: 185b        adds	r3, r3, r1
@   0x080155ba: 7898        ldrb	r0, [r3, #2]
@   0x080155bc: 9000        str	r0, [sp, #0]
@   0x080155be: 4807        ldr	r0, [pc, #28]	@ (0x155dc)
@   0x080155c0: 9001        str	r0, [sp, #4]
@   0x080155c2: 6818        ldr	r0, [r3, #0]
@   0x080155c4: 6859        ldr	r1, [r3, #4]
@   0x080155c6: 689a        ldr	r2, [r3, #8]
@   0x080155c8: 68db        ldr	r3, [r3, #12]
@   0x080155ca: f7fe        fb49 	bl	0x13c60
@   0x080155ce: b002        add	sp, #8
@   0x080155d0: bc30        pop	{r4, r5}
@   0x080155d2: bc01        pop	{r0}
@   0x080155d4: 4700        bx	r0
@   0x080155d6: 0000        movs	r0, r0
@   0x080155d8: 5330        strh	r0, [r6, r4]
@   0x080155da: 0300        lsls	r0, r0, #12
@   0x080155dc: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x080155de: 0300        lsls	r0, r0, #12
@   0x080155e0: 3610        adds	r6, #16
@   0x080155e2: 0300        lsls	r0, r0, #12
@   0x080155e4: 6f08        ldr	r0, [r1, #112]	@ 0x70
@   0x080155e6: 0830        lsrs	r0, r6, #32
@   0x080155e8: 00d4        lsls	r4, r2, #3
@   0x080155ea: 0400        lsls	r0, r0, #16
@   0x080155ec: 7da8        ldrb	r0, [r5, #22]
@   0x080155ee: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_0801549C
sub_0801549C: @ 0x0801549c
        .incbin "frog_us_baserom.gba", 0x1549c, 0x154
        thumb_func_end sub_0801549C
