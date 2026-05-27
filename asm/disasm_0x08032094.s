@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08032094, 0x08032148)  (180 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8032094 --end 0x8032148 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08032094: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08032096: 4647        mov	r7, r8
@   0x08032098: b480        push	{r7}
@   0x0803209a: 4680        mov	r8, r0
@   0x0803209c: 4816        ldr	r0, [pc, #88]	@ (0x320f8)
@   0x0803209e: 6801        ldr	r1, [r0, #0]
@   0x080320a0: 228c        movs	r2, #140	@ 0x8c
@   0x080320a2: 0052        lsls	r2, r2, #1
@   0x080320a4: 1889        adds	r1, r1, r2
@   0x080320a6: 680d        ldr	r5, [r1, #0]
@   0x080320a8: 4914        ldr	r1, [pc, #80]	@ (0x320fc)
@   0x080320aa: 186b        adds	r3, r5, r1
@   0x080320ac: 781a        ldrb	r2, [r3, #0]
@   0x080320ae: 2107        movs	r1, #7
@   0x080320b0: 4011        ands	r1, r2
@   0x080320b2: 4684        mov	ip, r0
@   0x080320b4: 2903        cmp	r1, #3
@   0x080320b6: d141        bne.n	0x3213c
@   0x080320b8: 20fd        movs	r0, #253	@ 0xfd
@   0x080320ba: 4010        ands	r0, r2
@   0x080320bc: 2104        movs	r1, #4
@   0x080320be: 4308        orrs	r0, r1
@   0x080320c0: 7018        strb	r0, [r3, #0]
@   0x080320c2: 4642        mov	r2, r8
@   0x080320c4: 2a00        cmp	r2, #0
@   0x080320c6: d034        beq.n	0x32132
@   0x080320c8: 2400        movs	r4, #0
@   0x080320ca: 4661        mov	r1, ip
@   0x080320cc: 6808        ldr	r0, [r1, #0]
@   0x080320ce: 7800        ldrb	r0, [r0, #0]
@   0x080320d0: 3004        adds	r0, #4
@   0x080320d2: 4284        cmp	r4, r0
@   0x080320d4: da2d        bge.n	0x32132
@   0x080320d6: 2288        movs	r2, #136	@ 0x88
@   0x080320d8: 0052        lsls	r2, r2, #1
@   0x080320da: 18ae        adds	r6, r5, r2
@   0x080320dc: 2500        movs	r5, #0
@   0x080320de: 2700        movs	r7, #0
@   0x080320e0: 6830        ldr	r0, [r6, #0]
@   0x080320e2: 1828        adds	r0, r5, r0
@   0x080320e4: 7900        ldrb	r0, [r0, #4]
@   0x080320e6: 2800        cmp	r0, #0
@   0x080320e8: d01b        beq.n	0x32122
@   0x080320ea: 4640        mov	r0, r8
@   0x080320ec: 2801        cmp	r0, #1
@   0x080320ee: d107        bne.n	0x32100
@   0x080320f0: 1c20        adds	r0, r4, #0
@   0x080320f2: f7fd        fc7d 	bl	0x2f9f0
@   0x080320f6: e00f        b.n	0x32118
@   0x080320f8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080320fa: 0300        lsls	r0, r0, #12
@   0x080320fc: 0151        lsls	r1, r2, #5
@   0x080320fe: 0000        movs	r0, r0
@   0x08032100: 480d        ldr	r0, [pc, #52]	@ (0x32138)
@   0x08032102: 6800        ldr	r0, [r0, #0]
@   0x08032104: 218a        movs	r1, #138	@ 0x8a
@   0x08032106: 0049        lsls	r1, r1, #1
@   0x08032108: 1840        adds	r0, r0, r1
@   0x0803210a: 6801        ldr	r1, [r0, #0]
@   0x0803210c: 0120        lsls	r0, r4, #4
@   0x0803210e: 1840        adds	r0, r0, r1
@   0x08032110: 6007        str	r7, [r0, #0]
@   0x08032112: 1c20        adds	r0, r4, #0
@   0x08032114: f7fc        fb06 	bl	0x2e724
@   0x08032118: 6830        ldr	r0, [r6, #0]
@   0x0803211a: 1828        adds	r0, r5, r0
@   0x0803211c: 7107        strb	r7, [r0, #4]
@   0x0803211e: 4a06        ldr	r2, [pc, #24]	@ (0x32138)
@   0x08032120: 4694        mov	ip, r2
@   0x08032122: 350c        adds	r5, #12
@   0x08032124: 3401        adds	r4, #1
@   0x08032126: 4661        mov	r1, ip
@   0x08032128: 6808        ldr	r0, [r1, #0]
@   0x0803212a: 7800        ldrb	r0, [r0, #0]
@   0x0803212c: 3004        adds	r0, #4
@   0x0803212e: 4284        cmp	r4, r0
@   0x08032130: dbd6        blt.n	0x320e0
@   0x08032132: 2001        movs	r0, #1
@   0x08032134: e003        b.n	0x3213e
@   0x08032136: 0000        movs	r0, r0
@   0x08032138: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803213a: 0300        lsls	r0, r0, #12
@   0x0803213c: 2000        movs	r0, #0
@   0x0803213e: bc08        pop	{r3}
@   0x08032140: 4698        mov	r8, r3
@   0x08032142: bcf0        pop	{r4, r5, r6, r7}
@   0x08032144: bc02        pop	{r1}
@   0x08032146: 4708        bx	r1

        thumb_func_start sub_08032094
sub_08032094: @ 0x08032094
        .incbin "frog_us_baserom.gba", 0x32094, 0xb4
        thumb_func_end sub_08032094
