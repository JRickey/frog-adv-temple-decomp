@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b278, 0x0801b30c)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b278 --end 0x801b30c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b278: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801b27a: 464f        mov	r7, r9
@   0x0801b27c: 4646        mov	r6, r8
@   0x0801b27e: b4c0        push	{r6, r7}
@   0x0801b280: b081        sub	sp, #4
@   0x0801b282: 0600        lsls	r0, r0, #24
@   0x0801b284: 0e00        lsrs	r0, r0, #24
@   0x0801b286: 4680        mov	r8, r0
@   0x0801b288: 4668        mov	r0, sp
@   0x0801b28a: 2200        movs	r2, #0
@   0x0801b28c: 8002        strh	r2, [r0, #0]
@   0x0801b28e: 4919        ldr	r1, [pc, #100]	@ (0x1b2f4)
@   0x0801b290: 6008        str	r0, [r1, #0]
@   0x0801b292: 4819        ldr	r0, [pc, #100]	@ (0x1b2f8)
@   0x0801b294: 6048        str	r0, [r1, #4]
@   0x0801b296: 4819        ldr	r0, [pc, #100]	@ (0x1b2fc)
@   0x0801b298: 6088        str	r0, [r1, #8]
@   0x0801b29a: 6888        ldr	r0, [r1, #8]
@   0x0801b29c: 4668        mov	r0, sp
@   0x0801b29e: 8002        strh	r2, [r0, #0]
@   0x0801b2a0: 6008        str	r0, [r1, #0]
@   0x0801b2a2: 4817        ldr	r0, [pc, #92]	@ (0x1b300)
@   0x0801b2a4: 6048        str	r0, [r1, #4]
@   0x0801b2a6: 4817        ldr	r0, [pc, #92]	@ (0x1b304)
@   0x0801b2a8: 6088        str	r0, [r1, #8]
@   0x0801b2aa: 6888        ldr	r0, [r1, #8]
@   0x0801b2ac: 2100        movs	r1, #0
@   0x0801b2ae: 4541        cmp	r1, r8
@   0x0801b2b0: d818        bhi.n	0x1b2e4
@   0x0801b2b2: 4815        ldr	r0, [pc, #84]	@ (0x1b308)
@   0x0801b2b4: 4681        mov	r9, r0
@   0x0801b2b6: 0088        lsls	r0, r1, #2
@   0x0801b2b8: 4448        add	r0, r9
@   0x0801b2ba: 6806        ldr	r6, [r0, #0]
@   0x0801b2bc: 7835        ldrb	r5, [r6, #0]
@   0x0801b2be: 2401        movs	r4, #1
@   0x0801b2c0: 1c4f        adds	r7, r1, #1
@   0x0801b2c2: 42ac        cmp	r4, r5
@   0x0801b2c4: d80a        bhi.n	0x1b2dc
@   0x0801b2c6: 0061        lsls	r1, r4, #1
@   0x0801b2c8: 1989        adds	r1, r1, r6
@   0x0801b2ca: 7808        ldrb	r0, [r1, #0]
@   0x0801b2cc: 7849        ldrb	r1, [r1, #1]
@   0x0801b2ce: f000        f81d 	bl	0x1b30c
@   0x0801b2d2: 1c60        adds	r0, r4, #1
@   0x0801b2d4: 0600        lsls	r0, r0, #24
@   0x0801b2d6: 0e04        lsrs	r4, r0, #24
@   0x0801b2d8: 42ac        cmp	r4, r5
@   0x0801b2da: d9f4        bls.n	0x1b2c6
@   0x0801b2dc: 0638        lsls	r0, r7, #24
@   0x0801b2de: 0e01        lsrs	r1, r0, #24
@   0x0801b2e0: 4541        cmp	r1, r8
@   0x0801b2e2: d9e8        bls.n	0x1b2b6
@   0x0801b2e4: b001        add	sp, #4
@   0x0801b2e6: bc18        pop	{r3, r4}
@   0x0801b2e8: 4698        mov	r8, r3
@   0x0801b2ea: 46a1        mov	r9, r4
@   0x0801b2ec: bcf0        pop	{r4, r5, r6, r7}
@   0x0801b2ee: bc01        pop	{r0}
@   0x0801b2f0: 4700        bx	r0
@   0x0801b2f2: 0000        movs	r0, r0
@   0x0801b2f4: 00d4        lsls	r4, r2, #3
@   0x0801b2f6: 0400        lsls	r0, r0, #16
@   0x0801b2f8: 0000        movs	r0, r0
@   0x0801b2fa: 0201        lsls	r1, r0, #8
@   0x0801b2fc: 8000        strh	r0, [r0, #0]
@   0x0801b2fe: 8100        strh	r0, [r0, #8]
@   0x0801b300: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801b304: 0400        lsls	r0, r0, #16
@   0x0801b306: 8100        strh	r0, [r0, #8]
@   0x0801b308: 8124        strh	r4, [r4, #8]
@   0x0801b30a: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_0801B278
sub_0801B278: @ 0x0801b278
        .incbin "frog_us_baserom.gba", 0x1b278, 0x94
        thumb_func_end sub_0801B278
