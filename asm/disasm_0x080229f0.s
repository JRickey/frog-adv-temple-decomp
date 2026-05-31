@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080229f0, 0x08022a28)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80229f0 --end 0x8022a28 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080229f0: b530        push	{r4, r5, lr}
@   0x080229f2: 2400        movs	r4, #0
@   0x080229f4: 4d0b        ldr	r5, [pc, #44]	@ (0x22a24)
@   0x080229f6: 00a0        lsls	r0, r4, #2
@   0x080229f8: 1940        adds	r0, r0, r5
@   0x080229fa: 6800        ldr	r0, [r0, #0]
@   0x080229fc: 1c21        adds	r1, r4, #0
@   0x080229fe: 313e        adds	r1, #62	@ 0x3e
@   0x08022a00: f7fe        ffdc 	bl	0x219bc
@   0x08022a04: 1c60        adds	r0, r4, #1
@   0x08022a06: 0600        lsls	r0, r0, #24
@   0x08022a08: 0e04        lsrs	r4, r0, #24
@   0x08022a0a: 2c06        cmp	r4, #6
@   0x08022a0c: d9f3        bls.n	0x229f6
@   0x08022a0e: 203e        movs	r0, #62	@ 0x3e
@   0x08022a10: 2144        movs	r1, #68	@ 0x44
@   0x08022a12: f7fe        fae7 	bl	0x20fe4
@   0x08022a16: 203e        movs	r0, #62	@ 0x3e
@   0x08022a18: 2144        movs	r1, #68	@ 0x44
@   0x08022a1a: f7e3        f979 	bl	0x5d10
@   0x08022a1e: bc30        pop	{r4, r5}
@   0x08022a20: bc01        pop	{r0}
@   0x08022a22: 4700        bx	r0
@   0x08022a24: 118c        asrs	r4, r1, #6
@   0x08022a26: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080229F0
sub_080229F0: @ 0x080229f0
        .incbin "frog_us_baserom.gba", 0x229f0, 0x38
        thumb_func_end sub_080229F0
