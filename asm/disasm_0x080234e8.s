@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080234e8, 0x08023514)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80234e8 --end 0x8023514 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080234e8: b500        push	{lr}
@   0x080234ea: b083        sub	sp, #12
@   0x080234ec: 4907        ldr	r1, [pc, #28]	@ (0x2350c)
@   0x080234ee: 4808        ldr	r0, [pc, #32]	@ (0x23510)
@   0x080234f0: 9000        str	r0, [sp, #0]
@   0x080234f2: 200e        movs	r0, #14
@   0x080234f4: 9001        str	r0, [sp, #4]
@   0x080234f6: 2000        movs	r0, #0
@   0x080234f8: 9002        str	r0, [sp, #8]
@   0x080234fa: 205f        movs	r0, #95	@ 0x5f
@   0x080234fc: 2200        movs	r2, #0
@   0x080234fe: 234c        movs	r3, #76	@ 0x4c
@   0x08023500: f7fd        fe1e 	bl	0x21140
@   0x08023504: b003        add	sp, #12
@   0x08023506: bc01        pop	{r0}
@   0x08023508: 4700        bx	r0
@   0x0802350a: 0000        movs	r0, r0
@   0x0802350c: 1488        asrs	r0, r1, #18
@   0x0802350e: 0831        lsrs	r1, r6, #32
@   0x08023510: 0231        lsls	r1, r6, #8

        thumb_func_start sub_080234E8
sub_080234E8: @ 0x080234e8
        .incbin "frog_us_baserom.gba", 0x234e8, 0x2c
        thumb_func_end sub_080234E8
