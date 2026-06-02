@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801585c, 0x08015930)  (212 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801585c --end 0x8015930 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801585c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801585e: 4657        mov	r7, sl
@   0x08015860: 464e        mov	r6, r9
@   0x08015862: 4645        mov	r5, r8
@   0x08015864: b4e0        push	{r5, r6, r7}
@   0x08015866: b083        sub	sp, #12
@   0x08015868: 4a20        ldr	r2, [pc, #128]	@ (0x158ec)
@   0x0801586a: 200f        movs	r0, #15
@   0x0801586c: 1c01        adds	r1, r0, #0
@   0x0801586e: 8cd3        ldrh	r3, [r2, #38]	@ 0x26
@   0x08015870: 4019        ands	r1, r3
@   0x08015872: 8d14        ldrh	r4, [r2, #40]	@ 0x28
@   0x08015874: 4020        ands	r0, r4
@   0x08015876: 4281        cmp	r1, r0
@   0x08015878: d04f        beq.n	0x1591a
@   0x0801587a: 2600        movs	r6, #0
@   0x0801587c: 1c17        adds	r7, r2, #0
@   0x0801587e: 2501        movs	r5, #1
@   0x08015880: 46a8        mov	r8, r5
@   0x08015882: 481b        ldr	r0, [pc, #108]	@ (0x158f0)
@   0x08015884: 4682        mov	sl, r0
@   0x08015886: 8cf9        ldrh	r1, [r7, #38]	@ 0x26
@   0x08015888: 4131        asrs	r1, r6
@   0x0801588a: 4642        mov	r2, r8
@   0x0801588c: 4011        ands	r1, r2
@   0x0801588e: 8d38        ldrh	r0, [r7, #40]	@ 0x28
@   0x08015890: 4130        asrs	r0, r6
@   0x08015892: 4010        ands	r0, r2
@   0x08015894: 1c73        adds	r3, r6, #1
@   0x08015896: 4699        mov	r9, r3
@   0x08015898: 4281        cmp	r1, r0
@   0x0801589a: d039        beq.n	0x15910
@   0x0801589c: 0075        lsls	r5, r6, #1
@   0x0801589e: 19ad        adds	r5, r5, r6
@   0x080158a0: 00ed        lsls	r5, r5, #3
@   0x080158a2: 4814        ldr	r0, [pc, #80]	@ (0x158f4)
@   0x080158a4: 182c        adds	r4, r5, r0
@   0x080158a6: 7a20        ldrb	r0, [r4, #8]
@   0x080158a8: 8821        ldrh	r1, [r4, #0]
@   0x080158aa: 8862        ldrh	r2, [r4, #2]
@   0x080158ac: 88a3        ldrh	r3, [r4, #4]
@   0x080158ae: 88e4        ldrh	r4, [r4, #6]
@   0x080158b0: 9400        str	r4, [sp, #0]
@   0x080158b2: 4c11        ldr	r4, [pc, #68]	@ (0x158f8)
@   0x080158b4: 192d        adds	r5, r5, r4
@   0x080158b6: 682c        ldr	r4, [r5, #0]
@   0x080158b8: 9401        str	r4, [sp, #4]
@   0x080158ba: 8cfc        ldrh	r4, [r7, #38]	@ 0x26
@   0x080158bc: 4134        asrs	r4, r6
@   0x080158be: 4645        mov	r5, r8
@   0x080158c0: 402c        ands	r4, r5
@   0x080158c2: 9402        str	r4, [sp, #8]
@   0x080158c4: f7fd        f97e 	bl	0x12bc4
@   0x080158c8: 8cf8        ldrh	r0, [r7, #38]	@ 0x26
@   0x080158ca: 4130        asrs	r0, r6
@   0x080158cc: 4028        ands	r0, r5
@   0x080158ce: 2800        cmp	r0, #0
@   0x080158d0: d014        beq.n	0x158fc
@   0x080158d2: 4640        mov	r0, r8
@   0x080158d4: 40b0        lsls	r0, r6
@   0x080158d6: 8d39        ldrh	r1, [r7, #40]	@ 0x28
@   0x080158d8: 4308        orrs	r0, r1
@   0x080158da: 8538        strh	r0, [r7, #40]	@ 0x28
@   0x080158dc: 2019        movs	r0, #25
@   0x080158de: f00b        f9cb 	bl	0x20c78
@   0x080158e2: 464b        mov	r3, r9
@   0x080158e4: 4652        mov	r2, sl
@   0x080158e6: 7013        strb	r3, [r2, #0]
@   0x080158e8: e010        b.n	0x1590c
@   0x080158ea: 0000        movs	r0, r0
@   0x080158ec: 6110        str	r0, [r2, #16]
@   0x080158ee: 0300        lsls	r0, r0, #12
@   0x080158f0: 3610        adds	r6, #16
@   0x080158f2: 0300        lsls	r0, r0, #12
@   0x080158f4: 7e18        ldrb	r0, [r3, #24]
@   0x080158f6: 0830        lsrs	r0, r6, #32
@   0x080158f8: 7e28        ldrb	r0, [r5, #24]
@   0x080158fa: 0830        lsrs	r0, r6, #32
@   0x080158fc: 4654        mov	r4, sl
@   0x080158fe: 7020        strb	r0, [r4, #0]
@   0x08015900: 4640        mov	r0, r8
@   0x08015902: 40b0        lsls	r0, r6
@   0x08015904: 8d3d        ldrh	r5, [r7, #40]	@ 0x28
@   0x08015906: 4385        bics	r5, r0
@   0x08015908: 1c28        adds	r0, r5, #0
@   0x0801590a: 8538        strh	r0, [r7, #40]	@ 0x28
@   0x0801590c: f7ff        fcd0 	bl	0x152b0
@   0x08015910: 4649        mov	r1, r9
@   0x08015912: 0608        lsls	r0, r1, #24
@   0x08015914: 0e06        lsrs	r6, r0, #24
@   0x08015916: 2e03        cmp	r6, #3
@   0x08015918: d9b5        bls.n	0x15886
@   0x0801591a: f7ff        fdbf 	bl	0x1549c
@   0x0801591e: b003        add	sp, #12
@   0x08015920: bc38        pop	{r3, r4, r5}
@   0x08015922: 4698        mov	r8, r3
@   0x08015924: 46a1        mov	r9, r4
@   0x08015926: 46aa        mov	sl, r5
@   0x08015928: bcf0        pop	{r4, r5, r6, r7}
@   0x0801592a: bc01        pop	{r0}
@   0x0801592c: 4700        bx	r0

        thumb_func_start sub_0801585C
sub_0801585C: @ 0x0801585c
        .incbin "frog_us_baserom.gba", 0x1585c, 0xd4
        thumb_func_end sub_0801585C
