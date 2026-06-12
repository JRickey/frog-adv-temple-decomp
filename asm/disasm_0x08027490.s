@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027490, 0x080274bc)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027490 --end 0x80274bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027490: b500        push	{lr}
@   0x08027492: b083        sub	sp, #12
@   0x08027494: 4907        ldr	r1, [pc, #28]	@ (0x274b4)
@   0x08027496: 4808        ldr	r0, [pc, #32]	@ (0x274b8)
@   0x08027498: 9000        str	r0, [sp, #0]
@   0x0802749a: 2005        movs	r0, #5
@   0x0802749c: 9001        str	r0, [sp, #4]
@   0x0802749e: 2000        movs	r0, #0
@   0x080274a0: 9002        str	r0, [sp, #8]
@   0x080274a2: 202d        movs	r0, #45	@ 0x2d
@   0x080274a4: 2210        movs	r2, #16
@   0x080274a6: 2336        movs	r3, #54	@ 0x36
@   0x080274a8: f7f9        fe4a 	bl	0x21140
@   0x080274ac: b003        add	sp, #12
@   0x080274ae: bc01        pop	{r0}
@   0x080274b0: 4700        bx	r0
@   0x080274b2: 0000        movs	r0, r0
@   0x080274b4: 5e68        ldrsh	r0, [r5, r1]
@   0x080274b6: 0831        lsrs	r1, r6, #32
@   0x080274b8: 0271        lsls	r1, r6, #9

        thumb_func_start sub_08027490
sub_08027490: @ 0x08027490
        .incbin "baserom.gba", 0x27490, 0x2c
        thumb_func_end sub_08027490
