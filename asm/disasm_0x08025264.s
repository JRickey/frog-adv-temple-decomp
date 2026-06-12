@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025264, 0x080252b0)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025264 --end 0x80252b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025264: b510        push	{r4, lr}
@   0x08025266: b084        sub	sp, #16
@   0x08025268: 2400        movs	r4, #0
@   0x0802526a: 1c20        adds	r0, r4, #0
@   0x0802526c: 302a        adds	r0, #42	@ 0x2a
@   0x0802526e: 4a0f        ldr	r2, [pc, #60]	@ (0x252ac)
@   0x08025270: 00a1        lsls	r1, r4, #2
@   0x08025272: 1889        adds	r1, r1, r2
@   0x08025274: 6809        ldr	r1, [r1, #0]
@   0x08025276: 2207        movs	r2, #7
@   0x08025278: 4022        ands	r2, r4
@   0x0802527a: 0512        lsls	r2, r2, #20
@   0x0802527c: 23e2        movs	r3, #226	@ 0xe2
@   0x0802527e: 03db        lsls	r3, r3, #15
@   0x08025280: 18d2        adds	r2, r2, r3
@   0x08025282: 0c12        lsrs	r2, r2, #16
@   0x08025284: 9200        str	r2, [sp, #0]
@   0x08025286: 2204        movs	r2, #4
@   0x08025288: 9201        str	r2, [sp, #4]
@   0x0802528a: 2203        movs	r2, #3
@   0x0802528c: 9202        str	r2, [sp, #8]
@   0x0802528e: 9203        str	r2, [sp, #12]
@   0x08025290: 2210        movs	r2, #16
@   0x08025292: 2320        movs	r3, #32
@   0x08025294: f7fb        ff04 	bl	0x210a0
@   0x08025298: 1c60        adds	r0, r4, #1
@   0x0802529a: 0600        lsls	r0, r0, #24
@   0x0802529c: 0e04        lsrs	r4, r0, #24
@   0x0802529e: 2c09        cmp	r4, #9
@   0x080252a0: d9e3        bls.n	0x2526a
@   0x080252a2: b004        add	sp, #16
@   0x080252a4: bc10        pop	{r4}
@   0x080252a6: bc01        pop	{r0}
@   0x080252a8: 4700        bx	r0
@   0x080252aa: 0000        movs	r0, r0
@   0x080252ac: 3fc4        subs	r7, #196	@ 0xc4
@   0x080252ae: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025264
sub_08025264: @ 0x08025264
        .incbin "baserom.gba", 0x25264, 0x4c
        thumb_func_end sub_08025264
