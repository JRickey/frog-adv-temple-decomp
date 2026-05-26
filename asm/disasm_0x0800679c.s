@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800679c, 0x08006830)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800679c --end 0x8006830 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800679c: 1c03        adds	r3, r0, #0
@   0x0800679e: 0609        lsls	r1, r1, #24
@   0x080067a0: 0e08        lsrs	r0, r1, #24
@   0x080067a2: 0612        lsls	r2, r2, #24
@   0x080067a4: 0e12        lsrs	r2, r2, #24
@   0x080067a6: 2809        cmp	r0, #9
@   0x080067a8: d840        bhi.n	0x682c
@   0x080067aa: 0080        lsls	r0, r0, #2
@   0x080067ac: 4901        ldr	r1, [pc, #4]	@ (0x67b4)
@   0x080067ae: 1840        adds	r0, r0, r1
@   0x080067b0: 6800        ldr	r0, [r0, #0]
@   0x080067b2: 4687        mov	pc, r0
@   0x080067b4: 67b8        str	r0, [r7, #120]	@ 0x78
@   0x080067b6: 0800        lsrs	r0, r0, #32
@   0x080067b8: 67e0        str	r0, [r4, #124]	@ 0x7c
@   0x080067ba: 0800        lsrs	r0, r0, #32
@   0x080067bc: 67e4        str	r4, [r4, #124]	@ 0x7c
@   0x080067be: 0800        lsrs	r0, r0, #32
@   0x080067c0: 67f8        str	r0, [r7, #124]	@ 0x7c
@   0x080067c2: 0800        lsrs	r0, r0, #32
@   0x080067c4: 67fc        str	r4, [r7, #124]	@ 0x7c
@   0x080067c6: 0800        lsrs	r0, r0, #32
@   0x080067c8: 6804        ldr	r4, [r0, #0]
@   0x080067ca: 0800        lsrs	r0, r0, #32
@   0x080067cc: 6808        ldr	r0, [r1, #0]
@   0x080067ce: 0800        lsrs	r0, r0, #32
@   0x080067d0: 682c        ldr	r4, [r5, #0]
@   0x080067d2: 0800        lsrs	r0, r0, #32
@   0x080067d4: 680c        ldr	r4, [r1, #0]
@   0x080067d6: 0800        lsrs	r0, r0, #32
@   0x080067d8: 6812        ldr	r2, [r2, #0]
@   0x080067da: 0800        lsrs	r0, r0, #32
@   0x080067dc: 6818        ldr	r0, [r3, #0]
@   0x080067de: 0800        lsrs	r0, r0, #32
@   0x080067e0: 8818        ldrh	r0, [r3, #0]
@   0x080067e2: e01c        b.n	0x681e
@   0x080067e4: 2001        movs	r0, #1
@   0x080067e6: 4090        lsls	r0, r2
@   0x080067e8: 17c1        asrs	r1, r0, #31
@   0x080067ea: 685a        ldr	r2, [r3, #4]
@   0x080067ec: 689b        ldr	r3, [r3, #8]
@   0x080067ee: 4002        ands	r2, r0
@   0x080067f0: 400b        ands	r3, r1
@   0x080067f2: 1c18        adds	r0, r3, #0
@   0x080067f4: 4310        orrs	r0, r2
@   0x080067f6: e015        b.n	0x6824
@   0x080067f8: 8998        ldrh	r0, [r3, #12]
@   0x080067fa: e010        b.n	0x681e
@   0x080067fc: 2101        movs	r1, #1
@   0x080067fe: 4091        lsls	r1, r2
@   0x08006800: 6918        ldr	r0, [r3, #16]
@   0x08006802: e00e        b.n	0x6822
@   0x08006804: 8c98        ldrh	r0, [r3, #36]	@ 0x24
@   0x08006806: e00a        b.n	0x681e
@   0x08006808: 8cd8        ldrh	r0, [r3, #38]	@ 0x26
@   0x0800680a: e008        b.n	0x681e
@   0x0800680c: 1c18        adds	r0, r3, #0
@   0x0800680e: 302c        adds	r0, #44	@ 0x2c
@   0x08006810: e004        b.n	0x681c
@   0x08006812: 1c18        adds	r0, r3, #0
@   0x08006814: 302a        adds	r0, #42	@ 0x2a
@   0x08006816: e001        b.n	0x681c
@   0x08006818: 1c18        adds	r0, r3, #0
@   0x0800681a: 302b        adds	r0, #43	@ 0x2b
@   0x0800681c: 7800        ldrb	r0, [r0, #0]
@   0x0800681e: 4110        asrs	r0, r2
@   0x08006820: 2101        movs	r1, #1
@   0x08006822: 4008        ands	r0, r1
@   0x08006824: 2800        cmp	r0, #0
@   0x08006826: d001        beq.n	0x682c
@   0x08006828: 2001        movs	r0, #1
@   0x0800682a: e000        b.n	0x682e
@   0x0800682c: 2000        movs	r0, #0
@   0x0800682e: 4770        bx	lr

        thumb_func_start sub_0800679C
sub_0800679C: @ 0x0800679c
        .incbin "frog_us_baserom.gba", 0x679c, 0x94
        thumb_func_end sub_0800679C
