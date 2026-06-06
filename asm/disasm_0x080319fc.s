@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080319fc, 0x08031a48)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80319fc --end 0x8031a48 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080319fc: b510        push	{r4, lr}
@   0x080319fe: 1c02        adds	r2, r0, #0
@   0x08031a00: 1c0b        adds	r3, r1, #0
@   0x08031a02: 681c        ldr	r4, [r3, #0]
@   0x08031a04: 2a03        cmp	r2, #3
@   0x08031a06: dc07        bgt.n	0x31a18
@   0x08031a08: 4802        ldr	r0, [pc, #8]	@ (0x31a14)
@   0x08031a0a: 0051        lsls	r1, r2, #1
@   0x08031a0c: 31ac        adds	r1, #172	@ 0xac
@   0x08031a0e: 6800        ldr	r0, [r0, #0]
@   0x08031a10: 1841        adds	r1, r0, r1
@   0x08031a12: e008        b.n	0x31a26
@   0x08031a14: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031a16: 0300        lsls	r0, r0, #12
@   0x08031a18: 480a        ldr	r0, [pc, #40]	@ (0x31a44)
@   0x08031a1a: 6800        ldr	r0, [r0, #0]
@   0x08031a1c: 30c8        adds	r0, #200	@ 0xc8
@   0x08031a1e: 0191        lsls	r1, r2, #6
@   0x08031a20: 6800        ldr	r0, [r0, #0]
@   0x08031a22: 1809        adds	r1, r1, r0
@   0x08031a24: 39cc        subs	r1, #204	@ 0xcc
@   0x08031a26: 20ff        movs	r0, #255	@ 0xff
@   0x08031a28: 0200        lsls	r0, r0, #8
@   0x08031a2a: 880a        ldrh	r2, [r1, #0]
@   0x08031a2c: 4010        ands	r0, r2
@   0x08031a2e: 7864        ldrb	r4, [r4, #1]
@   0x08031a30: 4320        orrs	r0, r4
@   0x08031a32: 8008        strh	r0, [r1, #0]
@   0x08031a34: 6818        ldr	r0, [r3, #0]
@   0x08031a36: 3002        adds	r0, #2
@   0x08031a38: 6018        str	r0, [r3, #0]
@   0x08031a3a: 2001        movs	r0, #1
@   0x08031a3c: bc10        pop	{r4}
@   0x08031a3e: bc02        pop	{r1}
@   0x08031a40: 4708        bx	r1
@   0x08031a42: 0000        movs	r0, r0
@   0x08031a44: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031a46: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080319FC
sub_080319FC: @ 0x080319fc
        .incbin "frog_us_baserom.gba", 0x319fc, 0x4c
        thumb_func_end sub_080319FC
