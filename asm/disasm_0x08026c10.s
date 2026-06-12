@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026c10, 0x08026c68)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026c10 --end 0x8026c68 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026c10: b570        push	{r4, r5, r6, lr}
@   0x08026c12: b084        sub	sp, #16
@   0x08026c14: 2600        movs	r6, #0
@   0x08026c16: 1c35        adds	r5, r6, #0
@   0x08026c18: 3533        adds	r5, #51	@ 0x33
@   0x08026c1a: 4911        ldr	r1, [pc, #68]	@ (0x26c60)
@   0x08026c1c: 00b0        lsls	r0, r6, #2
@   0x08026c1e: 1840        adds	r0, r0, r1
@   0x08026c20: 6804        ldr	r4, [r0, #0]
@   0x08026c22: 1c30        adds	r0, r6, #0
@   0x08026c24: 210c        movs	r1, #12
@   0x08026c26: f00d        f999 	bl	0x33f5c
@   0x08026c2a: 0600        lsls	r0, r0, #24
@   0x08026c2c: 0900        lsrs	r0, r0, #4
@   0x08026c2e: 490d        ldr	r1, [pc, #52]	@ (0x26c64)
@   0x08026c30: 1840        adds	r0, r0, r1
@   0x08026c32: 0c00        lsrs	r0, r0, #16
@   0x08026c34: 9000        str	r0, [sp, #0]
@   0x08026c36: 2002        movs	r0, #2
@   0x08026c38: 9001        str	r0, [sp, #4]
@   0x08026c3a: 2003        movs	r0, #3
@   0x08026c3c: 9002        str	r0, [sp, #8]
@   0x08026c3e: 9003        str	r0, [sp, #12]
@   0x08026c40: 1c28        adds	r0, r5, #0
@   0x08026c42: 1c21        adds	r1, r4, #0
@   0x08026c44: 2210        movs	r2, #16
@   0x08026c46: 2330        movs	r3, #48	@ 0x30
@   0x08026c48: f7fa        fa2a 	bl	0x210a0
@   0x08026c4c: 1c70        adds	r0, r6, #1
@   0x08026c4e: 0600        lsls	r0, r0, #24
@   0x08026c50: 0e06        lsrs	r6, r0, #24
@   0x08026c52: 2e18        cmp	r6, #24
@   0x08026c54: d9df        bls.n	0x26c16
@   0x08026c56: b004        add	sp, #16
@   0x08026c58: bc70        pop	{r4, r5, r6}
@   0x08026c5a: bc01        pop	{r0}
@   0x08026c5c: 4700        bx	r0
@   0x08026c5e: 0000        movs	r0, r0
@   0x08026c60: 5ae0        ldrh	r0, [r4, r3]
@   0x08026c62: 0831        lsrs	r1, r6, #32
@   0x08026c64: 0000        movs	r0, r0
@   0x08026c66: 0141        lsls	r1, r0, #5

        thumb_func_start sub_08026C10
sub_08026C10: @ 0x08026c10
        .incbin "baserom.gba", 0x26c10, 0x58
        thumb_func_end sub_08026C10
