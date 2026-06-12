@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027558, 0x08027584)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027558 --end 0x8027584 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027558: b500        push	{lr}
@   0x0802755a: b083        sub	sp, #12
@   0x0802755c: 4907        ldr	r1, [pc, #28]	@ (0x2757c)
@   0x0802755e: 4808        ldr	r0, [pc, #32]	@ (0x27580)
@   0x08027560: 9000        str	r0, [sp, #0]
@   0x08027562: 2007        movs	r0, #7
@   0x08027564: 9001        str	r0, [sp, #4]
@   0x08027566: 2000        movs	r0, #0
@   0x08027568: 9002        str	r0, [sp, #8]
@   0x0802756a: 2049        movs	r0, #73	@ 0x49
@   0x0802756c: 2210        movs	r2, #16
@   0x0802756e: 2311        movs	r3, #17
@   0x08027570: f7f9        fde6 	bl	0x21140
@   0x08027574: b003        add	sp, #12
@   0x08027576: bc01        pop	{r0}
@   0x08027578: 4700        bx	r0
@   0x0802757a: 0000        movs	r0, r0
@   0x0802757c: 63f0        str	r0, [r6, #60]	@ 0x3c
@   0x0802757e: 0831        lsrs	r1, r6, #32
@   0x08027580: 02b1        lsls	r1, r6, #10

        thumb_func_start sub_08027558
sub_08027558: @ 0x08027558
        .incbin "baserom.gba", 0x27558, 0x2c
        thumb_func_end sub_08027558
