@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802bc4c, 0x0802bc84)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802bc4c --end 0x802bc84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802bc4c: b530        push	{r4, r5, lr}
@   0x0802bc4e: 2300        movs	r3, #0
@   0x0802bc50: 4d0a        ldr	r5, [pc, #40]	@ (0x2bc7c)
@   0x0802bc52: 4c0b        ldr	r4, [pc, #44]	@ (0x2bc80)
@   0x0802bc54: 00d8        lsls	r0, r3, #3
@   0x0802bc56: 1942        adds	r2, r0, r5
@   0x0802bc58: 1900        adds	r0, r0, r4
@   0x0802bc5a: 6841        ldr	r1, [r0, #4]
@   0x0802bc5c: 6800        ldr	r0, [r0, #0]
@   0x0802bc5e: 6050        str	r0, [r2, #4]
@   0x0802bc60: 6091        str	r1, [r2, #8]
@   0x0802bc62: 1c58        adds	r0, r3, #1
@   0x0802bc64: 0600        lsls	r0, r0, #24
@   0x0802bc66: 0e03        lsrs	r3, r0, #24
@   0x0802bc68: 2b03        cmp	r3, #3
@   0x0802bc6a: d9f3        bls.n	0x2bc54
@   0x0802bc6c: f7ff        fba0 	bl	0x2b3b0
@   0x0802bc70: f7e1        fece 	bl	0xda10
@   0x0802bc74: bc30        pop	{r4, r5}
@   0x0802bc76: bc01        pop	{r0}
@   0x0802bc78: 4700        bx	r0
@   0x0802bc7a: 0000        movs	r0, r0
@   0x0802bc7c: 3570        adds	r5, #112	@ 0x70
@   0x0802bc7e: 0300        lsls	r0, r0, #12
@   0x0802bc80: 7ffc        ldrb	r4, [r7, #31]
@   0x0802bc82: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802BC4C
sub_0802BC4C: @ 0x0802bc4c
        .incbin "frog_us_baserom.gba", 0x2bc4c, 0x38
        thumb_func_end sub_0802BC4C
