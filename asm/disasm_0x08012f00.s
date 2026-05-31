@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012f00, 0x08012fa0)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012f00 --end 0x8012fa0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012f00: b510        push	{r4, lr}
@   0x08012f02: 2300        movs	r3, #0
@   0x08012f04: 4a07        ldr	r2, [pc, #28]	@ (0x12f24)
@   0x08012f06: 1c10        adds	r0, r2, #0
@   0x08012f08: 30d3        adds	r0, #211	@ 0xd3
@   0x08012f0a: 7800        ldrb	r0, [r0, #0]
@   0x08012f0c: 4118        asrs	r0, r3
@   0x08012f0e: 2101        movs	r1, #1
@   0x08012f10: 4008        ands	r0, r1
@   0x08012f12: 2800        cmp	r0, #0
@   0x08012f14: d03c        beq.n	0x12f90
@   0x08012f16: 2b07        cmp	r3, #7
@   0x08012f18: d83a        bhi.n	0x12f90
@   0x08012f1a: 0098        lsls	r0, r3, #2
@   0x08012f1c: 4902        ldr	r1, [pc, #8]	@ (0x12f28)
@   0x08012f1e: 1840        adds	r0, r0, r1
@   0x08012f20: 6800        ldr	r0, [r0, #0]
@   0x08012f22: 4687        mov	pc, r0
@   0x08012f24: 3610        adds	r6, #16
@   0x08012f26: 0300        lsls	r0, r0, #12
@   0x08012f28: 2f2c        cmp	r7, #44	@ 0x2c
@   0x08012f2a: 0801        lsrs	r1, r0, #32
@   0x08012f2c: 2f4c        cmp	r7, #76	@ 0x4c
@   0x08012f2e: 0801        lsrs	r1, r0, #32
@   0x08012f30: 2f54        cmp	r7, #84	@ 0x54
@   0x08012f32: 0801        lsrs	r1, r0, #32
@   0x08012f34: 2f5c        cmp	r7, #92	@ 0x5c
@   0x08012f36: 0801        lsrs	r1, r0, #32
@   0x08012f38: 2f64        cmp	r7, #100	@ 0x64
@   0x08012f3a: 0801        lsrs	r1, r0, #32
@   0x08012f3c: 2f6c        cmp	r7, #108	@ 0x6c
@   0x08012f3e: 0801        lsrs	r1, r0, #32
@   0x08012f40: 2f74        cmp	r7, #116	@ 0x74
@   0x08012f42: 0801        lsrs	r1, r0, #32
@   0x08012f44: 2f7c        cmp	r7, #124	@ 0x7c
@   0x08012f46: 0801        lsrs	r1, r0, #32
@   0x08012f48: 2f84        cmp	r7, #132	@ 0x84
@   0x08012f4a: 0801        lsrs	r1, r0, #32
@   0x08012f4c: 1c10        adds	r0, r2, #0
@   0x08012f4e: 30d4        adds	r0, #212	@ 0xd4
@   0x08012f50: 2120        movs	r1, #32
@   0x08012f52: e01a        b.n	0x12f8a
@   0x08012f54: 1c10        adds	r0, r2, #0
@   0x08012f56: 30d4        adds	r0, #212	@ 0xd4
@   0x08012f58: 2110        movs	r1, #16
@   0x08012f5a: e016        b.n	0x12f8a
@   0x08012f5c: 1c10        adds	r0, r2, #0
@   0x08012f5e: 30d4        adds	r0, #212	@ 0xd4
@   0x08012f60: 2180        movs	r1, #128	@ 0x80
@   0x08012f62: e012        b.n	0x12f8a
@   0x08012f64: 1c10        adds	r0, r2, #0
@   0x08012f66: 30d4        adds	r0, #212	@ 0xd4
@   0x08012f68: 2140        movs	r1, #64	@ 0x40
@   0x08012f6a: e00e        b.n	0x12f8a
@   0x08012f6c: 1c10        adds	r0, r2, #0
@   0x08012f6e: 30d4        adds	r0, #212	@ 0xd4
@   0x08012f70: 2102        movs	r1, #2
@   0x08012f72: e00a        b.n	0x12f8a
@   0x08012f74: 1c10        adds	r0, r2, #0
@   0x08012f76: 30d4        adds	r0, #212	@ 0xd4
@   0x08012f78: 2101        movs	r1, #1
@   0x08012f7a: e006        b.n	0x12f8a
@   0x08012f7c: 1c10        adds	r0, r2, #0
@   0x08012f7e: 30d4        adds	r0, #212	@ 0xd4
@   0x08012f80: 2108        movs	r1, #8
@   0x08012f82: e002        b.n	0x12f8a
@   0x08012f84: 1c10        adds	r0, r2, #0
@   0x08012f86: 30d4        adds	r0, #212	@ 0xd4
@   0x08012f88: 2104        movs	r1, #4
@   0x08012f8a: 7804        ldrb	r4, [r0, #0]
@   0x08012f8c: 4321        orrs	r1, r4
@   0x08012f8e: 7001        strb	r1, [r0, #0]
@   0x08012f90: 1c58        adds	r0, r3, #1
@   0x08012f92: 0600        lsls	r0, r0, #24
@   0x08012f94: 0e03        lsrs	r3, r0, #24
@   0x08012f96: 2b07        cmp	r3, #7
@   0x08012f98: d9b5        bls.n	0x12f06
@   0x08012f9a: bc10        pop	{r4}
@   0x08012f9c: bc01        pop	{r0}
@   0x08012f9e: 4700        bx	r0

        thumb_func_start sub_08012F00
sub_08012F00: @ 0x08012f00
        .incbin "frog_us_baserom.gba", 0x12f00, 0xa0
        thumb_func_end sub_08012F00
