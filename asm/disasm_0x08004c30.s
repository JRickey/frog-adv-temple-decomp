@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004c30, 0x08004c64)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004c30 --end 0x8004c64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004c30: b500        push	{lr}
@   0x08004c32: b082        sub	sp, #8
@   0x08004c34: 4809        ldr	r0, [pc, #36]	@ (0x4c5c)
@   0x08004c36: 4b0a        ldr	r3, [pc, #40]	@ (0x4c60)
@   0x08004c38: 2101        movs	r1, #1
@   0x08004c3a: 9100        str	r1, [sp, #0]
@   0x08004c3c: 2105        movs	r1, #5
@   0x08004c3e: 9101        str	r1, [sp, #4]
@   0x08004c40: 2180        movs	r1, #128	@ 0x80
@   0x08004c42: 220f        movs	r2, #15
@   0x08004c44: f001        fca2 	bl	0x658c
@   0x08004c48: 200f        movs	r0, #15
@   0x08004c4a: 2100        movs	r1, #0
@   0x08004c4c: f008        f924 	bl	0xce98
@   0x08004c50: f005        f834 	bl	0x9cbc
@   0x08004c54: b002        add	sp, #8
@   0x08004c56: bc01        pop	{r0}
@   0x08004c58: 4700        bx	r0
@   0x08004c5a: 0000        movs	r0, r0
@   0x08004c5c: 6110        str	r0, [r2, #16]
@   0x08004c5e: 0300        lsls	r0, r0, #12
@   0x08004c60: 9bd0        ldr	r3, [sp, #832]	@ 0x340
@   0x08004c62: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_08004C30
sub_08004C30: @ 0x08004c30
        .incbin "frog_us_baserom.gba", 0x4c30, 0x34
        thumb_func_end sub_08004C30
