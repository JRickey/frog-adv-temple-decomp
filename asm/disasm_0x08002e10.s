@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002e10, 0x08002e44)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002e10 --end 0x8002e44 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002e10: b500        push	{lr}
@   0x08002e12: b082        sub	sp, #8
@   0x08002e14: 4809        ldr	r0, [pc, #36]	@ (0x2e3c)
@   0x08002e16: 4b0a        ldr	r3, [pc, #40]	@ (0x2e40)
@   0x08002e18: 2101        movs	r1, #1
@   0x08002e1a: 9100        str	r1, [sp, #0]
@   0x08002e1c: 2100        movs	r1, #0
@   0x08002e1e: 9101        str	r1, [sp, #4]
@   0x08002e20: 2150        movs	r1, #80	@ 0x50
@   0x08002e22: 220a        movs	r2, #10
@   0x08002e24: f003        fbb2 	bl	0x658c
@   0x08002e28: 200a        movs	r0, #10
@   0x08002e2a: 2100        movs	r1, #0
@   0x08002e2c: f00a        f834 	bl	0xce98
@   0x08002e30: f006        ff44 	bl	0x9cbc
@   0x08002e34: b002        add	sp, #8
@   0x08002e36: bc01        pop	{r0}
@   0x08002e38: 4700        bx	r0
@   0x08002e3a: 0000        movs	r0, r0
@   0x08002e3c: 6110        str	r0, [r2, #16]
@   0x08002e3e: 0300        lsls	r0, r0, #12
@   0x08002e40: 9cc0        ldr	r4, [sp, #768]	@ 0x300
@   0x08002e42: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_08002E10
sub_08002E10: @ 0x08002e10
        .incbin "frog_us_baserom.gba", 0x2e10, 0x34
        thumb_func_end sub_08002E10
