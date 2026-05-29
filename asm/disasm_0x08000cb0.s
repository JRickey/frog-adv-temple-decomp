@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000cb0, 0x08000cec)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000cb0 --end 0x8000cec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000cb0: b500        push	{lr}
@   0x08000cb2: b082        sub	sp, #8
@   0x08000cb4: 480b        ldr	r0, [pc, #44]	@ (0xce4)
@   0x08000cb6: 4b0c        ldr	r3, [pc, #48]	@ (0xce8)
@   0x08000cb8: 2101        movs	r1, #1
@   0x08000cba: 9100        str	r1, [sp, #0]
@   0x08000cbc: 2103        movs	r1, #3
@   0x08000cbe: 9101        str	r1, [sp, #4]
@   0x08000cc0: 2164        movs	r1, #100	@ 0x64
@   0x08000cc2: 2200        movs	r2, #0
@   0x08000cc4: f005        fc62 	bl	0x658c
@   0x08000cc8: 2000        movs	r0, #0
@   0x08000cca: 2100        movs	r1, #0
@   0x08000ccc: f00c        f8e4 	bl	0xce98
@   0x08000cd0: 2001        movs	r0, #1
@   0x08000cd2: 2101        movs	r1, #1
@   0x08000cd4: f00c        f8e0 	bl	0xce98
@   0x08000cd8: f008        fff0 	bl	0x9cbc
@   0x08000cdc: b002        add	sp, #8
@   0x08000cde: bc01        pop	{r0}
@   0x08000ce0: 4700        bx	r0
@   0x08000ce2: 0000        movs	r0, r0
@   0x08000ce4: 6110        str	r0, [r2, #16]
@   0x08000ce6: 0300        lsls	r0, r0, #12
@   0x08000ce8: 998c        ldr	r1, [sp, #560]	@ 0x230
@   0x08000cea: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_08000CB0
sub_08000CB0: @ 0x08000cb0
        .incbin "frog_us_baserom.gba", 0xcb0, 0x3c
        thumb_func_end sub_08000CB0
