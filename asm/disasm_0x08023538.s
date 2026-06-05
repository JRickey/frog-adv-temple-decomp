@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023538, 0x08023594)  (92 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023538 --end 0x8023594 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023538: b530        push	{r4, r5, lr}
@   0x0802353a: 2300        movs	r3, #0
@   0x0802353c: 4d13        ldr	r5, [pc, #76]	@ (0x2358c)
@   0x0802353e: 4c14        ldr	r4, [pc, #80]	@ (0x23590)
@   0x08023540: 00d8        lsls	r0, r3, #3
@   0x08023542: 1942        adds	r2, r0, r5
@   0x08023544: 1900        adds	r0, r0, r4
@   0x08023546: 6841        ldr	r1, [r0, #4]
@   0x08023548: 6800        ldr	r0, [r0, #0]
@   0x0802354a: 6050        str	r0, [r2, #4]
@   0x0802354c: 6091        str	r1, [r2, #8]
@   0x0802354e: 1c58        adds	r0, r3, #1
@   0x08023550: 0600        lsls	r0, r0, #24
@   0x08023552: 0e03        lsrs	r3, r0, #24
@   0x08023554: 2b0b        cmp	r3, #11
@   0x08023556: d9f3        bls.n	0x23540
@   0x08023558: f7ff        fe60 	bl	0x2321c
@   0x0802355c: f7ff        ff3a 	bl	0x233d4
@   0x08023560: f7ff        fcf4 	bl	0x22f4c
@   0x08023564: f7ff        fee6 	bl	0x23334
@   0x08023568: f7ff        ff0c 	bl	0x23384
@   0x0802356c: f7ff        fc9c 	bl	0x22ea8
@   0x08023570: f7ff        fe40 	bl	0x231f4
@   0x08023574: f7ff        fbae 	bl	0x22cd4
@   0x08023578: f7ff        fbe8 	bl	0x22d4c
@   0x0802357c: f7ff        ff8e 	bl	0x2349c
@   0x08023580: f7ff        ffb2 	bl	0x234e8
@   0x08023584: bc30        pop	{r4, r5}
@   0x08023586: bc01        pop	{r0}
@   0x08023588: 4700        bx	r0
@   0x0802358a: 0000        movs	r0, r0
@   0x0802358c: 3570        adds	r5, #112	@ 0x70
@   0x0802358e: 0300        lsls	r0, r0, #12
@   0x08023590: 20d8        movs	r0, #216	@ 0xd8
@   0x08023592: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08023538
sub_08023538: @ 0x08023538
        .incbin "frog_us_baserom.gba", 0x23538, 0x5c
        thumb_func_end sub_08023538
