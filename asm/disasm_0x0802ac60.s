@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ac60, 0x0802acb4)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ac60 --end 0x802acb4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ac60: b530        push	{r4, r5, lr}
@   0x0802ac62: 2300        movs	r3, #0
@   0x0802ac64: 4d0e        ldr	r5, [pc, #56]	@ (0x2aca0)
@   0x0802ac66: 4c0f        ldr	r4, [pc, #60]	@ (0x2aca4)
@   0x0802ac68: 00d8        lsls	r0, r3, #3
@   0x0802ac6a: 1942        adds	r2, r0, r5
@   0x0802ac6c: 1900        adds	r0, r0, r4
@   0x0802ac6e: 6841        ldr	r1, [r0, #4]
@   0x0802ac70: 6800        ldr	r0, [r0, #0]
@   0x0802ac72: 6050        str	r0, [r2, #4]
@   0x0802ac74: 6091        str	r1, [r2, #8]
@   0x0802ac76: 1c58        adds	r0, r3, #1
@   0x0802ac78: 0600        lsls	r0, r0, #24
@   0x0802ac7a: 0e03        lsrs	r3, r0, #24
@   0x0802ac7c: 2b05        cmp	r3, #5
@   0x0802ac7e: d9f3        bls.n	0x2ac68
@   0x0802ac80: f7ff        ff32 	bl	0x2aae8
@   0x0802ac84: f7ff        ff32 	bl	0x2aaec
@   0x0802ac88: f7ff        ff92 	bl	0x2abb0
@   0x0802ac8c: 4806        ldr	r0, [pc, #24]	@ (0x2aca8)
@   0x0802ac8e: 4907        ldr	r1, [pc, #28]	@ (0x2acac)
@   0x0802ac90: 1840        adds	r0, r0, r1
@   0x0802ac92: 4907        ldr	r1, [pc, #28]	@ (0x2acb0)
@   0x0802ac94: 6809        ldr	r1, [r1, #0]
@   0x0802ac96: 6001        str	r1, [r0, #0]
@   0x0802ac98: bc30        pop	{r4, r5}
@   0x0802ac9a: bc01        pop	{r0}
@   0x0802ac9c: 4700        bx	r0
@   0x0802ac9e: 0000        movs	r0, r0
@   0x0802aca0: 3570        adds	r5, #112	@ 0x70
@   0x0802aca2: 0300        lsls	r0, r0, #12
@   0x0802aca4: 7e74        ldrb	r4, [r6, #25]
@   0x0802aca6: 0831        lsrs	r1, r6, #32
@   0x0802aca8: 3720        adds	r7, #32
@   0x0802acaa: 0300        lsls	r0, r0, #12
@   0x0802acac: 0b48        lsrs	r0, r1, #13
@   0x0802acae: 0000        movs	r0, r0
@   0x0802acb0: 5330        strh	r0, [r6, r4]
@   0x0802acb2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802AC60
sub_0802AC60: @ 0x0802ac60
        .incbin "frog_us_baserom.gba", 0x2ac60, 0x54
        thumb_func_end sub_0802AC60
