@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031c04, 0x08031c64)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031c04 --end 0x8031c64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031c04: b510        push	{r4, lr}
@   0x08031c06: 1c02        adds	r2, r0, #0
@   0x08031c08: 1c0c        adds	r4, r1, #0
@   0x08031c0a: 2a03        cmp	r2, #3
@   0x08031c0c: dc08        bgt.n	0x31c20
@   0x08031c0e: 4803        ldr	r0, [pc, #12]	@ (0x31c1c)
@   0x08031c10: 0091        lsls	r1, r2, #2
@   0x08031c12: 3110        adds	r1, #16
@   0x08031c14: 6800        ldr	r0, [r0, #0]
@   0x08031c16: 1841        adds	r1, r0, r1
@   0x08031c18: e009        b.n	0x31c2e
@   0x08031c1a: 0000        movs	r0, r0
@   0x08031c1c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031c1e: 0300        lsls	r0, r0, #12
@   0x08031c20: 480f        ldr	r0, [pc, #60]	@ (0x31c60)
@   0x08031c22: 6800        ldr	r0, [r0, #0]
@   0x08031c24: 30c8        adds	r0, #200	@ 0xc8
@   0x08031c26: 0191        lsls	r1, r2, #6
@   0x08031c28: 6800        ldr	r0, [r0, #0]
@   0x08031c2a: 1809        adds	r1, r1, r0
@   0x08031c2c: 39c8        subs	r1, #200	@ 0xc8
@   0x08031c2e: 680b        ldr	r3, [r1, #0]
@   0x08031c30: 2001        movs	r0, #1
@   0x08031c32: 4018        ands	r0, r3
@   0x08031c34: 2800        cmp	r0, #0
@   0x08031c36: d00c        beq.n	0x31c52
@   0x08031c38: 2210        movs	r2, #16
@   0x08031c3a: 431a        orrs	r2, r3
@   0x08031c3c: 600a        str	r2, [r1, #0]
@   0x08031c3e: 2306        movs	r3, #6
@   0x08031c40: 1c10        adds	r0, r2, #0
@   0x08031c42: 4018        ands	r0, r3
@   0x08031c44: 2802        cmp	r0, #2
@   0x08031c46: d804        bhi.n	0x31c52
@   0x08031c48: 2007        movs	r0, #7
@   0x08031c4a: 4240        negs	r0, r0
@   0x08031c4c: 4002        ands	r2, r0
@   0x08031c4e: 431a        orrs	r2, r3
@   0x08031c50: 600a        str	r2, [r1, #0]
@   0x08031c52: 6820        ldr	r0, [r4, #0]
@   0x08031c54: 3002        adds	r0, #2
@   0x08031c56: 6020        str	r0, [r4, #0]
@   0x08031c58: 2001        movs	r0, #1
@   0x08031c5a: bc10        pop	{r4}
@   0x08031c5c: bc02        pop	{r1}
@   0x08031c5e: 4708        bx	r1
@   0x08031c60: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031c62: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08031C04
sub_08031C04: @ 0x08031c04
        .incbin "frog_us_baserom.gba", 0x31c04, 0x60
        thumb_func_end sub_08031C04
