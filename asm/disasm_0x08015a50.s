@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015a50, 0x08015ad4)  (132 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015a50 --end 0x8015ad4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015a50: b500        push	{lr}
@   0x08015a52: 4a07        ldr	r2, [pc, #28]	@ (0x15a70)
@   0x08015a54: 4807        ldr	r0, [pc, #28]	@ (0x15a74)
@   0x08015a56: 6010        str	r0, [r2, #0]
@   0x08015a58: 2180        movs	r1, #128	@ 0x80
@   0x08015a5a: 0489        lsls	r1, r1, #18
@   0x08015a5c: 6051        str	r1, [r2, #4]
@   0x08015a5e: 4806        ldr	r0, [pc, #24]	@ (0x15a78)
@   0x08015a60: 6090        str	r0, [r2, #8]
@   0x08015a62: 6890        ldr	r0, [r2, #8]
@   0x08015a64: 4a05        ldr	r2, [pc, #20]	@ (0x15a7c)
@   0x08015a66: 2000        movs	r0, #0
@   0x08015a68: f7fa        fb3c 	bl	0x100e4
@   0x08015a6c: bc01        pop	{r0}
@   0x08015a6e: 4700        bx	r0
@   0x08015a70: 00d4        lsls	r4, r2, #3
@   0x08015a72: 0400        lsls	r0, r0, #16
@   0x08015a74: c312        stmia	r3!, {r1, r4}
@   0x08015a76: 0819        lsrs	r1, r3, #32
@   0x08015a78: 8000        strh	r0, [r0, #0]
@   0x08015a7a: 8000        strh	r0, [r0, #0]
@   0x08015a7c: e000        b.n	0x15a80
@   0x08015a7e: 0600        lsls	r0, r0, #24
@   0x08015a80: b500        push	{lr}
@   0x08015a82: 4a07        ldr	r2, [pc, #28]	@ (0x15aa0)
@   0x08015a84: 4807        ldr	r0, [pc, #28]	@ (0x15aa4)
@   0x08015a86: 6010        str	r0, [r2, #0]
@   0x08015a88: 2180        movs	r1, #128	@ 0x80
@   0x08015a8a: 0489        lsls	r1, r1, #18
@   0x08015a8c: 6051        str	r1, [r2, #4]
@   0x08015a8e: 4806        ldr	r0, [pc, #24]	@ (0x15aa8)
@   0x08015a90: 6090        str	r0, [r2, #8]
@   0x08015a92: 6890        ldr	r0, [r2, #8]
@   0x08015a94: 4a05        ldr	r2, [pc, #20]	@ (0x15aac)
@   0x08015a96: 2000        movs	r0, #0
@   0x08015a98: f7fa        fb24 	bl	0x100e4
@   0x08015a9c: bc01        pop	{r0}
@   0x08015a9e: 4700        bx	r0
@   0x08015aa0: 00d4        lsls	r4, r2, #3
@   0x08015aa2: 0400        lsls	r0, r0, #16
@   0x08015aa4: cfde        ldmia	r7, {r1, r2, r3, r4, r6, r7}
@   0x08015aa6: 0819        lsrs	r1, r3, #32
@   0x08015aa8: 8000        strh	r0, [r0, #0]
@   0x08015aaa: 8000        strh	r0, [r0, #0]
@   0x08015aac: e000        b.n	0x15ab0
@   0x08015aae: 0600        lsls	r0, r0, #24
@   0x08015ab0: b500        push	{lr}
@   0x08015ab2: 2002        movs	r0, #2
@   0x08015ab4: f7f8        fed2 	bl	0xe85c
@   0x08015ab8: f7f9        f830 	bl	0xeb1c
@   0x08015abc: f7ff        ff78 	bl	0x159b0
@   0x08015ac0: 2002        movs	r0, #2
@   0x08015ac2: f7f9        fbc3 	bl	0xf24c
@   0x08015ac6: 2002        movs	r0, #2
@   0x08015ac8: f7f9        f888 	bl	0xebdc
@   0x08015acc: f000        ffb8 	bl	0x16a40
@   0x08015ad0: bc01        pop	{r0}
@   0x08015ad2: 4700        bx	r0

        thumb_func_start sub_08015A50
sub_08015A50: @ 0x08015a50
        .incbin "frog_us_baserom.gba", 0x15a50, 0x84
        thumb_func_end sub_08015A50
