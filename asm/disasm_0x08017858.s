@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017858, 0x0801789c)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017858 --end 0x801789c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017858: b530        push	{r4, r5, lr}
@   0x0801785a: b084        sub	sp, #16
@   0x0801785c: 1c03        adds	r3, r0, #0
@   0x0801785e: 0609        lsls	r1, r1, #24
@   0x08017860: 0e09        lsrs	r1, r1, #24
@   0x08017862: 0048        lsls	r0, r1, #1
@   0x08017864: 1840        adds	r0, r0, r1
@   0x08017866: 1c44        adds	r4, r0, #1
@   0x08017868: 2200        movs	r2, #0
@   0x0801786a: 0050        lsls	r0, r2, #1
@   0x0801786c: 466d        mov	r5, sp
@   0x0801786e: 1829        adds	r1, r5, r0
@   0x08017870: 18c0        adds	r0, r0, r3
@   0x08017872: 8800        ldrh	r0, [r0, #0]
@   0x08017874: 8008        strh	r0, [r1, #0]
@   0x08017876: 1c50        adds	r0, r2, #1
@   0x08017878: 0600        lsls	r0, r0, #24
@   0x0801787a: 0e02        lsrs	r2, r0, #24
@   0x0801787c: 2a07        cmp	r2, #7
@   0x0801787e: d9f4        bls.n	0x1786a
@   0x08017880: 4668        mov	r0, sp
@   0x08017882: 1c21        adds	r1, r4, #0
@   0x08017884: 2202        movs	r2, #2
@   0x08017886: f000        f809 	bl	0x1789c
@   0x0801788a: 2800        cmp	r0, #0
@   0x0801788c: d101        bne.n	0x17892
@   0x0801788e: 2000        movs	r0, #0
@   0x08017890: e000        b.n	0x17894
@   0x08017892: 2001        movs	r0, #1
@   0x08017894: b004        add	sp, #16
@   0x08017896: bc30        pop	{r4, r5}
@   0x08017898: bc02        pop	{r1}
@   0x0801789a: 4708        bx	r1

        thumb_func_start sub_08017858
sub_08017858: @ 0x08017858
        .incbin "frog_us_baserom.gba", 0x17858, 0x44
        thumb_func_end sub_08017858
