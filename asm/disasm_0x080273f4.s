@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080273f4, 0x08027458)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80273f4 --end 0x8027458 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080273f4: b570        push	{r4, r5, r6, lr}
@   0x080273f6: b084        sub	sp, #16
@   0x080273f8: 2400        movs	r4, #0
@   0x080273fa: 4e13        ldr	r6, [pc, #76]	@ (0x27448)
@   0x080273fc: 2503        movs	r5, #3
@   0x080273fe: 1c20        adds	r0, r4, #0
@   0x08027400: 302a        adds	r0, #42	@ 0x2a
@   0x08027402: 00a1        lsls	r1, r4, #2
@   0x08027404: 1989        adds	r1, r1, r6
@   0x08027406: 6809        ldr	r1, [r1, #0]
@   0x08027408: 2271        movs	r2, #113	@ 0x71
@   0x0802740a: 9200        str	r2, [sp, #0]
@   0x0802740c: 2204        movs	r2, #4
@   0x0802740e: 9201        str	r2, [sp, #4]
@   0x08027410: 9502        str	r5, [sp, #8]
@   0x08027412: 9503        str	r5, [sp, #12]
@   0x08027414: 2280        movs	r2, #128	@ 0x80
@   0x08027416: 00d2        lsls	r2, r2, #3
@   0x08027418: 2335        movs	r3, #53	@ 0x35
@   0x0802741a: f7f9        fe41 	bl	0x210a0
@   0x0802741e: 1c60        adds	r0, r4, #1
@   0x08027420: 0600        lsls	r0, r0, #24
@   0x08027422: 0e04        lsrs	r4, r0, #24
@   0x08027424: 2c02        cmp	r4, #2
@   0x08027426: d9ea        bls.n	0x273fe
@   0x08027428: 4808        ldr	r0, [pc, #32]	@ (0x2744c)
@   0x0802742a: 4a09        ldr	r2, [pc, #36]	@ (0x27450)
@   0x0802742c: 1881        adds	r1, r0, r2
@   0x0802742e: 2202        movs	r2, #2
@   0x08027430: 700a        strb	r2, [r1, #0]
@   0x08027432: 4908        ldr	r1, [pc, #32]	@ (0x27454)
@   0x08027434: 1840        adds	r0, r0, r1
@   0x08027436: 7002        strb	r2, [r0, #0]
@   0x08027438: 202a        movs	r0, #42	@ 0x2a
@   0x0802743a: f7de        ffd7 	bl	0x63ec
@   0x0802743e: b004        add	sp, #16
@   0x08027440: bc70        pop	{r4, r5, r6}
@   0x08027442: bc01        pop	{r0}
@   0x08027444: 4700        bx	r0
@   0x08027446: 0000        movs	r0, r0
@   0x08027448: 6660        str	r0, [r4, #100]	@ 0x64
@   0x0802744a: 0831        lsrs	r1, r6, #32
@   0x0802744c: 3720        adds	r7, #32
@   0x0802744e: 0300        lsls	r0, r0, #12
@   0x08027450: 0936        lsrs	r6, r6, #4
@   0x08027452: 0000        movs	r0, r0
@   0x08027454: 096e        lsrs	r6, r5, #5

        thumb_func_start sub_080273F4
sub_080273F4: @ 0x080273f4
        .incbin "baserom.gba", 0x273f4, 0x64
        thumb_func_end sub_080273F4
