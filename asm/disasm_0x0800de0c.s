@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800de0c, 0x0800de80)  (116 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800de0c --end 0x800de80 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800de0c: b530        push	{r4, r5, lr}
@   0x0800de0e: 2500        movs	r5, #0
@   0x0800de10: 4a17        ldr	r2, [pc, #92]	@ (0xde70)
@   0x0800de12: 4818        ldr	r0, [pc, #96]	@ (0xde74)
@   0x0800de14: 1811        adds	r1, r2, r0
@   0x0800de16: 2002        movs	r0, #2
@   0x0800de18: 7008        strb	r0, [r1, #0]
@   0x0800de1a: 23d1        movs	r3, #209	@ 0xd1
@   0x0800de1c: 009b        lsls	r3, r3, #2
@   0x0800de1e: 18d1        adds	r1, r2, r3
@   0x0800de20: 880b        ldrh	r3, [r1, #0]
@   0x0800de22: 4318        orrs	r0, r3
@   0x0800de24: 8008        strh	r0, [r1, #0]
@   0x0800de26: 4814        ldr	r0, [pc, #80]	@ (0xde78)
@   0x0800de28: 1812        adds	r2, r2, r0
@   0x0800de2a: 4814        ldr	r0, [pc, #80]	@ (0xde7c)
@   0x0800de2c: 6801        ldr	r1, [r0, #0]
@   0x0800de2e: 6011        str	r1, [r2, #0]
@   0x0800de30: 8441        strh	r1, [r0, #34]	@ 0x22
@   0x0800de32: 1c04        adds	r4, r0, #0
@   0x0800de34: f7fc        fb74 	bl	0xa520
@   0x0800de38: f003        fbde 	bl	0x115f8
@   0x0800de3c: 2800        cmp	r0, #0
@   0x0800de3e: d007        beq.n	0xde50
@   0x0800de40: 2322        movs	r3, #34	@ 0x22
@   0x0800de42: 5ee1        ldrsh	r1, [r4, r3]
@   0x0800de44: 6820        ldr	r0, [r4, #0]
@   0x0800de46: 1a40        subs	r0, r0, r1
@   0x0800de48: 28db        cmp	r0, #219	@ 0xdb
@   0x0800de4a: d901        bls.n	0xde50
@   0x0800de4c: 2001        movs	r0, #1
@   0x0800de4e: 4305        orrs	r5, r0
@   0x0800de50: f7fb        fe02 	bl	0x9a58
@   0x0800de54: f7fb        f998 	bl	0x9188
@   0x0800de58: f7f2        fd40 	bl	0x8dc
@   0x0800de5c: f7fc        fa64 	bl	0xa328
@   0x0800de60: 2001        movs	r0, #1
@   0x0800de62: 4028        ands	r0, r5
@   0x0800de64: 2800        cmp	r0, #0
@   0x0800de66: d0e5        beq.n	0xde34
@   0x0800de68: bc30        pop	{r4, r5}
@   0x0800de6a: bc01        pop	{r0}
@   0x0800de6c: 4700        bx	r0
@   0x0800de6e: 0000        movs	r0, r0
@   0x0800de70: 3720        adds	r7, #32
@   0x0800de72: 0300        lsls	r0, r0, #12
@   0x0800de74: 032a        lsls	r2, r5, #12
@   0x0800de76: 0000        movs	r0, r0
@   0x0800de78: 0b1c        lsrs	r4, r3, #12
@   0x0800de7a: 0000        movs	r0, r0
@   0x0800de7c: 5330        strh	r0, [r6, r4]
@   0x0800de7e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800DE0C
sub_0800DE0C: @ 0x0800de0c
        .incbin "frog_us_baserom.gba", 0xde0c, 0x74
        thumb_func_end sub_0800DE0C
