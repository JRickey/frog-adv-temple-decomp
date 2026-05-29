@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d070, 0x0800d0f8)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d070 --end 0x800d0f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d070: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800d072: 464f        mov	r7, r9
@   0x0800d074: 4646        mov	r6, r8
@   0x0800d076: b4c0        push	{r6, r7}
@   0x0800d078: 4680        mov	r8, r0
@   0x0800d07a: 4a1a        ldr	r2, [pc, #104]	@ (0xd0e4)
@   0x0800d07c: 4b1a        ldr	r3, [pc, #104]	@ (0xd0e8)
@   0x0800d07e: 18d0        adds	r0, r2, r3
@   0x0800d080: 8803        ldrh	r3, [r0, #0]
@   0x0800d082: 3b02        subs	r3, #2
@   0x0800d084: 041b        lsls	r3, r3, #16
@   0x0800d086: 4819        ldr	r0, [pc, #100]	@ (0xd0ec)
@   0x0800d088: 4681        mov	r9, r0
@   0x0800d08a: 4819        ldr	r0, [pc, #100]	@ (0xd0f0)
@   0x0800d08c: 1812        adds	r2, r2, r0
@   0x0800d08e: 8810        ldrh	r0, [r2, #0]
@   0x0800d090: 3802        subs	r0, #2
@   0x0800d092: 0400        lsls	r0, r0, #16
@   0x0800d094: 4e17        ldr	r6, [pc, #92]	@ (0xd0f4)
@   0x0800d096: 0c1f        lsrs	r7, r3, #16
@   0x0800d098: 4307        orrs	r7, r0
@   0x0800d09a: 060d        lsls	r5, r1, #24
@   0x0800d09c: 162d        asrs	r5, r5, #24
@   0x0800d09e: 1c28        adds	r0, r5, #0
@   0x0800d0a0: 2105        movs	r1, #5
@   0x0800d0a2: f026        fe37 	bl	0x33d14
@   0x0800d0a6: 1c04        adds	r4, r0, #0
@   0x0800d0a8: 0624        lsls	r4, r4, #24
@   0x0800d0aa: 0e24        lsrs	r4, r4, #24
@   0x0800d0ac: 1c28        adds	r0, r5, #0
@   0x0800d0ae: 2105        movs	r1, #5
@   0x0800d0b0: f026        feb0 	bl	0x33e14
@   0x0800d0b4: 1439        asrs	r1, r7, #16
@   0x0800d0b6: 0624        lsls	r4, r4, #24
@   0x0800d0b8: 1624        asrs	r4, r4, #24
@   0x0800d0ba: 1864        adds	r4, r4, r1
@   0x0800d0bc: 0424        lsls	r4, r4, #16
@   0x0800d0be: 4037        ands	r7, r6
@   0x0800d0c0: 4327        orrs	r7, r4
@   0x0800d0c2: 0600        lsls	r0, r0, #24
@   0x0800d0c4: 1600        asrs	r0, r0, #24
@   0x0800d0c6: 19c0        adds	r0, r0, r7
@   0x0800d0c8: 0400        lsls	r0, r0, #16
@   0x0800d0ca: 0c00        lsrs	r0, r0, #16
@   0x0800d0cc: 4649        mov	r1, r9
@   0x0800d0ce: 400f        ands	r7, r1
@   0x0800d0d0: 4307        orrs	r7, r0
@   0x0800d0d2: 4643        mov	r3, r8
@   0x0800d0d4: 601f        str	r7, [r3, #0]
@   0x0800d0d6: 4640        mov	r0, r8
@   0x0800d0d8: bc18        pop	{r3, r4}
@   0x0800d0da: 4698        mov	r8, r3
@   0x0800d0dc: 46a1        mov	r9, r4
@   0x0800d0de: bcf0        pop	{r4, r5, r6, r7}
@   0x0800d0e0: bc02        pop	{r1}
@   0x0800d0e2: 4708        bx	r1
@   0x0800d0e4: 3720        adds	r7, #32
@   0x0800d0e6: 0300        lsls	r0, r0, #12
@   0x0800d0e8: 0692        lsls	r2, r2, #26
@   0x0800d0ea: 0000        movs	r0, r0
@   0x0800d0ec: 0000        movs	r0, r0
@   0x0800d0ee: ffff        0694 	vqshlu.s64	d16, d4, #63	@ 0x3f
@   0x0800d0f2: 0000        movs	r0, r0
@   0x0800d0f4: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0

        thumb_func_start sub_0800D070
sub_0800D070: @ 0x0800d070
        .incbin "frog_us_baserom.gba", 0xd070, 0x88
        thumb_func_end sub_0800D070
