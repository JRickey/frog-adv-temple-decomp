@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800dab8, 0x0800dc3c)  (388 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800dab8 --end 0x800dc3c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800dab8: b500        push	{lr}
@   0x0800daba: b081        sub	sp, #4
@   0x0800dabc: 1c01        adds	r1, r0, #0
@   0x0800dabe: 0609        lsls	r1, r1, #24
@   0x0800dac0: 1609        asrs	r1, r1, #24
@   0x0800dac2: 4668        mov	r0, sp
@   0x0800dac4: f7ff        fad4 	bl	0xd070
@   0x0800dac8: 9b00        ldr	r3, [sp, #0]
@   0x0800daca: 490b        ldr	r1, [pc, #44]	@ (0xdaf8)
@   0x0800dacc: 7e08        ldrb	r0, [r1, #24]
@   0x0800dace: 7e49        ldrb	r1, [r1, #25]
@   0x0800dad0: 041a        lsls	r2, r3, #16
@   0x0800dad2: 1412        asrs	r2, r2, #16
@   0x0800dad4: 141b        asrs	r3, r3, #16
@   0x0800dad6: f7ff        f957 	bl	0xcd88
@   0x0800dada: 0600        lsls	r0, r0, #24
@   0x0800dadc: 1601        asrs	r1, r0, #24
@   0x0800dade: 22ff        movs	r2, #255	@ 0xff
@   0x0800dae0: 0612        lsls	r2, r2, #24
@   0x0800dae2: 1880        adds	r0, r0, r2
@   0x0800dae4: 0e00        lsrs	r0, r0, #24
@   0x0800dae6: 2801        cmp	r0, #1
@   0x0800dae8: d903        bls.n	0xdaf2
@   0x0800daea: 2915        cmp	r1, #21
@   0x0800daec: d001        beq.n	0xdaf2
@   0x0800daee: 2914        cmp	r1, #20
@   0x0800daf0: d104        bne.n	0xdafc
@   0x0800daf2: 2000        movs	r0, #0
@   0x0800daf4: e003        b.n	0xdafe
@   0x0800daf6: 0000        movs	r0, r0
@   0x0800daf8: 35e0        adds	r5, #224	@ 0xe0
@   0x0800dafa: 0300        lsls	r0, r0, #12
@   0x0800dafc: 2001        movs	r0, #1
@   0x0800dafe: b001        add	sp, #4
@   0x0800db00: bc02        pop	{r1}
@   0x0800db02: 4708        bx	r1
@   0x0800db04: b570        push	{r4, r5, r6, lr}
@   0x0800db06: 0609        lsls	r1, r1, #24
@   0x0800db08: 4c0d        ldr	r4, [pc, #52]	@ (0xdb40)
@   0x0800db0a: 4026        ands	r6, r4
@   0x0800db0c: 22a0        movs	r2, #160	@ 0xa0
@   0x0800db0e: 02d2        lsls	r2, r2, #11
@   0x0800db10: 4316        orrs	r6, r2
@   0x0800db12: 4d0c        ldr	r5, [pc, #48]	@ (0xdb44)
@   0x0800db14: 402e        ands	r6, r5
@   0x0800db16: 2203        movs	r2, #3
@   0x0800db18: 4316        orrs	r6, r2
@   0x0800db1a: 1433        asrs	r3, r6, #16
@   0x0800db1c: 0eca        lsrs	r2, r1, #27
@   0x0800db1e: 18d2        adds	r2, r2, r3
@   0x0800db20: 0412        lsls	r2, r2, #16
@   0x0800db22: 4026        ands	r6, r4
@   0x0800db24: 4316        orrs	r6, r2
@   0x0800db26: 22e0        movs	r2, #224	@ 0xe0
@   0x0800db28: 04d2        lsls	r2, r2, #19
@   0x0800db2a: 400a        ands	r2, r1
@   0x0800db2c: 0e12        lsrs	r2, r2, #24
@   0x0800db2e: 1992        adds	r2, r2, r6
@   0x0800db30: 0412        lsls	r2, r2, #16
@   0x0800db32: 0c12        lsrs	r2, r2, #16
@   0x0800db34: 402e        ands	r6, r5
@   0x0800db36: 4316        orrs	r6, r2
@   0x0800db38: 6006        str	r6, [r0, #0]
@   0x0800db3a: bc70        pop	{r4, r5, r6}
@   0x0800db3c: bc02        pop	{r1}
@   0x0800db3e: 4708        bx	r1
@   0x0800db40: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0800db44: 0000        movs	r0, r0
@   0x0800db46: ffff        0400 	vraddhn.i<illegal width 128>	d16, <illegal reg q7.5>, q0
@   0x0800db4a: 0c00        lsrs	r0, r0, #16
@   0x0800db4c: 1c02        adds	r2, r0, #0
@   0x0800db4e: 0409        lsls	r1, r1, #16
@   0x0800db50: 0c09        lsrs	r1, r1, #16
@   0x0800db52: 0410        lsls	r0, r2, #16
@   0x0800db54: 4b06        ldr	r3, [pc, #24]	@ (0xdb70)
@   0x0800db56: 18c0        adds	r0, r0, r3
@   0x0800db58: 0c00        lsrs	r0, r0, #16
@   0x0800db5a: 2808        cmp	r0, #8
@   0x0800db5c: d805        bhi.n	0xdb6a
@   0x0800db5e: 0408        lsls	r0, r1, #16
@   0x0800db60: 1400        asrs	r0, r0, #16
@   0x0800db62: 2804        cmp	r0, #4
@   0x0800db64: dd01        ble.n	0xdb6a
@   0x0800db66: 280d        cmp	r0, #13
@   0x0800db68: dd04        ble.n	0xdb74
@   0x0800db6a: 20ff        movs	r0, #255	@ 0xff
@   0x0800db6c: e008        b.n	0xdb80
@   0x0800db6e: 0000        movs	r0, r0
@   0x0800db70: 0000        movs	r0, r0
@   0x0800db72: fffd        3805 	vtbl.8	d19, {d13}, d5
@   0x0800db76: 00c0        lsls	r0, r0, #3
@   0x0800db78: 1ed1        subs	r1, r2, #3
@   0x0800db7a: 1840        adds	r0, r0, r1
@   0x0800db7c: 0600        lsls	r0, r0, #24
@   0x0800db7e: 0e00        lsrs	r0, r0, #24
@   0x0800db80: 4770        bx	lr
@   0x0800db82: 0000        movs	r0, r0
@   0x0800db84: b510        push	{r4, lr}
@   0x0800db86: 0409        lsls	r1, r1, #16
@   0x0800db88: 0c09        lsrs	r1, r1, #16
@   0x0800db8a: 0612        lsls	r2, r2, #24
@   0x0800db8c: 0e14        lsrs	r4, r2, #24
@   0x0800db8e: 0400        lsls	r0, r0, #16
@   0x0800db90: 1403        asrs	r3, r0, #16
@   0x0800db92: 1eda        subs	r2, r3, #3
@   0x0800db94: 0410        lsls	r0, r2, #16
@   0x0800db96: 0c00        lsrs	r0, r0, #16
@   0x0800db98: 2807        cmp	r0, #7
@   0x0800db9a: d819        bhi.n	0xdbd0
@   0x0800db9c: 0408        lsls	r0, r1, #16
@   0x0800db9e: 1401        asrs	r1, r0, #16
@   0x0800dba0: 2904        cmp	r1, #4
@   0x0800dba2: dd15        ble.n	0xdbd0
@   0x0800dba4: 290c        cmp	r1, #12
@   0x0800dba6: dc13        bgt.n	0xdbd0
@   0x0800dba8: 1c10        adds	r0, r2, #0
@   0x0800dbaa: 0400        lsls	r0, r0, #16
@   0x0800dbac: 0c00        lsrs	r0, r0, #16
@   0x0800dbae: 2808        cmp	r0, #8
@   0x0800dbb0: d804        bhi.n	0xdbbc
@   0x0800dbb2: 1c08        adds	r0, r1, #0
@   0x0800dbb4: 2804        cmp	r0, #4
@   0x0800dbb6: dd01        ble.n	0xdbbc
@   0x0800dbb8: 280d        cmp	r0, #13
@   0x0800dbba: dd01        ble.n	0xdbc0
@   0x0800dbbc: 20ff        movs	r0, #255	@ 0xff
@   0x0800dbbe: e002        b.n	0xdbc6
@   0x0800dbc0: 3805        subs	r0, #5
@   0x0800dbc2: 00c0        lsls	r0, r0, #3
@   0x0800dbc4: 1880        adds	r0, r0, r2
@   0x0800dbc6: 0600        lsls	r0, r0, #24
@   0x0800dbc8: 0e00        lsrs	r0, r0, #24
@   0x0800dbca: 4903        ldr	r1, [pc, #12]	@ (0xdbd8)
@   0x0800dbcc: 1840        adds	r0, r0, r1
@   0x0800dbce: 7004        strb	r4, [r0, #0]
@   0x0800dbd0: bc10        pop	{r4}
@   0x0800dbd2: bc01        pop	{r0}
@   0x0800dbd4: 4700        bx	r0
@   0x0800dbd6: 0000        movs	r0, r0
@   0x0800dbd8: 53a0        strh	r0, [r4, r6]
@   0x0800dbda: 0300        lsls	r0, r0, #12
@   0x0800dbdc: b510        push	{r4, lr}
@   0x0800dbde: 0409        lsls	r1, r1, #16
@   0x0800dbe0: 0c09        lsrs	r1, r1, #16
@   0x0800dbe2: 0612        lsls	r2, r2, #24
@   0x0800dbe4: 0e14        lsrs	r4, r2, #24
@   0x0800dbe6: 0400        lsls	r0, r0, #16
@   0x0800dbe8: 1403        asrs	r3, r0, #16
@   0x0800dbea: 1eda        subs	r2, r3, #3
@   0x0800dbec: 0410        lsls	r0, r2, #16
@   0x0800dbee: 0c00        lsrs	r0, r0, #16
@   0x0800dbf0: 2807        cmp	r0, #7
@   0x0800dbf2: d81b        bhi.n	0xdc2c
@   0x0800dbf4: 0408        lsls	r0, r1, #16
@   0x0800dbf6: 1401        asrs	r1, r0, #16
@   0x0800dbf8: 2904        cmp	r1, #4
@   0x0800dbfa: dd17        ble.n	0xdc2c
@   0x0800dbfc: 290c        cmp	r1, #12
@   0x0800dbfe: dc15        bgt.n	0xdc2c
@   0x0800dc00: 1ed8        subs	r0, r3, #3
@   0x0800dc02: 0400        lsls	r0, r0, #16
@   0x0800dc04: 0c00        lsrs	r0, r0, #16
@   0x0800dc06: 2808        cmp	r0, #8
@   0x0800dc08: d804        bhi.n	0xdc14
@   0x0800dc0a: 1c08        adds	r0, r1, #0
@   0x0800dc0c: 2804        cmp	r0, #4
@   0x0800dc0e: dd01        ble.n	0xdc14
@   0x0800dc10: 280d        cmp	r0, #13
@   0x0800dc12: dd01        ble.n	0xdc18
@   0x0800dc14: 20ff        movs	r0, #255	@ 0xff
@   0x0800dc16: e002        b.n	0xdc1e
@   0x0800dc18: 3805        subs	r0, #5
@   0x0800dc1a: 00c0        lsls	r0, r0, #3
@   0x0800dc1c: 1880        adds	r0, r0, r2
@   0x0800dc1e: 0600        lsls	r0, r0, #24
@   0x0800dc20: 0e00        lsrs	r0, r0, #24
@   0x0800dc22: 4903        ldr	r1, [pc, #12]	@ (0xdc30)
@   0x0800dc24: 1840        adds	r0, r0, r1
@   0x0800dc26: 7800        ldrb	r0, [r0, #0]
@   0x0800dc28: 42a0        cmp	r0, r4
@   0x0800dc2a: d003        beq.n	0xdc34
@   0x0800dc2c: 2000        movs	r0, #0
@   0x0800dc2e: e002        b.n	0xdc36
@   0x0800dc30: 53a0        strh	r0, [r4, r6]
@   0x0800dc32: 0300        lsls	r0, r0, #12
@   0x0800dc34: 2001        movs	r0, #1
@   0x0800dc36: bc10        pop	{r4}
@   0x0800dc38: bc02        pop	{r1}
@   0x0800dc3a: 4708        bx	r1

        thumb_func_start sub_0800DAB8
sub_0800DAB8: @ 0x0800dab8
        .incbin "frog_us_baserom.gba", 0xdab8, 0x4c
        thumb_func_end sub_0800DAB8

        .global sub_0800DB04
        .thumb_func
sub_0800DB04: @ 0x0800db04
        .incbin "frog_us_baserom.gba", 0xdb04, 0x48

        .incbin "frog_us_baserom.gba", 0xdb4c, 0xf0
