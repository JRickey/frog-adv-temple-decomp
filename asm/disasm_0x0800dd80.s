@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800dd80, 0x0800de0c)  (140 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800dd80 --end 0x800de0c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800dd80: b530        push	{r4, r5, lr}
@   0x0800dd82: b081        sub	sp, #4
@   0x0800dd84: 4a18        ldr	r2, [pc, #96]	@ (0xdde8)
@   0x0800dd86: 7a90        ldrb	r0, [r2, #10]
@   0x0800dd88: 2800        cmp	r0, #0
@   0x0800dd8a: d006        beq.n	0xdd9a
@   0x0800dd8c: 7a90        ldrb	r0, [r2, #10]
@   0x0800dd8e: 3801        subs	r0, #1
@   0x0800dd90: 2101        movs	r1, #1
@   0x0800dd92: 4081        lsls	r1, r0
@   0x0800dd94: 68d0        ldr	r0, [r2, #12]
@   0x0800dd96: 4308        orrs	r0, r1
@   0x0800dd98: 60d0        str	r0, [r2, #12]
@   0x0800dd9a: 2000        movs	r0, #0
@   0x0800dd9c: 9000        str	r0, [sp, #0]
@   0x0800dd9e: 4913        ldr	r1, [pc, #76]	@ (0xddec)
@   0x0800dda0: 4a13        ldr	r2, [pc, #76]	@ (0xddf0)
@   0x0800dda2: 4668        mov	r0, sp
@   0x0800dda4: f01f        fbd8 	bl	0x2d558
@   0x0800dda8: 2100        movs	r1, #0
@   0x0800ddaa: 4d12        ldr	r5, [pc, #72]	@ (0xddf4)
@   0x0800ddac: 2300        movs	r3, #0
@   0x0800ddae: 24f0        movs	r4, #240	@ 0xf0
@   0x0800ddb0: 00c8        lsls	r0, r1, #3
@   0x0800ddb2: 1940        adds	r0, r0, r5
@   0x0800ddb4: 8004        strh	r4, [r0, #0]
@   0x0800ddb6: 1c4a        adds	r2, r1, #1
@   0x0800ddb8: 3002        adds	r0, #2
@   0x0800ddba: 2102        movs	r1, #2
@   0x0800ddbc: 8003        strh	r3, [r0, #0]
@   0x0800ddbe: 3002        adds	r0, #2
@   0x0800ddc0: 3901        subs	r1, #1
@   0x0800ddc2: 2900        cmp	r1, #0
@   0x0800ddc4: dafa        bge.n	0xddbc
@   0x0800ddc6: 1c11        adds	r1, r2, #0
@   0x0800ddc8: 297f        cmp	r1, #127	@ 0x7f
@   0x0800ddca: ddf1        ble.n	0xddb0
@   0x0800ddcc: f01f        fd94 	bl	0x2d8f8
@   0x0800ddd0: 4809        ldr	r0, [pc, #36]	@ (0xddf8)
@   0x0800ddd2: 3038        adds	r0, #56	@ 0x38
@   0x0800ddd4: 7800        ldrb	r0, [r0, #0]
@   0x0800ddd6: 4909        ldr	r1, [pc, #36]	@ (0xddfc)
@   0x0800ddd8: f009        fbc8 	bl	0x1756c
@   0x0800dddc: 4902        ldr	r1, [pc, #8]	@ (0xdde8)
@   0x0800ddde: 7a88        ldrb	r0, [r1, #10]
@   0x0800dde0: 280f        cmp	r0, #15
@   0x0800dde2: d10d        bne.n	0xde00
@   0x0800dde4: 2017        movs	r0, #23
@   0x0800dde6: e00c        b.n	0xde02
@   0x0800dde8: 5330        strh	r0, [r6, r4]
@   0x0800ddea: 0300        lsls	r0, r0, #12
@   0x0800ddec: 0000        movs	r0, r0
@   0x0800ddee: 0601        lsls	r1, r0, #24
@   0x0800ddf0: 0008        movs	r0, r1
@   0x0800ddf2: 0100        lsls	r0, r0, #4
@   0x0800ddf4: 54a0        strb	r0, [r4, r2]
@   0x0800ddf6: 0300        lsls	r0, r0, #12
@   0x0800ddf8: 3500        adds	r5, #0
@   0x0800ddfa: 0300        lsls	r0, r0, #12
@   0x0800ddfc: 3600        adds	r6, #0
@   0x0800ddfe: 0300        lsls	r0, r0, #12
@   0x0800de00: 201d        movs	r0, #29
@   0x0800de02: 7248        strb	r0, [r1, #9]
@   0x0800de04: b001        add	sp, #4
@   0x0800de06: bc30        pop	{r4, r5}
@   0x0800de08: bc01        pop	{r0}
@   0x0800de0a: 4700        bx	r0

        thumb_func_start sub_0800DD80
sub_0800DD80: @ 0x0800dd80
        .incbin "frog_us_baserom.gba", 0xdd80, 0x8c
        thumb_func_end sub_0800DD80
