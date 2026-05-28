@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080072e0, 0x0800736c)  (140 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80072e0 --end 0x800736c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080072e0: b570        push	{r4, r5, r6, lr}
@   0x080072e2: b081        sub	sp, #4
@   0x080072e4: 1c16        adds	r6, r2, #0
@   0x080072e6: 0600        lsls	r0, r0, #24
@   0x080072e8: 1605        asrs	r5, r0, #24
@   0x080072ea: 4810        ldr	r0, [pc, #64]	@ (0x732c)
@   0x080072ec: 0609        lsls	r1, r1, #24
@   0x080072ee: 1549        asrs	r1, r1, #21
@   0x080072f0: 1809        adds	r1, r1, r0
@   0x080072f2: 2400        movs	r4, #0
@   0x080072f4: 570c        ldrsb	r4, [r1, r4]
@   0x080072f6: 1e63        subs	r3, r4, #1
@   0x080072f8: 2002        movs	r0, #2
@   0x080072fa: 5608        ldrsb	r0, [r1, r0]
@   0x080072fc: 9000        str	r0, [sp, #0]
@   0x080072fe: 1c28        adds	r0, r5, #0
@   0x08007300: 1c31        adds	r1, r6, #0
@   0x08007302: 2200        movs	r2, #0
@   0x08007304: f000        f832 	bl	0x736c
@   0x08007308: 2d01        cmp	r5, #1
@   0x0800730a: d117        bne.n	0x733c
@   0x0800730c: 4808        ldr	r0, [pc, #32]	@ (0x7330)
@   0x0800730e: 7e80        ldrb	r0, [r0, #26]
@   0x08007310: 2803        cmp	r0, #3
@   0x08007312: d822        bhi.n	0x735a
@   0x08007314: 1c30        adds	r0, r6, #0
@   0x08007316: 1c21        adds	r1, r4, #0
@   0x08007318: f7ff        ff0e 	bl	0x7138
@   0x0800731c: 2800        cmp	r0, #0
@   0x0800731e: d01c        beq.n	0x735a
@   0x08007320: 4804        ldr	r0, [pc, #16]	@ (0x7334)
@   0x08007322: 4905        ldr	r1, [pc, #20]	@ (0x7338)
@   0x08007324: 89c9        ldrh	r1, [r1, #14]
@   0x08007326: f7ff        fc2f 	bl	0x6b88
@   0x0800732a: e016        b.n	0x735a
@   0x0800732c: 0ab0        lsrs	r0, r6, #10
@   0x0800732e: 080c        lsrs	r4, r1, #32
@   0x08007330: 3720        adds	r7, #32
@   0x08007332: 0300        lsls	r0, r0, #12
@   0x08007334: 35e0        adds	r5, #224	@ 0xe0
@   0x08007336: 0300        lsls	r0, r0, #12
@   0x08007338: 0ae8        lsrs	r0, r5, #11
@   0x0800733a: 080c        lsrs	r4, r1, #32
@   0x0800733c: 1c30        adds	r0, r6, #0
@   0x0800733e: 1c21        adds	r1, r4, #0
@   0x08007340: f7ff        fefa 	bl	0x7138
@   0x08007344: 2800        cmp	r0, #0
@   0x08007346: d008        beq.n	0x735a
@   0x08007348: 4806        ldr	r0, [pc, #24]	@ (0x7364)
@   0x0800734a: 4a07        ldr	r2, [pc, #28]	@ (0x7368)
@   0x0800734c: 0069        lsls	r1, r5, #1
@   0x0800734e: 1949        adds	r1, r1, r5
@   0x08007350: 0089        lsls	r1, r1, #2
@   0x08007352: 1889        adds	r1, r1, r2
@   0x08007354: 8849        ldrh	r1, [r1, #2]
@   0x08007356: f7ff        fc17 	bl	0x6b88
@   0x0800735a: b001        add	sp, #4
@   0x0800735c: bc70        pop	{r4, r5, r6}
@   0x0800735e: bc01        pop	{r0}
@   0x08007360: 4700        bx	r0
@   0x08007362: 0000        movs	r0, r0
@   0x08007364: 35e0        adds	r5, #224	@ 0xe0
@   0x08007366: 0300        lsls	r0, r0, #12
@   0x08007368: 0ae8        lsrs	r0, r5, #11
@   0x0800736a: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_080072E0
sub_080072E0: @ 0x080072e0
        .incbin "frog_us_baserom.gba", 0x72e0, 0x8c
        thumb_func_end sub_080072E0
