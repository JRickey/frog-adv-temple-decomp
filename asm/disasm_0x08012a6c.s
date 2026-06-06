@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012a6c, 0x08012b38)  (204 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012a6c --end 0x8012b38 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012a6c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08012a6e: 4657        mov	r7, sl
@   0x08012a70: 464e        mov	r6, r9
@   0x08012a72: 4645        mov	r5, r8
@   0x08012a74: b4e0        push	{r5, r6, r7}
@   0x08012a76: b084        sub	sp, #16
@   0x08012a78: 4826        ldr	r0, [pc, #152]	@ (0x12b14)
@   0x08012a7a: 4681        mov	r9, r0
@   0x08012a7c: 7801        ldrb	r1, [r0, #0]
@   0x08012a7e: 2901        cmp	r1, #1
@   0x08012a80: d13d        bne.n	0x12afe
@   0x08012a82: 4825        ldr	r0, [pc, #148]	@ (0x12b18)
@   0x08012a84: 4e25        ldr	r6, [pc, #148]	@ (0x12b1c)
@   0x08012a86: 6801        ldr	r1, [r0, #0]
@   0x08012a88: 6870        ldr	r0, [r6, #4]
@   0x08012a8a: 1a08        subs	r0, r1, r0
@   0x08012a8c: 4f24        ldr	r7, [pc, #144]	@ (0x12b20)
@   0x08012a8e: 7b3a        ldrb	r2, [r7, #12]
@   0x08012a90: 4290        cmp	r0, r2
@   0x08012a92: d336        bcc.n	0x12b02
@   0x08012a94: 6071        str	r1, [r6, #4]
@   0x08012a96: 7a3b        ldrb	r3, [r7, #8]
@   0x08012a98: 091b        lsrs	r3, r3, #4
@   0x08012a9a: 9303        str	r3, [sp, #12]
@   0x08012a9c: 2101        movs	r1, #1
@   0x08012a9e: 1c18        adds	r0, r3, #0
@   0x08012aa0: 4008        ands	r0, r1
@   0x08012aa2: 4c20        ldr	r4, [pc, #128]	@ (0x12b24)
@   0x08012aa4: 46a4        mov	ip, r4
@   0x08012aa6: 2800        cmp	r0, #0
@   0x08012aa8: d001        beq.n	0x12aae
@   0x08012aaa: 4d1f        ldr	r5, [pc, #124]	@ (0x12b28)
@   0x08012aac: 46ac        mov	ip, r5
@   0x08012aae: 6938        ldr	r0, [r7, #16]
@   0x08012ab0: 4680        mov	r8, r0
@   0x08012ab2: 79b8        ldrb	r0, [r7, #6]
@   0x08012ab4: 7939        ldrb	r1, [r7, #4]
@   0x08012ab6: 4c1d        ldr	r4, [pc, #116]	@ (0x12b2c)
@   0x08012ab8: 4a1d        ldr	r2, [pc, #116]	@ (0x12b30)
@   0x08012aba: 5f13        ldrsh	r3, [r2, r4]
@   0x08012abc: 005a        lsls	r2, r3, #1
@   0x08012abe: 18d2        adds	r2, r2, r3
@   0x08012ac0: 0412        lsls	r2, r2, #16
@   0x08012ac2: 0c12        lsrs	r2, r2, #16
@   0x08012ac4: 4b1b        ldr	r3, [pc, #108]	@ (0x12b34)
@   0x08012ac6: 18e4        adds	r4, r4, r3
@   0x08012ac8: 2500        movs	r5, #0
@   0x08012aca: 5f64        ldrsh	r4, [r4, r5]
@   0x08012acc: 0063        lsls	r3, r4, #1
@   0x08012ace: 191b        adds	r3, r3, r4
@   0x08012ad0: 041b        lsls	r3, r3, #16
@   0x08012ad2: 0c1b        lsrs	r3, r3, #16
@   0x08012ad4: 9c03        ldr	r4, [sp, #12]
@   0x08012ad6: 9400        str	r4, [sp, #0]
@   0x08012ad8: 7ab4        ldrb	r4, [r6, #10]
@   0x08012ada: 1c65        adds	r5, r4, #1
@   0x08012adc: 72b5        strb	r5, [r6, #10]
@   0x08012ade: 0624        lsls	r4, r4, #24
@   0x08012ae0: 0da4        lsrs	r4, r4, #22
@   0x08012ae2: 4444        add	r4, r8
@   0x08012ae4: 6824        ldr	r4, [r4, #0]
@   0x08012ae6: 9401        str	r4, [sp, #4]
@   0x08012ae8: 4665        mov	r5, ip
@   0x08012aea: 9502        str	r5, [sp, #8]
@   0x08012aec: f7fd        fbb6 	bl	0x1025c
@   0x08012af0: 7ab6        ldrb	r6, [r6, #10]
@   0x08012af2: 897f        ldrh	r7, [r7, #10]
@   0x08012af4: 42be        cmp	r6, r7
@   0x08012af6: d302        bcc.n	0x12afe
@   0x08012af8: 2000        movs	r0, #0
@   0x08012afa: 4649        mov	r1, r9
@   0x08012afc: 7008        strb	r0, [r1, #0]
@   0x08012afe: f7fb        fe69 	bl	0xe7d4
@   0x08012b02: b004        add	sp, #16
@   0x08012b04: bc38        pop	{r3, r4, r5}
@   0x08012b06: 4698        mov	r8, r3
@   0x08012b08: 46a1        mov	r9, r4
@   0x08012b0a: 46aa        mov	sl, r5
@   0x08012b0c: bcf0        pop	{r4, r5, r6, r7}
@   0x08012b0e: bc01        pop	{r0}
@   0x08012b10: 4700        bx	r0
@   0x08012b12: 0000        movs	r0, r0
@   0x08012b14: 3610        adds	r6, #16
@   0x08012b16: 0300        lsls	r0, r0, #12
@   0x08012b18: 5330        strh	r0, [r6, r4]
@   0x08012b1a: 0300        lsls	r0, r0, #12
@   0x08012b1c: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08012b1e: 0300        lsls	r0, r0, #12
@   0x08012b20: 6e64        ldr	r4, [r4, #100]	@ 0x64
@   0x08012b22: 0830        lsrs	r0, r6, #32
@   0x08012b24: e000        b.n	0x12b28
@   0x08012b26: 0600        lsls	r0, r0, #24
@   0x08012b28: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08012b2c: 3720        adds	r7, #32
@   0x08012b2e: 0300        lsls	r0, r0, #12
@   0x08012b30: 0692        lsls	r2, r2, #26
@   0x08012b32: 0000        movs	r0, r0
@   0x08012b34: 0694        lsls	r4, r2, #26

        thumb_func_start ScaleBlit_Tick
ScaleBlit_Tick: @ 0x08012a6c
        .incbin "frog_us_baserom.gba", 0x12a6c, 0xcc
        thumb_func_end ScaleBlit_Tick
