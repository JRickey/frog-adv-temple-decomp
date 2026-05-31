@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800c2d0, 0x0800c358)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800c2d0 --end 0x800c358 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800c2d0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800c2d2: b081        sub	sp, #4
@   0x0800c2d4: 9c06        ldr	r4, [sp, #24]
@   0x0800c2d6: 0600        lsls	r0, r0, #24
@   0x0800c2d8: 0e00        lsrs	r0, r0, #24
@   0x0800c2da: 0609        lsls	r1, r1, #24
@   0x0800c2dc: 0e0d        lsrs	r5, r1, #24
@   0x0800c2de: 0612        lsls	r2, r2, #24
@   0x0800c2e0: 0e16        lsrs	r6, r2, #24
@   0x0800c2e2: 061b        lsls	r3, r3, #24
@   0x0800c2e4: 0e1b        lsrs	r3, r3, #24
@   0x0800c2e6: 0624        lsls	r4, r4, #24
@   0x0800c2e8: 2c00        cmp	r4, #0
@   0x0800c2ea: d119        bne.n	0xc320
@   0x0800c2ec: 4c0b        ldr	r4, [pc, #44]	@ (0xc31c)
@   0x0800c2ee: 0600        lsls	r0, r0, #24
@   0x0800c2f0: 1600        asrs	r0, r0, #24
@   0x0800c2f2: 0041        lsls	r1, r0, #1
@   0x0800c2f4: 1809        adds	r1, r1, r0
@   0x0800c2f6: 0089        lsls	r1, r1, #2
@   0x0800c2f8: 1d20        adds	r0, r4, #4
@   0x0800c2fa: 1808        adds	r0, r1, r0
@   0x0800c2fc: 6802        ldr	r2, [r0, #0]
@   0x0800c2fe: 0098        lsls	r0, r3, #2
@   0x0800c300: 1880        adds	r0, r0, r2
@   0x0800c302: 2300        movs	r3, #0
@   0x0800c304: 5ec2        ldrsh	r2, [r0, r3]
@   0x0800c306: 2702        movs	r7, #2
@   0x0800c308: 5fc3        ldrsh	r3, [r0, r7]
@   0x0800c30a: 1909        adds	r1, r1, r4
@   0x0800c30c: 7a08        ldrb	r0, [r1, #8]
@   0x0800c30e: 9000        str	r0, [sp, #0]
@   0x0800c310: 1c28        adds	r0, r5, #0
@   0x0800c312: 1c31        adds	r1, r6, #0
@   0x0800c314: f000        fc34 	bl	0xcb80
@   0x0800c318: e018        b.n	0xc34c
@   0x0800c31a: 0000        movs	r0, r0
@   0x0800c31c: 0b00        lsrs	r0, r0, #12
@   0x0800c31e: 080c        lsrs	r4, r1, #32
@   0x0800c320: 4c0c        ldr	r4, [pc, #48]	@ (0xc354)
@   0x0800c322: 0600        lsls	r0, r0, #24
@   0x0800c324: 1600        asrs	r0, r0, #24
@   0x0800c326: 0041        lsls	r1, r0, #1
@   0x0800c328: 1809        adds	r1, r1, r0
@   0x0800c32a: 0089        lsls	r1, r1, #2
@   0x0800c32c: 1d20        adds	r0, r4, #4
@   0x0800c32e: 1808        adds	r0, r1, r0
@   0x0800c330: 6802        ldr	r2, [r0, #0]
@   0x0800c332: 0098        lsls	r0, r3, #2
@   0x0800c334: 1880        adds	r0, r0, r2
@   0x0800c336: 2300        movs	r3, #0
@   0x0800c338: 5ec2        ldrsh	r2, [r0, r3]
@   0x0800c33a: 2702        movs	r7, #2
@   0x0800c33c: 5fc3        ldrsh	r3, [r0, r7]
@   0x0800c33e: 1909        adds	r1, r1, r4
@   0x0800c340: 7a48        ldrb	r0, [r1, #9]
@   0x0800c342: 9000        str	r0, [sp, #0]
@   0x0800c344: 1c28        adds	r0, r5, #0
@   0x0800c346: 1c31        adds	r1, r6, #0
@   0x0800c348: f000        fc1a 	bl	0xcb80
@   0x0800c34c: b001        add	sp, #4
@   0x0800c34e: bcf0        pop	{r4, r5, r6, r7}
@   0x0800c350: bc01        pop	{r0}
@   0x0800c352: 4700        bx	r0
@   0x0800c354: 0b00        lsrs	r0, r0, #12
@   0x0800c356: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_0800C2D0
sub_0800C2D0: @ 0x0800c2d0
        .incbin "frog_us_baserom.gba", 0xc2d0, 0x88
        thumb_func_end sub_0800C2D0
