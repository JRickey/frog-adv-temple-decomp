@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080281d8, 0x08028238)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80281d8 --end 0x8028238 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080281d8: b530        push	{r4, r5, lr}
@   0x080281da: 2300        movs	r3, #0
@   0x080281dc: 4d14        ldr	r5, [pc, #80]	@ (0x28230)
@   0x080281de: 4c15        ldr	r4, [pc, #84]	@ (0x28234)
@   0x080281e0: 00d8        lsls	r0, r3, #3
@   0x080281e2: 1942        adds	r2, r0, r5
@   0x080281e4: 1900        adds	r0, r0, r4
@   0x080281e6: 6841        ldr	r1, [r0, #4]
@   0x080281e8: 6800        ldr	r0, [r0, #0]
@   0x080281ea: 6050        str	r0, [r2, #4]
@   0x080281ec: 6091        str	r1, [r2, #8]
@   0x080281ee: 1c58        adds	r0, r3, #1
@   0x080281f0: 0600        lsls	r0, r0, #24
@   0x080281f2: 0e03        lsrs	r3, r0, #24
@   0x080281f4: 2b0b        cmp	r3, #11
@   0x080281f6: d9f3        bls.n	0x281e0
@   0x080281f8: f7ff        fd8e 	bl	0x27d18
@   0x080281fc: f7ff        fdb2 	bl	0x27d64
@   0x08028200: f7ff        fdd6 	bl	0x27db0
@   0x08028204: f7ff        fdfa 	bl	0x27dfc
@   0x08028208: f7ff        fe18 	bl	0x27e3c
@   0x0802820c: f7ff        fe2a 	bl	0x27e64
@   0x08028210: f7ff        fe6a 	bl	0x27ee8
@   0x08028214: f7ff        feb0 	bl	0x27f78
@   0x08028218: f7ff        fef6 	bl	0x28008
@   0x0802821c: f7ff        ff32 	bl	0x28084
@   0x08028220: f7ff        ff52 	bl	0x280c8
@   0x08028224: f7ff        ffb0 	bl	0x28188
@   0x08028228: bc30        pop	{r4, r5}
@   0x0802822a: bc01        pop	{r0}
@   0x0802822c: 4700        bx	r0
@   0x0802822e: 0000        movs	r0, r0
@   0x08028230: 3570        adds	r5, #112	@ 0x70
@   0x08028232: 0300        lsls	r0, r0, #12
@   0x08028234: 6e54        ldr	r4, [r2, #100]	@ 0x64
@   0x08028236: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080281D8
sub_080281D8: @ 0x080281d8
        .incbin "baserom.gba", 0x281d8, 0x60
        thumb_func_end sub_080281D8
