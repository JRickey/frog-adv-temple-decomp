@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028188, 0x080281b4)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028188 --end 0x80281b4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028188: b500        push	{lr}
@   0x0802818a: b083        sub	sp, #12
@   0x0802818c: 4907        ldr	r1, [pc, #28]	@ (0x281ac)
@   0x0802818e: 4808        ldr	r0, [pc, #32]	@ (0x281b0)
@   0x08028190: 9000        str	r0, [sp, #0]
@   0x08028192: 200e        movs	r0, #14
@   0x08028194: 9001        str	r0, [sp, #4]
@   0x08028196: 2000        movs	r0, #0
@   0x08028198: 9002        str	r0, [sp, #8]
@   0x0802819a: 204c        movs	r0, #76	@ 0x4c
@   0x0802819c: 2200        movs	r2, #0
@   0x0802819e: 234c        movs	r3, #76	@ 0x4c
@   0x080281a0: f7f8        ffce 	bl	0x21140
@   0x080281a4: b003        add	sp, #12
@   0x080281a6: bc01        pop	{r0}
@   0x080281a8: 4700        bx	r0
@   0x080281aa: 0000        movs	r0, r0
@   0x080281ac: 6760        str	r0, [r4, #116]	@ 0x74
@   0x080281ae: 0831        lsrs	r1, r6, #32
@   0x080281b0: 01f9        lsls	r1, r7, #7

        thumb_func_start sub_08028188
sub_08028188: @ 0x08028188
        .incbin "baserom.gba", 0x28188, 0x2c
        thumb_func_end sub_08028188
