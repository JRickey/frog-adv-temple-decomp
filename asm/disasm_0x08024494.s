@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024494, 0x080244f8)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024494 --end 0x80244f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024494: b530        push	{r4, r5, lr}
@   0x08024496: 2300        movs	r3, #0
@   0x08024498: 4d15        ldr	r5, [pc, #84]	@ (0x244f0)
@   0x0802449a: 4c16        ldr	r4, [pc, #88]	@ (0x244f4)
@   0x0802449c: 00d8        lsls	r0, r3, #3
@   0x0802449e: 1942        adds	r2, r0, r5
@   0x080244a0: 1900        adds	r0, r0, r4
@   0x080244a2: 6841        ldr	r1, [r0, #4]
@   0x080244a4: 6800        ldr	r0, [r0, #0]
@   0x080244a6: 6050        str	r0, [r2, #4]
@   0x080244a8: 6091        str	r1, [r2, #8]
@   0x080244aa: 1c58        adds	r0, r3, #1
@   0x080244ac: 0600        lsls	r0, r0, #24
@   0x080244ae: 0e03        lsrs	r3, r0, #24
@   0x080244b0: 2b0a        cmp	r3, #10
@   0x080244b2: d9f3        bls.n	0x2449c
@   0x080244b4: f7ff        fd58 	bl	0x23f68
@   0x080244b8: f7ff        fdc6 	bl	0x24048
@   0x080244bc: f7ff        fdea 	bl	0x24094
@   0x080244c0: f7ff        fe3a 	bl	0x24138
@   0x080244c4: f7ff        fe5c 	bl	0x24180
@   0x080244c8: f7ff        feb4 	bl	0x24234
@   0x080244cc: f7ff        ff04 	bl	0x242d8
@   0x080244d0: f7ff        ff5e 	bl	0x24390
@   0x080244d4: f7ff        feea 	bl	0x242ac
@   0x080244d8: f7ff        ff26 	bl	0x24328
@   0x080244dc: f7ff        ff7a 	bl	0x243d4
@   0x080244e0: f7ff        fd8a 	bl	0x23ff8
@   0x080244e4: f7ff        ffae 	bl	0x24444
@   0x080244e8: bc30        pop	{r4, r5}
@   0x080244ea: bc01        pop	{r0}
@   0x080244ec: 4700        bx	r0
@   0x080244ee: 0000        movs	r0, r0
@   0x080244f0: 3570        adds	r5, #112	@ 0x70
@   0x080244f2: 0300        lsls	r0, r0, #12
@   0x080244f4: 2e84        cmp	r6, #132	@ 0x84
@   0x080244f6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024494
sub_08024494: @ 0x08024494
        .incbin "baserom.gba", 0x24494, 0x64
        thumb_func_end sub_08024494
