@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025484, 0x080254dc)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025484 --end 0x80254dc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025484: b570        push	{r4, r5, r6, lr}
@   0x08025486: b084        sub	sp, #16
@   0x08025488: 2600        movs	r6, #0
@   0x0802548a: 1c35        adds	r5, r6, #0
@   0x0802548c: 354e        adds	r5, #78	@ 0x4e
@   0x0802548e: 4911        ldr	r1, [pc, #68]	@ (0x254d4)
@   0x08025490: 00b0        lsls	r0, r6, #2
@   0x08025492: 1840        adds	r0, r0, r1
@   0x08025494: 6804        ldr	r4, [r0, #0]
@   0x08025496: 1c30        adds	r0, r6, #0
@   0x08025498: 2105        movs	r1, #5
@   0x0802549a: f00e        fd5f 	bl	0x33f5c
@   0x0802549e: 0600        lsls	r0, r0, #24
@   0x080254a0: 0900        lsrs	r0, r0, #4
@   0x080254a2: 490d        ldr	r1, [pc, #52]	@ (0x254d8)
@   0x080254a4: 1840        adds	r0, r0, r1
@   0x080254a6: 0c00        lsrs	r0, r0, #16
@   0x080254a8: 9000        str	r0, [sp, #0]
@   0x080254aa: 2009        movs	r0, #9
@   0x080254ac: 9001        str	r0, [sp, #4]
@   0x080254ae: 2003        movs	r0, #3
@   0x080254b0: 9002        str	r0, [sp, #8]
@   0x080254b2: 9003        str	r0, [sp, #12]
@   0x080254b4: 1c28        adds	r0, r5, #0
@   0x080254b6: 1c21        adds	r1, r4, #0
@   0x080254b8: 2200        movs	r2, #0
@   0x080254ba: 2329        movs	r3, #41	@ 0x29
@   0x080254bc: f7fb        fdf0 	bl	0x210a0
@   0x080254c0: 1c70        adds	r0, r6, #1
@   0x080254c2: 0600        lsls	r0, r0, #24
@   0x080254c4: 0e06        lsrs	r6, r0, #24
@   0x080254c6: 2e0e        cmp	r6, #14
@   0x080254c8: d9df        bls.n	0x2548a
@   0x080254ca: b004        add	sp, #16
@   0x080254cc: bc70        pop	{r4, r5, r6}
@   0x080254ce: bc01        pop	{r0}
@   0x080254d0: 4700        bx	r0
@   0x080254d2: 0000        movs	r0, r0
@   0x080254d4: 3f88        subs	r7, #136	@ 0x88
@   0x080254d6: 0831        lsrs	r1, r6, #32
@   0x080254d8: 0000        movs	r0, r0
@   0x080254da: 0231        lsls	r1, r6, #8

        thumb_func_start sub_08025484
sub_08025484: @ 0x08025484
        .incbin "baserom.gba", 0x25484, 0x58
        thumb_func_end sub_08025484
