@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019e28, 0x08019e6c)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019e28 --end 0x8019e6c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019e28: 2801        cmp	r0, #1
@   0x08019e2a: d00e        beq.n	0x19e4a
@   0x08019e2c: 2801        cmp	r0, #1
@   0x08019e2e: dc02        bgt.n	0x19e36
@   0x08019e30: 2800        cmp	r0, #0
@   0x08019e32: d005        beq.n	0x19e40
@   0x08019e34: e019        b.n	0x19e6a
@   0x08019e36: 2802        cmp	r0, #2
@   0x08019e38: d00c        beq.n	0x19e54
@   0x08019e3a: 2803        cmp	r0, #3
@   0x08019e3c: d00f        beq.n	0x19e5e
@   0x08019e3e: e014        b.n	0x19e6a
@   0x08019e40: 2180        movs	r1, #128	@ 0x80
@   0x08019e42: 04c9        lsls	r1, r1, #19
@   0x08019e44: 2280        movs	r2, #128	@ 0x80
@   0x08019e46: 0052        lsls	r2, r2, #1
@   0x08019e48: e00d        b.n	0x19e66
@   0x08019e4a: 2180        movs	r1, #128	@ 0x80
@   0x08019e4c: 04c9        lsls	r1, r1, #19
@   0x08019e4e: 2280        movs	r2, #128	@ 0x80
@   0x08019e50: 0092        lsls	r2, r2, #2
@   0x08019e52: e008        b.n	0x19e66
@   0x08019e54: 2180        movs	r1, #128	@ 0x80
@   0x08019e56: 04c9        lsls	r1, r1, #19
@   0x08019e58: 2280        movs	r2, #128	@ 0x80
@   0x08019e5a: 00d2        lsls	r2, r2, #3
@   0x08019e5c: e003        b.n	0x19e66
@   0x08019e5e: 2180        movs	r1, #128	@ 0x80
@   0x08019e60: 04c9        lsls	r1, r1, #19
@   0x08019e62: 2280        movs	r2, #128	@ 0x80
@   0x08019e64: 0112        lsls	r2, r2, #4
@   0x08019e66: 1c10        adds	r0, r2, #0
@   0x08019e68: 8008        strh	r0, [r1, #0]
@   0x08019e6a: 4770        bx	lr

        thumb_func_start sub_08019E28
sub_08019E28: @ 0x08019e28
        .incbin "frog_us_baserom.gba", 0x19e28, 0x44
        thumb_func_end sub_08019E28
