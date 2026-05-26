@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800696c, 0x080069bc)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800696c --end 0x80069bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800696c: b510        push	{r4, lr}
@   0x0800696e: 1c0a        adds	r2, r1, #0
@   0x08006970: 2a3f        cmp	r2, #63	@ 0x3f
@   0x08006972: dc0f        bgt.n	0x6994
@   0x08006974: 2001        movs	r0, #1
@   0x08006976: 2100        movs	r1, #0
@   0x08006978: f02d        f994 	bl	0x33ca4
@   0x0800697c: 1c0c        adds	r4, r1, #0
@   0x0800697e: 1c03        adds	r3, r0, #0
@   0x08006980: 4a03        ldr	r2, [pc, #12]	@ (0x6990)
@   0x08006982: 6950        ldr	r0, [r2, #20]
@   0x08006984: 6991        ldr	r1, [r2, #24]
@   0x08006986: 4318        orrs	r0, r3
@   0x08006988: 4321        orrs	r1, r4
@   0x0800698a: 6150        str	r0, [r2, #20]
@   0x0800698c: 6191        str	r1, [r2, #24]
@   0x0800698e: e00f        b.n	0x69b0
@   0x08006990: 6110        str	r0, [r2, #16]
@   0x08006992: 0300        lsls	r0, r0, #12
@   0x08006994: 3a40        subs	r2, #64	@ 0x40
@   0x08006996: 2001        movs	r0, #1
@   0x08006998: 2100        movs	r1, #0
@   0x0800699a: f02d        f983 	bl	0x33ca4
@   0x0800699e: 1c0c        adds	r4, r1, #0
@   0x080069a0: 1c03        adds	r3, r0, #0
@   0x080069a2: 4a05        ldr	r2, [pc, #20]	@ (0x69b8)
@   0x080069a4: 69d0        ldr	r0, [r2, #28]
@   0x080069a6: 6a11        ldr	r1, [r2, #32]
@   0x080069a8: 4318        orrs	r0, r3
@   0x080069aa: 4321        orrs	r1, r4
@   0x080069ac: 61d0        str	r0, [r2, #28]
@   0x080069ae: 6211        str	r1, [r2, #32]
@   0x080069b0: bc10        pop	{r4}
@   0x080069b2: bc01        pop	{r0}
@   0x080069b4: 4700        bx	r0
@   0x080069b6: 0000        movs	r0, r0
@   0x080069b8: 6110        str	r0, [r2, #16]
@   0x080069ba: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800696C
sub_0800696C: @ 0x0800696c
        .incbin "frog_us_baserom.gba", 0x696c, 0x50
        thumb_func_end sub_0800696C
