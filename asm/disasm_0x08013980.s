@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013980, 0x080139bc)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013980 --end 0x80139bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013980: b570        push	{r4, r5, r6, lr}
@   0x08013982: b083        sub	sp, #12
@   0x08013984: 0600        lsls	r0, r0, #24
@   0x08013986: 0e00        lsrs	r0, r0, #24
@   0x08013988: 4e0b        ldr	r6, [pc, #44]	@ (0x139b8)
@   0x0801398a: 0045        lsls	r5, r0, #1
@   0x0801398c: 182d        adds	r5, r5, r0
@   0x0801398e: 00ed        lsls	r5, r5, #3
@   0x08013990: 19ac        adds	r4, r5, r6
@   0x08013992: 7a20        ldrb	r0, [r4, #8]
@   0x08013994: 8821        ldrh	r1, [r4, #0]
@   0x08013996: 8862        ldrh	r2, [r4, #2]
@   0x08013998: 88a3        ldrh	r3, [r4, #4]
@   0x0801399a: 88e4        ldrh	r4, [r4, #6]
@   0x0801399c: 9400        str	r4, [sp, #0]
@   0x0801399e: 3610        adds	r6, #16
@   0x080139a0: 19ad        adds	r5, r5, r6
@   0x080139a2: 682c        ldr	r4, [r5, #0]
@   0x080139a4: 9401        str	r4, [sp, #4]
@   0x080139a6: 2400        movs	r4, #0
@   0x080139a8: 9402        str	r4, [sp, #8]
@   0x080139aa: f7ff        f90b 	bl	0x12bc4
@   0x080139ae: b003        add	sp, #12
@   0x080139b0: bc70        pop	{r4, r5, r6}
@   0x080139b2: bc01        pop	{r0}
@   0x080139b4: 4700        bx	r0
@   0x080139b6: 0000        movs	r0, r0
@   0x080139b8: 702c        strb	r4, [r5, #0]
@   0x080139ba: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_08013980
sub_08013980: @ 0x08013980
        .incbin "frog_us_baserom.gba", 0x13980, 0x3c
        thumb_func_end sub_08013980
