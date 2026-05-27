@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800eee8, 0x0800ef58)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800eee8 --end 0x800ef58 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
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

        thumb_func_start sub_0800EEE8
sub_0800EEE8: @ 0x0800eee8
        .incbin "frog_us_baserom.gba", 0xeee8, 0x70
        thumb_func_end sub_0800EEE8
