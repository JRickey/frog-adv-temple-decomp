@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080228d0, 0x080228fc)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80228d0 --end 0x80228fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080228d0: b500        push	{lr}
@   0x080228d2: b083        sub	sp, #12
@   0x080228d4: 4907        ldr	r1, [pc, #28]	@ (0x228f4)
@   0x080228d6: 4808        ldr	r0, [pc, #32]	@ (0x228f8)
@   0x080228d8: 9000        str	r0, [sp, #0]
@   0x080228da: 200b        movs	r0, #11
@   0x080228dc: 9001        str	r0, [sp, #4]
@   0x080228de: 2000        movs	r0, #0
@   0x080228e0: 9002        str	r0, [sp, #8]
@   0x080228e2: 2047        movs	r0, #71	@ 0x47
@   0x080228e4: 2210        movs	r2, #16
@   0x080228e6: 2310        movs	r3, #16
@   0x080228e8: f7fe        fc2a 	bl	0x21140
@   0x080228ec: b003        add	sp, #12
@   0x080228ee: bc01        pop	{r0}
@   0x080228f0: 4700        bx	r0
@   0x080228f2: 0000        movs	r0, r0
@   0x080228f4: 0c44        lsrs	r4, r0, #17
@   0x080228f6: 0831        lsrs	r1, r6, #32
@   0x080228f8: 0195        lsls	r5, r2, #6

        thumb_func_start sub_080228D0
sub_080228D0: @ 0x080228d0
        .incbin "frog_us_baserom.gba", 0x228d0, 0x2c
        thumb_func_end sub_080228D0
