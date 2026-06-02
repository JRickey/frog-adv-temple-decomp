@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080198a8, 0x08019964)  (188 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80198a8 --end 0x8019964 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080198a8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080198aa: 464f        mov	r7, r9
@   0x080198ac: 4646        mov	r6, r8
@   0x080198ae: b4c0        push	{r6, r7}
@   0x080198b0: b081        sub	sp, #4
@   0x080198b2: 1c07        adds	r7, r0, #0
@   0x080198b4: 9808        ldr	r0, [sp, #32]
@   0x080198b6: 0409        lsls	r1, r1, #16
@   0x080198b8: 0c09        lsrs	r1, r1, #16
@   0x080198ba: 4689        mov	r9, r1
@   0x080198bc: 0412        lsls	r2, r2, #16
@   0x080198be: 0c12        lsrs	r2, r2, #16
@   0x080198c0: 4690        mov	r8, r2
@   0x080198c2: 061b        lsls	r3, r3, #24
@   0x080198c4: 0e1d        lsrs	r5, r3, #24
@   0x080198c6: 0600        lsls	r0, r0, #24
@   0x080198c8: 0e04        lsrs	r4, r0, #24
@   0x080198ca: 6838        ldr	r0, [r7, #0]
@   0x080198cc: 490e        ldr	r1, [pc, #56]	@ (0x19908)
@   0x080198ce: 4008        ands	r0, r1
@   0x080198d0: 210f        movs	r1, #15
@   0x080198d2: 4308        orrs	r0, r1
@   0x080198d4: 490d        ldr	r1, [pc, #52]	@ (0x1990c)
@   0x080198d6: 4008        ands	r0, r1
@   0x080198d8: 2180        movs	r1, #128	@ 0x80
@   0x080198da: 0289        lsls	r1, r1, #10
@   0x080198dc: 4308        orrs	r0, r1
@   0x080198de: 9000        str	r0, [sp, #0]
@   0x080198e0: 2c00        cmp	r4, #0
@   0x080198e2: d031        beq.n	0x19948
@   0x080198e4: 4e0a        ldr	r6, [pc, #40]	@ (0x19910)
@   0x080198e6: 2001        movs	r0, #1
@   0x080198e8: 4020        ands	r0, r4
@   0x080198ea: 2800        cmp	r0, #0
@   0x080198ec: d012        beq.n	0x19914
@   0x080198ee: 1c38        adds	r0, r7, #0
@   0x080198f0: 4649        mov	r1, r9
@   0x080198f2: 4642        mov	r2, r8
@   0x080198f4: 1c2b        adds	r3, r5, #0
@   0x080198f6: f7fe        fdf1 	bl	0x184dc
@   0x080198fa: 4668        mov	r0, sp
@   0x080198fc: 2106        movs	r1, #6
@   0x080198fe: 2207        movs	r2, #7
@   0x08019900: 1c2b        adds	r3, r5, #0
@   0x08019902: f7fe        fdeb 	bl	0x184dc
@   0x08019906: e011        b.n	0x1992c
@   0x08019908: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801990c: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x08019910: 8100        strh	r0, [r0, #8]
@   0x08019912: 0830        lsrs	r0, r6, #32
@   0x08019914: 1c38        adds	r0, r7, #0
@   0x08019916: 4641        mov	r1, r8
@   0x08019918: 464a        mov	r2, r9
@   0x0801991a: 1c2b        adds	r3, r5, #0
@   0x0801991c: f7fe        fdde 	bl	0x184dc
@   0x08019920: 4668        mov	r0, sp
@   0x08019922: 2107        movs	r1, #7
@   0x08019924: 2206        movs	r2, #6
@   0x08019926: 1c2b        adds	r3, r5, #0
@   0x08019928: f7fe        fdd8 	bl	0x184dc
@   0x0801992c: 2005        movs	r0, #5
@   0x0801992e: f004        fc9f 	bl	0x1e270
@   0x08019932: 6830        ldr	r0, [r6, #0]
@   0x08019934: 6871        ldr	r1, [r6, #4]
@   0x08019936: 68b2        ldr	r2, [r6, #8]
@   0x08019938: 68f3        ldr	r3, [r6, #12]
@   0x0801993a: f7fe        fe41 	bl	0x185c0
@   0x0801993e: 1e60        subs	r0, r4, #1
@   0x08019940: 0600        lsls	r0, r0, #24
@   0x08019942: 0e04        lsrs	r4, r0, #24
@   0x08019944: 2c00        cmp	r4, #0
@   0x08019946: d1ce        bne.n	0x198e6
@   0x08019948: b001        add	sp, #4
@   0x0801994a: bc18        pop	{r3, r4}
@   0x0801994c: 4698        mov	r8, r3
@   0x0801994e: 46a1        mov	r9, r4
@   0x08019950: bcf0        pop	{r4, r5, r6, r7}
@   0x08019952: bc01        pop	{r0}
@   0x08019954: 4700        bx	r0
@   0x08019956: 0000        movs	r0, r0
@   0x08019958: 4901        ldr	r1, [pc, #4]	@ (0x19960)
@   0x0801995a: 6008        str	r0, [r1, #0]
@   0x0801995c: 4770        bx	lr
@   0x0801995e: 0000        movs	r0, r0
@   0x08019960: 34b0        adds	r4, #176	@ 0xb0
@   0x08019962: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080198A8
sub_080198A8: @ 0x080198a8
        .incbin "frog_us_baserom.gba", 0x198a8, 0xbc
        thumb_func_end sub_080198A8
