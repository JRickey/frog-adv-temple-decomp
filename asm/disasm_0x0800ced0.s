@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ced0, 0x0800cfdc)  (268 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ced0 --end 0x800cfdc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ced0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800ced2: 464f        mov	r7, r9
@   0x0800ced4: 4646        mov	r6, r8
@   0x0800ced6: b4c0        push	{r6, r7}
@   0x0800ced8: 4684        mov	ip, r0
@   0x0800ceda: 1c15        adds	r5, r2, #0
@   0x0800cedc: 1c0c        adds	r4, r1, #0
@   0x0800cede: 9807        ldr	r0, [sp, #28]
@   0x0800cee0: 041b        lsls	r3, r3, #16
@   0x0800cee2: 0c1b        lsrs	r3, r3, #16
@   0x0800cee4: 0400        lsls	r0, r0, #16
@   0x0800cee6: 1400        asrs	r0, r0, #16
@   0x0800cee8: 4681        mov	r9, r0
@   0x0800ceea: 1a20        subs	r0, r4, r0
@   0x0800ceec: 0400        lsls	r0, r0, #16
@   0x0800ceee: 0c00        lsrs	r0, r0, #16
@   0x0800cef0: 4928        ldr	r1, [pc, #160]	@ (0xcf94)
@   0x0800cef2: 4688        mov	r8, r1
@   0x0800cef4: 4642        mov	r2, r8
@   0x0800cef6: 4022        ands	r2, r4
@   0x0800cef8: 4302        orrs	r2, r0
@   0x0800cefa: 1c14        adds	r4, r2, #0
@   0x0800cefc: 1c21        adds	r1, r4, #0
@   0x0800cefe: 0408        lsls	r0, r1, #16
@   0x0800cf00: 2800        cmp	r0, #0
@   0x0800cf02: da00        bge.n	0xcf06
@   0x0800cf04: 2100        movs	r1, #0
@   0x0800cf06: 0409        lsls	r1, r1, #16
@   0x0800cf08: 0c09        lsrs	r1, r1, #16
@   0x0800cf0a: 4640        mov	r0, r8
@   0x0800cf0c: 4010        ands	r0, r2
@   0x0800cf0e: 4308        orrs	r0, r1
@   0x0800cf10: 1402        asrs	r2, r0, #16
@   0x0800cf12: 0419        lsls	r1, r3, #16
@   0x0800cf14: 140e        asrs	r6, r1, #16
@   0x0800cf16: 1b92        subs	r2, r2, r6
@   0x0800cf18: 0412        lsls	r2, r2, #16
@   0x0800cf1a: 4f1f        ldr	r7, [pc, #124]	@ (0xcf98)
@   0x0800cf1c: 1c39        adds	r1, r7, #0
@   0x0800cf1e: 4001        ands	r1, r0
@   0x0800cf20: 4311        orrs	r1, r2
@   0x0800cf22: 1408        asrs	r0, r1, #16
@   0x0800cf24: 1c02        adds	r2, r0, #0
@   0x0800cf26: 2800        cmp	r0, #0
@   0x0800cf28: da00        bge.n	0xcf2c
@   0x0800cf2a: 2200        movs	r2, #0
@   0x0800cf2c: 0410        lsls	r0, r2, #16
@   0x0800cf2e: 1c3b        adds	r3, r7, #0
@   0x0800cf30: 400b        ands	r3, r1
@   0x0800cf32: 4303        orrs	r3, r0
@   0x0800cf34: 1c1c        adds	r4, r3, #0
@   0x0800cf36: 0070        lsls	r0, r6, #1
@   0x0800cf38: 1828        adds	r0, r5, r0
@   0x0800cf3a: 0400        lsls	r0, r0, #16
@   0x0800cf3c: 0c00        lsrs	r0, r0, #16
@   0x0800cf3e: 4641        mov	r1, r8
@   0x0800cf40: 4029        ands	r1, r5
@   0x0800cf42: 4301        orrs	r1, r0
@   0x0800cf44: 1408        asrs	r0, r1, #16
@   0x0800cf46: 464e        mov	r6, r9
@   0x0800cf48: 0072        lsls	r2, r6, #1
@   0x0800cf4a: 1880        adds	r0, r0, r2
@   0x0800cf4c: 0400        lsls	r0, r0, #16
@   0x0800cf4e: 1c3a        adds	r2, r7, #0
@   0x0800cf50: 400a        ands	r2, r1
@   0x0800cf52: 4302        orrs	r2, r0
@   0x0800cf54: 1c15        adds	r5, r2, #0
@   0x0800cf56: 4667        mov	r7, ip
@   0x0800cf58: 2102        movs	r1, #2
@   0x0800cf5a: 5e78        ldrsh	r0, [r7, r1]
@   0x0800cf5c: 141b        asrs	r3, r3, #16
@   0x0800cf5e: 2600        movs	r6, #0
@   0x0800cf60: 4298        cmp	r0, r3
@   0x0800cf62: db10        blt.n	0xcf86
@   0x0800cf64: 1c01        adds	r1, r0, #0
@   0x0800cf66: 0428        lsls	r0, r5, #16
@   0x0800cf68: 1400        asrs	r0, r0, #16
@   0x0800cf6a: 1818        adds	r0, r3, r0
@   0x0800cf6c: 4281        cmp	r1, r0
@   0x0800cf6e: dc0a        bgt.n	0xcf86
@   0x0800cf70: 2304        movs	r3, #4
@   0x0800cf72: 5ef9        ldrsh	r1, [r7, r3]
@   0x0800cf74: 0420        lsls	r0, r4, #16
@   0x0800cf76: 1403        asrs	r3, r0, #16
@   0x0800cf78: 4299        cmp	r1, r3
@   0x0800cf7a: db04        blt.n	0xcf86
@   0x0800cf7c: 1410        asrs	r0, r2, #16
@   0x0800cf7e: 1818        adds	r0, r3, r0
@   0x0800cf80: 4281        cmp	r1, r0
@   0x0800cf82: dc00        bgt.n	0xcf86
@   0x0800cf84: 2601        movs	r6, #1
@   0x0800cf86: 1c30        adds	r0, r6, #0
@   0x0800cf88: bc18        pop	{r3, r4}
@   0x0800cf8a: 4698        mov	r8, r3
@   0x0800cf8c: 46a1        mov	r9, r4
@   0x0800cf8e: bcf0        pop	{r4, r5, r6, r7}
@   0x0800cf90: bc02        pop	{r1}
@   0x0800cf92: 4708        bx	r1
@   0x0800cf94: 0000        movs	r0, r0
@   0x0800cf96: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0800cf9a: 0000        movs	r0, r0
@   0x0800cf9c: b530        push	{r4, r5, lr}
@   0x0800cf9e: 1c05        adds	r5, r0, #0
@   0x0800cfa0: 1c13        adds	r3, r2, #0
@   0x0800cfa2: 1c0a        adds	r2, r1, #0
@   0x0800cfa4: 2102        movs	r1, #2
@   0x0800cfa6: 5e68        ldrsh	r0, [r5, r1]
@   0x0800cfa8: 1414        asrs	r4, r2, #16
@   0x0800cfaa: 42a0        cmp	r0, r4
@   0x0800cfac: db11        blt.n	0xcfd2
@   0x0800cfae: 1c01        adds	r1, r0, #0
@   0x0800cfb0: 0418        lsls	r0, r3, #16
@   0x0800cfb2: 1400        asrs	r0, r0, #16
@   0x0800cfb4: 1820        adds	r0, r4, r0
@   0x0800cfb6: 4281        cmp	r1, r0
@   0x0800cfb8: dc0b        bgt.n	0xcfd2
@   0x0800cfba: 2004        movs	r0, #4
@   0x0800cfbc: 5e29        ldrsh	r1, [r5, r0]
@   0x0800cfbe: 0410        lsls	r0, r2, #16
@   0x0800cfc0: 1404        asrs	r4, r0, #16
@   0x0800cfc2: 42a1        cmp	r1, r4
@   0x0800cfc4: db05        blt.n	0xcfd2
@   0x0800cfc6: 1418        asrs	r0, r3, #16
@   0x0800cfc8: 1820        adds	r0, r4, r0
@   0x0800cfca: 4281        cmp	r1, r0
@   0x0800cfcc: dc01        bgt.n	0xcfd2
@   0x0800cfce: 2001        movs	r0, #1
@   0x0800cfd0: e000        b.n	0xcfd4
@   0x0800cfd2: 2000        movs	r0, #0
@   0x0800cfd4: bc30        pop	{r4, r5}
@   0x0800cfd6: bc02        pop	{r1}
@   0x0800cfd8: 4708        bx	r1

        thumb_func_start sub_0800CED0
sub_0800CED0: @ 0x0800ced0
        .incbin "frog_us_baserom.gba", 0xced0, 0x10c
        thumb_func_end sub_0800CED0
