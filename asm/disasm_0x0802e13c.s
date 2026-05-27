@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e13c, 0x0802e1c8)  (140 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e13c --end 0x802e1c8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e13c: b570        push	{r4, r5, r6, lr}
@   0x0802e13e: 4810        ldr	r0, [pc, #64]	@ (0x2e180)
@   0x0802e140: 6800        ldr	r0, [r0, #0]
@   0x0802e142: 218e        movs	r1, #142	@ 0x8e
@   0x0802e144: 0049        lsls	r1, r1, #1
@   0x0802e146: 1846        adds	r6, r0, r1
@   0x0802e148: 2500        movs	r5, #0
@   0x0802e14a: 2400        movs	r4, #0
@   0x0802e14c: 7800        ldrb	r0, [r0, #0]
@   0x0802e14e: 3004        adds	r0, #4
@   0x0802e150: 4285        cmp	r5, r0
@   0x0802e152: da10        bge.n	0x2e176
@   0x0802e154: 6870        ldr	r0, [r6, #4]
@   0x0802e156: 00a1        lsls	r1, r4, #2
@   0x0802e158: 1809        adds	r1, r1, r0
@   0x0802e15a: 6808        ldr	r0, [r1, #0]
@   0x0802e15c: 2800        cmp	r0, #0
@   0x0802e15e: d003        beq.n	0x2e168
@   0x0802e160: 1c20        adds	r0, r4, #0
@   0x0802e162: f001        fc45 	bl	0x2f9f0
@   0x0802e166: 3501        adds	r5, #1
@   0x0802e168: 3401        adds	r4, #1
@   0x0802e16a: 4805        ldr	r0, [pc, #20]	@ (0x2e180)
@   0x0802e16c: 6800        ldr	r0, [r0, #0]
@   0x0802e16e: 7800        ldrb	r0, [r0, #0]
@   0x0802e170: 3004        adds	r0, #4
@   0x0802e172: 4284        cmp	r4, r0
@   0x0802e174: dbee        blt.n	0x2e154
@   0x0802e176: 1c28        adds	r0, r5, #0
@   0x0802e178: bc70        pop	{r4, r5, r6}
@   0x0802e17a: bc02        pop	{r1}
@   0x0802e17c: 4708        bx	r1
@   0x0802e17e: 0000        movs	r0, r0
@   0x0802e180: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e182: 0300        lsls	r0, r0, #12
@   0x0802e184: 1c03        adds	r3, r0, #0
@   0x0802e186: 2b00        cmp	r3, #0
@   0x0802e188: d01c        beq.n	0x2e1c4
@   0x0802e18a: 0c1a        lsrs	r2, r3, #16
@   0x0802e18c: 20ff        movs	r0, #255	@ 0xff
@   0x0802e18e: 4002        ands	r2, r0
@   0x0802e190: 480b        ldr	r0, [pc, #44]	@ (0x2e1c0)
@   0x0802e192: 6800        ldr	r0, [r0, #0]
@   0x0802e194: 4684        mov	ip, r0
@   0x0802e196: 2090        movs	r0, #144	@ 0x90
@   0x0802e198: 0040        lsls	r0, r0, #1
@   0x0802e19a: 4460        add	r0, ip
@   0x0802e19c: 6801        ldr	r1, [r0, #0]
@   0x0802e19e: 0090        lsls	r0, r2, #2
@   0x0802e1a0: 1840        adds	r0, r0, r1
@   0x0802e1a2: 6800        ldr	r0, [r0, #0]
@   0x0802e1a4: 4298        cmp	r0, r3
@   0x0802e1a6: d10d        bne.n	0x2e1c4
@   0x0802e1a8: 208a        movs	r0, #138	@ 0x8a
@   0x0802e1aa: 0040        lsls	r0, r0, #1
@   0x0802e1ac: 4460        add	r0, ip
@   0x0802e1ae: 6801        ldr	r1, [r0, #0]
@   0x0802e1b0: 0110        lsls	r0, r2, #4
@   0x0802e1b2: 1840        adds	r0, r0, r1
@   0x0802e1b4: 6800        ldr	r0, [r0, #0]
@   0x0802e1b6: 2800        cmp	r0, #0
@   0x0802e1b8: d004        beq.n	0x2e1c4
@   0x0802e1ba: 2001        movs	r0, #1
@   0x0802e1bc: e003        b.n	0x2e1c6
@   0x0802e1be: 0000        movs	r0, r0
@   0x0802e1c0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e1c2: 0300        lsls	r0, r0, #12
@   0x0802e1c4: 2000        movs	r0, #0
@   0x0802e1c6: 4770        bx	lr

        thumb_func_start sub_0802E13C
sub_0802E13C: @ 0x0802e13c
        .incbin "frog_us_baserom.gba", 0x2e13c, 0x8c
        thumb_func_end sub_0802E13C
