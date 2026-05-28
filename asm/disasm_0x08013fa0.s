@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013fa0, 0x08013fd0)  (48 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013fa0 --end 0x8013fd0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013fa0: b530        push	{r4, r5, lr}
@   0x08013fa2: b083        sub	sp, #12
@   0x08013fa4: 4c08        ldr	r4, [pc, #32]	@ (0x13fc8)
@   0x08013fa6: 7a20        ldrb	r0, [r4, #8]
@   0x08013fa8: 8821        ldrh	r1, [r4, #0]
@   0x08013faa: 8862        ldrh	r2, [r4, #2]
@   0x08013fac: 88a3        ldrh	r3, [r4, #4]
@   0x08013fae: 88e5        ldrh	r5, [r4, #6]
@   0x08013fb0: 9500        str	r5, [sp, #0]
@   0x08013fb2: 6924        ldr	r4, [r4, #16]
@   0x08013fb4: 9401        str	r4, [sp, #4]
@   0x08013fb6: 2401        movs	r4, #1
@   0x08013fb8: 9402        str	r4, [sp, #8]
@   0x08013fba: f7fe        fe03 	bl	0x12bc4
@   0x08013fbe: b003        add	sp, #12
@   0x08013fc0: bc30        pop	{r4, r5}
@   0x08013fc2: bc01        pop	{r0}
@   0x08013fc4: 4700        bx	r0
@   0x08013fc6: 0000        movs	r0, r0
@   0x08013fc8: 72f8        strb	r0, [r7, #11]
@   0x08013fca: 0830        lsrs	r0, r6, #32
@   0x08013fcc: 4770        bx	lr

        thumb_func_start sub_08013FA0
sub_08013FA0: @ 0x08013fa0
        .incbin "frog_us_baserom.gba", 0x13fa0, 0x30
        thumb_func_end sub_08013FA0
