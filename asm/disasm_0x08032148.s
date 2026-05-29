@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08032148, 0x08032200)  (184 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8032148 --end 0x8032200 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08032148: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0803214a: 4820        ldr	r0, [pc, #128]	@ (0x321cc)
@   0x0803214c: 6801        ldr	r1, [r0, #0]
@   0x0803214e: 228c        movs	r2, #140	@ 0x8c
@   0x08032150: 0052        lsls	r2, r2, #1
@   0x08032152: 1889        adds	r1, r1, r2
@   0x08032154: 680c        ldr	r4, [r1, #0]
@   0x08032156: 491e        ldr	r1, [pc, #120]	@ (0x321d0)
@   0x08032158: 1862        adds	r2, r4, r1
@   0x0803215a: 2102        movs	r1, #2
@   0x0803215c: 7812        ldrb	r2, [r2, #0]
@   0x0803215e: 4011        ands	r1, r2
@   0x08032160: 1c05        adds	r5, r0, #0
@   0x08032162: 2900        cmp	r1, #0
@   0x08032164: d00e        beq.n	0x32184
@   0x08032166: 2300        movs	r3, #0
@   0x08032168: 1c22        adds	r2, r4, #0
@   0x0803216a: 3288        adds	r2, #136	@ 0x88
@   0x0803216c: 1c21        adds	r1, r4, #0
@   0x0803216e: 6808        ldr	r0, [r1, #0]
@   0x08032170: 2800        cmp	r0, #0
@   0x08032172: d139        bne.n	0x321e8
@   0x08032174: 6810        ldr	r0, [r2, #0]
@   0x08032176: 2800        cmp	r0, #0
@   0x08032178: d136        bne.n	0x321e8
@   0x0803217a: 3208        adds	r2, #8
@   0x0803217c: 3108        adds	r1, #8
@   0x0803217e: 3301        adds	r3, #1
@   0x08032180: 2b0f        cmp	r3, #15
@   0x08032182: ddf4        ble.n	0x3216e
@   0x08032184: 2300        movs	r3, #0
@   0x08032186: 6828        ldr	r0, [r5, #0]
@   0x08032188: 7801        ldrb	r1, [r0, #0]
@   0x0803218a: 3104        adds	r1, #4
@   0x0803218c: 428b        cmp	r3, r1
@   0x0803218e: da33        bge.n	0x321f8
@   0x08032190: 2288        movs	r2, #136	@ 0x88
@   0x08032192: 0052        lsls	r2, r2, #1
@   0x08032194: 18a0        adds	r0, r4, r2
@   0x08032196: 1c2f        adds	r7, r5, #0
@   0x08032198: 1c0e        adds	r6, r1, #0
@   0x0803219a: 6805        ldr	r5, [r0, #0]
@   0x0803219c: 005c        lsls	r4, r3, #1
@   0x0803219e: 7928        ldrb	r0, [r5, #4]
@   0x080321a0: 2800        cmp	r0, #0
@   0x080321a2: d121        bne.n	0x321e8
@   0x080321a4: 683a        ldr	r2, [r7, #0]
@   0x080321a6: 218a        movs	r1, #138	@ 0x8a
@   0x080321a8: 0049        lsls	r1, r1, #1
@   0x080321aa: 1850        adds	r0, r2, r1
@   0x080321ac: 6801        ldr	r1, [r0, #0]
@   0x080321ae: 0118        lsls	r0, r3, #4
@   0x080321b0: 1840        adds	r0, r0, r1
@   0x080321b2: 6800        ldr	r0, [r0, #0]
@   0x080321b4: 2800        cmp	r0, #0
@   0x080321b6: d01b        beq.n	0x321f0
@   0x080321b8: 2b03        cmp	r3, #3
@   0x080321ba: dc0b        bgt.n	0x321d4
@   0x080321bc: 1c10        adds	r0, r2, #0
@   0x080321be: 30ac        adds	r0, #172	@ 0xac
@   0x080321c0: 1900        adds	r0, r0, r4
@   0x080321c2: 8800        ldrh	r0, [r0, #0]
@   0x080321c4: 28ff        cmp	r0, #255	@ 0xff
@   0x080321c6: dd0f        ble.n	0x321e8
@   0x080321c8: e012        b.n	0x321f0
@   0x080321ca: 0000        movs	r0, r0
@   0x080321cc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080321ce: 0300        lsls	r0, r0, #12
@   0x080321d0: 0151        lsls	r1, r2, #5
@   0x080321d2: 0000        movs	r0, r0
@   0x080321d4: 1c10        adds	r0, r2, #0
@   0x080321d6: 30c8        adds	r0, #200	@ 0xc8
@   0x080321d8: 6801        ldr	r1, [r0, #0]
@   0x080321da: 0198        lsls	r0, r3, #6
@   0x080321dc: 1840        adds	r0, r0, r1
@   0x080321de: 4a03        ldr	r2, [pc, #12]	@ (0x321ec)
@   0x080321e0: 1880        adds	r0, r0, r2
@   0x080321e2: 8e80        ldrh	r0, [r0, #52]	@ 0x34
@   0x080321e4: 28ff        cmp	r0, #255	@ 0xff
@   0x080321e6: dc03        bgt.n	0x321f0
@   0x080321e8: 2001        movs	r0, #1
@   0x080321ea: e006        b.n	0x321fa
@   0x080321ec: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x080321f0: 350c        adds	r5, #12
@   0x080321f2: 3301        adds	r3, #1
@   0x080321f4: 42b3        cmp	r3, r6
@   0x080321f6: dbd1        blt.n	0x3219c
@   0x080321f8: 2000        movs	r0, #0
@   0x080321fa: bcf0        pop	{r4, r5, r6, r7}
@   0x080321fc: bc02        pop	{r1}
@   0x080321fe: 4708        bx	r1

        thumb_func_start sub_08032148
sub_08032148: @ 0x08032148
        .incbin "frog_us_baserom.gba", 0x32148, 0xb8
        thumb_func_end sub_08032148
