@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023334, 0x08023360)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023334 --end 0x8023360 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023334: b500        push	{lr}
@   0x08023336: b083        sub	sp, #12
@   0x08023338: 4907        ldr	r1, [pc, #28]	@ (0x23358)
@   0x0802333a: 4808        ldr	r0, [pc, #32]	@ (0x2335c)
@   0x0802333c: 9000        str	r0, [sp, #0]
@   0x0802333e: 2009        movs	r0, #9
@   0x08023340: 9001        str	r0, [sp, #4]
@   0x08023342: 2000        movs	r0, #0
@   0x08023344: 9002        str	r0, [sp, #8]
@   0x08023346: 2043        movs	r0, #67	@ 0x43
@   0x08023348: 2200        movs	r2, #0
@   0x0802334a: 2302        movs	r3, #2
@   0x0802334c: f7fd        fef8 	bl	0x21140
@   0x08023350: b003        add	sp, #12
@   0x08023352: bc01        pop	{r0}
@   0x08023354: 4700        bx	r0
@   0x08023356: 0000        movs	r0, r0
@   0x08023358: 1ce0        adds	r0, r4, #3
@   0x0802335a: 0831        lsrs	r1, r6, #32
@   0x0802335c: 0151        lsls	r1, r2, #5

        thumb_func_start sub_08023334
sub_08023334: @ 0x08023334
        .incbin "frog_us_baserom.gba", 0x23334, 0x2c
        thumb_func_end sub_08023334
