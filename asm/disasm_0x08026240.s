@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026240, 0x0802626c)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026240 --end 0x802626c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026240: b500        push	{lr}
@   0x08026242: b083        sub	sp, #12
@   0x08026244: 4907        ldr	r1, [pc, #28]	@ (0x26264)
@   0x08026246: 4808        ldr	r0, [pc, #32]	@ (0x26268)
@   0x08026248: 9000        str	r0, [sp, #0]
@   0x0802624a: 200c        movs	r0, #12
@   0x0802624c: 9001        str	r0, [sp, #4]
@   0x0802624e: 2000        movs	r0, #0
@   0x08026250: 9002        str	r0, [sp, #8]
@   0x08026252: 205e        movs	r0, #94	@ 0x5e
@   0x08026254: 2200        movs	r2, #0
@   0x08026256: 234c        movs	r3, #76	@ 0x4c
@   0x08026258: f7fa        ff72 	bl	0x21140
@   0x0802625c: b003        add	sp, #12
@   0x0802625e: bc01        pop	{r0}
@   0x08026260: 4700        bx	r0
@   0x08026262: 0000        movs	r0, r0
@   0x08026264: 40a8        lsls	r0, r5
@   0x08026266: 0831        lsrs	r1, r6, #32
@   0x08026268: 0281        lsls	r1, r0, #10

        thumb_func_start sub_08026240
sub_08026240: @ 0x08026240
        .incbin "baserom.gba", 0x26240, 0x2c
        thumb_func_end sub_08026240
