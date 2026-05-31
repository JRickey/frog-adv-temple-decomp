@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019580, 0x080195c4)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019580 --end 0x80195c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019580: b510        push	{r4, lr}
@   0x08019582: f007        fae5 	bl	0x20b50
@   0x08019586: 4c0d        ldr	r4, [pc, #52]	@ (0x195bc)
@   0x08019588: 2000        movs	r0, #0
@   0x0801958a: 7160        strb	r0, [r4, #5]
@   0x0801958c: 490c        ldr	r1, [pc, #48]	@ (0x195c0)
@   0x0801958e: 6008        str	r0, [r1, #0]
@   0x08019590: f7f7        f8be 	bl	0x10710
@   0x08019594: 2800        cmp	r0, #0
@   0x08019596: d10e        bne.n	0x195b6
@   0x08019598: f7e7        f9b2 	bl	0x900
@   0x0801959c: 68e1        ldr	r1, [r4, #12]
@   0x0801959e: 1a40        subs	r0, r0, r1
@   0x080195a0: 2877        cmp	r0, #119	@ 0x77
@   0x080195a2: d908        bls.n	0x195b6
@   0x080195a4: f7e7        f9ac 	bl	0x900
@   0x080195a8: 60e0        str	r0, [r4, #12]
@   0x080195aa: 7820        ldrb	r0, [r4, #0]
@   0x080195ac: 3001        adds	r0, #1
@   0x080195ae: 7020        strb	r0, [r4, #0]
@   0x080195b0: 20bf        movs	r0, #191	@ 0xbf
@   0x080195b2: f7f7        f86f 	bl	0x10694
@   0x080195b6: bc10        pop	{r4}
@   0x080195b8: bc01        pop	{r0}
@   0x080195ba: 4700        bx	r0
@   0x080195bc: 3480        adds	r4, #128	@ 0x80
@   0x080195be: 0300        lsls	r0, r0, #12
@   0x080195c0: 3608        adds	r6, #8
@   0x080195c2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08019580
sub_08019580: @ 0x08019580
        .incbin "frog_us_baserom.gba", 0x19580, 0x44
        thumb_func_end sub_08019580
