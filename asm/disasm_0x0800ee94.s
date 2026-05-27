@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ee94, 0x0800ef58)  (196 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ee94 --end 0x800ef58 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ee94: 0600        lsls	r0, r0, #24
@   0x0800ee96: 0e00        lsrs	r0, r0, #24
@   0x0800ee98: 1c01        adds	r1, r0, #0
@   0x0800ee9a: 2801        cmp	r0, #1
@   0x0800ee9c: d00f        beq.n	0xeebe
@   0x0800ee9e: 2801        cmp	r0, #1
@   0x0800eea0: dc02        bgt.n	0xeea8
@   0x0800eea2: 2800        cmp	r0, #0
@   0x0800eea4: d005        beq.n	0xeeb2
@   0x0800eea6: e01e        b.n	0xeee6
@   0x0800eea8: 2902        cmp	r1, #2
@   0x0800eeaa: d00e        beq.n	0xeeca
@   0x0800eeac: 2903        cmp	r1, #3
@   0x0800eeae: d012        beq.n	0xeed6
@   0x0800eeb0: e019        b.n	0xeee6
@   0x0800eeb2: 2080        movs	r0, #128	@ 0x80
@   0x0800eeb4: 04c0        lsls	r0, r0, #19
@   0x0800eeb6: 8801        ldrh	r1, [r0, #0]
@   0x0800eeb8: 2380        movs	r3, #128	@ 0x80
@   0x0800eeba: 005b        lsls	r3, r3, #1
@   0x0800eebc: e010        b.n	0xeee0
@   0x0800eebe: 2080        movs	r0, #128	@ 0x80
@   0x0800eec0: 04c0        lsls	r0, r0, #19
@   0x0800eec2: 8801        ldrh	r1, [r0, #0]
@   0x0800eec4: 2380        movs	r3, #128	@ 0x80
@   0x0800eec6: 009b        lsls	r3, r3, #2
@   0x0800eec8: e00a        b.n	0xeee0
@   0x0800eeca: 2080        movs	r0, #128	@ 0x80
@   0x0800eecc: 04c0        lsls	r0, r0, #19
@   0x0800eece: 8801        ldrh	r1, [r0, #0]
@   0x0800eed0: 2380        movs	r3, #128	@ 0x80
@   0x0800eed2: 00db        lsls	r3, r3, #3
@   0x0800eed4: e004        b.n	0xeee0
@   0x0800eed6: 2080        movs	r0, #128	@ 0x80
@   0x0800eed8: 04c0        lsls	r0, r0, #19
@   0x0800eeda: 8801        ldrh	r1, [r0, #0]
@   0x0800eedc: 2380        movs	r3, #128	@ 0x80
@   0x0800eede: 011b        lsls	r3, r3, #4
@   0x0800eee0: 1c1a        adds	r2, r3, #0
@   0x0800eee2: 4311        orrs	r1, r2
@   0x0800eee4: 8001        strh	r1, [r0, #0]
@   0x0800eee6: 4770        bx	lr
@   0x0800eee8: b510        push	{r4, lr}
@   0x0800eeea: 0600        lsls	r0, r0, #24
@   0x0800eeec: 0e02        lsrs	r2, r0, #24
@   0x0800eeee: 1c13        adds	r3, r2, #0
@   0x0800eef0: 2180        movs	r1, #128	@ 0x80
@   0x0800eef2: 04c9        lsls	r1, r1, #19
@   0x0800eef4: 2482        movs	r4, #130	@ 0x82
@   0x0800eef6: 0164        lsls	r4, r4, #5
@   0x0800eef8: 1c20        adds	r0, r4, #0
@   0x0800eefa: 8008        strh	r0, [r1, #0]
@   0x0800eefc: 2a02        cmp	r2, #2
@   0x0800eefe: d00e        beq.n	0xef1e
@   0x0800ef00: 2a02        cmp	r2, #2
@   0x0800ef02: dc02        bgt.n	0xef0a
@   0x0800ef04: 2a01        cmp	r2, #1
@   0x0800ef06: d003        beq.n	0xef10
@   0x0800ef08: e022        b.n	0xef50
@   0x0800ef0a: 2b03        cmp	r3, #3
@   0x0800ef0c: d014        beq.n	0xef38
@   0x0800ef0e: e01f        b.n	0xef50
@   0x0800ef10: 2000        movs	r0, #0
@   0x0800ef12: f7ff        ffbf 	bl	0xee94
@   0x0800ef16: 2001        movs	r0, #1
@   0x0800ef18: f7ff        ff8c 	bl	0xee34
@   0x0800ef1c: e005        b.n	0xef2a
@   0x0800ef1e: 2000        movs	r0, #0
@   0x0800ef20: f7ff        ffb8 	bl	0xee94
@   0x0800ef24: 2001        movs	r0, #1
@   0x0800ef26: f7ff        ffb5 	bl	0xee94
@   0x0800ef2a: 2002        movs	r0, #2
@   0x0800ef2c: f7ff        ff82 	bl	0xee34
@   0x0800ef30: 2003        movs	r0, #3
@   0x0800ef32: f7ff        ffaf 	bl	0xee94
@   0x0800ef36: e00b        b.n	0xef50
@   0x0800ef38: 2000        movs	r0, #0
@   0x0800ef3a: f7ff        ffab 	bl	0xee94
@   0x0800ef3e: 2001        movs	r0, #1
@   0x0800ef40: f7ff        ffa8 	bl	0xee94
@   0x0800ef44: 2002        movs	r0, #2
@   0x0800ef46: f7ff        ffa5 	bl	0xee94
@   0x0800ef4a: 2003        movs	r0, #3
@   0x0800ef4c: f7ff        ffa2 	bl	0xee94
@   0x0800ef50: bc10        pop	{r4}
@   0x0800ef52: bc01        pop	{r0}
@   0x0800ef54: 4700        bx	r0

        thumb_func_start sub_0800EE94
sub_0800EE94: @ 0x0800ee94
        .incbin "frog_us_baserom.gba", 0xee94, 0xc4
        thumb_func_end sub_0800EE94
