@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015b20, 0x08015b6c)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015b20 --end 0x8015b6c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015b20: b500        push	{lr}
@   0x08015b22: 0600        lsls	r0, r0, #24
@   0x08015b24: 0e00        lsrs	r0, r0, #24
@   0x08015b26: 2801        cmp	r0, #1
@   0x08015b28: d00e        beq.n	0x15b48
@   0x08015b2a: 2801        cmp	r0, #1
@   0x08015b2c: dc02        bgt.n	0x15b34
@   0x08015b2e: 2800        cmp	r0, #0
@   0x08015b30: d003        beq.n	0x15b3a
@   0x08015b32: e013        b.n	0x15b5c
@   0x08015b34: 2802        cmp	r0, #2
@   0x08015b36: d00f        beq.n	0x15b58
@   0x08015b38: e010        b.n	0x15b5c
@   0x08015b3a: 2180        movs	r1, #128	@ 0x80
@   0x08015b3c: 0489        lsls	r1, r1, #18
@   0x08015b3e: 4a01        ldr	r2, [pc, #4]	@ (0x15b44)
@   0x08015b40: e00c        b.n	0x15b5c
@   0x08015b42: 0000        movs	r0, r0
@   0x08015b44: e000        b.n	0x15b48
@   0x08015b46: 0600        lsls	r0, r0, #24
@   0x08015b48: 4901        ldr	r1, [pc, #4]	@ (0x15b50)
@   0x08015b4a: 4a02        ldr	r2, [pc, #8]	@ (0x15b54)
@   0x08015b4c: e006        b.n	0x15b5c
@   0x08015b4e: 0000        movs	r0, r0
@   0x08015b50: 0000        movs	r0, r0
@   0x08015b52: 0201        lsls	r1, r0, #8
@   0x08015b54: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08015b58: 4902        ldr	r1, [pc, #8]	@ (0x15b64)
@   0x08015b5a: 4a03        ldr	r2, [pc, #12]	@ (0x15b68)
@   0x08015b5c: f7fa        fac2 	bl	0x100e4
@   0x08015b60: bc01        pop	{r0}
@   0x08015b62: 4700        bx	r0
@   0x08015b64: 0000        movs	r0, r0
@   0x08015b66: 0202        lsls	r2, r0, #8
@   0x08015b68: f000        0600 	and.w	r6, r0, #0

        thumb_func_start sub_08015B20
sub_08015B20: @ 0x08015b20
        .incbin "frog_us_baserom.gba", 0x15b20, 0x4c
        thumb_func_end sub_08015B20
