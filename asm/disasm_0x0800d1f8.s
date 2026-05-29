@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d1f8, 0x0800d270)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d1f8 --end 0x800d270 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d1f8: b570        push	{r4, r5, r6, lr}
@   0x0800d1fa: 4818        ldr	r0, [pc, #96]	@ (0xd25c)
@   0x0800d1fc: 2103        movs	r1, #3
@   0x0800d1fe: 2200        movs	r2, #0
@   0x0800d200: f7f9        facc 	bl	0x679c
@   0x0800d204: 0600        lsls	r0, r0, #24
@   0x0800d206: 2800        cmp	r0, #0
@   0x0800d208: d021        beq.n	0xd24e
@   0x0800d20a: 4e15        ldr	r6, [pc, #84]	@ (0xd260)
@   0x0800d20c: 4c15        ldr	r4, [pc, #84]	@ (0xd264)
@   0x0800d20e: 4816        ldr	r0, [pc, #88]	@ (0xd268)
@   0x0800d210: 1825        adds	r5, r4, r0
@   0x0800d212: 6830        ldr	r0, [r6, #0]
@   0x0800d214: 6829        ldr	r1, [r5, #0]
@   0x0800d216: 1a40        subs	r0, r0, r1
@   0x0800d218: 4a14        ldr	r2, [pc, #80]	@ (0xd26c)
@   0x0800d21a: 18a1        adds	r1, r4, r2
@   0x0800d21c: 7809        ldrb	r1, [r1, #0]
@   0x0800d21e: 4288        cmp	r0, r1
@   0x0800d220: d915        bls.n	0xd24e
@   0x0800d222: 2005        movs	r0, #5
@   0x0800d224: f000        faf0 	bl	0xd808
@   0x0800d228: 2014        movs	r0, #20
@   0x0800d22a: 210a        movs	r1, #10
@   0x0800d22c: f000        f910 	bl	0xd450
@   0x0800d230: f7ff        ff62 	bl	0xd0f8
@   0x0800d234: 2038        movs	r0, #56	@ 0x38
@   0x0800d236: f013        fd1f 	bl	0x20c78
@   0x0800d23a: 20b2        movs	r0, #178	@ 0xb2
@   0x0800d23c: 0100        lsls	r0, r0, #4
@   0x0800d23e: 1821        adds	r1, r4, r0
@   0x0800d240: 7808        ldrb	r0, [r1, #0]
@   0x0800d242: 2804        cmp	r0, #4
@   0x0800d244: d801        bhi.n	0xd24a
@   0x0800d246: 3001        adds	r0, #1
@   0x0800d248: 7008        strb	r0, [r1, #0]
@   0x0800d24a: 6830        ldr	r0, [r6, #0]
@   0x0800d24c: 6028        str	r0, [r5, #0]
@   0x0800d24e: f01e        fbc1 	bl	0x2b9d4
@   0x0800d252: f01e        fc07 	bl	0x2ba64
@   0x0800d256: bc70        pop	{r4, r5, r6}
@   0x0800d258: bc01        pop	{r0}
@   0x0800d25a: 4700        bx	r0
@   0x0800d25c: 6110        str	r0, [r2, #16]
@   0x0800d25e: 0300        lsls	r0, r0, #12
@   0x0800d260: 5330        strh	r0, [r6, r4]
@   0x0800d262: 0300        lsls	r0, r0, #12
@   0x0800d264: 3720        adds	r7, #32
@   0x0800d266: 0300        lsls	r0, r0, #12
@   0x0800d268: 0b1c        lsrs	r4, r3, #12
@   0x0800d26a: 0000        movs	r0, r0
@   0x0800d26c: 0b22        lsrs	r2, r4, #12

        thumb_func_start sub_0800D1F8
sub_0800D1F8: @ 0x0800d1f8
        .incbin "frog_us_baserom.gba", 0xd1f8, 0x78
        thumb_func_end sub_0800D1F8
