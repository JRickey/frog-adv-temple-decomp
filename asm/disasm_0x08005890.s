@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08005890, 0x080058cc)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8005890 --end 0x80058cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08005890: b510        push	{r4, lr}
@   0x08005892: b082        sub	sp, #8
@   0x08005894: 4c0b        ldr	r4, [pc, #44]	@ (0x58c4)
@   0x08005896: 4b0c        ldr	r3, [pc, #48]	@ (0x58c8)
@   0x08005898: 2001        movs	r0, #1
@   0x0800589a: 9000        str	r0, [sp, #0]
@   0x0800589c: 2000        movs	r0, #0
@   0x0800589e: 9001        str	r0, [sp, #4]
@   0x080058a0: 1c20        adds	r0, r4, #0
@   0x080058a2: 2150        movs	r1, #80	@ 0x50
@   0x080058a4: 2211        movs	r2, #17
@   0x080058a6: f000        fe71 	bl	0x658c
@   0x080058aa: 2011        movs	r0, #17
@   0x080058ac: 2100        movs	r1, #0
@   0x080058ae: f007        faf3 	bl	0xce98
@   0x080058b2: f004        fa03 	bl	0x9cbc
@   0x080058b6: 2004        movs	r0, #4
@   0x080058b8: 6120        str	r0, [r4, #16]
@   0x080058ba: b002        add	sp, #8
@   0x080058bc: bc10        pop	{r4}
@   0x080058be: bc01        pop	{r0}
@   0x080058c0: 4700        bx	r0
@   0x080058c2: 0000        movs	r0, r0
@   0x080058c4: 6110        str	r0, [r2, #16]
@   0x080058c6: 0300        lsls	r0, r0, #12
@   0x080058c8: 9cf0        ldr	r4, [sp, #960]	@ 0x3c0
@   0x080058ca: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_08005890
sub_08005890: @ 0x08005890
        .incbin "frog_us_baserom.gba", 0x5890, 0x3c
        thumb_func_end sub_08005890
