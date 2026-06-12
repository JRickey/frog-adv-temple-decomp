@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027000, 0x080270c0)  (192 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027000 --end 0x80270c0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027000: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08027002: b081        sub	sp, #4
@   0x08027004: 2400        movs	r4, #0
@   0x08027006: 00e0        lsls	r0, r4, #3
@   0x08027008: 1b00        subs	r0, r0, r4
@   0x0802700a: 00c0        lsls	r0, r0, #3
@   0x0802700c: 4907        ldr	r1, [pc, #28]	@ (0x2702c)
@   0x0802700e: 1841        adds	r1, r0, r1
@   0x08027010: 7e88        ldrb	r0, [r1, #26]
@   0x08027012: 2801        cmp	r0, #1
@   0x08027014: d10c        bne.n	0x27030
@   0x08027016: 7ec8        ldrb	r0, [r1, #27]
@   0x08027018: 2800        cmp	r0, #0
@   0x0802701a: d114        bne.n	0x27046
@   0x0802701c: 1c08        adds	r0, r1, #0
@   0x0802701e: 2109        movs	r1, #9
@   0x08027020: 2204        movs	r2, #4
@   0x08027022: 2302        movs	r3, #2
@   0x08027024: f7f9        fef6 	bl	0x20e14
@   0x08027028: e00d        b.n	0x27046
@   0x0802702a: 0000        movs	r0, r0
@   0x0802702c: 40f8        lsrs	r0, r7
@   0x0802702e: 0300        lsls	r0, r0, #12
@   0x08027030: 2802        cmp	r0, #2
@   0x08027032: d108        bne.n	0x27046
@   0x08027034: 7ec8        ldrb	r0, [r1, #27]
@   0x08027036: 2802        cmp	r0, #2
@   0x08027038: d105        bne.n	0x27046
@   0x0802703a: 1c08        adds	r0, r1, #0
@   0x0802703c: 2109        movs	r1, #9
@   0x0802703e: 2204        movs	r2, #4
@   0x08027040: 2302        movs	r3, #2
@   0x08027042: f7f9        fee7 	bl	0x20e14
@   0x08027046: 1c60        adds	r0, r4, #1
@   0x08027048: 0600        lsls	r0, r0, #24
@   0x0802704a: 0e04        lsrs	r4, r0, #24
@   0x0802704c: 2c07        cmp	r4, #7
@   0x0802704e: d9da        bls.n	0x27006
@   0x08027050: 4a16        ldr	r2, [pc, #88]	@ (0x270ac)
@   0x08027052: 4917        ldr	r1, [pc, #92]	@ (0x270b0)
@   0x08027054: 1850        adds	r0, r2, r1
@   0x08027056: 7800        ldrb	r0, [r0, #0]
@   0x08027058: 4e16        ldr	r6, [pc, #88]	@ (0x270b4)
@   0x0802705a: 4f17        ldr	r7, [pc, #92]	@ (0x270b8)
@   0x0802705c: 2800        cmp	r0, #0
@   0x0802705e: d119        bne.n	0x27094
@   0x08027060: 4816        ldr	r0, [pc, #88]	@ (0x270bc)
@   0x08027062: 1811        adds	r1, r2, r0
@   0x08027064: 2002        movs	r0, #2
@   0x08027066: 8809        ldrh	r1, [r1, #0]
@   0x08027068: 4008        ands	r0, r1
@   0x0802706a: 2800        cmp	r0, #0
@   0x0802706c: d012        beq.n	0x27094
@   0x0802706e: 2401        movs	r4, #1
@   0x08027070: 1c15        adds	r5, r2, #0
@   0x08027072: 2300        movs	r3, #0
@   0x08027074: 2202        movs	r2, #2
@   0x08027076: 1c21        adds	r1, r4, #0
@   0x08027078: 312d        adds	r1, #45	@ 0x2d
@   0x0802707a: 00c8        lsls	r0, r1, #3
@   0x0802707c: 1a40        subs	r0, r0, r1
@   0x0802707e: 00c0        lsls	r0, r0, #3
@   0x08027080: 1940        adds	r0, r0, r5
@   0x08027082: 76c3        strb	r3, [r0, #27]
@   0x08027084: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x08027086: 4311        orrs	r1, r2
@   0x08027088: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0802708a: 1c60        adds	r0, r4, #1
@   0x0802708c: 0600        lsls	r0, r0, #24
@   0x0802708e: 0e04        lsrs	r4, r0, #24
@   0x08027090: 2c07        cmp	r4, #7
@   0x08027092: d9f0        bls.n	0x27076
@   0x08027094: 2000        movs	r0, #0
@   0x08027096: 9000        str	r0, [sp, #0]
@   0x08027098: 202d        movs	r0, #45	@ 0x2d
@   0x0802709a: 1c31        adds	r1, r6, #0
@   0x0802709c: 2236        movs	r2, #54	@ 0x36
@   0x0802709e: 1c3b        adds	r3, r7, #0
@   0x080270a0: f7fa        fa36 	bl	0x21510
@   0x080270a4: b001        add	sp, #4
@   0x080270a6: bcf0        pop	{r4, r5, r6, r7}
@   0x080270a8: bc01        pop	{r0}
@   0x080270aa: 4700        bx	r0
@   0x080270ac: 3720        adds	r7, #32
@   0x080270ae: 0300        lsls	r0, r0, #12
@   0x080270b0: 09f3        lsrs	r3, r6, #7
@   0x080270b2: 0000        movs	r0, r0
@   0x080270b4: 5e68        ldrsh	r0, [r5, r1]
@   0x080270b6: 0831        lsrs	r1, r6, #32
@   0x080270b8: 6110        str	r0, [r2, #16]
@   0x080270ba: 0300        lsls	r0, r0, #12
@   0x080270bc: 0a0c        lsrs	r4, r1, #8

        thumb_func_start sub_08027000
sub_08027000: @ 0x08027000
        .incbin "baserom.gba", 0x27000, 0xc0
        thumb_func_end sub_08027000
