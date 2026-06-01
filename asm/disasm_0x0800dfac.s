@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800dfac, 0x0800dffc)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800dfac --end 0x800dffc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800dfac: b510        push	{r4, lr}
@   0x0800dfae: b081        sub	sp, #4
@   0x0800dfb0: 2400        movs	r4, #0
@   0x0800dfb2: 4668        mov	r0, sp
@   0x0800dfb4: 7004        strb	r4, [r0, #0]
@   0x0800dfb6: e001        b.n	0xdfbc
@   0x0800dfb8: f7f2        fc90 	bl	0x8dc
@   0x0800dfbc: 4668        mov	r0, sp
@   0x0800dfbe: 4903        ldr	r1, [pc, #12]	@ (0xdfcc)
@   0x0800dfc0: f7fc        f8a0 	bl	0xa104
@   0x0800dfc4: 0600        lsls	r0, r0, #24
@   0x0800dfc6: 2800        cmp	r0, #0
@   0x0800dfc8: d0f6        beq.n	0xdfb8
@   0x0800dfca: e00f        b.n	0xdfec
@   0x0800dfcc: df9d        svc	157	@ 0x9d
@   0x0800dfce: 0800        lsrs	r0, r0, #32
@   0x0800dfd0: f7f2        fc84 	bl	0x8dc
@   0x0800dfd4: f005        fb5e 	bl	0x13694
@   0x0800dfd8: 2800        cmp	r0, #0
@   0x0800dfda: d001        beq.n	0xdfe0
@   0x0800dfdc: 2001        movs	r0, #1
@   0x0800dfde: 4304        orrs	r4, r0
@   0x0800dfe0: f7fb        fd3a 	bl	0x9a58
@   0x0800dfe4: f7fb        f8d0 	bl	0x9188
@   0x0800dfe8: f7fc        f99e 	bl	0xa328
@   0x0800dfec: 2001        movs	r0, #1
@   0x0800dfee: 4020        ands	r0, r4
@   0x0800dff0: 2800        cmp	r0, #0
@   0x0800dff2: d0ed        beq.n	0xdfd0
@   0x0800dff4: b001        add	sp, #4
@   0x0800dff6: bc10        pop	{r4}
@   0x0800dff8: bc01        pop	{r0}
@   0x0800dffa: 4700        bx	r0

        thumb_func_start sub_0800DFAC
sub_0800DFAC: @ 0x0800dfac
        .incbin "frog_us_baserom.gba", 0xdfac, 0x50
        thumb_func_end sub_0800DFAC
