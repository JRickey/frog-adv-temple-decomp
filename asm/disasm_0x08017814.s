@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017814, 0x08017858)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017814 --end 0x8017858 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017814: b510        push	{r4, lr}
@   0x08017816: b084        sub	sp, #16
@   0x08017818: 1c04        adds	r4, r0, #0
@   0x0801781a: 0609        lsls	r1, r1, #24
@   0x0801781c: 0e09        lsrs	r1, r1, #24
@   0x0801781e: 004a        lsls	r2, r1, #1
@   0x08017820: 1852        adds	r2, r2, r1
@   0x08017822: 3201        adds	r2, #1
@   0x08017824: 4668        mov	r0, sp
@   0x08017826: 1c11        adds	r1, r2, #0
@   0x08017828: 2202        movs	r2, #2
@   0x0801782a: f000        f867 	bl	0x178fc
@   0x0801782e: 2800        cmp	r0, #0
@   0x08017830: d00c        beq.n	0x1784c
@   0x08017832: 2200        movs	r2, #0
@   0x08017834: 0050        lsls	r0, r2, #1
@   0x08017836: 1901        adds	r1, r0, r4
@   0x08017838: 4468        add	r0, sp
@   0x0801783a: 8800        ldrh	r0, [r0, #0]
@   0x0801783c: 8008        strh	r0, [r1, #0]
@   0x0801783e: 1c50        adds	r0, r2, #1
@   0x08017840: 0600        lsls	r0, r0, #24
@   0x08017842: 0e02        lsrs	r2, r0, #24
@   0x08017844: 2a07        cmp	r2, #7
@   0x08017846: d9f5        bls.n	0x17834
@   0x08017848: 2001        movs	r0, #1
@   0x0801784a: e000        b.n	0x1784e
@   0x0801784c: 2000        movs	r0, #0
@   0x0801784e: b004        add	sp, #16
@   0x08017850: bc10        pop	{r4}
@   0x08017852: bc02        pop	{r1}
@   0x08017854: 4708        bx	r1

        thumb_func_start sub_08017814
sub_08017814: @ 0x08017814
        .incbin "frog_us_baserom.gba", 0x17814, 0x44
        thumb_func_end sub_08017814
