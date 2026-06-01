@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08011574, 0x080115f8)  (132 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8011574 --end 0x80115f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08011574: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08011576: 464f        mov	r7, r9
@   0x08011578: 4646        mov	r6, r8
@   0x0801157a: b4c0        push	{r6, r7}
@   0x0801157c: b083        sub	sp, #12
@   0x0801157e: 0600        lsls	r0, r0, #24
@   0x08011580: 0e01        lsrs	r1, r0, #24
@   0x08011582: 4d04        ldr	r5, [pc, #16]	@ (0x11594)
@   0x08011584: 7aaf        ldrb	r7, [r5, #10]
@   0x08011586: 46bc        mov	ip, r7
@   0x08011588: 4660        mov	r0, ip
@   0x0801158a: 2803        cmp	r0, #3
@   0x0801158c: d904        bls.n	0x11598
@   0x0801158e: 2001        movs	r0, #1
@   0x08011590: e027        b.n	0x115e2
@   0x08011592: 0000        movs	r0, r0
@   0x08011594: 6580        str	r0, [r0, #88]	@ 0x58
@   0x08011596: 0300        lsls	r0, r0, #12
@   0x08011598: 4c15        ldr	r4, [pc, #84]	@ (0x115f0)
@   0x0801159a: 46a0        mov	r8, r4
@   0x0801159c: 0048        lsls	r0, r1, #1
@   0x0801159e: 1840        adds	r0, r0, r1
@   0x080115a0: 00c6        lsls	r6, r0, #3
@   0x080115a2: 1934        adds	r4, r6, r4
@   0x080115a4: 7b20        ldrb	r0, [r4, #12]
@   0x080115a6: 72e8        strb	r0, [r5, #11]
@   0x080115a8: 4812        ldr	r0, [pc, #72]	@ (0x115f4)
@   0x080115aa: 4681        mov	r9, r0
@   0x080115ac: 6800        ldr	r0, [r0, #0]
@   0x080115ae: 6869        ldr	r1, [r5, #4]
@   0x080115b0: 1a40        subs	r0, r0, r1
@   0x080115b2: 7ae9        ldrb	r1, [r5, #11]
@   0x080115b4: 4288        cmp	r0, r1
@   0x080115b6: d313        bcc.n	0x115e0
@   0x080115b8: 7a20        ldrb	r0, [r4, #8]
@   0x080115ba: 8821        ldrh	r1, [r4, #0]
@   0x080115bc: 8862        ldrh	r2, [r4, #2]
@   0x080115be: 88a3        ldrh	r3, [r4, #4]
@   0x080115c0: 88e4        ldrh	r4, [r4, #6]
@   0x080115c2: 9400        str	r4, [sp, #0]
@   0x080115c4: 4644        mov	r4, r8
@   0x080115c6: 3410        adds	r4, #16
@   0x080115c8: 1934        adds	r4, r6, r4
@   0x080115ca: 6824        ldr	r4, [r4, #0]
@   0x080115cc: 9401        str	r4, [sp, #4]
@   0x080115ce: 1c7c        adds	r4, r7, #1
@   0x080115d0: 72ac        strb	r4, [r5, #10]
@   0x080115d2: 4664        mov	r4, ip
@   0x080115d4: 9402        str	r4, [sp, #8]
@   0x080115d6: f001        faf5 	bl	0x12bc4
@   0x080115da: 4649        mov	r1, r9
@   0x080115dc: 6808        ldr	r0, [r1, #0]
@   0x080115de: 6068        str	r0, [r5, #4]
@   0x080115e0: 2000        movs	r0, #0
@   0x080115e2: b003        add	sp, #12
@   0x080115e4: bc18        pop	{r3, r4}
@   0x080115e6: 4698        mov	r8, r3
@   0x080115e8: 46a1        mov	r9, r4
@   0x080115ea: bcf0        pop	{r4, r5, r6, r7}
@   0x080115ec: bc02        pop	{r1}
@   0x080115ee: 4708        bx	r1
@   0x080115f0: 6b74        ldr	r4, [r6, #52]	@ 0x34
@   0x080115f2: 0830        lsrs	r0, r6, #32
@   0x080115f4: 5330        strh	r0, [r6, r4]
@   0x080115f6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08011574
sub_08011574: @ 0x08011574
        .incbin "frog_us_baserom.gba", 0x11574, 0x84
        thumb_func_end sub_08011574
