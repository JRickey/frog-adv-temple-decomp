@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026e40, 0x08026e6c)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026e40 --end 0x8026e6c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026e40: b500        push	{lr}
@   0x08026e42: b083        sub	sp, #12
@   0x08026e44: 4907        ldr	r1, [pc, #28]	@ (0x26e64)
@   0x08026e46: 4808        ldr	r0, [pc, #32]	@ (0x26e68)
@   0x08026e48: 9000        str	r0, [sp, #0]
@   0x08026e4a: 200c        movs	r0, #12
@   0x08026e4c: 9001        str	r0, [sp, #4]
@   0x08026e4e: 200a        movs	r0, #10
@   0x08026e50: 9002        str	r0, [sp, #8]
@   0x08026e52: 2073        movs	r0, #115	@ 0x73
@   0x08026e54: 2200        movs	r2, #0
@   0x08026e56: 234c        movs	r3, #76	@ 0x4c
@   0x08026e58: f7fa        f972 	bl	0x21140
@   0x08026e5c: b003        add	sp, #12
@   0x08026e5e: bc01        pop	{r0}
@   0x08026e60: 4700        bx	r0
@   0x08026e62: 0000        movs	r0, r0
@   0x08026e64: 4b70        ldr	r3, [pc, #448]	@ (0x27028)
@   0x08026e66: 0831        lsrs	r1, r6, #32
@   0x08026e68: 0201        lsls	r1, r0, #8

        thumb_func_start sub_08026E40
sub_08026E40: @ 0x08026e40
        .incbin "baserom.gba", 0x26e40, 0x2c
        thumb_func_end sub_08026E40
