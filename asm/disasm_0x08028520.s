@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028520, 0x0802857c)  (92 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028520 --end 0x802857c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028520: b570        push	{r4, r5, r6, lr}
@   0x08028522: 2400        movs	r4, #0
@   0x08028524: 4d13        ldr	r5, [pc, #76]	@ (0x28574)
@   0x08028526: 1c22        adds	r2, r4, #0
@   0x08028528: 3232        adds	r2, #50	@ 0x32
@   0x0802852a: 00d0        lsls	r0, r2, #3
@   0x0802852c: 1a80        subs	r0, r0, r2
@   0x0802852e: 00c0        lsls	r0, r0, #3
@   0x08028530: 1943        adds	r3, r0, r5
@   0x08028532: 8e99        ldrh	r1, [r3, #52]	@ 0x34
@   0x08028534: 2680        movs	r6, #128	@ 0x80
@   0x08028536: 0236        lsls	r6, r6, #8
@   0x08028538: 1c30        adds	r0, r6, #0
@   0x0802853a: 4008        ands	r0, r1
@   0x0802853c: 2800        cmp	r0, #0
@   0x0802853e: d005        beq.n	0x2854c
@   0x08028540: 2002        movs	r0, #2
@   0x08028542: 4308        orrs	r0, r1
@   0x08028544: 3e01        subs	r6, #1
@   0x08028546: 1c31        adds	r1, r6, #0
@   0x08028548: 4008        ands	r0, r1
@   0x0802854a: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x0802854c: 480a        ldr	r0, [pc, #40]	@ (0x28578)
@   0x0802854e: 1c11        adds	r1, r2, #0
@   0x08028550: f7de        fa0c 	bl	0x696c
@   0x08028554: 1c60        adds	r0, r4, #1
@   0x08028556: 0600        lsls	r0, r0, #24
@   0x08028558: 0e04        lsrs	r4, r0, #24
@   0x0802855a: 2c04        cmp	r4, #4
@   0x0802855c: d9e3        bls.n	0x28526
@   0x0802855e: 2032        movs	r0, #50	@ 0x32
@   0x08028560: 2136        movs	r1, #54	@ 0x36
@   0x08028562: f7f8        fd3f 	bl	0x20fe4
@   0x08028566: 2032        movs	r0, #50	@ 0x32
@   0x08028568: 2136        movs	r1, #54	@ 0x36
@   0x0802856a: f7dd        fbd1 	bl	0x5d10
@   0x0802856e: bc70        pop	{r4, r5, r6}
@   0x08028570: bc01        pop	{r0}
@   0x08028572: 4700        bx	r0
@   0x08028574: 3720        adds	r7, #32
@   0x08028576: 0300        lsls	r0, r0, #12
@   0x08028578: 6110        str	r0, [r2, #16]
@   0x0802857a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08028520
sub_08028520: @ 0x08028520
        .incbin "baserom.gba", 0x28520, 0x5c
        thumb_func_end sub_08028520
