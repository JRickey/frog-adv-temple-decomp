@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080195c4, 0x08019678)  (180 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80195c4 --end 0x8019678 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080195c4: b510        push	{r4, lr}
@   0x080195c6: 4c18        ldr	r4, [pc, #96]	@ (0x19628)
@   0x080195c8: 2000        movs	r0, #0
@   0x080195ca: 7160        strb	r0, [r4, #5]
@   0x080195cc: f7f7        f874 	bl	0x106b8
@   0x080195d0: 2800        cmp	r0, #0
@   0x080195d2: d126        bne.n	0x19622
@   0x080195d4: 4915        ldr	r1, [pc, #84]	@ (0x1962c)
@   0x080195d6: 4a16        ldr	r2, [pc, #88]	@ (0x19630)
@   0x080195d8: 1c10        adds	r0, r2, #0
@   0x080195da: 8008        strh	r0, [r1, #0]
@   0x080195dc: 31c6        adds	r1, #198	@ 0xc6
@   0x080195de: 4a15        ldr	r2, [pc, #84]	@ (0x19634)
@   0x080195e0: 68d0        ldr	r0, [r2, #12]
@   0x080195e2: 6008        str	r0, [r1, #0]
@   0x080195e4: 4814        ldr	r0, [pc, #80]	@ (0x19638)
@   0x080195e6: 6048        str	r0, [r1, #4]
@   0x080195e8: 4814        ldr	r0, [pc, #80]	@ (0x1963c)
@   0x080195ea: 6088        str	r0, [r1, #8]
@   0x080195ec: 6888        ldr	r0, [r1, #8]
@   0x080195ee: 6910        ldr	r0, [r2, #16]
@   0x080195f0: 6008        str	r0, [r1, #0]
@   0x080195f2: 20a0        movs	r0, #160	@ 0xa0
@   0x080195f4: 04c0        lsls	r0, r0, #19
@   0x080195f6: 6048        str	r0, [r1, #4]
@   0x080195f8: 4811        ldr	r0, [pc, #68]	@ (0x19640)
@   0x080195fa: 6088        str	r0, [r1, #8]
@   0x080195fc: 6888        ldr	r0, [r1, #8]
@   0x080195fe: 6950        ldr	r0, [r2, #20]
@   0x08019600: 6008        str	r0, [r1, #0]
@   0x08019602: 4810        ldr	r0, [pc, #64]	@ (0x19644)
@   0x08019604: 6048        str	r0, [r1, #4]
@   0x08019606: 4810        ldr	r0, [pc, #64]	@ (0x19648)
@   0x08019608: 6088        str	r0, [r1, #8]
@   0x0801960a: 6888        ldr	r0, [r1, #8]
@   0x0801960c: 39d4        subs	r1, #212	@ 0xd4
@   0x0801960e: 2284        movs	r2, #132	@ 0x84
@   0x08019610: 0112        lsls	r2, r2, #4
@   0x08019612: 1c10        adds	r0, r2, #0
@   0x08019614: 8008        strh	r0, [r1, #0]
@   0x08019616: 20bf        movs	r0, #191	@ 0xbf
@   0x08019618: f7f7        f868 	bl	0x106ec
@   0x0801961c: 7820        ldrb	r0, [r4, #0]
@   0x0801961e: 3001        adds	r0, #1
@   0x08019620: 7020        strb	r0, [r4, #0]
@   0x08019622: bc10        pop	{r4}
@   0x08019624: bc01        pop	{r0}
@   0x08019626: 4700        bx	r0
@   0x08019628: 3480        adds	r4, #128	@ 0x80
@   0x0801962a: 0300        lsls	r0, r0, #12
@   0x0801962c: 000e        movs	r6, r1
@   0x0801962e: 0400        lsls	r0, r0, #16
@   0x08019630: 1e08        subs	r0, r1, #0
@   0x08019632: 0000        movs	r0, r0
@   0x08019634: 3550        adds	r5, #80	@ 0x50
@   0x08019636: 080e        lsrs	r6, r1, #32
@   0x08019638: 8000        strh	r0, [r0, #0]
@   0x0801963a: 0600        lsls	r0, r0, #24
@   0x0801963c: 0890        lsrs	r0, r2, #2
@   0x0801963e: 8000        strh	r0, [r0, #0]
@   0x08019640: 0100        lsls	r0, r0, #4
@   0x08019642: 8000        strh	r0, [r0, #0]
@   0x08019644: f000        0600 	and.w	r6, r0, #0
@   0x08019648: 0400        lsls	r0, r0, #16
@   0x0801964a: 8000        strh	r0, [r0, #0]
@   0x0801964c: b500        push	{lr}
@   0x0801964e: f7f7        f833 	bl	0x106b8
@   0x08019652: 1c01        adds	r1, r0, #0
@   0x08019654: 2900        cmp	r1, #0
@   0x08019656: d102        bne.n	0x1965e
@   0x08019658: 4802        ldr	r0, [pc, #8]	@ (0x19664)
@   0x0801965a: 71c1        strb	r1, [r0, #7]
@   0x0801965c: 7001        strb	r1, [r0, #0]
@   0x0801965e: bc01        pop	{r0}
@   0x08019660: 4700        bx	r0
@   0x08019662: 0000        movs	r0, r0
@   0x08019664: 3480        adds	r4, #128	@ 0x80
@   0x08019666: 0300        lsls	r0, r0, #12
@   0x08019668: 4902        ldr	r1, [pc, #8]	@ (0x19674)
@   0x0801966a: 78c8        ldrb	r0, [r1, #3]
@   0x0801966c: 3001        adds	r0, #1
@   0x0801966e: 70c8        strb	r0, [r1, #3]
@   0x08019670: 4770        bx	lr
@   0x08019672: 0000        movs	r0, r0
@   0x08019674: 3480        adds	r4, #128	@ 0x80
@   0x08019676: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080195C4
sub_080195C4: @ 0x080195c4
        .incbin "frog_us_baserom.gba", 0x195c4, 0xb4
        thumb_func_end sub_080195C4
