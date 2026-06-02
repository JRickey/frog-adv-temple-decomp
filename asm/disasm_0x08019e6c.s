@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019e6c, 0x08019ef0)  (132 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019e6c --end 0x8019ef0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019e6c: b530        push	{r4, r5, lr}
@   0x08019e6e: 4c14        ldr	r4, [pc, #80]	@ (0x19ec0)
@   0x08019e70: 6820        ldr	r0, [r4, #0]
@   0x08019e72: 2800        cmp	r0, #0
@   0x08019e74: d036        beq.n	0x19ee4
@   0x08019e76: 2180        movs	r1, #128	@ 0x80
@   0x08019e78: 04c9        lsls	r1, r1, #19
@   0x08019e7a: 88a0        ldrh	r0, [r4, #4]
@   0x08019e7c: 8008        strh	r0, [r1, #0]
@   0x08019e7e: 4911        ldr	r1, [pc, #68]	@ (0x19ec4)
@   0x08019e80: 1c20        adds	r0, r4, #0
@   0x08019e82: 3008        adds	r0, #8
@   0x08019e84: c82c        ldmia	r0!, {r2, r3, r5}
@   0x08019e86: c12c        stmia	r1!, {r2, r3, r5}
@   0x08019e88: 6800        ldr	r0, [r0, #0]
@   0x08019e8a: 6008        str	r0, [r1, #0]
@   0x08019e8c: 2000        movs	r0, #0
@   0x08019e8e: 2180        movs	r1, #128	@ 0x80
@   0x08019e90: 0489        lsls	r1, r1, #18
@   0x08019e92: 4a0d        ldr	r2, [pc, #52]	@ (0x19ec8)
@   0x08019e94: f7f6        f926 	bl	0x100e4
@   0x08019e98: 2001        movs	r0, #1
@   0x08019e9a: 490c        ldr	r1, [pc, #48]	@ (0x19ecc)
@   0x08019e9c: 4a0c        ldr	r2, [pc, #48]	@ (0x19ed0)
@   0x08019e9e: f7f6        f921 	bl	0x100e4
@   0x08019ea2: 2002        movs	r0, #2
@   0x08019ea4: 490b        ldr	r1, [pc, #44]	@ (0x19ed4)
@   0x08019ea6: 4a0c        ldr	r2, [pc, #48]	@ (0x19ed8)
@   0x08019ea8: f7f6        f91c 	bl	0x100e4
@   0x08019eac: 2003        movs	r0, #3
@   0x08019eae: 490b        ldr	r1, [pc, #44]	@ (0x19edc)
@   0x08019eb0: 4a0b        ldr	r2, [pc, #44]	@ (0x19ee0)
@   0x08019eb2: f7f6        f917 	bl	0x100e4
@   0x08019eb6: 2000        movs	r0, #0
@   0x08019eb8: 6020        str	r0, [r4, #0]
@   0x08019eba: 2001        movs	r0, #1
@   0x08019ebc: e015        b.n	0x19eea
@   0x08019ebe: 0000        movs	r0, r0
@   0x08019ec0: 6420        str	r0, [r4, #64]	@ 0x40
@   0x08019ec2: 0300        lsls	r0, r0, #12
@   0x08019ec4: 3550        adds	r5, #80	@ 0x50
@   0x08019ec6: 0300        lsls	r0, r0, #12
@   0x08019ec8: e000        b.n	0x19ecc
@   0x08019eca: 0600        lsls	r0, r0, #24
@   0x08019ecc: 0000        movs	r0, r0
@   0x08019ece: 0201        lsls	r1, r0, #8
@   0x08019ed0: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08019ed4: 0000        movs	r0, r0
@   0x08019ed6: 0202        lsls	r2, r0, #8
@   0x08019ed8: f000        0600 	and.w	r6, r0, #0
@   0x08019edc: 0000        movs	r0, r0
@   0x08019ede: 0203        lsls	r3, r0, #8
@   0x08019ee0: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08019ee4: f7ff        fd96 	bl	0x19a14
@   0x08019ee8: 2000        movs	r0, #0
@   0x08019eea: bc30        pop	{r4, r5}
@   0x08019eec: bc02        pop	{r1}
@   0x08019eee: 4708        bx	r1

        thumb_func_start sub_08019E6C
sub_08019E6C: @ 0x08019e6c
        .incbin "frog_us_baserom.gba", 0x19e6c, 0x84
        thumb_func_end sub_08019E6C
