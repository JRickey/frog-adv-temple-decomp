@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080177d8, 0x08017814)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80177d8 --end 0x8017814 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080177d8: b510        push	{r4, lr}
@   0x080177da: b082        sub	sp, #8
@   0x080177dc: 1c03        adds	r3, r0, #0
@   0x080177de: 2200        movs	r2, #0
@   0x080177e0: 0050        lsls	r0, r2, #1
@   0x080177e2: 466c        mov	r4, sp
@   0x080177e4: 1821        adds	r1, r4, r0
@   0x080177e6: 18c0        adds	r0, r0, r3
@   0x080177e8: 8800        ldrh	r0, [r0, #0]
@   0x080177ea: 8008        strh	r0, [r1, #0]
@   0x080177ec: 1c50        adds	r0, r2, #1
@   0x080177ee: 0600        lsls	r0, r0, #24
@   0x080177f0: 0e02        lsrs	r2, r0, #24
@   0x080177f2: 2a03        cmp	r2, #3
@   0x080177f4: d9f4        bls.n	0x177e0
@   0x080177f6: 4668        mov	r0, sp
@   0x080177f8: 2100        movs	r1, #0
@   0x080177fa: 2201        movs	r2, #1
@   0x080177fc: f000        f84e 	bl	0x1789c
@   0x08017800: 2800        cmp	r0, #0
@   0x08017802: d101        bne.n	0x17808
@   0x08017804: 2000        movs	r0, #0
@   0x08017806: e000        b.n	0x1780a
@   0x08017808: 2001        movs	r0, #1
@   0x0801780a: b002        add	sp, #8
@   0x0801780c: bc10        pop	{r4}
@   0x0801780e: bc02        pop	{r1}
@   0x08017810: 4708        bx	r1

        thumb_func_start sub_080177D8
sub_080177D8: @ 0x080177d8
        .incbin "frog_us_baserom.gba", 0x177d8, 0x3c
        thumb_func_end sub_080177D8
