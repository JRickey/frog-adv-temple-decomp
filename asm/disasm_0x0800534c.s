@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800534c, 0x080053a4)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800534c --end 0x80053a4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800534c: b510        push	{r4, lr}
@   0x0800534e: 4c12        ldr	r4, [pc, #72]	@ (0x5398)
@   0x08005350: 1c20        adds	r0, r4, #0
@   0x08005352: 2103        movs	r1, #3
@   0x08005354: 2208        movs	r2, #8
@   0x08005356: f001        fa21 	bl	0x679c
@   0x0800535a: 0600        lsls	r0, r0, #24
@   0x0800535c: 2800        cmp	r0, #0
@   0x0800535e: d018        beq.n	0x5392
@   0x08005360: f00c        fa90 	bl	0x11884
@   0x08005364: 0600        lsls	r0, r0, #24
@   0x08005366: 2800        cmp	r0, #0
@   0x08005368: d013        beq.n	0x5392
@   0x0800536a: 490c        ldr	r1, [pc, #48]	@ (0x539c)
@   0x0800536c: 480c        ldr	r0, [pc, #48]	@ (0x53a0)
@   0x0800536e: 22b1        movs	r2, #177	@ 0xb1
@   0x08005370: 0112        lsls	r2, r2, #4
@   0x08005372: 1880        adds	r0, r0, r2
@   0x08005374: 6809        ldr	r1, [r1, #0]
@   0x08005376: 6800        ldr	r0, [r0, #0]
@   0x08005378: 1a09        subs	r1, r1, r0
@   0x0800537a: 2978        cmp	r1, #120	@ 0x78
@   0x0800537c: d909        bls.n	0x5392
@   0x0800537e: 1c20        adds	r0, r4, #0
@   0x08005380: 2103        movs	r1, #3
@   0x08005382: 2203        movs	r2, #3
@   0x08005384: f001        f93c 	bl	0x6600
@   0x08005388: 1c20        adds	r0, r4, #0
@   0x0800538a: 2103        movs	r1, #3
@   0x0800538c: 2208        movs	r2, #8
@   0x0800538e: f001        f999 	bl	0x66c4
@   0x08005392: bc10        pop	{r4}
@   0x08005394: bc01        pop	{r0}
@   0x08005396: 4700        bx	r0
@   0x08005398: 6110        str	r0, [r2, #16]
@   0x0800539a: 0300        lsls	r0, r0, #12
@   0x0800539c: 5330        strh	r0, [r6, r4]
@   0x0800539e: 0300        lsls	r0, r0, #12
@   0x080053a0: 3720        adds	r7, #32
@   0x080053a2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800534C
sub_0800534C: @ 0x0800534c
        .incbin "frog_us_baserom.gba", 0x534c, 0x58
        thumb_func_end sub_0800534C
