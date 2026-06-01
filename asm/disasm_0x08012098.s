@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012098, 0x08012100)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012098 --end 0x8012100 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012098: b500        push	{lr}
@   0x0801209a: 480c        ldr	r0, [pc, #48]	@ (0x120cc)
@   0x0801209c: 490c        ldr	r1, [pc, #48]	@ (0x120d0)
@   0x0801209e: 6802        ldr	r2, [r0, #0]
@   0x080120a0: 6888        ldr	r0, [r1, #8]
@   0x080120a2: 1a10        subs	r0, r2, r0
@   0x080120a4: 7b0b        ldrb	r3, [r1, #12]
@   0x080120a6: 4298        cmp	r0, r3
@   0x080120a8: d325        bcc.n	0x120f6
@   0x080120aa: 608a        str	r2, [r1, #8]
@   0x080120ac: 4809        ldr	r0, [pc, #36]	@ (0x120d4)
@   0x080120ae: 8801        ldrh	r1, [r0, #0]
@   0x080120b0: 0a0a        lsrs	r2, r1, #8
@   0x080120b2: 8800        ldrh	r0, [r0, #0]
@   0x080120b4: 23ff        movs	r3, #255	@ 0xff
@   0x080120b6: 4003        ands	r3, r0
@   0x080120b8: 2b00        cmp	r3, #0
@   0x080120ba: d10d        bne.n	0x120d8
@   0x080120bc: 2a0f        cmp	r2, #15
@   0x080120be: d10d        bne.n	0x120dc
@   0x080120c0: 2002        movs	r0, #2
@   0x080120c2: f7fc        feb7 	bl	0xee34
@   0x080120c6: 2001        movs	r0, #1
@   0x080120c8: e016        b.n	0x120f8
@   0x080120ca: 0000        movs	r0, r0
@   0x080120cc: 5330        strh	r0, [r6, r4]
@   0x080120ce: 0300        lsls	r0, r0, #12
@   0x080120d0: 6410        str	r0, [r2, #64]	@ 0x40
@   0x080120d2: 0300        lsls	r0, r0, #12
@   0x080120d4: 0052        lsls	r2, r2, #1
@   0x080120d6: 0400        lsls	r0, r0, #16
@   0x080120d8: 2a0f        cmp	r2, #15
@   0x080120da: d002        beq.n	0x120e2
@   0x080120dc: 1c50        adds	r0, r2, #1
@   0x080120de: 0400        lsls	r0, r0, #16
@   0x080120e0: 0c02        lsrs	r2, r0, #16
@   0x080120e2: 2b00        cmp	r3, #0
@   0x080120e4: d002        beq.n	0x120ec
@   0x080120e6: 1e58        subs	r0, r3, #1
@   0x080120e8: 0400        lsls	r0, r0, #16
@   0x080120ea: 0c03        lsrs	r3, r0, #16
@   0x080120ec: 0610        lsls	r0, r2, #24
@   0x080120ee: 0c02        lsrs	r2, r0, #16
@   0x080120f0: 4902        ldr	r1, [pc, #8]	@ (0x120fc)
@   0x080120f2: 18d0        adds	r0, r2, r3
@   0x080120f4: 8008        strh	r0, [r1, #0]
@   0x080120f6: 2000        movs	r0, #0
@   0x080120f8: bc02        pop	{r1}
@   0x080120fa: 4708        bx	r1
@   0x080120fc: 0052        lsls	r2, r2, #1
@   0x080120fe: 0400        lsls	r0, r0, #16

        thumb_func_start sub_08012098
sub_08012098: @ 0x08012098
        .incbin "frog_us_baserom.gba", 0x12098, 0x68
        thumb_func_end sub_08012098
