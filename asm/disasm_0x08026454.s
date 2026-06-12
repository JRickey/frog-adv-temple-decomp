@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026454, 0x080264b8)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026454 --end 0x80264b8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026454: b570        push	{r4, r5, r6, lr}
@   0x08026456: 2400        movs	r4, #0
@   0x08026458: 4d08        ldr	r5, [pc, #32]	@ (0x2647c)
@   0x0802645a: 1c22        adds	r2, r4, #0
@   0x0802645c: 3233        adds	r2, #51	@ 0x33
@   0x0802645e: 00d0        lsls	r0, r2, #3
@   0x08026460: 1a80        subs	r0, r0, r2
@   0x08026462: 00c0        lsls	r0, r0, #3
@   0x08026464: 1943        adds	r3, r0, r5
@   0x08026466: 2004        movs	r0, #4
@   0x08026468: 5e19        ldrsh	r1, [r3, r0]
@   0x0802646a: 2604        movs	r6, #4
@   0x0802646c: 5fa8        ldrsh	r0, [r5, r6]
@   0x0802646e: 1a09        subs	r1, r1, r0
@   0x08026470: 2900        cmp	r1, #0
@   0x08026472: db05        blt.n	0x26480
@   0x08026474: 889b        ldrh	r3, [r3, #4]
@   0x08026476: 88a9        ldrh	r1, [r5, #4]
@   0x08026478: 1a58        subs	r0, r3, r1
@   0x0802647a: e004        b.n	0x26486
@   0x0802647c: 3720        adds	r7, #32
@   0x0802647e: 0300        lsls	r0, r0, #12
@   0x08026480: 88ae        ldrh	r6, [r5, #4]
@   0x08026482: 889b        ldrh	r3, [r3, #4]
@   0x08026484: 1af0        subs	r0, r6, r3
@   0x08026486: 0400        lsls	r0, r0, #16
@   0x08026488: 0c00        lsrs	r0, r0, #16
@   0x0802648a: 0400        lsls	r0, r0, #16
@   0x0802648c: 1400        asrs	r0, r0, #16
@   0x0802648e: 289f        cmp	r0, #159	@ 0x9f
@   0x08026490: dc07        bgt.n	0x264a2
@   0x08026492: 4908        ldr	r1, [pc, #32]	@ (0x264b4)
@   0x08026494: 00a0        lsls	r0, r4, #2
@   0x08026496: 1840        adds	r0, r0, r1
@   0x08026498: 6800        ldr	r0, [r0, #0]
@   0x0802649a: 0611        lsls	r1, r2, #24
@   0x0802649c: 0e09        lsrs	r1, r1, #24
@   0x0802649e: f7fb        fd25 	bl	0x21eec
@   0x080264a2: 1c60        adds	r0, r4, #1
@   0x080264a4: 0600        lsls	r0, r0, #24
@   0x080264a6: 0e04        lsrs	r4, r0, #24
@   0x080264a8: 2c18        cmp	r4, #24
@   0x080264aa: d9d6        bls.n	0x2645a
@   0x080264ac: bc70        pop	{r4, r5, r6}
@   0x080264ae: bc01        pop	{r0}
@   0x080264b0: 4700        bx	r0
@   0x080264b2: 0000        movs	r0, r0
@   0x080264b4: 5ae0        ldrh	r0, [r4, r3]
@   0x080264b6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026454
sub_08026454: @ 0x08026454
        .incbin "baserom.gba", 0x26454, 0x64
        thumb_func_end sub_08026454
