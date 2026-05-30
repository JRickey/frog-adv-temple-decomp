@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08005960, 0x080059b0)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8005960 --end 0x80059b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08005960: b510        push	{r4, lr}
@   0x08005962: f006        fd9d 	bl	0xc4a0
@   0x08005966: e007        b.n	0x5978
@   0x08005968: f004        fdda 	bl	0xa520
@   0x0800596c: f004        fcb4 	bl	0xa2d8
@   0x08005970: f7fa        ffb4 	bl	0x8dc
@   0x08005974: f004        fcd8 	bl	0xa328
@   0x08005978: 480c        ldr	r0, [pc, #48]	@ (0x59ac)
@   0x0800597a: 2108        movs	r1, #8
@   0x0800597c: 2202        movs	r2, #2
@   0x0800597e: f000        ff0d 	bl	0x679c
@   0x08005982: 0600        lsls	r0, r0, #24
@   0x08005984: 2800        cmp	r0, #0
@   0x08005986: d0ef        beq.n	0x5968
@   0x08005988: 4c08        ldr	r4, [pc, #32]	@ (0x59ac)
@   0x0800598a: 1c20        adds	r0, r4, #0
@   0x0800598c: 2108        movs	r1, #8
@   0x0800598e: 2202        movs	r2, #2
@   0x08005990: f000        fe98 	bl	0x66c4
@   0x08005994: 1c21        adds	r1, r4, #0
@   0x08005996: 312a        adds	r1, #42	@ 0x2a
@   0x08005998: 2000        movs	r0, #0
@   0x0800599a: 7008        strb	r0, [r1, #0]
@   0x0800599c: 1c20        adds	r0, r4, #0
@   0x0800599e: 2105        movs	r1, #5
@   0x080059a0: 2204        movs	r2, #4
@   0x080059a2: f000        fe8f 	bl	0x66c4
@   0x080059a6: bc10        pop	{r4}
@   0x080059a8: bc01        pop	{r0}
@   0x080059aa: 4700        bx	r0
@   0x080059ac: 6110        str	r0, [r2, #16]
@   0x080059ae: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08005960
sub_08005960: @ 0x08005960
        .incbin "frog_us_baserom.gba", 0x5960, 0x50
        thumb_func_end sub_08005960
