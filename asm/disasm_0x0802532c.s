@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802532c, 0x08025364)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802532c --end 0x8025364 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802532c: b530        push	{r4, r5, lr}
@   0x0802532e: 2400        movs	r4, #0
@   0x08025330: 4d0b        ldr	r5, [pc, #44]	@ (0x25360)
@   0x08025332: 00a0        lsls	r0, r4, #2
@   0x08025334: 1940        adds	r0, r0, r5
@   0x08025336: 6800        ldr	r0, [r0, #0]
@   0x08025338: 1c21        adds	r1, r4, #0
@   0x0802533a: 3134        adds	r1, #52	@ 0x34
@   0x0802533c: f7fc        fb3e 	bl	0x219bc
@   0x08025340: 1c60        adds	r0, r4, #1
@   0x08025342: 0600        lsls	r0, r0, #24
@   0x08025344: 0e04        lsrs	r4, r0, #24
@   0x08025346: 2c05        cmp	r4, #5
@   0x08025348: d9f3        bls.n	0x25332
@   0x0802534a: 2034        movs	r0, #52	@ 0x34
@   0x0802534c: 2139        movs	r1, #57	@ 0x39
@   0x0802534e: f7fb        fe49 	bl	0x20fe4
@   0x08025352: 2034        movs	r0, #52	@ 0x34
@   0x08025354: 2139        movs	r1, #57	@ 0x39
@   0x08025356: f7e0        fcdb 	bl	0x5d10
@   0x0802535a: bc30        pop	{r4, r5}
@   0x0802535c: bc01        pop	{r0}
@   0x0802535e: 4700        bx	r0
@   0x08025360: 3fec        subs	r7, #236	@ 0xec
@   0x08025362: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802532C
sub_0802532C: @ 0x0802532c
        .incbin "baserom.gba", 0x2532c, 0x38
        thumb_func_end sub_0802532C
