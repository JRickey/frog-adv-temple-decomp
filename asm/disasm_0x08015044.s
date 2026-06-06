@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015044, 0x08015194)  (336 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015044 --end 0x8015194 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015044: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08015046: 4647        mov	r7, r8
@   0x08015048: b480        push	{r7}
@   0x0801504a: b084        sub	sp, #16
@   0x0801504c: 1c06        adds	r6, r0, #0
@   0x0801504e: 0609        lsls	r1, r1, #24
@   0x08015050: 0e09        lsrs	r1, r1, #24
@   0x08015052: 061b        lsls	r3, r3, #24
@   0x08015054: 0e1b        lsrs	r3, r3, #24
@   0x08015056: 2700        movs	r7, #0
@   0x08015058: 4d04        ldr	r5, [pc, #16]	@ (0x1506c)
@   0x0801505a: 7aa8        ldrb	r0, [r5, #10]
@   0x0801505c: 2801        cmp	r0, #1
@   0x0801505e: d049        beq.n	0x150f4
@   0x08015060: 2801        cmp	r0, #1
@   0x08015062: dc05        bgt.n	0x15070
@   0x08015064: 2800        cmp	r0, #0
@   0x08015066: d007        beq.n	0x15078
@   0x08015068: e089        b.n	0x1517e
@   0x0801506a: 0000        movs	r0, r0
@   0x0801506c: 3610        adds	r6, #16
@   0x0801506e: 0300        lsls	r0, r0, #12
@   0x08015070: 2802        cmp	r0, #2
@   0x08015072: d100        bne.n	0x15076
@   0x08015074: e07a        b.n	0x1516c
@   0x08015076: e082        b.n	0x1517e
@   0x08015078: 7928        ldrb	r0, [r5, #4]
@   0x0801507a: 4288        cmp	r0, r1
@   0x0801507c: d306        bcc.n	0x1508c
@   0x0801507e: 4802        ldr	r0, [pc, #8]	@ (0x15088)
@   0x08015080: 8687        strh	r7, [r0, #52]	@ 0x34
@   0x08015082: 2001        movs	r0, #1
@   0x08015084: e07c        b.n	0x15180
@   0x08015086: 0000        movs	r0, r0
@   0x08015088: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0801508a: 0300        lsls	r0, r0, #12
@   0x0801508c: 792a        ldrb	r2, [r5, #4]
@   0x0801508e: 0053        lsls	r3, r2, #1
@   0x08015090: 189b        adds	r3, r3, r2
@   0x08015092: 00db        lsls	r3, r3, #3
@   0x08015094: 199b        adds	r3, r3, r6
@   0x08015096: 4c14        ldr	r4, [pc, #80]	@ (0x150e8)
@   0x08015098: 46a0        mov	r8, r4
@   0x0801509a: 9402        str	r4, [sp, #8]
@   0x0801509c: 2003        movs	r0, #3
@   0x0801509e: 9003        str	r0, [sp, #12]
@   0x080150a0: 4669        mov	r1, sp
@   0x080150a2: 1c18        adds	r0, r3, #0
@   0x080150a4: 3010        adds	r0, #16
@   0x080150a6: c814        ldmia	r0!, {r2, r4}
@   0x080150a8: c114        stmia	r1!, {r2, r4}
@   0x080150aa: 6818        ldr	r0, [r3, #0]
@   0x080150ac: 6859        ldr	r1, [r3, #4]
@   0x080150ae: 689a        ldr	r2, [r3, #8]
@   0x080150b0: 68db        ldr	r3, [r3, #12]
@   0x080150b2: f7fe        fff5 	bl	0x140a0
@   0x080150b6: 4640        mov	r0, r8
@   0x080150b8: 2103        movs	r1, #3
@   0x080150ba: f7ff        f841 	bl	0x14140
@   0x080150be: 2180        movs	r1, #128	@ 0x80
@   0x080150c0: 0489        lsls	r1, r1, #18
@   0x080150c2: 4a0a        ldr	r2, [pc, #40]	@ (0x150ec)
@   0x080150c4: 2000        movs	r0, #0
@   0x080150c6: f7fb        f80d 	bl	0x100e4
@   0x080150ca: 4909        ldr	r1, [pc, #36]	@ (0x150f0)
@   0x080150cc: 728f        strb	r7, [r1, #10]
@   0x080150ce: 792a        ldrb	r2, [r5, #4]
@   0x080150d0: 0050        lsls	r0, r2, #1
@   0x080150d2: 1880        adds	r0, r0, r2
@   0x080150d4: 00c0        lsls	r0, r0, #3
@   0x080150d6: 1980        adds	r0, r0, r6
@   0x080150d8: 8800        ldrh	r0, [r0, #0]
@   0x080150da: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x080150dc: 2003        movs	r0, #3
@   0x080150de: f00b        fe71 	bl	0x20dc4
@   0x080150e2: 2001        movs	r0, #1
@   0x080150e4: 72a8        strb	r0, [r5, #10]
@   0x080150e6: e04a        b.n	0x1517e
@   0x080150e8: 6480        str	r0, [r0, #72]	@ 0x48
@   0x080150ea: 0300        lsls	r0, r0, #12
@   0x080150ec: e000        b.n	0x150f0
@   0x080150ee: 0600        lsls	r0, r0, #24
@   0x080150f0: 6540        str	r0, [r0, #84]	@ 0x54
@   0x080150f2: 0300        lsls	r0, r0, #12
@   0x080150f4: 011b        lsls	r3, r3, #4
@   0x080150f6: 189b        adds	r3, r3, r2
@   0x080150f8: 7898        ldrb	r0, [r3, #2]
@   0x080150fa: 9000        str	r0, [sp, #0]
@   0x080150fc: 4c18        ldr	r4, [pc, #96]	@ (0x15160)
@   0x080150fe: 9401        str	r4, [sp, #4]
@   0x08015100: 6818        ldr	r0, [r3, #0]
@   0x08015102: 6859        ldr	r1, [r3, #4]
@   0x08015104: 689a        ldr	r2, [r3, #8]
@   0x08015106: 68db        ldr	r3, [r3, #12]
@   0x08015108: f7fe        fdaa 	bl	0x13c60
@   0x0801510c: 7020        strb	r0, [r4, #0]
@   0x0801510e: 0600        lsls	r0, r0, #24
@   0x08015110: 0e00        lsrs	r0, r0, #24
@   0x08015112: 2801        cmp	r0, #1
@   0x08015114: d133        bne.n	0x1517e
@   0x08015116: 4c13        ldr	r4, [pc, #76]	@ (0x15164)
@   0x08015118: 7220        strb	r0, [r4, #8]
@   0x0801511a: 7928        ldrb	r0, [r5, #4]
@   0x0801511c: 0043        lsls	r3, r0, #1
@   0x0801511e: 181b        adds	r3, r3, r0
@   0x08015120: 00db        lsls	r3, r3, #3
@   0x08015122: 199b        adds	r3, r3, r6
@   0x08015124: 9402        str	r4, [sp, #8]
@   0x08015126: 2003        movs	r0, #3
@   0x08015128: 9003        str	r0, [sp, #12]
@   0x0801512a: 4669        mov	r1, sp
@   0x0801512c: 1c18        adds	r0, r3, #0
@   0x0801512e: 3010        adds	r0, #16
@   0x08015130: c844        ldmia	r0!, {r2, r6}
@   0x08015132: c144        stmia	r1!, {r2, r6}
@   0x08015134: 6818        ldr	r0, [r3, #0]
@   0x08015136: 6859        ldr	r1, [r3, #4]
@   0x08015138: 689a        ldr	r2, [r3, #8]
@   0x0801513a: 68db        ldr	r3, [r3, #12]
@   0x0801513c: f7fe        ffb0 	bl	0x140a0
@   0x08015140: 1c20        adds	r0, r4, #0
@   0x08015142: 2103        movs	r1, #3
@   0x08015144: f7fe        fffc 	bl	0x14140
@   0x08015148: 7928        ldrb	r0, [r5, #4]
@   0x0801514a: 3001        adds	r0, #1
@   0x0801514c: 7128        strb	r0, [r5, #4]
@   0x0801514e: 7227        strb	r7, [r4, #8]
@   0x08015150: 72af        strb	r7, [r5, #10]
@   0x08015152: 2180        movs	r1, #128	@ 0x80
@   0x08015154: 0489        lsls	r1, r1, #18
@   0x08015156: 4a04        ldr	r2, [pc, #16]	@ (0x15168)
@   0x08015158: 2000        movs	r0, #0
@   0x0801515a: f7fa        ffc3 	bl	0x100e4
@   0x0801515e: e00e        b.n	0x1517e
@   0x08015160: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08015162: 0300        lsls	r0, r0, #12
@   0x08015164: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08015166: 0300        lsls	r0, r0, #12
@   0x08015168: e000        b.n	0x1516c
@   0x0801516a: 0600        lsls	r0, r0, #24
@   0x0801516c: 4807        ldr	r0, [pc, #28]	@ (0x1518c)
@   0x0801516e: 7800        ldrb	r0, [r0, #0]
@   0x08015170: 2801        cmp	r0, #1
@   0x08015172: d104        bne.n	0x1517e
@   0x08015174: 4806        ldr	r0, [pc, #24]	@ (0x15190)
@   0x08015176: 7800        ldrb	r0, [r0, #0]
@   0x08015178: 2801        cmp	r0, #1
@   0x0801517a: d100        bne.n	0x1517e
@   0x0801517c: 702f        strb	r7, [r5, #0]
@   0x0801517e: 2000        movs	r0, #0
@   0x08015180: b004        add	sp, #16
@   0x08015182: bc08        pop	{r3}
@   0x08015184: 4698        mov	r8, r3
@   0x08015186: bcf0        pop	{r4, r5, r6, r7}
@   0x08015188: bc02        pop	{r1}
@   0x0801518a: 4708        bx	r1
@   0x0801518c: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0801518e: 0300        lsls	r0, r0, #12
@   0x08015190: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08015192: 0300        lsls	r0, r0, #12

        thumb_func_start EnemySpawn_ProcessWaveB
EnemySpawn_ProcessWaveB: @ 0x08015044
        .incbin "frog_us_baserom.gba", 0x15044, 0x150
        thumb_func_end EnemySpawn_ProcessWaveB
