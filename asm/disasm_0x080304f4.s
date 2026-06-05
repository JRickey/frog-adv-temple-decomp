@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080304f4, 0x08030644)  (336 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80304f4 --end 0x8030644 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080304f4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080304f6: 1c02        adds	r2, r0, #0
@   0x080304f8: 1c0c        adds	r4, r1, #0
@   0x080304fa: 6825        ldr	r5, [r4, #0]
@   0x080304fc: 8960        ldrh	r0, [r4, #10]
@   0x080304fe: 2800        cmp	r0, #0
@   0x08030500: d152        bne.n	0x305a8
@   0x08030502: 8868        ldrh	r0, [r5, #2]
@   0x08030504: 1c07        adds	r7, r0, #0
@   0x08030506: 2f00        cmp	r7, #0
@   0x08030508: d100        bne.n	0x3050c
@   0x0803050a: e08d        b.n	0x30628
@   0x0803050c: 7869        ldrb	r1, [r5, #1]
@   0x0803050e: 2001        movs	r0, #1
@   0x08030510: 4008        ands	r0, r1
@   0x08030512: 1c0e        adds	r6, r1, #0
@   0x08030514: 2800        cmp	r0, #0
@   0x08030516: d019        beq.n	0x3054c
@   0x08030518: 2a03        cmp	r2, #3
@   0x0803051a: dc09        bgt.n	0x30530
@   0x0803051c: 4803        ldr	r0, [pc, #12]	@ (0x3052c)
@   0x0803051e: 6800        ldr	r0, [r0, #0]
@   0x08030520: 0091        lsls	r1, r2, #2
@   0x08030522: 3010        adds	r0, #16
@   0x08030524: 1840        adds	r0, r0, r1
@   0x08030526: 6800        ldr	r0, [r0, #0]
@   0x08030528: e00b        b.n	0x30542
@   0x0803052a: 0000        movs	r0, r0
@   0x0803052c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803052e: 0300        lsls	r0, r0, #12
@   0x08030530: 481a        ldr	r0, [pc, #104]	@ (0x3059c)
@   0x08030532: 6800        ldr	r0, [r0, #0]
@   0x08030534: 30c8        adds	r0, #200	@ 0xc8
@   0x08030536: 6801        ldr	r1, [r0, #0]
@   0x08030538: 0190        lsls	r0, r2, #6
@   0x0803053a: 1840        adds	r0, r0, r1
@   0x0803053c: 4918        ldr	r1, [pc, #96]	@ (0x305a0)
@   0x0803053e: 1840        adds	r0, r0, r1
@   0x08030540: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x08030542: 2180        movs	r1, #128	@ 0x80
@   0x08030544: 0049        lsls	r1, r1, #1
@   0x08030546: 4008        ands	r0, r1
@   0x08030548: 2800        cmp	r0, #0
@   0x0803054a: d16d        bne.n	0x30628
@   0x0803054c: 2004        movs	r0, #4
@   0x0803054e: 4030        ands	r0, r6
@   0x08030550: 2800        cmp	r0, #0
@   0x08030552: d019        beq.n	0x30588
@   0x08030554: 2a03        cmp	r2, #3
@   0x08030556: dd17        ble.n	0x30588
@   0x08030558: 4810        ldr	r0, [pc, #64]	@ (0x3059c)
@   0x0803055a: 6803        ldr	r3, [r0, #0]
@   0x0803055c: 1c18        adds	r0, r3, #0
@   0x0803055e: 30c8        adds	r0, #200	@ 0xc8
@   0x08030560: 6801        ldr	r1, [r0, #0]
@   0x08030562: 0190        lsls	r0, r2, #6
@   0x08030564: 1840        adds	r0, r0, r1
@   0x08030566: 490e        ldr	r1, [pc, #56]	@ (0x305a0)
@   0x08030568: 1840        adds	r0, r0, r1
@   0x0803056a: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x0803056c: 2180        movs	r1, #128	@ 0x80
@   0x0803056e: 0089        lsls	r1, r1, #2
@   0x08030570: 4008        ands	r0, r1
@   0x08030572: 2800        cmp	r0, #0
@   0x08030574: d108        bne.n	0x30588
@   0x08030576: 1c18        adds	r0, r3, #0
@   0x08030578: 30c4        adds	r0, #196	@ 0xc4
@   0x0803057a: 6801        ldr	r1, [r0, #0]
@   0x0803057c: 0090        lsls	r0, r2, #2
@   0x0803057e: 1840        adds	r0, r0, r1
@   0x08030580: 3810        subs	r0, #16
@   0x08030582: 6800        ldr	r0, [r0, #0]
@   0x08030584: 2800        cmp	r0, #0
@   0x08030586: d04f        beq.n	0x30628
@   0x08030588: 2002        movs	r0, #2
@   0x0803058a: 4030        ands	r0, r6
@   0x0803058c: 2800        cmp	r0, #0
@   0x0803058e: d009        beq.n	0x305a4
@   0x08030590: 8868        ldrh	r0, [r5, #2]
@   0x08030592: f7fd        ff19 	bl	0x2e3c8
@   0x08030596: 8160        strh	r0, [r4, #10]
@   0x08030598: e050        b.n	0x3063c
@   0x0803059a: 0000        movs	r0, r0
@   0x0803059c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803059e: 0300        lsls	r0, r0, #12
@   0x080305a0: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x080305a4: 8167        strh	r7, [r4, #10]
@   0x080305a6: e049        b.n	0x3063c
@   0x080305a8: 4905        ldr	r1, [pc, #20]	@ (0x305c0)
@   0x080305aa: 886b        ldrh	r3, [r5, #2]
@   0x080305ac: 428b        cmp	r3, r1
@   0x080305ae: d009        beq.n	0x305c4
@   0x080305b0: 3801        subs	r0, #1
@   0x080305b2: 8160        strh	r0, [r4, #10]
@   0x080305b4: 4008        ands	r0, r1
@   0x080305b6: 2800        cmp	r0, #0
@   0x080305b8: d104        bne.n	0x305c4
@   0x080305ba: 1d28        adds	r0, r5, #4
@   0x080305bc: e036        b.n	0x3062c
@   0x080305be: 0000        movs	r0, r0
@   0x080305c0: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x080305c4: 7869        ldrb	r1, [r5, #1]
@   0x080305c6: 2001        movs	r0, #1
@   0x080305c8: 4008        ands	r0, r1
@   0x080305ca: 1c0e        adds	r6, r1, #0
@   0x080305cc: 2800        cmp	r0, #0
@   0x080305ce: d019        beq.n	0x30604
@   0x080305d0: 2a03        cmp	r2, #3
@   0x080305d2: dc09        bgt.n	0x305e8
@   0x080305d4: 4803        ldr	r0, [pc, #12]	@ (0x305e4)
@   0x080305d6: 6800        ldr	r0, [r0, #0]
@   0x080305d8: 0091        lsls	r1, r2, #2
@   0x080305da: 3010        adds	r0, #16
@   0x080305dc: 1840        adds	r0, r0, r1
@   0x080305de: 6800        ldr	r0, [r0, #0]
@   0x080305e0: e00b        b.n	0x305fa
@   0x080305e2: 0000        movs	r0, r0
@   0x080305e4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080305e6: 0300        lsls	r0, r0, #12
@   0x080305e8: 4812        ldr	r0, [pc, #72]	@ (0x30634)
@   0x080305ea: 6800        ldr	r0, [r0, #0]
@   0x080305ec: 30c8        adds	r0, #200	@ 0xc8
@   0x080305ee: 6801        ldr	r1, [r0, #0]
@   0x080305f0: 0190        lsls	r0, r2, #6
@   0x080305f2: 1840        adds	r0, r0, r1
@   0x080305f4: 4910        ldr	r1, [pc, #64]	@ (0x30638)
@   0x080305f6: 1840        adds	r0, r0, r1
@   0x080305f8: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x080305fa: 2180        movs	r1, #128	@ 0x80
@   0x080305fc: 0049        lsls	r1, r1, #1
@   0x080305fe: 4008        ands	r0, r1
@   0x08030600: 2800        cmp	r0, #0
@   0x08030602: d10f        bne.n	0x30624
@   0x08030604: 2004        movs	r0, #4
@   0x08030606: 4030        ands	r0, r6
@   0x08030608: 2800        cmp	r0, #0
@   0x0803060a: d017        beq.n	0x3063c
@   0x0803060c: 2a03        cmp	r2, #3
@   0x0803060e: dd15        ble.n	0x3063c
@   0x08030610: 4808        ldr	r0, [pc, #32]	@ (0x30634)
@   0x08030612: 6800        ldr	r0, [r0, #0]
@   0x08030614: 30c4        adds	r0, #196	@ 0xc4
@   0x08030616: 6801        ldr	r1, [r0, #0]
@   0x08030618: 0090        lsls	r0, r2, #2
@   0x0803061a: 1840        adds	r0, r0, r1
@   0x0803061c: 3810        subs	r0, #16
@   0x0803061e: 6800        ldr	r0, [r0, #0]
@   0x08030620: 2800        cmp	r0, #0
@   0x08030622: d10b        bne.n	0x3063c
@   0x08030624: 2000        movs	r0, #0
@   0x08030626: 8160        strh	r0, [r4, #10]
@   0x08030628: 6820        ldr	r0, [r4, #0]
@   0x0803062a: 3004        adds	r0, #4
@   0x0803062c: 6020        str	r0, [r4, #0]
@   0x0803062e: 2001        movs	r0, #1
@   0x08030630: e005        b.n	0x3063e
@   0x08030632: 0000        movs	r0, r0
@   0x08030634: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030636: 0300        lsls	r0, r0, #12
@   0x08030638: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0803063c: 2000        movs	r0, #0
@   0x0803063e: bcf0        pop	{r4, r5, r6, r7}
@   0x08030640: bc02        pop	{r1}
@   0x08030642: 4708        bx	r1

        thumb_func_start sub_080304F4
sub_080304F4: @ 0x080304f4
        .incbin "frog_us_baserom.gba", 0x304f4, 0x150
        thumb_func_end sub_080304F4
