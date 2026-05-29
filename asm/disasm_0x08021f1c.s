@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08021f1c, 0x08021f64)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8021f1c --end 0x8021f64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08021f1c: b510        push	{r4, lr}
@   0x08021f1e: 0600        lsls	r0, r0, #24
@   0x08021f20: 0e03        lsrs	r3, r0, #24
@   0x08021f22: 1c1c        adds	r4, r3, #0
@   0x08021f24: 2000        movs	r0, #0
@   0x08021f26: 7008        strb	r0, [r1, #0]
@   0x08021f28: 7010        strb	r0, [r2, #0]
@   0x08021f2a: 2b02        cmp	r3, #2
@   0x08021f2c: d00e        beq.n	0x21f4c
@   0x08021f2e: 2b02        cmp	r3, #2
@   0x08021f30: dc02        bgt.n	0x21f38
@   0x08021f32: 2b01        cmp	r3, #1
@   0x08021f34: d005        beq.n	0x21f42
@   0x08021f36: e012        b.n	0x21f5e
@   0x08021f38: 2c03        cmp	r4, #3
@   0x08021f3a: d00a        beq.n	0x21f52
@   0x08021f3c: 2c04        cmp	r4, #4
@   0x08021f3e: d00c        beq.n	0x21f5a
@   0x08021f40: e00d        b.n	0x21f5e
@   0x08021f42: 2101        movs	r1, #1
@   0x08021f44: 4249        negs	r1, r1
@   0x08021f46: 1c08        adds	r0, r1, #0
@   0x08021f48: 7010        strb	r0, [r2, #0]
@   0x08021f4a: e008        b.n	0x21f5e
@   0x08021f4c: 2001        movs	r0, #1
@   0x08021f4e: 7010        strb	r0, [r2, #0]
@   0x08021f50: e005        b.n	0x21f5e
@   0x08021f52: 2201        movs	r2, #1
@   0x08021f54: 4252        negs	r2, r2
@   0x08021f56: 1c10        adds	r0, r2, #0
@   0x08021f58: e000        b.n	0x21f5c
@   0x08021f5a: 2001        movs	r0, #1
@   0x08021f5c: 7008        strb	r0, [r1, #0]
@   0x08021f5e: bc10        pop	{r4}
@   0x08021f60: bc01        pop	{r0}
@   0x08021f62: 4700        bx	r0

        thumb_func_start sub_08021F1C
sub_08021F1C: @ 0x08021f1c
        .incbin "frog_us_baserom.gba", 0x21f1c, 0x48
        thumb_func_end sub_08021F1C
