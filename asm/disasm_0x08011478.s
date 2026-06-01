@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08011478, 0x08011518)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8011478 --end 0x8011518 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08011478: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801147a: 4657        mov	r7, sl
@   0x0801147c: 464e        mov	r6, r9
@   0x0801147e: 4645        mov	r5, r8
@   0x08011480: b4e0        push	{r5, r6, r7}
@   0x08011482: b084        sub	sp, #16
@   0x08011484: 9103        str	r1, [sp, #12]
@   0x08011486: 0600        lsls	r0, r0, #24
@   0x08011488: 0e00        lsrs	r0, r0, #24
@   0x0801148a: 4680        mov	r8, r0
@   0x0801148c: 0612        lsls	r2, r2, #24
@   0x0801148e: 0e12        lsrs	r2, r2, #24
@   0x08011490: 4692        mov	sl, r2
@   0x08011492: 2700        movs	r7, #0
@   0x08011494: 4547        cmp	r7, r8
@   0x08011496: d230        bcs.n	0x114fa
@   0x08011498: 481c        ldr	r0, [pc, #112]	@ (0x1150c)
@   0x0801149a: 4681        mov	r9, r0
@   0x0801149c: 481c        ldr	r0, [pc, #112]	@ (0x11510)
@   0x0801149e: 8cc0        ldrh	r0, [r0, #38]	@ 0x26
@   0x080114a0: 4138        asrs	r0, r7
@   0x080114a2: 2101        movs	r1, #1
@   0x080114a4: 4008        ands	r0, r1
@   0x080114a6: 2800        cmp	r0, #0
@   0x080114a8: d022        beq.n	0x114f0
@   0x080114aa: 0078        lsls	r0, r7, #1
@   0x080114ac: 19c0        adds	r0, r0, r7
@   0x080114ae: 00c6        lsls	r6, r0, #3
@   0x080114b0: 9c03        ldr	r4, [sp, #12]
@   0x080114b2: 1935        adds	r5, r6, r4
@   0x080114b4: 7a28        ldrb	r0, [r5, #8]
@   0x080114b6: 8829        ldrh	r1, [r5, #0]
@   0x080114b8: 886a        ldrh	r2, [r5, #2]
@   0x080114ba: 88ab        ldrh	r3, [r5, #4]
@   0x080114bc: 88ec        ldrh	r4, [r5, #6]
@   0x080114be: 9400        str	r4, [sp, #0]
@   0x080114c0: 692c        ldr	r4, [r5, #16]
@   0x080114c2: 9401        str	r4, [sp, #4]
@   0x080114c4: 4655        mov	r5, sl
@   0x080114c6: 9502        str	r5, [sp, #8]
@   0x080114c8: f001        fb7c 	bl	0x12bc4
@   0x080114cc: 2f03        cmp	r7, #3
@   0x080114ce: d00f        beq.n	0x114f0
@   0x080114d0: 4648        mov	r0, r9
@   0x080114d2: 1834        adds	r4, r6, r0
@   0x080114d4: 7a20        ldrb	r0, [r4, #8]
@   0x080114d6: 8821        ldrh	r1, [r4, #0]
@   0x080114d8: 8862        ldrh	r2, [r4, #2]
@   0x080114da: 88a3        ldrh	r3, [r4, #4]
@   0x080114dc: 88e4        ldrh	r4, [r4, #6]
@   0x080114de: 9400        str	r4, [sp, #0]
@   0x080114e0: 4d0c        ldr	r5, [pc, #48]	@ (0x11514)
@   0x080114e2: 1974        adds	r4, r6, r5
@   0x080114e4: 6824        ldr	r4, [r4, #0]
@   0x080114e6: 9401        str	r4, [sp, #4]
@   0x080114e8: 2403        movs	r4, #3
@   0x080114ea: 9402        str	r4, [sp, #8]
@   0x080114ec: f001        fb6a 	bl	0x12bc4
@   0x080114f0: 1c78        adds	r0, r7, #1
@   0x080114f2: 0600        lsls	r0, r0, #24
@   0x080114f4: 0e07        lsrs	r7, r0, #24
@   0x080114f6: 4547        cmp	r7, r8
@   0x080114f8: d3d0        bcc.n	0x1149c
@   0x080114fa: b004        add	sp, #16
@   0x080114fc: bc38        pop	{r3, r4, r5}
@   0x080114fe: 4698        mov	r8, r3
@   0x08011500: 46a1        mov	r9, r4
@   0x08011502: 46aa        mov	sl, r5
@   0x08011504: bcf0        pop	{r4, r5, r6, r7}
@   0x08011506: bc01        pop	{r0}
@   0x08011508: 4700        bx	r0
@   0x0801150a: 0000        movs	r0, r0
@   0x0801150c: 6b74        ldr	r4, [r6, #52]	@ 0x34
@   0x0801150e: 0830        lsrs	r0, r6, #32
@   0x08011510: 6110        str	r0, [r2, #16]
@   0x08011512: 0300        lsls	r0, r0, #12
@   0x08011514: 6b84        ldr	r4, [r0, #56]	@ 0x38
@   0x08011516: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_08011478
sub_08011478: @ 0x08011478
        .incbin "frog_us_baserom.gba", 0x11478, 0xa0
        thumb_func_end sub_08011478
