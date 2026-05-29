@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080027a0, 0x080027f0)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80027a0 --end 0x80027f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080027a0: b510        push	{r4, lr}
@   0x080027a2: f007        fd99 	bl	0xa2d8
@   0x080027a6: f7fe        f899 	bl	0x8dc
@   0x080027aa: f007        fdbd 	bl	0xa328
@   0x080027ae: f006        fea3 	bl	0x94f8
@   0x080027b2: f007        f8e7 	bl	0x9984
@   0x080027b6: 4b0c        ldr	r3, [pc, #48]	@ (0x27e8)
@   0x080027b8: 2010        movs	r0, #16
@   0x080027ba: 8a19        ldrh	r1, [r3, #16]
@   0x080027bc: 4008        ands	r0, r1
@   0x080027be: 2800        cmp	r0, #0
@   0x080027c0: d00b        beq.n	0x27da
@   0x080027c2: 7e18        ldrb	r0, [r3, #24]
@   0x080027c4: 7e59        ldrb	r1, [r3, #25]
@   0x080027c6: 2408        movs	r4, #8
@   0x080027c8: 5f1a        ldrsh	r2, [r3, r4]
@   0x080027ca: 240a        movs	r4, #10
@   0x080027cc: 5f1b        ldrsh	r3, [r3, r4]
@   0x080027ce: f00a        fadb 	bl	0xcd88
@   0x080027d2: 0600        lsls	r0, r0, #24
@   0x080027d4: 0e00        lsrs	r0, r0, #24
@   0x080027d6: f009        fe05 	bl	0xc3e4
@   0x080027da: 4904        ldr	r1, [pc, #16]	@ (0x27ec)
@   0x080027dc: 6948        ldr	r0, [r1, #20]
@   0x080027de: 3001        adds	r0, #1
@   0x080027e0: 6148        str	r0, [r1, #20]
@   0x080027e2: bc10        pop	{r4}
@   0x080027e4: bc01        pop	{r0}
@   0x080027e6: 4700        bx	r0
@   0x080027e8: 35e0        adds	r5, #224	@ 0xe0
@   0x080027ea: 0300        lsls	r0, r0, #12
@   0x080027ec: 5330        strh	r0, [r6, r4]
@   0x080027ee: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080027A0
sub_080027A0: @ 0x080027a0
        .incbin "frog_us_baserom.gba", 0x27a0, 0x50
        thumb_func_end sub_080027A0
