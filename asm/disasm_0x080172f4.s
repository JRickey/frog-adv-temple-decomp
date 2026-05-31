@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080172f4, 0x08017364)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80172f4 --end 0x8017364 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080172f4: b510        push	{r4, lr}
@   0x080172f6: b093        sub	sp, #76	@ 0x4c
@   0x080172f8: a803        add	r0, sp, #12
@   0x080172fa: 4915        ldr	r1, [pc, #84]	@ (0x17350)
@   0x080172fc: 2240        movs	r2, #64	@ 0x40
@   0x080172fe: f01e        fa45 	bl	0x3578c
@   0x08017302: 2200        movs	r2, #0
@   0x08017304: ac01        add	r4, sp, #4
@   0x08017306: 1c23        adds	r3, r4, #0
@   0x08017308: 0050        lsls	r0, r2, #1
@   0x0801730a: 1819        adds	r1, r3, r0
@   0x0801730c: 4468        add	r0, sp
@   0x0801730e: 8980        ldrh	r0, [r0, #12]
@   0x08017310: 8008        strh	r0, [r1, #0]
@   0x08017312: 1c50        adds	r0, r2, #1
@   0x08017314: 0600        lsls	r0, r0, #24
@   0x08017316: 0e02        lsrs	r2, r0, #24
@   0x08017318: 2a03        cmp	r2, #3
@   0x0801731a: d9f5        bls.n	0x17308
@   0x0801731c: 2004        movs	r0, #4
@   0x0801731e: f01c        fac3 	bl	0x338a8
@   0x08017322: 490c        ldr	r1, [pc, #48]	@ (0x17354)
@   0x08017324: 2003        movs	r0, #3
@   0x08017326: f01c        faf3 	bl	0x33910
@   0x0801732a: 1c20        adds	r0, r4, #0
@   0x0801732c: 2114        movs	r1, #20
@   0x0801732e: 2201        movs	r2, #1
@   0x08017330: f000        fae4 	bl	0x178fc
@   0x08017334: 0400        lsls	r0, r0, #16
@   0x08017336: 2800        cmp	r0, #0
@   0x08017338: d00e        beq.n	0x17358
@   0x0801733a: 1c20        adds	r0, r4, #0
@   0x0801733c: 2114        movs	r1, #20
@   0x0801733e: 2201        movs	r2, #1
@   0x08017340: f000        faac 	bl	0x1789c
@   0x08017344: 0400        lsls	r0, r0, #16
@   0x08017346: 2800        cmp	r0, #0
@   0x08017348: d006        beq.n	0x17358
@   0x0801734a: 2001        movs	r0, #1
@   0x0801734c: e005        b.n	0x1735a
@   0x0801734e: 0000        movs	r0, r0
@   0x08017350: d8cc        bhi.n	0x172ec
@   0x08017352: 081b        lsrs	r3, r3, #32
@   0x08017354: 7939        ldrb	r1, [r7, #4]
@   0x08017356: 0801        lsrs	r1, r0, #32
@   0x08017358: 2000        movs	r0, #0
@   0x0801735a: b013        add	sp, #76	@ 0x4c
@   0x0801735c: bc10        pop	{r4}
@   0x0801735e: bc02        pop	{r1}
@   0x08017360: 4708        bx	r1

        thumb_func_start sub_080172F4
sub_080172F4: @ 0x080172f4
        .incbin "frog_us_baserom.gba", 0x172f4, 0x70
        thumb_func_end sub_080172F4
