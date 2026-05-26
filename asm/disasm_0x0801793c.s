@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801793c, 0x080179b8)  (124 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801793c --end 0x80179b8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801793c: b500        push	{lr}
@   0x0801793e: 4a07        ldr	r2, [pc, #28]	@ (0x1795c)
@   0x08017940: 4807        ldr	r0, [pc, #28]	@ (0x17960)
@   0x08017942: 7880        ldrb	r0, [r0, #2]
@   0x08017944: 2100        movs	r1, #0
@   0x08017946: 7010        strb	r0, [r2, #0]
@   0x08017948: 8051        strh	r1, [r2, #2]
@   0x0801794a: 4806        ldr	r0, [pc, #24]	@ (0x17964)
@   0x0801794c: 1c01        adds	r1, r0, #0
@   0x0801794e: 3124        adds	r1, #36	@ 0x24
@   0x08017950: 780a        ldrb	r2, [r1, #0]
@   0x08017952: 1c03        adds	r3, r0, #0
@   0x08017954: 2a02        cmp	r2, #2
@   0x08017956: d107        bne.n	0x17968
@   0x08017958: 2000        movs	r0, #0
@   0x0801795a: e006        b.n	0x1796a
@   0x0801795c: 35e0        adds	r5, #224	@ 0xe0
@   0x0801795e: 0300        lsls	r0, r0, #12
@   0x08017960: 34b4        adds	r4, #180	@ 0xb4
@   0x08017962: 0300        lsls	r0, r0, #12
@   0x08017964: 5330        strh	r0, [r6, r4]
@   0x08017966: 0300        lsls	r0, r0, #12
@   0x08017968: 1c50        adds	r0, r2, #1
@   0x0801796a: 7008        strb	r0, [r1, #0]
@   0x0801796c: 2a01        cmp	r2, #1
@   0x0801796e: d00b        beq.n	0x17988
@   0x08017970: 2a01        cmp	r2, #1
@   0x08017972: dc02        bgt.n	0x1797a
@   0x08017974: 2a00        cmp	r2, #0
@   0x08017976: d005        beq.n	0x17984
@   0x08017978: e00c        b.n	0x17994
@   0x0801797a: 2a02        cmp	r2, #2
@   0x0801797c: d006        beq.n	0x1798c
@   0x0801797e: 2a03        cmp	r2, #3
@   0x08017980: d006        beq.n	0x17990
@   0x08017982: e007        b.n	0x17994
@   0x08017984: 2001        movs	r0, #1
@   0x08017986: e004        b.n	0x17992
@   0x08017988: 2002        movs	r0, #2
@   0x0801798a: e002        b.n	0x17992
@   0x0801798c: 2004        movs	r0, #4
@   0x0801798e: e000        b.n	0x17992
@   0x08017990: 2007        movs	r0, #7
@   0x08017992: 7298        strb	r0, [r3, #10]
@   0x08017994: 4906        ldr	r1, [pc, #24]	@ (0x179b0)
@   0x08017996: 0090        lsls	r0, r2, #2
@   0x08017998: 1840        adds	r0, r0, r1
@   0x0801799a: 6800        ldr	r0, [r0, #0]
@   0x0801799c: f01c        f99c 	bl	0x33cd8
@   0x080179a0: f000        f872 	bl	0x17a88
@   0x080179a4: 4903        ldr	r1, [pc, #12]	@ (0x179b4)
@   0x080179a6: 2000        movs	r0, #0
@   0x080179a8: 7288        strb	r0, [r1, #10]
@   0x080179aa: bc01        pop	{r0}
@   0x080179ac: 4700        bx	r0
@   0x080179ae: 0000        movs	r0, r0
@   0x080179b0: 8028        strh	r0, [r5, #0]
@   0x080179b2: 0830        lsrs	r0, r6, #32
@   0x080179b4: 5330        strh	r0, [r6, r4]
@   0x080179b6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801793C
sub_0801793C: @ 0x0801793c
        .incbin "frog_us_baserom.gba", 0x1793c, 0x7c
        thumb_func_end sub_0801793C
