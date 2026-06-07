@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031a48, 0x08031ab4)  (108 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031a48 --end 0x8031ab4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031a48: b530        push	{r4, r5, lr}
@   0x08031a4a: 1c02        adds	r2, r0, #0
@   0x08031a4c: 1c0c        adds	r4, r1, #0
@   0x08031a4e: 6825        ldr	r5, [r4, #0]
@   0x08031a50: 2a03        cmp	r2, #3
@   0x08031a52: dc07        bgt.n	0x31a64
@   0x08031a54: 4802        ldr	r0, [pc, #8]	@ (0x31a60)
@   0x08031a56: 0051        lsls	r1, r2, #1
@   0x08031a58: 31ac        adds	r1, #172	@ 0xac
@   0x08031a5a: 6800        ldr	r0, [r0, #0]
@   0x08031a5c: 1843        adds	r3, r0, r1
@   0x08031a5e: e009        b.n	0x31a74
@   0x08031a60: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031a62: 0300        lsls	r0, r0, #12
@   0x08031a64: 4809        ldr	r0, [pc, #36]	@ (0x31a8c)
@   0x08031a66: 6800        ldr	r0, [r0, #0]
@   0x08031a68: 30c8        adds	r0, #200	@ 0xc8
@   0x08031a6a: 0191        lsls	r1, r2, #6
@   0x08031a6c: 6800        ldr	r0, [r0, #0]
@   0x08031a6e: 1809        adds	r1, r1, r0
@   0x08031a70: 1c0b        adds	r3, r1, #0
@   0x08031a72: 3bcc        subs	r3, #204	@ 0xcc
@   0x08031a74: 8819        ldrh	r1, [r3, #0]
@   0x08031a76: 22ff        movs	r2, #255	@ 0xff
@   0x08031a78: 0212        lsls	r2, r2, #8
@   0x08031a7a: 400a        ands	r2, r1
@   0x08031a7c: 2001        movs	r0, #1
@   0x08031a7e: 5628        ldrsb	r0, [r5, r0]
@   0x08031a80: 4302        orrs	r2, r0
@   0x08031a82: 2a00        cmp	r2, #0
@   0x08031a84: da04        bge.n	0x31a90
@   0x08031a86: 2200        movs	r2, #0
@   0x08031a88: e005        b.n	0x31a96
@   0x08031a8a: 0000        movs	r0, r0
@   0x08031a8c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031a8e: 0300        lsls	r0, r0, #12
@   0x08031a90: 2aff        cmp	r2, #255	@ 0xff
@   0x08031a92: dd00        ble.n	0x31a96
@   0x08031a94: 22ff        movs	r2, #255	@ 0xff
@   0x08031a96: 20ff        movs	r0, #255	@ 0xff
@   0x08031a98: 0200        lsls	r0, r0, #8
@   0x08031a9a: 4008        ands	r0, r1
@   0x08031a9c: 0611        lsls	r1, r2, #24
@   0x08031a9e: 0e09        lsrs	r1, r1, #24
@   0x08031aa0: 4301        orrs	r1, r0
@   0x08031aa2: 8019        strh	r1, [r3, #0]
@   0x08031aa4: 6820        ldr	r0, [r4, #0]
@   0x08031aa6: 3002        adds	r0, #2
@   0x08031aa8: 6020        str	r0, [r4, #0]
@   0x08031aaa: 2001        movs	r0, #1
@   0x08031aac: bc30        pop	{r4, r5}
@   0x08031aae: bc02        pop	{r1}
@   0x08031ab0: 4708        bx	r1

        thumb_func_start sub_08031A48
sub_08031A48: @ 0x08031a48
        .incbin "frog_us_baserom.gba", 0x31a48, 0x6c
        thumb_func_end sub_08031A48
