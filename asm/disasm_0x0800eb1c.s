@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800eb1c, 0x0800ebdc)  (192 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800eb1c --end 0x800ebdc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800eb1c: b510        push	{r4, lr}
@   0x0800eb1e: b081        sub	sp, #4
@   0x0800eb20: 491f        ldr	r1, [pc, #124]	@ (0xeba0)
@   0x0800eb22: 2400        movs	r4, #0
@   0x0800eb24: 2201        movs	r2, #1
@   0x0800eb26: 700a        strb	r2, [r1, #0]
@   0x0800eb28: 2003        movs	r0, #3
@   0x0800eb2a: 7108        strb	r0, [r1, #4]
@   0x0800eb2c: 720a        strb	r2, [r1, #8]
@   0x0800eb2e: 2009        movs	r0, #9
@   0x0800eb30: 7308        strb	r0, [r1, #12]
@   0x0800eb32: 7408        strb	r0, [r1, #16]
@   0x0800eb34: 481b        ldr	r0, [pc, #108]	@ (0xeba4)
@   0x0800eb36: 7002        strb	r2, [r0, #0]
@   0x0800eb38: f00b        f9da 	bl	0x19ef0
@   0x0800eb3c: 4668        mov	r0, sp
@   0x0800eb3e: 8004        strh	r4, [r0, #0]
@   0x0800eb40: 4919        ldr	r1, [pc, #100]	@ (0xeba8)
@   0x0800eb42: 6008        str	r0, [r1, #0]
@   0x0800eb44: 4819        ldr	r0, [pc, #100]	@ (0xebac)
@   0x0800eb46: 6048        str	r0, [r1, #4]
@   0x0800eb48: 4819        ldr	r0, [pc, #100]	@ (0xebb0)
@   0x0800eb4a: 6088        str	r0, [r1, #8]
@   0x0800eb4c: 6888        ldr	r0, [r1, #8]
@   0x0800eb4e: 4a19        ldr	r2, [pc, #100]	@ (0xebb4)
@   0x0800eb50: 600a        str	r2, [r1, #0]
@   0x0800eb52: 4819        ldr	r0, [pc, #100]	@ (0xebb8)
@   0x0800eb54: 6048        str	r0, [r1, #4]
@   0x0800eb56: 4b19        ldr	r3, [pc, #100]	@ (0xebbc)
@   0x0800eb58: 608b        str	r3, [r1, #8]
@   0x0800eb5a: 6888        ldr	r0, [r1, #8]
@   0x0800eb5c: 4818        ldr	r0, [pc, #96]	@ (0xebc0)
@   0x0800eb5e: 6008        str	r0, [r1, #0]
@   0x0800eb60: 4818        ldr	r0, [pc, #96]	@ (0xebc4)
@   0x0800eb62: 6048        str	r0, [r1, #4]
@   0x0800eb64: 4818        ldr	r0, [pc, #96]	@ (0xebc8)
@   0x0800eb66: 6088        str	r0, [r1, #8]
@   0x0800eb68: 6888        ldr	r0, [r1, #8]
@   0x0800eb6a: 4818        ldr	r0, [pc, #96]	@ (0xebcc)
@   0x0800eb6c: 7a80        ldrb	r0, [r0, #10]
@   0x0800eb6e: 280c        cmp	r0, #12
@   0x0800eb70: d106        bne.n	0xeb80
@   0x0800eb72: 1c10        adds	r0, r2, #0
@   0x0800eb74: 3060        adds	r0, #96	@ 0x60
@   0x0800eb76: 6008        str	r0, [r1, #0]
@   0x0800eb78: 4815        ldr	r0, [pc, #84]	@ (0xebd0)
@   0x0800eb7a: 6048        str	r0, [r1, #4]
@   0x0800eb7c: 608b        str	r3, [r1, #8]
@   0x0800eb7e: 6888        ldr	r0, [r1, #8]
@   0x0800eb80: 4914        ldr	r1, [pc, #80]	@ (0xebd4)
@   0x0800eb82: 4a15        ldr	r2, [pc, #84]	@ (0xebd8)
@   0x0800eb84: 1c10        adds	r0, r2, #0
@   0x0800eb86: 8008        strh	r0, [r1, #0]
@   0x0800eb88: 2280        movs	r2, #128	@ 0x80
@   0x0800eb8a: 04d2        lsls	r2, r2, #19
@   0x0800eb8c: 8810        ldrh	r0, [r2, #0]
@   0x0800eb8e: 2380        movs	r3, #128	@ 0x80
@   0x0800eb90: 011b        lsls	r3, r3, #4
@   0x0800eb92: 1c19        adds	r1, r3, #0
@   0x0800eb94: 4308        orrs	r0, r1
@   0x0800eb96: 8010        strh	r0, [r2, #0]
@   0x0800eb98: b001        add	sp, #4
@   0x0800eb9a: bc10        pop	{r4}
@   0x0800eb9c: bc01        pop	{r0}
@   0x0800eb9e: 4700        bx	r0
@   0x0800eba0: 5370        strh	r0, [r6, r5]
@   0x0800eba2: 0300        lsls	r0, r0, #12
@   0x0800eba4: 5328        strh	r0, [r5, r4]
@   0x0800eba6: 0300        lsls	r0, r0, #12
@   0x0800eba8: 00d4        lsls	r4, r2, #3
@   0x0800ebaa: 0400        lsls	r0, r0, #16
@   0x0800ebac: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0800ebb0: 0400        lsls	r0, r0, #16
@   0x0800ebb2: 8100        strh	r0, [r0, #8]
@   0x0800ebb4: 3754        adds	r7, #84	@ 0x54
@   0x0800ebb6: 080e        lsrs	r6, r1, #32
@   0x0800ebb8: 01a0        lsls	r0, r4, #6
@   0x0800ebba: 0500        lsls	r0, r0, #20
@   0x0800ebbc: 0030        movs	r0, r6
@   0x0800ebbe: 8000        strh	r0, [r0, #0]
@   0x0800ebc0: 3ab6        subs	r2, #182	@ 0xb6
@   0x0800ebc2: 080e        lsrs	r6, r1, #32
@   0x0800ebc4: 8000        strh	r0, [r0, #0]
@   0x0800ebc6: 0600        lsls	r0, r0, #24
@   0x0800ebc8: 2000        movs	r0, #0
@   0x0800ebca: 8000        strh	r0, [r0, #0]
@   0x0800ebcc: 5330        strh	r0, [r6, r4]
@   0x0800ebce: 0300        lsls	r0, r0, #12
@   0x0800ebd0: 0140        lsls	r0, r0, #5
@   0x0800ebd2: 0500        lsls	r0, r0, #20
@   0x0800ebd4: 000e        movs	r6, r1
@   0x0800ebd6: 0400        lsls	r0, r0, #16
@   0x0800ebd8: 1f08        subs	r0, r1, #4

        thumb_func_start sub_0800EB1C
sub_0800EB1C: @ 0x0800eb1c
        .incbin "frog_us_baserom.gba", 0xeb1c, 0xc0
        thumb_func_end sub_0800EB1C
