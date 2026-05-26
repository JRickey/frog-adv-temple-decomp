@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080090b0, 0x080090fc)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80090b0 --end 0x80090fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080090b0: b570        push	{r4, r5, r6, lr}
@   0x080090b2: 4c10        ldr	r4, [pc, #64]	@ (0x90f4)
@   0x080090b4: 2102        movs	r1, #2
@   0x080090b6: 5e60        ldrsh	r0, [r4, r1]
@   0x080090b8: 2118        movs	r1, #24
@   0x080090ba: f02a        fe2b 	bl	0x33d14
@   0x080090be: 0400        lsls	r0, r0, #16
@   0x080090c0: 0c00        lsrs	r0, r0, #16
@   0x080090c2: 1c05        adds	r5, r0, #0
@   0x080090c4: 2104        movs	r1, #4
@   0x080090c6: 5e60        ldrsh	r0, [r4, r1]
@   0x080090c8: 2118        movs	r1, #24
@   0x080090ca: f02a        fe23 	bl	0x33d14
@   0x080090ce: 0400        lsls	r0, r0, #16
@   0x080090d0: 0c00        lsrs	r0, r0, #16
@   0x080090d2: 1c06        adds	r6, r0, #0
@   0x080090d4: 4c08        ldr	r4, [pc, #32]	@ (0x90f8)
@   0x080090d6: 8921        ldrh	r1, [r4, #8]
@   0x080090d8: 42a9        cmp	r1, r5
@   0x080090da: d102        bne.n	0x90e2
@   0x080090dc: 8961        ldrh	r1, [r4, #10]
@   0x080090de: 4281        cmp	r1, r0
@   0x080090e0: d005        beq.n	0x90ee
@   0x080090e2: 1c20        adds	r0, r4, #0
@   0x080090e4: 2140        movs	r1, #64	@ 0x40
@   0x080090e6: f7fd        fd4f 	bl	0x6b88
@   0x080090ea: 8125        strh	r5, [r4, #8]
@   0x080090ec: 8166        strh	r6, [r4, #10]
@   0x080090ee: bc70        pop	{r4, r5, r6}
@   0x080090f0: bc01        pop	{r0}
@   0x080090f2: 4700        bx	r0
@   0x080090f4: 3720        adds	r7, #32
@   0x080090f6: 0300        lsls	r0, r0, #12
@   0x080090f8: 35e0        adds	r5, #224	@ 0xe0
@   0x080090fa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080090B0
sub_080090B0: @ 0x080090b0
        .incbin "frog_us_baserom.gba", 0x90b0, 0x4c
        thumb_func_end sub_080090B0
