@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080256c8, 0x0802572c)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80256c8 --end 0x802572c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080256c8: b530        push	{r4, r5, lr}
@   0x080256ca: 2300        movs	r3, #0
@   0x080256cc: 4d15        ldr	r5, [pc, #84]	@ (0x25724)
@   0x080256ce: 4c16        ldr	r4, [pc, #88]	@ (0x25728)
@   0x080256d0: 00d8        lsls	r0, r3, #3
@   0x080256d2: 1942        adds	r2, r0, r5
@   0x080256d4: 1900        adds	r0, r0, r4
@   0x080256d6: 6841        ldr	r1, [r0, #4]
@   0x080256d8: 6800        ldr	r0, [r0, #0]
@   0x080256da: 6050        str	r0, [r2, #4]
@   0x080256dc: 6091        str	r1, [r2, #8]
@   0x080256de: 1c58        adds	r0, r3, #1
@   0x080256e0: 0600        lsls	r0, r0, #24
@   0x080256e2: 0e03        lsrs	r3, r0, #24
@   0x080256e4: 2b09        cmp	r3, #9
@   0x080256e6: d9f3        bls.n	0x256d0
@   0x080256e8: f7ff        fd4a 	bl	0x25180
@   0x080256ec: f7ff        fd6e 	bl	0x251cc
@   0x080256f0: f7ff        fd92 	bl	0x25218
@   0x080256f4: f7ff        fdb6 	bl	0x25264
@   0x080256f8: f7ff        fdf6 	bl	0x252e8
@   0x080256fc: f7ff        fe32 	bl	0x25364
@   0x08025700: f7ff        fe76 	bl	0x253f0
@   0x08025704: f7ff        fa30 	bl	0x24b68
@   0x08025708: f7ff        febc 	bl	0x25484
@   0x0802570c: f7ff        fc60 	bl	0x24fd0
@   0x08025710: f7ff        fee4 	bl	0x254dc
@   0x08025714: f7ff        ff30 	bl	0x25578
@   0x08025718: f7ff        ff6c 	bl	0x255f4
@   0x0802571c: bc30        pop	{r4, r5}
@   0x0802571e: bc01        pop	{r0}
@   0x08025720: 4700        bx	r0
@   0x08025722: 0000        movs	r0, r0
@   0x08025724: 3570        adds	r5, #112	@ 0x70
@   0x08025726: 0300        lsls	r0, r0, #12
@   0x08025728: 4058        eors	r0, r3
@   0x0802572a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080256C8
sub_080256C8: @ 0x080256c8
        .incbin "baserom.gba", 0x256c8, 0x64
        thumb_func_end sub_080256C8
