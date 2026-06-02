@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022cd4, 0x08022d4c)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022cd4 --end 0x8022d4c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022cd4: b570        push	{r4, r5, r6, lr}
@   0x08022cd6: b084        sub	sp, #16
@   0x08022cd8: 2400        movs	r4, #0
@   0x08022cda: 4e19        ldr	r6, [pc, #100]	@ (0x22d40)
@   0x08022cdc: 2503        movs	r5, #3
@   0x08022cde: 1c20        adds	r0, r4, #0
@   0x08022ce0: 300c        adds	r0, #12
@   0x08022ce2: 00a1        lsls	r1, r4, #2
@   0x08022ce4: 1989        adds	r1, r1, r6
@   0x08022ce6: 6809        ldr	r1, [r1, #0]
@   0x08022ce8: 2281        movs	r2, #129	@ 0x81
@   0x08022cea: 9200        str	r2, [sp, #0]
@   0x08022cec: 2204        movs	r2, #4
@   0x08022cee: 9201        str	r2, [sp, #4]
@   0x08022cf0: 9502        str	r5, [sp, #8]
@   0x08022cf2: 9503        str	r5, [sp, #12]
@   0x08022cf4: 2280        movs	r2, #128	@ 0x80
@   0x08022cf6: 00d2        lsls	r2, r2, #3
@   0x08022cf8: 2314        movs	r3, #20
@   0x08022cfa: f7fe        f9d1 	bl	0x210a0
@   0x08022cfe: 1c60        adds	r0, r4, #1
@   0x08022d00: 0600        lsls	r0, r0, #24
@   0x08022d02: 0e04        lsrs	r4, r0, #24
@   0x08022d04: 2c0d        cmp	r4, #13
@   0x08022d06: d9ea        bls.n	0x22cde
@   0x08022d08: 2400        movs	r4, #0
@   0x08022d0a: 4d0e        ldr	r5, [pc, #56]	@ (0x22d44)
@   0x08022d0c: 1c2b        adds	r3, r5, #0
@   0x08022d0e: 2202        movs	r2, #2
@   0x08022d10: 1c20        adds	r0, r4, #0
@   0x08022d12: 300c        adds	r0, #12
@   0x08022d14: 00c1        lsls	r1, r0, #3
@   0x08022d16: 1a09        subs	r1, r1, r0
@   0x08022d18: 00c9        lsls	r1, r1, #3
@   0x08022d1a: 18c9        adds	r1, r1, r3
@   0x08022d1c: 718a        strb	r2, [r1, #6]
@   0x08022d1e: 1c60        adds	r0, r4, #1
@   0x08022d20: 0600        lsls	r0, r0, #24
@   0x08022d22: 0e04        lsrs	r4, r0, #24
@   0x08022d24: 2c05        cmp	r4, #5
@   0x08022d26: d9f3        bls.n	0x22d10
@   0x08022d28: 4807        ldr	r0, [pc, #28]	@ (0x22d48)
@   0x08022d2a: 1829        adds	r1, r5, r0
@   0x08022d2c: 2002        movs	r0, #2
@   0x08022d2e: 7008        strb	r0, [r1, #0]
@   0x08022d30: 200c        movs	r0, #12
@   0x08022d32: f7e3        fb5b 	bl	0x63ec
@   0x08022d36: b004        add	sp, #16
@   0x08022d38: bc70        pop	{r4, r5, r6}
@   0x08022d3a: bc01        pop	{r0}
@   0x08022d3c: 4700        bx	r0
@   0x08022d3e: 0000        movs	r0, r0
@   0x08022d40: 16b8        asrs	r0, r7, #26
@   0x08022d42: 0831        lsrs	r1, r6, #32
@   0x08022d44: 3720        adds	r7, #32
@   0x08022d46: 0300        lsls	r0, r0, #12
@   0x08022d48: 057e        lsls	r6, r7, #21

        thumb_func_start sub_08022CD4
sub_08022CD4: @ 0x08022cd4
        .incbin "frog_us_baserom.gba", 0x22cd4, 0x78
        thumb_func_end sub_08022CD4
