@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080177a0, 0x080177d8)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80177a0 --end 0x80177d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080177a0: b510        push	{r4, lr}
@   0x080177a2: b082        sub	sp, #8
@   0x080177a4: 1c04        adds	r4, r0, #0
@   0x080177a6: 4668        mov	r0, sp
@   0x080177a8: 2100        movs	r1, #0
@   0x080177aa: 2201        movs	r2, #1
@   0x080177ac: f000        f8a6 	bl	0x178fc
@   0x080177b0: 2800        cmp	r0, #0
@   0x080177b2: d00c        beq.n	0x177ce
@   0x080177b4: 2200        movs	r2, #0
@   0x080177b6: 0050        lsls	r0, r2, #1
@   0x080177b8: 1901        adds	r1, r0, r4
@   0x080177ba: 4468        add	r0, sp
@   0x080177bc: 8800        ldrh	r0, [r0, #0]
@   0x080177be: 8008        strh	r0, [r1, #0]
@   0x080177c0: 1c50        adds	r0, r2, #1
@   0x080177c2: 0600        lsls	r0, r0, #24
@   0x080177c4: 0e02        lsrs	r2, r0, #24
@   0x080177c6: 2a03        cmp	r2, #3
@   0x080177c8: d9f5        bls.n	0x177b6
@   0x080177ca: 2001        movs	r0, #1
@   0x080177cc: e000        b.n	0x177d0
@   0x080177ce: 2000        movs	r0, #0
@   0x080177d0: b002        add	sp, #8
@   0x080177d2: bc10        pop	{r4}
@   0x080177d4: bc02        pop	{r1}
@   0x080177d6: 4708        bx	r1

        thumb_func_start sub_080177A0
sub_080177A0: @ 0x080177a0
        .incbin "frog_us_baserom.gba", 0x177a0, 0x38
        thumb_func_end sub_080177A0
