@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027e3c, 0x08027e64)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027e3c --end 0x8027e64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027e3c: b500        push	{lr}
@   0x08027e3e: b083        sub	sp, #12
@   0x08027e40: 4907        ldr	r1, [pc, #28]	@ (0x27e60)
@   0x08027e42: 2081        movs	r0, #129	@ 0x81
@   0x08027e44: 9000        str	r0, [sp, #0]
@   0x08027e46: 2005        movs	r0, #5
@   0x08027e48: 9001        str	r0, [sp, #4]
@   0x08027e4a: 2000        movs	r0, #0
@   0x08027e4c: 9002        str	r0, [sp, #8]
@   0x08027e4e: 2025        movs	r0, #37	@ 0x25
@   0x08027e50: 2210        movs	r2, #16
@   0x08027e52: 2340        movs	r3, #64	@ 0x40
@   0x08027e54: f7f9        f974 	bl	0x21140
@   0x08027e58: b003        add	sp, #12
@   0x08027e5a: bc01        pop	{r0}
@   0x08027e5c: 4700        bx	r0
@   0x08027e5e: 0000        movs	r0, r0
@   0x08027e60: 68e0        ldr	r0, [r4, #12]
@   0x08027e62: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027E3C
sub_08027E3C: @ 0x08027e3c
        .incbin "baserom.gba", 0x27e3c, 0x28
        thumb_func_end sub_08027E3C
