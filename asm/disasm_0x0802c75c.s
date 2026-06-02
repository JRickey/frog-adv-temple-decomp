@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802c75c, 0x0802c7ec)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802c75c --end 0x802c7ec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802c75c: b500        push	{lr}
@   0x0802c75e: b083        sub	sp, #12
@   0x0802c760: 4a08        ldr	r2, [pc, #32]	@ (0x2c784)
@   0x0802c762: 2001        movs	r0, #1
@   0x0802c764: 4240        negs	r0, r0
@   0x0802c766: 17c1        asrs	r1, r0, #31
@   0x0802c768: 6150        str	r0, [r2, #20]
@   0x0802c76a: 6191        str	r1, [r2, #24]
@   0x0802c76c: 61d0        str	r0, [r2, #28]
@   0x0802c76e: 6211        str	r1, [r2, #32]
@   0x0802c770: 3233        adds	r2, #51	@ 0x33
@   0x0802c772: 7812        ldrb	r2, [r2, #0]
@   0x0802c774: 2a01        cmp	r2, #1
@   0x0802c776: d015        beq.n	0x2c7a4
@   0x0802c778: 2a01        cmp	r2, #1
@   0x0802c77a: dc05        bgt.n	0x2c788
@   0x0802c77c: 2a00        cmp	r2, #0
@   0x0802c77e: d008        beq.n	0x2c792
@   0x0802c780: e02f        b.n	0x2c7e2
@   0x0802c782: 0000        movs	r0, r0
@   0x0802c784: 6110        str	r0, [r2, #16]
@   0x0802c786: 0300        lsls	r0, r0, #12
@   0x0802c788: 2a02        cmp	r2, #2
@   0x0802c78a: d00f        beq.n	0x2c7ac
@   0x0802c78c: 2a03        cmp	r2, #3
@   0x0802c78e: d01d        beq.n	0x2c7cc
@   0x0802c790: e027        b.n	0x2c7e2
@   0x0802c792: 4903        ldr	r1, [pc, #12]	@ (0x2c7a0)
@   0x0802c794: 2085        movs	r0, #133	@ 0x85
@   0x0802c796: 9000        str	r0, [sp, #0]
@   0x0802c798: 2003        movs	r0, #3
@   0x0802c79a: 9001        str	r0, [sp, #4]
@   0x0802c79c: 9202        str	r2, [sp, #8]
@   0x0802c79e: e00d        b.n	0x2c7bc
@   0x0802c7a0: 807c        strh	r4, [r7, #2]
@   0x0802c7a2: 0831        lsrs	r1, r6, #32
@   0x0802c7a4: 4900        ldr	r1, [pc, #0]	@ (0x2c7a8)
@   0x0802c7a6: e002        b.n	0x2c7ae
@   0x0802c7a8: 810c        strh	r4, [r1, #8]
@   0x0802c7aa: 0831        lsrs	r1, r6, #32
@   0x0802c7ac: 4906        ldr	r1, [pc, #24]	@ (0x2c7c8)
@   0x0802c7ae: 2085        movs	r0, #133	@ 0x85
@   0x0802c7b0: 9000        str	r0, [sp, #0]
@   0x0802c7b2: 2003        movs	r0, #3
@   0x0802c7b4: 9001        str	r0, [sp, #4]
@   0x0802c7b6: 2000        movs	r0, #0
@   0x0802c7b8: 9002        str	r0, [sp, #8]
@   0x0802c7ba: 2003        movs	r0, #3
@   0x0802c7bc: 2210        movs	r2, #16
@   0x0802c7be: 2304        movs	r3, #4
@   0x0802c7c0: f7f4        fcbe 	bl	0x21140
@   0x0802c7c4: e00d        b.n	0x2c7e2
@   0x0802c7c6: 0000        movs	r0, r0
@   0x0802c7c8: 80dc        strh	r4, [r3, #6]
@   0x0802c7ca: 0831        lsrs	r1, r6, #32
@   0x0802c7cc: 4906        ldr	r1, [pc, #24]	@ (0x2c7e8)
@   0x0802c7ce: 2085        movs	r0, #133	@ 0x85
@   0x0802c7d0: 9000        str	r0, [sp, #0]
@   0x0802c7d2: 9201        str	r2, [sp, #4]
@   0x0802c7d4: 2000        movs	r0, #0
@   0x0802c7d6: 9002        str	r0, [sp, #8]
@   0x0802c7d8: 2003        movs	r0, #3
@   0x0802c7da: 2210        movs	r2, #16
@   0x0802c7dc: 2304        movs	r3, #4
@   0x0802c7de: f7f4        fcaf 	bl	0x21140
@   0x0802c7e2: b003        add	sp, #12
@   0x0802c7e4: bc01        pop	{r0}
@   0x0802c7e6: 4700        bx	r0
@   0x0802c7e8: 80ac        strh	r4, [r5, #4]
@   0x0802c7ea: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802C75C
sub_0802C75C: @ 0x0802c75c
        .incbin "frog_us_baserom.gba", 0x2c75c, 0x90
        thumb_func_end sub_0802C75C
