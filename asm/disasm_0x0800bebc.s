@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800bebc, 0x0800bf24)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800bebc --end 0x800bf24 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800bebc: b530        push	{r4, r5, lr}
@   0x0800bebe: 1c04        adds	r4, r0, #0
@   0x0800bec0: 1c0d        adds	r5, r1, #0
@   0x0800bec2: 0612        lsls	r2, r2, #24
@   0x0800bec4: 0e10        lsrs	r0, r2, #24
@   0x0800bec6: 061b        lsls	r3, r3, #24
@   0x0800bec8: 0e1b        lsrs	r3, r3, #24
@   0x0800beca: 2b17        cmp	r3, #23
@   0x0800becc: d123        bne.n	0xbf16
@   0x0800bece: 0600        lsls	r0, r0, #24
@   0x0800bed0: 1600        asrs	r0, r0, #24
@   0x0800bed2: 4a12        ldr	r2, [pc, #72]	@ (0xbf1c)
@   0x0800bed4: 2308        movs	r3, #8
@   0x0800bed6: 5ed1        ldrsh	r1, [r2, r3]
@   0x0800bed8: 230a        movs	r3, #10
@   0x0800beda: 5ed2        ldrsh	r2, [r2, r3]
@   0x0800bedc: f7fe        fc64 	bl	0xa7a8
@   0x0800bee0: 0600        lsls	r0, r0, #24
@   0x0800bee2: 1602        asrs	r2, r0, #24
@   0x0800bee4: 2001        movs	r0, #1
@   0x0800bee6: 4240        negs	r0, r0
@   0x0800bee8: 4282        cmp	r2, r0
@   0x0800beea: d014        beq.n	0xbf16
@   0x0800beec: 00d0        lsls	r0, r2, #3
@   0x0800beee: 1901        adds	r1, r0, r4
@   0x0800bef0: 7908        ldrb	r0, [r1, #4]
@   0x0800bef2: 2800        cmp	r0, #0
@   0x0800bef4: d10f        bne.n	0xbf16
@   0x0800bef6: 7148        strb	r0, [r1, #5]
@   0x0800bef8: 2001        movs	r0, #1
@   0x0800befa: 7108        strb	r0, [r1, #4]
@   0x0800befc: 4808        ldr	r0, [pc, #32]	@ (0xbf20)
@   0x0800befe: 6800        ldr	r0, [r0, #0]
@   0x0800bf00: 6008        str	r0, [r1, #0]
@   0x0800bf02: 2001        movs	r0, #1
@   0x0800bf04: 2100        movs	r1, #0
@   0x0800bf06: f027        fecd 	bl	0x33ca4
@   0x0800bf0a: 682a        ldr	r2, [r5, #0]
@   0x0800bf0c: 686b        ldr	r3, [r5, #4]
@   0x0800bf0e: 4302        orrs	r2, r0
@   0x0800bf10: 430b        orrs	r3, r1
@   0x0800bf12: 602a        str	r2, [r5, #0]
@   0x0800bf14: 606b        str	r3, [r5, #4]
@   0x0800bf16: bc30        pop	{r4, r5}
@   0x0800bf18: bc01        pop	{r0}
@   0x0800bf1a: 4700        bx	r0
@   0x0800bf1c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800bf1e: 0300        lsls	r0, r0, #12
@   0x0800bf20: 5330        strh	r0, [r6, r4]
@   0x0800bf22: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800BEBC
sub_0800BEBC: @ 0x0800bebc
        .incbin "frog_us_baserom.gba", 0xbebc, 0x68
        thumb_func_end sub_0800BEBC
