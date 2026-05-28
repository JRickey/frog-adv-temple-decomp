@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800c4a0, 0x0800c4e8)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800c4a0 --end 0x800c4e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800c4a0: b570        push	{r4, r5, r6, lr}
@   0x0800c4a2: 2100        movs	r1, #0
@   0x0800c4a4: 4e0d        ldr	r6, [pc, #52]	@ (0xc4dc)
@   0x0800c4a6: 1c35        adds	r5, r6, #0
@   0x0800c4a8: 3533        adds	r5, #51	@ 0x33
@   0x0800c4aa: 060c        lsls	r4, r1, #24
@   0x0800c4ac: 0e22        lsrs	r2, r4, #24
@   0x0800c4ae: 1c30        adds	r0, r6, #0
@   0x0800c4b0: 2105        movs	r1, #5
@   0x0800c4b2: f7fa        f973 	bl	0x679c
@   0x0800c4b6: 0600        lsls	r0, r0, #24
@   0x0800c4b8: 2800        cmp	r0, #0
@   0x0800c4ba: d005        beq.n	0xc4c8
@   0x0800c4bc: 1621        asrs	r1, r4, #24
@   0x0800c4be: 2001        movs	r0, #1
@   0x0800c4c0: 4088        lsls	r0, r1
@   0x0800c4c2: 7829        ldrb	r1, [r5, #0]
@   0x0800c4c4: 4308        orrs	r0, r1
@   0x0800c4c6: 7028        strb	r0, [r5, #0]
@   0x0800c4c8: 2180        movs	r1, #128	@ 0x80
@   0x0800c4ca: 0449        lsls	r1, r1, #17
@   0x0800c4cc: 1860        adds	r0, r4, r1
@   0x0800c4ce: 0e01        lsrs	r1, r0, #24
@   0x0800c4d0: 1600        asrs	r0, r0, #24
@   0x0800c4d2: 2803        cmp	r0, #3
@   0x0800c4d4: dde9        ble.n	0xc4aa
@   0x0800c4d6: bc70        pop	{r4, r5, r6}
@   0x0800c4d8: bc01        pop	{r0}
@   0x0800c4da: 4700        bx	r0
@   0x0800c4dc: 6110        str	r0, [r2, #16]
@   0x0800c4de: 0300        lsls	r0, r0, #12
@   0x0800c4e0: 4770        bx	lr
@   0x0800c4e2: 0000        movs	r0, r0
@   0x0800c4e4: 4770        bx	lr

        thumb_func_start sub_0800C4A0
sub_0800C4A0: @ 0x0800c4a0
        .incbin "frog_us_baserom.gba", 0xc4a0, 0x48
        thumb_func_end sub_0800C4A0
