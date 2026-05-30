@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013c60, 0x08013d1c)  (188 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013c60 --end 0x8013d1c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013c60: b570        push	{r4, r5, r6, lr}
@   0x08013c62: b084        sub	sp, #16
@   0x08013c64: 9000        str	r0, [sp, #0]
@   0x08013c66: 9101        str	r1, [sp, #4]
@   0x08013c68: 9202        str	r2, [sp, #8]
@   0x08013c6a: 9303        str	r3, [sp, #12]
@   0x08013c6c: 9908        ldr	r1, [sp, #32]
@   0x08013c6e: 9c09        ldr	r4, [sp, #36]	@ 0x24
@   0x08013c70: 0609        lsls	r1, r1, #24
@   0x08013c72: 0e09        lsrs	r1, r1, #24
@   0x08013c74: 2500        movs	r5, #0
@   0x08013c76: 4e15        ldr	r6, [pc, #84]	@ (0x13ccc)
@   0x08013c78: 6833        ldr	r3, [r6, #0]
@   0x08013c7a: 6862        ldr	r2, [r4, #4]
@   0x08013c7c: 1a98        subs	r0, r3, r2
@   0x08013c7e: 4288        cmp	r0, r1
@   0x08013c80: d201        bcs.n	0x13c86
@   0x08013c82: 4293        cmp	r3, r2
@   0x08013c84: d11c        bne.n	0x13cc0
@   0x08013c86: 7aa0        ldrb	r0, [r4, #10]
@   0x08013c88: 1c41        adds	r1, r0, #1
@   0x08013c8a: 72a1        strb	r1, [r4, #10]
@   0x08013c8c: 0600        lsls	r0, r0, #24
@   0x08013c8e: 9901        ldr	r1, [sp, #4]
@   0x08013c90: 0d80        lsrs	r0, r0, #22
@   0x08013c92: 1840        adds	r0, r0, r1
@   0x08013c94: 6800        ldr	r0, [r0, #0]
@   0x08013c96: 4a0e        ldr	r2, [pc, #56]	@ (0x13cd0)
@   0x08013c98: 6010        str	r0, [r2, #0]
@   0x08013c9a: 9802        ldr	r0, [sp, #8]
@   0x08013c9c: 6050        str	r0, [r2, #4]
@   0x08013c9e: 4668        mov	r0, sp
@   0x08013ca0: 8980        ldrh	r0, [r0, #12]
@   0x08013ca2: 0840        lsrs	r0, r0, #1
@   0x08013ca4: 2180        movs	r1, #128	@ 0x80
@   0x08013ca6: 0609        lsls	r1, r1, #24
@   0x08013ca8: 4308        orrs	r0, r1
@   0x08013caa: 6090        str	r0, [r2, #8]
@   0x08013cac: 6890        ldr	r0, [r2, #8]
@   0x08013cae: 4668        mov	r0, sp
@   0x08013cb0: 7aa1        ldrb	r1, [r4, #10]
@   0x08013cb2: 8800        ldrh	r0, [r0, #0]
@   0x08013cb4: 4281        cmp	r1, r0
@   0x08013cb6: d301        bcc.n	0x13cbc
@   0x08013cb8: 72a5        strb	r5, [r4, #10]
@   0x08013cba: 2501        movs	r5, #1
@   0x08013cbc: 6830        ldr	r0, [r6, #0]
@   0x08013cbe: 6060        str	r0, [r4, #4]
@   0x08013cc0: 1c28        adds	r0, r5, #0
@   0x08013cc2: b004        add	sp, #16
@   0x08013cc4: bc70        pop	{r4, r5, r6}
@   0x08013cc6: bc02        pop	{r1}
@   0x08013cc8: 4708        bx	r1
@   0x08013cca: 0000        movs	r0, r0
@   0x08013ccc: 5330        strh	r0, [r6, r4]
@   0x08013cce: 0300        lsls	r0, r0, #12
@   0x08013cd0: 00d4        lsls	r4, r2, #3
@   0x08013cd2: 0400        lsls	r0, r0, #16
@   0x08013cd4: b084        sub	sp, #16
@   0x08013cd6: b570        push	{r4, r5, r6, lr}
@   0x08013cd8: 9004        str	r0, [sp, #16]
@   0x08013cda: 9105        str	r1, [sp, #20]
@   0x08013cdc: 9206        str	r2, [sp, #24]
@   0x08013cde: 9307        str	r3, [sp, #28]
@   0x08013ce0: 990a        ldr	r1, [sp, #40]	@ 0x28
@   0x08013ce2: 9c0b        ldr	r4, [sp, #44]	@ 0x2c
@   0x08013ce4: 0609        lsls	r1, r1, #24
@   0x08013ce6: 0e09        lsrs	r1, r1, #24
@   0x08013ce8: 2500        movs	r5, #0
@   0x08013cea: 4e0b        ldr	r6, [pc, #44]	@ (0x13d18)
@   0x08013cec: 6833        ldr	r3, [r6, #0]
@   0x08013cee: 6862        ldr	r2, [r4, #4]
@   0x08013cf0: 1a98        subs	r0, r3, r2
@   0x08013cf2: 4288        cmp	r0, r1
@   0x08013cf4: d201        bcs.n	0x13cfa
@   0x08013cf6: 4293        cmp	r3, r2
@   0x08013cf8: d108        bne.n	0x13d0c
@   0x08013cfa: a804        add	r0, sp, #16
@   0x08013cfc: 7aa1        ldrb	r1, [r4, #10]
@   0x08013cfe: 8940        ldrh	r0, [r0, #10]
@   0x08013d00: 4281        cmp	r1, r0
@   0x08013d02: d301        bcc.n	0x13d08
@   0x08013d04: 72a5        strb	r5, [r4, #10]
@   0x08013d06: 2501        movs	r5, #1
@   0x08013d08: 6830        ldr	r0, [r6, #0]
@   0x08013d0a: 6060        str	r0, [r4, #4]
@   0x08013d0c: 1c28        adds	r0, r5, #0
@   0x08013d0e: bc70        pop	{r4, r5, r6}
@   0x08013d10: bc08        pop	{r3}
@   0x08013d12: b004        add	sp, #16
@   0x08013d14: 4718        bx	r3
@   0x08013d16: 0000        movs	r0, r0
@   0x08013d18: 5330        strh	r0, [r6, r4]
@   0x08013d1a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013C60
sub_08013C60: @ 0x08013c60
        .incbin "frog_us_baserom.gba", 0x13c60, 0xbc
        thumb_func_end sub_08013C60
