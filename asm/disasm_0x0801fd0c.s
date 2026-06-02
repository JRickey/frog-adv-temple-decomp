@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801fd0c, 0x0801fe68)  (348 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801fd0c --end 0x801fe68 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801fd0c: b570        push	{r4, r5, r6, lr}
@   0x0801fd0e: b088        sub	sp, #32
@   0x0801fd10: 2300        movs	r3, #0
@   0x0801fd12: 9304        str	r3, [sp, #16]
@   0x0801fd14: 4d27        ldr	r5, [pc, #156]	@ (0x1fdb4)
@   0x0801fd16: 9505        str	r5, [sp, #20]
@   0x0801fd18: 4827        ldr	r0, [pc, #156]	@ (0x1fdb8)
@   0x0801fd1a: 9006        str	r0, [sp, #24]
@   0x0801fd1c: 9307        str	r3, [sp, #28]
@   0x0801fd1e: 4c27        ldr	r4, [pc, #156]	@ (0x1fdbc)
@   0x0801fd20: 4827        ldr	r0, [pc, #156]	@ (0x1fdc0)
@   0x0801fd22: 6800        ldr	r0, [r0, #0]
@   0x0801fd24: 7520        strb	r0, [r4, #20]
@   0x0801fd26: 2280        movs	r2, #128	@ 0x80
@   0x0801fd28: 04d2        lsls	r2, r2, #19
@   0x0801fd2a: 8811        ldrh	r1, [r2, #0]
@   0x0801fd2c: 4825        ldr	r0, [pc, #148]	@ (0x1fdc4)
@   0x0801fd2e: 4008        ands	r0, r1
@   0x0801fd30: 8010        strh	r0, [r2, #0]
@   0x0801fd32: 4925        ldr	r1, [pc, #148]	@ (0x1fdc8)
@   0x0801fd34: 610b        str	r3, [r1, #16]
@   0x0801fd36: 4a25        ldr	r2, [pc, #148]	@ (0x1fdcc)
@   0x0801fd38: 7d23        ldrb	r3, [r4, #20]
@   0x0801fd3a: 0098        lsls	r0, r3, #2
@   0x0801fd3c: 1880        adds	r0, r0, r2
@   0x0801fd3e: 7800        ldrb	r0, [r0, #0]
@   0x0801fd40: 3810        subs	r0, #16
@   0x0801fd42: 7108        strb	r0, [r1, #4]
@   0x0801fd44: 7d26        ldrb	r6, [r4, #20]
@   0x0801fd46: 0070        lsls	r0, r6, #1
@   0x0801fd48: 3001        adds	r0, #1
@   0x0801fd4a: 0040        lsls	r0, r0, #1
@   0x0801fd4c: 1880        adds	r0, r0, r2
@   0x0801fd4e: 7800        ldrb	r0, [r0, #0]
@   0x0801fd50: 3818        subs	r0, #24
@   0x0801fd52: 7148        strb	r0, [r1, #5]
@   0x0801fd54: 7d23        ldrb	r3, [r4, #20]
@   0x0801fd56: 0098        lsls	r0, r3, #2
@   0x0801fd58: 1880        adds	r0, r0, r2
@   0x0801fd5a: 8800        ldrh	r0, [r0, #0]
@   0x0801fd5c: 3810        subs	r0, #16
@   0x0801fd5e: 8008        strh	r0, [r1, #0]
@   0x0801fd60: 7d24        ldrb	r4, [r4, #20]
@   0x0801fd62: 0060        lsls	r0, r4, #1
@   0x0801fd64: 3001        adds	r0, #1
@   0x0801fd66: 0040        lsls	r0, r0, #1
@   0x0801fd68: 1880        adds	r0, r0, r2
@   0x0801fd6a: 8800        ldrh	r0, [r0, #0]
@   0x0801fd6c: 3818        subs	r0, #24
@   0x0801fd6e: 8048        strh	r0, [r1, #2]
@   0x0801fd70: 2003        movs	r0, #3
@   0x0801fd72: 7748        strb	r0, [r1, #29]
@   0x0801fd74: 4c16        ldr	r4, [pc, #88]	@ (0x1fdd0)
@   0x0801fd76: 68a0        ldr	r0, [r4, #8]
@   0x0801fd78: 2800        cmp	r0, #0
@   0x0801fd7a: d131        bne.n	0x1fde0
@   0x0801fd7c: 200e        movs	r0, #14
@   0x0801fd7e: f7f8        ff45 	bl	0x18c0c
@   0x0801fd82: 2200        movs	r2, #0
@   0x0801fd84: 68a0        ldr	r0, [r4, #8]
@   0x0801fd86: 2800        cmp	r0, #0
@   0x0801fd88: d100        bne.n	0x1fd8c
@   0x0801fd8a: 2201        movs	r2, #1
@   0x0801fd8c: 2002        movs	r0, #2
@   0x0801fd8e: 9003        str	r0, [sp, #12]
@   0x0801fd90: 4669        mov	r1, sp
@   0x0801fd92: a805        add	r0, sp, #20
@   0x0801fd94: c858        ldmia	r0!, {r3, r4, r6}
@   0x0801fd96: c158        stmia	r1!, {r3, r4, r6}
@   0x0801fd98: 9b04        ldr	r3, [sp, #16]
@   0x0801fd9a: 1c10        adds	r0, r2, #0
@   0x0801fd9c: 2121        movs	r1, #33	@ 0x21
@   0x0801fd9e: 2206        movs	r2, #6
@   0x0801fda0: f7f8        fd7a 	bl	0x18898
@   0x0801fda4: 490b        ldr	r1, [pc, #44]	@ (0x1fdd4)
@   0x0801fda6: 600d        str	r5, [r1, #0]
@   0x0801fda8: 480b        ldr	r0, [pc, #44]	@ (0x1fdd8)
@   0x0801fdaa: 6048        str	r0, [r1, #4]
@   0x0801fdac: 480b        ldr	r0, [pc, #44]	@ (0x1fddc)
@   0x0801fdae: 6088        str	r0, [r1, #8]
@   0x0801fdb0: 6888        ldr	r0, [r1, #8]
@   0x0801fdb2: e034        b.n	0x1fe1e
@   0x0801fdb4: 5c18        ldrb	r0, [r3, r0]
@   0x0801fdb6: 081e        lsrs	r6, r3, #32
@   0x0801fdb8: 4c18        ldr	r4, [pc, #96]	@ (0x1fe1c)
@   0x0801fdba: 081e        lsrs	r6, r3, #32
@   0x0801fdbc: 3480        adds	r4, #128	@ 0x80
@   0x0801fdbe: 0300        lsls	r0, r0, #12
@   0x0801fdc0: 34b0        adds	r4, #176	@ 0xb0
@   0x0801fdc2: 0300        lsls	r0, r0, #12
@   0x0801fdc4: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x0801fdc8: 34d0        adds	r4, #208	@ 0xd0
@   0x0801fdca: 0300        lsls	r0, r0, #12
@   0x0801fdcc: d918        bls.n	0x1fe00
@   0x0801fdce: 081b        lsrs	r3, r3, #32
@   0x0801fdd0: 34a0        adds	r4, #160	@ 0xa0
@   0x0801fdd2: 0300        lsls	r0, r0, #12
@   0x0801fdd4: 00d4        lsls	r4, r2, #3
@   0x0801fdd6: 0400        lsls	r0, r0, #16
@   0x0801fdd8: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801fddc: 0400        lsls	r0, r0, #16
@   0x0801fdde: 8000        strh	r0, [r0, #0]
@   0x0801fde0: f7f8        fb34 	bl	0x1844c
@   0x0801fde4: 4815        ldr	r0, [pc, #84]	@ (0x1fe3c)
@   0x0801fde6: 4916        ldr	r1, [pc, #88]	@ (0x1fe40)
@   0x0801fde8: 6001        str	r1, [r0, #0]
@   0x0801fdea: 21a0        movs	r1, #160	@ 0xa0
@   0x0801fdec: 04c9        lsls	r1, r1, #19
@   0x0801fdee: 6041        str	r1, [r0, #4]
@   0x0801fdf0: 4914        ldr	r1, [pc, #80]	@ (0x1fe44)
@   0x0801fdf2: 6081        str	r1, [r0, #8]
@   0x0801fdf4: 6881        ldr	r1, [r0, #8]
@   0x0801fdf6: 4914        ldr	r1, [pc, #80]	@ (0x1fe48)
@   0x0801fdf8: 6001        str	r1, [r0, #0]
@   0x0801fdfa: 21c0        movs	r1, #192	@ 0xc0
@   0x0801fdfc: 04c9        lsls	r1, r1, #19
@   0x0801fdfe: 6041        str	r1, [r0, #4]
@   0x0801fe00: 4912        ldr	r1, [pc, #72]	@ (0x1fe4c)
@   0x0801fe02: 6081        str	r1, [r0, #8]
@   0x0801fe04: 6881        ldr	r1, [r0, #8]
@   0x0801fe06: 4912        ldr	r1, [pc, #72]	@ (0x1fe50)
@   0x0801fe08: 6001        str	r1, [r0, #0]
@   0x0801fe0a: 4912        ldr	r1, [pc, #72]	@ (0x1fe54)
@   0x0801fe0c: 6041        str	r1, [r0, #4]
@   0x0801fe0e: 4a12        ldr	r2, [pc, #72]	@ (0x1fe58)
@   0x0801fe10: 6082        str	r2, [r0, #8]
@   0x0801fe12: 6881        ldr	r1, [r0, #8]
@   0x0801fe14: 6005        str	r5, [r0, #0]
@   0x0801fe16: 4911        ldr	r1, [pc, #68]	@ (0x1fe5c)
@   0x0801fe18: 6041        str	r1, [r0, #4]
@   0x0801fe1a: 6082        str	r2, [r0, #8]
@   0x0801fe1c: 6880        ldr	r0, [r0, #8]
@   0x0801fe1e: f7f8        ff43 	bl	0x18ca8
@   0x0801fe22: f000        f947 	bl	0x200b4
@   0x0801fe26: 480e        ldr	r0, [pc, #56]	@ (0x1fe60)
@   0x0801fe28: 7881        ldrb	r1, [r0, #2]
@   0x0801fe2a: 3101        adds	r1, #1
@   0x0801fe2c: 2200        movs	r2, #0
@   0x0801fe2e: 7081        strb	r1, [r0, #2]
@   0x0801fe30: 480c        ldr	r0, [pc, #48]	@ (0x1fe64)
@   0x0801fe32: 8002        strh	r2, [r0, #0]
@   0x0801fe34: b008        add	sp, #32
@   0x0801fe36: bc70        pop	{r4, r5, r6}
@   0x0801fe38: bc01        pop	{r0}
@   0x0801fe3a: 4700        bx	r0
@   0x0801fe3c: 00d4        lsls	r4, r2, #3
@   0x0801fe3e: 0400        lsls	r0, r0, #16
@   0x0801fe40: ab98        add	r3, sp, #608	@ 0x260
@   0x0801fe42: 081d        lsrs	r5, r3, #32
@   0x0801fe44: 0100        lsls	r0, r0, #4
@   0x0801fe46: 8000        strh	r0, [r0, #0]
@   0x0801fe48: ad98        add	r5, sp, #608	@ 0x260
@   0x0801fe4a: 081d        lsrs	r5, r3, #32
@   0x0801fe4c: 4000        ands	r0, r0
@   0x0801fe4e: 8000        strh	r0, [r0, #0]
@   0x0801fe50: 4418        add	r0, r3
@   0x0801fe52: 081e        lsrs	r6, r3, #32
@   0x0801fe54: e000        b.n	0x1fe58
@   0x0801fe56: 0600        lsls	r0, r0, #24
@   0x0801fe58: 0400        lsls	r0, r0, #16
@   0x0801fe5a: 8000        strh	r0, [r0, #0]
@   0x0801fe5c: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801fe60: 3480        adds	r4, #128	@ 0x80
@   0x0801fe62: 0300        lsls	r0, r0, #12
@   0x0801fe64: 5398        strh	r0, [r3, r6]
@   0x0801fe66: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801FD0C
sub_0801FD0C: @ 0x0801fd0c
        .incbin "frog_us_baserom.gba", 0x1fd0c, 0x15c
        thumb_func_end sub_0801FD0C
