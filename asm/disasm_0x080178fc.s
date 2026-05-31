@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080178fc, 0x0801793c)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80178fc --end 0x801793c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080178fc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080178fe: 1c07        adds	r7, r0, #0
@   0x08017900: 0409        lsls	r1, r1, #16
@   0x08017902: 0c0e        lsrs	r6, r1, #16
@   0x08017904: 0612        lsls	r2, r2, #24
@   0x08017906: 0e15        lsrs	r5, r2, #24
@   0x08017908: 2400        movs	r4, #0
@   0x0801790a: 42ac        cmp	r4, r5
@   0x0801790c: d20e        bcs.n	0x1792c
@   0x0801790e: 1930        adds	r0, r6, r4
@   0x08017910: 0400        lsls	r0, r0, #16
@   0x08017912: 0c00        lsrs	r0, r0, #16
@   0x08017914: 00e1        lsls	r1, r4, #3
@   0x08017916: 1879        adds	r1, r7, r1
@   0x08017918: f01c        f8aa 	bl	0x33a70
@   0x0801791c: 0400        lsls	r0, r0, #16
@   0x0801791e: 2800        cmp	r0, #0
@   0x08017920: d106        bne.n	0x17930
@   0x08017922: 1c60        adds	r0, r4, #1
@   0x08017924: 0600        lsls	r0, r0, #24
@   0x08017926: 0e04        lsrs	r4, r0, #24
@   0x08017928: 42ac        cmp	r4, r5
@   0x0801792a: d3f0        bcc.n	0x1790e
@   0x0801792c: 2001        movs	r0, #1
@   0x0801792e: e000        b.n	0x17932
@   0x08017930: 2000        movs	r0, #0
@   0x08017932: bcf0        pop	{r4, r5, r6, r7}
@   0x08017934: bc02        pop	{r1}
@   0x08017936: 4708        bx	r1
@   0x08017938: 4770        bx	lr

        thumb_func_start sub_080178FC
sub_080178FC: @ 0x080178fc
        .incbin "frog_us_baserom.gba", 0x178fc, 0x40
        thumb_func_end sub_080178FC
