@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08010958, 0x08010a44)  (236 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8010958 --end 0x8010a44 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08010958: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801095a: 4657        mov	r7, sl
@   0x0801095c: 464e        mov	r6, r9
@   0x0801095e: 4645        mov	r5, r8
@   0x08010960: b4e0        push	{r5, r6, r7}
@   0x08010962: 0600        lsls	r0, r0, #24
@   0x08010964: 0e05        lsrs	r5, r0, #24
@   0x08010966: 0609        lsls	r1, r1, #24
@   0x08010968: 0e09        lsrs	r1, r1, #24
@   0x0801096a: 4688        mov	r8, r1
@   0x0801096c: 4830        ldr	r0, [pc, #192]	@ (0x10a30)
@   0x0801096e: 8cc1        ldrh	r1, [r0, #38]	@ 0x26
@   0x08010970: 1c06        adds	r6, r0, #0
@   0x08010972: 2900        cmp	r1, #0
@   0x08010974: d01b        beq.n	0x109ae
@   0x08010976: 2400        movs	r4, #0
@   0x08010978: 42ac        cmp	r4, r5
@   0x0801097a: d218        bcs.n	0x109ae
@   0x0801097c: 4f2d        ldr	r7, [pc, #180]	@ (0x10a34)
@   0x0801097e: 482c        ldr	r0, [pc, #176]	@ (0x10a30)
@   0x08010980: 8cc0        ldrh	r0, [r0, #38]	@ 0x26
@   0x08010982: 4120        asrs	r0, r4
@   0x08010984: 2101        movs	r1, #1
@   0x08010986: 4008        ands	r0, r1
@   0x08010988: 2800        cmp	r0, #0
@   0x0801098a: d00b        beq.n	0x109a4
@   0x0801098c: 482a        ldr	r0, [pc, #168]	@ (0x10a38)
@   0x0801098e: 7a81        ldrb	r1, [r0, #10]
@   0x08010990: 3901        subs	r1, #1
@   0x08010992: 0088        lsls	r0, r1, #2
@   0x08010994: 1840        adds	r0, r0, r1
@   0x08010996: 0080        lsls	r0, r0, #2
@   0x08010998: 19c0        adds	r0, r0, r7
@   0x0801099a: 6800        ldr	r0, [r0, #0]
@   0x0801099c: 1c21        adds	r1, r4, #0
@   0x0801099e: 2201        movs	r2, #1
@   0x080109a0: f7ff        fe06 	bl	0x105b0
@   0x080109a4: 1c60        adds	r0, r4, #1
@   0x080109a6: 0600        lsls	r0, r0, #24
@   0x080109a8: 0e04        lsrs	r4, r0, #24
@   0x080109aa: 42ac        cmp	r4, r5
@   0x080109ac: d3e7        bcc.n	0x1097e
@   0x080109ae: 1c31        adds	r1, r6, #0
@   0x080109b0: 312a        adds	r1, #42	@ 0x2a
@   0x080109b2: 7808        ldrb	r0, [r1, #0]
@   0x080109b4: 2800        cmp	r0, #0
@   0x080109b6: d034        beq.n	0x10a22
@   0x080109b8: 2400        movs	r4, #0
@   0x080109ba: 4544        cmp	r4, r8
@   0x080109bc: d231        bcs.n	0x10a22
@   0x080109be: 481f        ldr	r0, [pc, #124]	@ (0x10a3c)
@   0x080109c0: 4682        mov	sl, r0
@   0x080109c2: 4689        mov	r9, r1
@   0x080109c4: 4648        mov	r0, r9
@   0x080109c6: 7801        ldrb	r1, [r0, #0]
@   0x080109c8: 4121        asrs	r1, r4
@   0x080109ca: 2001        movs	r0, #1
@   0x080109cc: 4001        ands	r1, r0
@   0x080109ce: 1c67        adds	r7, r4, #1
@   0x080109d0: 2900        cmp	r1, #0
@   0x080109d2: d022        beq.n	0x10a1a
@   0x080109d4: 4818        ldr	r0, [pc, #96]	@ (0x10a38)
@   0x080109d6: 7a81        ldrb	r1, [r0, #10]
@   0x080109d8: 3901        subs	r1, #1
@   0x080109da: 0088        lsls	r0, r1, #2
@   0x080109dc: 1840        adds	r0, r0, r1
@   0x080109de: 0080        lsls	r0, r0, #2
@   0x080109e0: 4450        add	r0, sl
@   0x080109e2: 6801        ldr	r1, [r0, #0]
@   0x080109e4: 0060        lsls	r0, r4, #1
@   0x080109e6: 1840        adds	r0, r0, r1
@   0x080109e8: 7805        ldrb	r5, [r0, #0]
@   0x080109ea: 7844        ldrb	r4, [r0, #1]
@   0x080109ec: 2c00        cmp	r4, #0
@   0x080109ee: d014        beq.n	0x10a1a
@   0x080109f0: 4e13        ldr	r6, [pc, #76]	@ (0x10a40)
@   0x080109f2: 4811        ldr	r0, [pc, #68]	@ (0x10a38)
@   0x080109f4: 7a81        ldrb	r1, [r0, #10]
@   0x080109f6: 3901        subs	r1, #1
@   0x080109f8: 0088        lsls	r0, r1, #2
@   0x080109fa: 1840        adds	r0, r0, r1
@   0x080109fc: 0080        lsls	r0, r0, #2
@   0x080109fe: 1980        adds	r0, r0, r6
@   0x08010a00: 6800        ldr	r0, [r0, #0]
@   0x08010a02: 1c29        adds	r1, r5, #0
@   0x08010a04: 1c4a        adds	r2, r1, #1
@   0x08010a06: 0612        lsls	r2, r2, #24
@   0x08010a08: 0e15        lsrs	r5, r2, #24
@   0x08010a0a: 2200        movs	r2, #0
@   0x08010a0c: f7ff        fdd0 	bl	0x105b0
@   0x08010a10: 1e60        subs	r0, r4, #1
@   0x08010a12: 0600        lsls	r0, r0, #24
@   0x08010a14: 0e04        lsrs	r4, r0, #24
@   0x08010a16: 2c00        cmp	r4, #0
@   0x08010a18: d1eb        bne.n	0x109f2
@   0x08010a1a: 0638        lsls	r0, r7, #24
@   0x08010a1c: 0e04        lsrs	r4, r0, #24
@   0x08010a1e: 4544        cmp	r4, r8
@   0x08010a20: d3d0        bcc.n	0x109c4
@   0x08010a22: bc38        pop	{r3, r4, r5}
@   0x08010a24: 4698        mov	r8, r3
@   0x08010a26: 46a1        mov	r9, r4
@   0x08010a28: 46aa        mov	sl, r5
@   0x08010a2a: bcf0        pop	{r4, r5, r6, r7}
@   0x08010a2c: bc01        pop	{r0}
@   0x08010a2e: 4700        bx	r0
@   0x08010a30: 6110        str	r0, [r2, #16]
@   0x08010a32: 0300        lsls	r0, r0, #12
@   0x08010a34: 7eb4        ldrb	r4, [r6, #26]
@   0x08010a36: 0830        lsrs	r0, r6, #32
@   0x08010a38: 5330        strh	r0, [r6, r4]
@   0x08010a3a: 0300        lsls	r0, r0, #12
@   0x08010a3c: 7eb8        ldrb	r0, [r7, #26]
@   0x08010a3e: 0830        lsrs	r0, r6, #32
@   0x08010a40: 7ebc        ldrb	r4, [r7, #26]
@   0x08010a42: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_08010958
sub_08010958: @ 0x08010958
        .incbin "frog_us_baserom.gba", 0x10958, 0xec
        thumb_func_end sub_08010958
