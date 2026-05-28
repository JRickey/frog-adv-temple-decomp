@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800be18, 0x0800bebc)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800be18 --end 0x800bebc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800be18: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800be1a: 4657        mov	r7, sl
@   0x0800be1c: 464e        mov	r6, r9
@   0x0800be1e: 4645        mov	r5, r8
@   0x0800be20: b4e0        push	{r5, r6, r7}
@   0x0800be22: b082        sub	sp, #8
@   0x0800be24: 4682        mov	sl, r0
@   0x0800be26: 9101        str	r1, [sp, #4]
@   0x0800be28: 2300        movs	r3, #0
@   0x0800be2a: 4c22        ldr	r4, [pc, #136]	@ (0xbeb4)
@   0x0800be2c: 0612        lsls	r2, r2, #24
@   0x0800be2e: 4691        mov	r9, r2
@   0x0800be30: 1610        asrs	r0, r2, #24
@   0x0800be32: 0041        lsls	r1, r0, #1
@   0x0800be34: 1809        adds	r1, r1, r0
@   0x0800be36: 0089        lsls	r1, r1, #2
@   0x0800be38: 1909        adds	r1, r1, r4
@   0x0800be3a: 2000        movs	r0, #0
@   0x0800be3c: 5608        ldrsb	r0, [r1, r0]
@   0x0800be3e: 4283        cmp	r3, r0
@   0x0800be40: da2b        bge.n	0xbe9a
@   0x0800be42: 2700        movs	r7, #0
@   0x0800be44: 46a0        mov	r8, r4
@   0x0800be46: 061b        lsls	r3, r3, #24
@   0x0800be48: 161d        asrs	r5, r3, #24
@   0x0800be4a: 00e8        lsls	r0, r5, #3
@   0x0800be4c: 4450        add	r0, sl
@   0x0800be4e: 7107        strb	r7, [r0, #4]
@   0x0800be50: 7147        strb	r7, [r0, #5]
@   0x0800be52: 7187        strb	r7, [r0, #6]
@   0x0800be54: 6007        str	r7, [r0, #0]
@   0x0800be56: 4648        mov	r0, r9
@   0x0800be58: 1606        asrs	r6, r0, #24
@   0x0800be5a: 4817        ldr	r0, [pc, #92]	@ (0xbeb8)
@   0x0800be5c: 7e00        ldrb	r0, [r0, #24]
@   0x0800be5e: 0074        lsls	r4, r6, #1
@   0x0800be60: 19a4        adds	r4, r4, r6
@   0x0800be62: 00a4        lsls	r4, r4, #2
@   0x0800be64: 4641        mov	r1, r8
@   0x0800be66: 3104        adds	r1, #4
@   0x0800be68: 1861        adds	r1, r4, r1
@   0x0800be6a: 6809        ldr	r1, [r1, #0]
@   0x0800be6c: 0d9b        lsrs	r3, r3, #22
@   0x0800be6e: 185b        adds	r3, r3, r1
@   0x0800be70: 2100        movs	r1, #0
@   0x0800be72: 5e5a        ldrsh	r2, [r3, r1]
@   0x0800be74: 2102        movs	r1, #2
@   0x0800be76: 5e5b        ldrsh	r3, [r3, r1]
@   0x0800be78: 4444        add	r4, r8
@   0x0800be7a: 7a21        ldrb	r1, [r4, #8]
@   0x0800be7c: 9100        str	r1, [sp, #0]
@   0x0800be7e: 2100        movs	r1, #0
@   0x0800be80: f000        fe7e 	bl	0xcb80
@   0x0800be84: 3501        adds	r5, #1
@   0x0800be86: 062d        lsls	r5, r5, #24
@   0x0800be88: 0070        lsls	r0, r6, #1
@   0x0800be8a: 1980        adds	r0, r0, r6
@   0x0800be8c: 0080        lsls	r0, r0, #2
@   0x0800be8e: 4440        add	r0, r8
@   0x0800be90: 0e2b        lsrs	r3, r5, #24
@   0x0800be92: 7800        ldrb	r0, [r0, #0]
@   0x0800be94: 0600        lsls	r0, r0, #24
@   0x0800be96: 4285        cmp	r5, r0
@   0x0800be98: dbd5        blt.n	0xbe46
@   0x0800be9a: 2000        movs	r0, #0
@   0x0800be9c: 2100        movs	r1, #0
@   0x0800be9e: 9a01        ldr	r2, [sp, #4]
@   0x0800bea0: 6010        str	r0, [r2, #0]
@   0x0800bea2: 6051        str	r1, [r2, #4]
@   0x0800bea4: b002        add	sp, #8
@   0x0800bea6: bc38        pop	{r3, r4, r5}
@   0x0800bea8: 4698        mov	r8, r3
@   0x0800beaa: 46a1        mov	r9, r4
@   0x0800beac: 46aa        mov	sl, r5
@   0x0800beae: bcf0        pop	{r4, r5, r6, r7}
@   0x0800beb0: bc01        pop	{r0}
@   0x0800beb2: 4700        bx	r0
@   0x0800beb4: 0b00        lsrs	r0, r0, #12
@   0x0800beb6: 080c        lsrs	r4, r1, #32
@   0x0800beb8: 35e0        adds	r5, #224	@ 0xe0
@   0x0800beba: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800BE18
sub_0800BE18: @ 0x0800be18
        .incbin "frog_us_baserom.gba", 0xbe18, 0xa4
        thumb_func_end sub_0800BE18
