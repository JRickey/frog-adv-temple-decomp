@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080070a0, 0x08007138)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80070a0 --end 0x8007138 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080070a0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080070a2: 464f        mov	r7, r9
@   0x080070a4: 4646        mov	r6, r8
@   0x080070a6: b4c0        push	{r6, r7}
@   0x080070a8: 1c0b        adds	r3, r1, #0
@   0x080070aa: 1c16        adds	r6, r2, #0
@   0x080070ac: 4a1f        ldr	r2, [pc, #124]	@ (0x712c)
@   0x080070ae: 00d9        lsls	r1, r3, #3
@   0x080070b0: 18c9        adds	r1, r1, r3
@   0x080070b2: 0089        lsls	r1, r1, #2
@   0x080070b4: 180d        adds	r5, r1, r0
@   0x080070b6: 6810        ldr	r0, [r2, #0]
@   0x080070b8: 68e9        ldr	r1, [r5, #12]
@   0x080070ba: 1a40        subs	r0, r0, r1
@   0x080070bc: 4690        mov	r8, r2
@   0x080070be: 7ca9        ldrb	r1, [r5, #18]
@   0x080070c0: 4288        cmp	r0, r1
@   0x080070c2: d32d        bcc.n	0x7120
@   0x080070c4: 1c1c        adds	r4, r3, #0
@   0x080070c6: 42b4        cmp	r4, r6
@   0x080070c8: dc2a        bgt.n	0x7120
@   0x080070ca: 4919        ldr	r1, [pc, #100]	@ (0x7130)
@   0x080070cc: 2202        movs	r2, #2
@   0x080070ce: 4691        mov	r9, r2
@   0x080070d0: 4648        mov	r0, r9
@   0x080070d2: 8a09        ldrh	r1, [r1, #16]
@   0x080070d4: 4008        ands	r0, r1
@   0x080070d6: 0400        lsls	r0, r0, #16
@   0x080070d8: 0c00        lsrs	r0, r0, #16
@   0x080070da: 4684        mov	ip, r0
@   0x080070dc: 1c2b        adds	r3, r5, #0
@   0x080070de: 4d15        ldr	r5, [pc, #84]	@ (0x7134)
@   0x080070e0: 2011        movs	r0, #17
@   0x080070e2: 5618        ldrsb	r0, [r3, r0]
@   0x080070e4: 2210        movs	r2, #16
@   0x080070e6: 569a        ldrsb	r2, [r3, r2]
@   0x080070e8: 881f        ldrh	r7, [r3, #0]
@   0x080070ea: 18b9        adds	r1, r7, r2
@   0x080070ec: 8019        strh	r1, [r3, #0]
@   0x080070ee: 1c01        adds	r1, r0, #0
@   0x080070f0: 885f        ldrh	r7, [r3, #2]
@   0x080070f2: 1878        adds	r0, r7, r1
@   0x080070f4: 8058        strh	r0, [r3, #2]
@   0x080070f6: 4660        mov	r0, ip
@   0x080070f8: 2800        cmp	r0, #0
@   0x080070fa: d00a        beq.n	0x7112
@   0x080070fc: 4648        mov	r0, r9
@   0x080070fe: 7e9f        ldrb	r7, [r3, #26]
@   0x08007100: 4038        ands	r0, r7
@   0x08007102: 2800        cmp	r0, #0
@   0x08007104: d005        beq.n	0x7112
@   0x08007106: 886f        ldrh	r7, [r5, #2]
@   0x08007108: 18b8        adds	r0, r7, r2
@   0x0800710a: 8068        strh	r0, [r5, #2]
@   0x0800710c: 88aa        ldrh	r2, [r5, #4]
@   0x0800710e: 1850        adds	r0, r2, r1
@   0x08007110: 80a8        strh	r0, [r5, #4]
@   0x08007112: 4647        mov	r7, r8
@   0x08007114: 6838        ldr	r0, [r7, #0]
@   0x08007116: 60d8        str	r0, [r3, #12]
@   0x08007118: 3324        adds	r3, #36	@ 0x24
@   0x0800711a: 3401        adds	r4, #1
@   0x0800711c: 42b4        cmp	r4, r6
@   0x0800711e: dddf        ble.n	0x70e0
@   0x08007120: bc18        pop	{r3, r4}
@   0x08007122: 4698        mov	r8, r3
@   0x08007124: 46a1        mov	r9, r4
@   0x08007126: bcf0        pop	{r4, r5, r6, r7}
@   0x08007128: bc01        pop	{r0}
@   0x0800712a: 4700        bx	r0
@   0x0800712c: 5330        strh	r0, [r6, r4]
@   0x0800712e: 0300        lsls	r0, r0, #12
@   0x08007130: 35e0        adds	r5, #224	@ 0xe0
@   0x08007132: 0300        lsls	r0, r0, #12
@   0x08007134: 3720        adds	r7, #32
@   0x08007136: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080070A0
sub_080070A0: @ 0x080070a0
        .incbin "frog_us_baserom.gba", 0x70a0, 0x98
        thumb_func_end sub_080070A0
