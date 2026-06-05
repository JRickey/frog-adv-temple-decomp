@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802367c, 0x080236f4)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802367c --end 0x80236f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802367c: b510        push	{r4, lr}
@   0x0802367e: b081        sub	sp, #4
@   0x08023680: 2400        movs	r4, #0
@   0x08023682: 00e0        lsls	r0, r4, #3
@   0x08023684: 1b00        subs	r0, r0, r4
@   0x08023686: 00c0        lsls	r0, r0, #3
@   0x08023688: 4905        ldr	r1, [pc, #20]	@ (0x236a0)
@   0x0802368a: 1840        adds	r0, r0, r1
@   0x0802368c: 7e81        ldrb	r1, [r0, #26]
@   0x0802368e: 2900        cmp	r1, #0
@   0x08023690: d108        bne.n	0x236a4
@   0x08023692: 7ec1        ldrb	r1, [r0, #27]
@   0x08023694: 2901        cmp	r1, #1
@   0x08023696: d00a        beq.n	0x236ae
@   0x08023698: 2907        cmp	r1, #7
@   0x0802369a: d115        bne.n	0x236c8
@   0x0802369c: 2109        movs	r1, #9
@   0x0802369e: e007        b.n	0x236b0
@   0x080236a0: 4c58        ldr	r4, [pc, #352]	@ (0x23804)
@   0x080236a2: 0300        lsls	r0, r0, #12
@   0x080236a4: 2901        cmp	r1, #1
@   0x080236a6: d10f        bne.n	0x236c8
@   0x080236a8: 7ec1        ldrb	r1, [r0, #27]
@   0x080236aa: 2903        cmp	r1, #3
@   0x080236ac: d105        bne.n	0x236ba
@   0x080236ae: 2108        movs	r1, #8
@   0x080236b0: 2202        movs	r2, #2
@   0x080236b2: 2302        movs	r3, #2
@   0x080236b4: f7fd        fbae 	bl	0x20e14
@   0x080236b8: e006        b.n	0x236c8
@   0x080236ba: 2909        cmp	r1, #9
@   0x080236bc: d104        bne.n	0x236c8
@   0x080236be: 2109        movs	r1, #9
@   0x080236c0: 2202        movs	r2, #2
@   0x080236c2: 2302        movs	r3, #2
@   0x080236c4: f7fd        fba6 	bl	0x20e14
@   0x080236c8: 1c60        adds	r0, r4, #1
@   0x080236ca: 0600        lsls	r0, r0, #24
@   0x080236cc: 0e04        lsrs	r4, r0, #24
@   0x080236ce: 2c03        cmp	r4, #3
@   0x080236d0: d9d7        bls.n	0x23682
@   0x080236d2: 4906        ldr	r1, [pc, #24]	@ (0x236ec)
@   0x080236d4: 4b06        ldr	r3, [pc, #24]	@ (0x236f0)
@   0x080236d6: 2000        movs	r0, #0
@   0x080236d8: 9000        str	r0, [sp, #0]
@   0x080236da: 2061        movs	r0, #97	@ 0x61
@   0x080236dc: 2211        movs	r2, #17
@   0x080236de: f7fd        ff17 	bl	0x21510
@   0x080236e2: b001        add	sp, #4
@   0x080236e4: bc10        pop	{r4}
@   0x080236e6: bc01        pop	{r0}
@   0x080236e8: 4700        bx	r0
@   0x080236ea: 0000        movs	r0, r0
@   0x080236ec: 2248        movs	r2, #72	@ 0x48
@   0x080236ee: 0831        lsrs	r1, r6, #32
@   0x080236f0: 6110        str	r0, [r2, #16]
@   0x080236f2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802367C
sub_0802367C: @ 0x0802367c
        .incbin "frog_us_baserom.gba", 0x2367c, 0x78
        thumb_func_end sub_0802367C
