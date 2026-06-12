@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080264b8, 0x0802651c)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80264b8 --end 0x802651c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080264b8: b570        push	{r4, r5, r6, lr}
@   0x080264ba: 2400        movs	r4, #0
@   0x080264bc: 4d08        ldr	r5, [pc, #32]	@ (0x264e0)
@   0x080264be: 1c22        adds	r2, r4, #0
@   0x080264c0: 3233        adds	r2, #51	@ 0x33
@   0x080264c2: 00d0        lsls	r0, r2, #3
@   0x080264c4: 1a80        subs	r0, r0, r2
@   0x080264c6: 00c0        lsls	r0, r0, #3
@   0x080264c8: 1943        adds	r3, r0, r5
@   0x080264ca: 2004        movs	r0, #4
@   0x080264cc: 5e19        ldrsh	r1, [r3, r0]
@   0x080264ce: 2604        movs	r6, #4
@   0x080264d0: 5fa8        ldrsh	r0, [r5, r6]
@   0x080264d2: 1a09        subs	r1, r1, r0
@   0x080264d4: 2900        cmp	r1, #0
@   0x080264d6: db05        blt.n	0x264e4
@   0x080264d8: 889b        ldrh	r3, [r3, #4]
@   0x080264da: 88a9        ldrh	r1, [r5, #4]
@   0x080264dc: 1a58        subs	r0, r3, r1
@   0x080264de: e004        b.n	0x264ea
@   0x080264e0: 3720        adds	r7, #32
@   0x080264e2: 0300        lsls	r0, r0, #12
@   0x080264e4: 88ae        ldrh	r6, [r5, #4]
@   0x080264e6: 889b        ldrh	r3, [r3, #4]
@   0x080264e8: 1af0        subs	r0, r6, r3
@   0x080264ea: 0400        lsls	r0, r0, #16
@   0x080264ec: 0c00        lsrs	r0, r0, #16
@   0x080264ee: 0400        lsls	r0, r0, #16
@   0x080264f0: 1400        asrs	r0, r0, #16
@   0x080264f2: 289f        cmp	r0, #159	@ 0x9f
@   0x080264f4: dc07        bgt.n	0x26506
@   0x080264f6: 4908        ldr	r1, [pc, #32]	@ (0x26518)
@   0x080264f8: 00a0        lsls	r0, r4, #2
@   0x080264fa: 1840        adds	r0, r0, r1
@   0x080264fc: 6800        ldr	r0, [r0, #0]
@   0x080264fe: 0611        lsls	r1, r2, #24
@   0x08026500: 0e09        lsrs	r1, r1, #24
@   0x08026502: f7fb        fcf3 	bl	0x21eec
@   0x08026506: 1c60        adds	r0, r4, #1
@   0x08026508: 0600        lsls	r0, r0, #24
@   0x0802650a: 0e04        lsrs	r4, r0, #24
@   0x0802650c: 2c18        cmp	r4, #24
@   0x0802650e: d9d6        bls.n	0x264be
@   0x08026510: bc70        pop	{r4, r5, r6}
@   0x08026512: bc01        pop	{r0}
@   0x08026514: 4700        bx	r0
@   0x08026516: 0000        movs	r0, r0
@   0x08026518: 5b44        ldrh	r4, [r0, r5]
@   0x0802651a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080264B8
sub_080264B8: @ 0x080264b8
        .incbin "baserom.gba", 0x264b8, 0x64
        thumb_func_end sub_080264B8
