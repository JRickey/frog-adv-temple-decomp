@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802de24, 0x0802de9c)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802de24 --end 0x802de9c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802de24: b570        push	{r4, r5, r6, lr}
@   0x0802de26: 1c03        adds	r3, r0, #0
@   0x0802de28: 0409        lsls	r1, r1, #16
@   0x0802de2a: 0c0d        lsrs	r5, r1, #16
@   0x0802de2c: 1c2e        adds	r6, r5, #0
@   0x0802de2e: 2b00        cmp	r3, #0
@   0x0802de30: d00f        beq.n	0x2de52
@   0x0802de32: 0c1a        lsrs	r2, r3, #16
@   0x0802de34: 20ff        movs	r0, #255	@ 0xff
@   0x0802de36: 4002        ands	r2, r0
@   0x0802de38: 4807        ldr	r0, [pc, #28]	@ (0x2de58)
@   0x0802de3a: 6801        ldr	r1, [r0, #0]
@   0x0802de3c: 2490        movs	r4, #144	@ 0x90
@   0x0802de3e: 0064        lsls	r4, r4, #1
@   0x0802de40: 1908        adds	r0, r1, r4
@   0x0802de42: 6800        ldr	r0, [r0, #0]
@   0x0802de44: 0094        lsls	r4, r2, #2
@   0x0802de46: 1820        adds	r0, r4, r0
@   0x0802de48: 6800        ldr	r0, [r0, #0]
@   0x0802de4a: 4298        cmp	r0, r3
@   0x0802de4c: d101        bne.n	0x2de52
@   0x0802de4e: 2a03        cmp	r2, #3
@   0x0802de50: d104        bne.n	0x2de5c
@   0x0802de52: 2000        movs	r0, #0
@   0x0802de54: e01f        b.n	0x2de96
@   0x0802de56: 0000        movs	r0, r0
@   0x0802de58: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802de5a: 0300        lsls	r0, r0, #12
@   0x0802de5c: 2a02        cmp	r2, #2
@   0x0802de5e: dc0c        bgt.n	0x2de7a
@   0x0802de60: 00d0        lsls	r0, r2, #3
@   0x0802de62: 1880        adds	r0, r0, r2
@   0x0802de64: 0080        lsls	r0, r0, #2
@   0x0802de66: 1808        adds	r0, r1, r0
@   0x0802de68: 8c03        ldrh	r3, [r0, #32]
@   0x0802de6a: 8405        strh	r5, [r0, #32]
@   0x0802de6c: 3110        adds	r1, #16
@   0x0802de6e: 1909        adds	r1, r1, r4
@   0x0802de70: 6808        ldr	r0, [r1, #0]
@   0x0802de72: 2240        movs	r2, #64	@ 0x40
@   0x0802de74: 4310        orrs	r0, r2
@   0x0802de76: 6008        str	r0, [r1, #0]
@   0x0802de78: e00c        b.n	0x2de94
@   0x0802de7a: 3a04        subs	r2, #4
@   0x0802de7c: 31c8        adds	r1, #200	@ 0xc8
@   0x0802de7e: 6808        ldr	r0, [r1, #0]
@   0x0802de80: 0192        lsls	r2, r2, #6
@   0x0802de82: 1810        adds	r0, r2, r0
@   0x0802de84: 8803        ldrh	r3, [r0, #0]
@   0x0802de86: 8006        strh	r6, [r0, #0]
@   0x0802de88: 6808        ldr	r0, [r1, #0]
@   0x0802de8a: 1812        adds	r2, r2, r0
@   0x0802de8c: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802de8e: 2140        movs	r1, #64	@ 0x40
@   0x0802de90: 4308        orrs	r0, r1
@   0x0802de92: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0802de94: 1c18        adds	r0, r3, #0
@   0x0802de96: bc70        pop	{r4, r5, r6}
@   0x0802de98: bc02        pop	{r1}
@   0x0802de9a: 4708        bx	r1

        thumb_func_start sub_0802DE24
sub_0802DE24: @ 0x0802de24
        .incbin "frog_us_baserom.gba", 0x2de24, 0x78
        thumb_func_end sub_0802DE24
