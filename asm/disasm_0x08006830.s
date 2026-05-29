@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006830, 0x0800690c)  (220 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006830 --end 0x800690c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006830: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08006832: b084        sub	sp, #16
@   0x08006834: 1c0b        adds	r3, r1, #0
@   0x08006836: 1c17        adds	r7, r2, #0
@   0x08006838: 1af8        subs	r0, r7, r3
@   0x0800683a: 3001        adds	r0, #1
@   0x0800683c: 0600        lsls	r0, r0, #24
@   0x0800683e: 0e00        lsrs	r0, r0, #24
@   0x08006840: 1c01        adds	r1, r0, #0
@   0x08006842: 2f3f        cmp	r7, #63	@ 0x3f
@   0x08006844: dc0e        bgt.n	0x6864
@   0x08006846: 0601        lsls	r1, r0, #24
@   0x08006848: 1609        asrs	r1, r1, #24
@   0x0800684a: 2001        movs	r0, #1
@   0x0800684c: 4088        lsls	r0, r1
@   0x0800684e: 3801        subs	r0, #1
@   0x08006850: 9000        str	r0, [sp, #0]
@   0x08006852: 17c0        asrs	r0, r0, #31
@   0x08006854: 9001        str	r0, [sp, #4]
@   0x08006856: 4802        ldr	r0, [pc, #8]	@ (0x6860)
@   0x08006858: 6981        ldr	r1, [r0, #24]
@   0x0800685a: 6940        ldr	r0, [r0, #20]
@   0x0800685c: 1c1a        adds	r2, r3, #0
@   0x0800685e: e010        b.n	0x6882
@   0x08006860: 6110        str	r0, [r2, #16]
@   0x08006862: 0300        lsls	r0, r0, #12
@   0x08006864: 2b3f        cmp	r3, #63	@ 0x3f
@   0x08006866: dd1b        ble.n	0x68a0
@   0x08006868: 0609        lsls	r1, r1, #24
@   0x0800686a: 1609        asrs	r1, r1, #24
@   0x0800686c: 2001        movs	r0, #1
@   0x0800686e: 4088        lsls	r0, r1
@   0x08006870: 3801        subs	r0, #1
@   0x08006872: 9000        str	r0, [sp, #0]
@   0x08006874: 17c0        asrs	r0, r0, #31
@   0x08006876: 9001        str	r0, [sp, #4]
@   0x08006878: 4808        ldr	r0, [pc, #32]	@ (0x689c)
@   0x0800687a: 1c1a        adds	r2, r3, #0
@   0x0800687c: 3a40        subs	r2, #64	@ 0x40
@   0x0800687e: 6a01        ldr	r1, [r0, #32]
@   0x08006880: 69c0        ldr	r0, [r0, #28]
@   0x08006882: f02d        faad 	bl	0x33de0
@   0x08006886: 9002        str	r0, [sp, #8]
@   0x08006888: 9103        str	r1, [sp, #12]
@   0x0800688a: 9800        ldr	r0, [sp, #0]
@   0x0800688c: 9a02        ldr	r2, [sp, #8]
@   0x0800688e: 4010        ands	r0, r2
@   0x08006890: 9901        ldr	r1, [sp, #4]
@   0x08006892: 9b03        ldr	r3, [sp, #12]
@   0x08006894: 4019        ands	r1, r3
@   0x08006896: 9002        str	r0, [sp, #8]
@   0x08006898: 9103        str	r1, [sp, #12]
@   0x0800689a: e02f        b.n	0x68fc
@   0x0800689c: 6110        str	r0, [r2, #16]
@   0x0800689e: 0300        lsls	r0, r0, #12
@   0x080068a0: 2540        movs	r5, #64	@ 0x40
@   0x080068a2: 1aed        subs	r5, r5, r3
@   0x080068a4: 2401        movs	r4, #1
@   0x080068a6: 1c20        adds	r0, r4, #0
@   0x080068a8: 40a8        lsls	r0, r5
@   0x080068aa: 3801        subs	r0, #1
@   0x080068ac: 9000        str	r0, [sp, #0]
@   0x080068ae: 17c0        asrs	r0, r0, #31
@   0x080068b0: 9001        str	r0, [sp, #4]
@   0x080068b2: 4e15        ldr	r6, [pc, #84]	@ (0x6908)
@   0x080068b4: 6970        ldr	r0, [r6, #20]
@   0x080068b6: 69b1        ldr	r1, [r6, #24]
@   0x080068b8: 1c1a        adds	r2, r3, #0
@   0x080068ba: f02d        fa91 	bl	0x33de0
@   0x080068be: 9002        str	r0, [sp, #8]
@   0x080068c0: 9103        str	r1, [sp, #12]
@   0x080068c2: 9800        ldr	r0, [sp, #0]
@   0x080068c4: 9a02        ldr	r2, [sp, #8]
@   0x080068c6: 4010        ands	r0, r2
@   0x080068c8: 9901        ldr	r1, [sp, #4]
@   0x080068ca: 9b03        ldr	r3, [sp, #12]
@   0x080068cc: 4019        ands	r1, r3
@   0x080068ce: 9002        str	r0, [sp, #8]
@   0x080068d0: 9103        str	r1, [sp, #12]
@   0x080068d2: 1c38        adds	r0, r7, #0
@   0x080068d4: 383f        subs	r0, #63	@ 0x3f
@   0x080068d6: 4084        lsls	r4, r0
@   0x080068d8: 3c01        subs	r4, #1
@   0x080068da: 9400        str	r4, [sp, #0]
@   0x080068dc: 17e4        asrs	r4, r4, #31
@   0x080068de: 9401        str	r4, [sp, #4]
@   0x080068e0: 69f0        ldr	r0, [r6, #28]
@   0x080068e2: 6a31        ldr	r1, [r6, #32]
@   0x080068e4: 9a00        ldr	r2, [sp, #0]
@   0x080068e6: 4010        ands	r0, r2
@   0x080068e8: 4021        ands	r1, r4
@   0x080068ea: 1c2a        adds	r2, r5, #0
@   0x080068ec: f02d        f9da 	bl	0x33ca4
@   0x080068f0: 9a02        ldr	r2, [sp, #8]
@   0x080068f2: 9b03        ldr	r3, [sp, #12]
@   0x080068f4: 1812        adds	r2, r2, r0
@   0x080068f6: 414b        adcs	r3, r1
@   0x080068f8: 9202        str	r2, [sp, #8]
@   0x080068fa: 9303        str	r3, [sp, #12]
@   0x080068fc: 9802        ldr	r0, [sp, #8]
@   0x080068fe: 9903        ldr	r1, [sp, #12]
@   0x08006900: b004        add	sp, #16
@   0x08006902: bcf0        pop	{r4, r5, r6, r7}
@   0x08006904: bc04        pop	{r2}
@   0x08006906: 4710        bx	r2
@   0x08006908: 6110        str	r0, [r2, #16]
@   0x0800690a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08006830
sub_08006830: @ 0x08006830
        .incbin "frog_us_baserom.gba", 0x6830, 0xdc
        thumb_func_end sub_08006830
