@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002a68, 0x08002a9c)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002a68 --end 0x8002a9c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002a68: b500        push	{lr}
@   0x08002a6a: b082        sub	sp, #8
@   0x08002a6c: 4809        ldr	r0, [pc, #36]	@ (0x2a94)
@   0x08002a6e: 4b0a        ldr	r3, [pc, #40]	@ (0x2a98)
@   0x08002a70: 2101        movs	r1, #1
@   0x08002a72: 9100        str	r1, [sp, #0]
@   0x08002a74: 2105        movs	r1, #5
@   0x08002a76: 9101        str	r1, [sp, #4]
@   0x08002a78: 2164        movs	r1, #100	@ 0x64
@   0x08002a7a: 2209        movs	r2, #9
@   0x08002a7c: f003        fd86 	bl	0x658c
@   0x08002a80: 2009        movs	r0, #9
@   0x08002a82: 2100        movs	r1, #0
@   0x08002a84: f00a        fa08 	bl	0xce98
@   0x08002a88: f007        f918 	bl	0x9cbc
@   0x08002a8c: b002        add	sp, #8
@   0x08002a8e: bc01        pop	{r0}
@   0x08002a90: 4700        bx	r0
@   0x08002a92: 0000        movs	r0, r0
@   0x08002a94: 6110        str	r0, [r2, #16]
@   0x08002a96: 0300        lsls	r0, r0, #12
@   0x08002a98: 9ab8        ldr	r2, [sp, #736]	@ 0x2e0
@   0x08002a9a: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_08002A68
sub_08002A68: @ 0x08002a68
        .incbin "frog_us_baserom.gba", 0x2a68, 0x34
        thumb_func_end sub_08002A68
