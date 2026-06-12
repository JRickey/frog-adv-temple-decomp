@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08030d8c, 0x08030e50)  (196 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8030d8c --end 0x8030e50 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08030d8c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08030d8e: 4647        mov	r7, r8
@   0x08030d90: b480        push	{r7}
@   0x08030d92: 1c05        adds	r5, r0, #0
@   0x08030d94: 4688        mov	r8, r1
@   0x08030d96: 680c        ldr	r4, [r1, #0]
@   0x08030d98: 2d03        cmp	r5, #3
@   0x08030d9a: d04e        beq.n	0x30e3a
@   0x08030d9c: 88a0        ldrh	r0, [r4, #4]
@   0x08030d9e: 8861        ldrh	r1, [r4, #2]
@   0x08030da0: 1a47        subs	r7, r0, r1
@   0x08030da2: 2f00        cmp	r7, #0
@   0x08030da4: d049        beq.n	0x30e3a
@   0x08030da6: 2001        movs	r0, #1
@   0x08030da8: 7862        ldrb	r2, [r4, #1]
@   0x08030daa: 4010        ands	r0, r2
@   0x08030dac: 2800        cmp	r0, #0
@   0x08030dae: d006        beq.n	0x30dbe
@   0x08030db0: 0438        lsls	r0, r7, #16
@   0x08030db2: 0c00        lsrs	r0, r0, #16
@   0x08030db4: f7fd        fb08 	bl	0x2e3c8
@   0x08030db8: 0400        lsls	r0, r0, #16
@   0x08030dba: 0c06        lsrs	r6, r0, #16
@   0x08030dbc: e00c        b.n	0x30dd8
@   0x08030dbe: 1238        asrs	r0, r7, #8
@   0x08030dc0: 2800        cmp	r0, #0
@   0x08030dc2: d103        bne.n	0x30dcc
@   0x08030dc4: 1da0        adds	r0, r4, #6
@   0x08030dc6: 4641        mov	r1, r8
@   0x08030dc8: 6008        str	r0, [r1, #0]
@   0x08030dca: e03a        b.n	0x30e42
@   0x08030dcc: 0400        lsls	r0, r0, #16
@   0x08030dce: 0c00        lsrs	r0, r0, #16
@   0x08030dd0: f7fd        fafa 	bl	0x2e3c8
@   0x08030dd4: 0400        lsls	r0, r0, #16
@   0x08030dd6: 0a06        lsrs	r6, r0, #8
@   0x08030dd8: 2d03        cmp	r5, #3
@   0x08030dda: dc0d        bgt.n	0x30df8
@   0x08030ddc: 4905        ldr	r1, [pc, #20]	@ (0x30df4)
@   0x08030dde: 00e8        lsls	r0, r5, #3
@   0x08030de0: 1940        adds	r0, r0, r5
@   0x08030de2: 0080        lsls	r0, r0, #2
@   0x08030de4: 3020        adds	r0, #32
@   0x08030de6: 6809        ldr	r1, [r1, #0]
@   0x08030de8: 180a        adds	r2, r1, r0
@   0x08030dea: 00a8        lsls	r0, r5, #2
@   0x08030dec: 3010        adds	r0, #16
@   0x08030dee: 180b        adds	r3, r1, r0
@   0x08030df0: e00c        b.n	0x30e0c
@   0x08030df2: 0000        movs	r0, r0
@   0x08030df4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030df6: 0300        lsls	r0, r0, #12
@   0x08030df8: 4809        ldr	r0, [pc, #36]	@ (0x30e20)
@   0x08030dfa: 6801        ldr	r1, [r0, #0]
@   0x08030dfc: 31c8        adds	r1, #200	@ 0xc8
@   0x08030dfe: 01a8        lsls	r0, r5, #6
@   0x08030e00: 4a08        ldr	r2, [pc, #32]	@ (0x30e24)
@   0x08030e02: 1880        adds	r0, r0, r2
@   0x08030e04: 6809        ldr	r1, [r1, #0]
@   0x08030e06: 180a        adds	r2, r1, r0
@   0x08030e08: 1c13        adds	r3, r2, #0
@   0x08030e0a: 3338        adds	r3, #56	@ 0x38
@   0x08030e0c: 2002        movs	r0, #2
@   0x08030e0e: 7861        ldrb	r1, [r4, #1]
@   0x08030e10: 4008        ands	r0, r1
@   0x08030e12: 2800        cmp	r0, #0
@   0x08030e14: d008        beq.n	0x30e28
@   0x08030e16: 1078        asrs	r0, r7, #1
@   0x08030e18: 8864        ldrh	r4, [r4, #2]
@   0x08030e1a: 1820        adds	r0, r4, r0
@   0x08030e1c: 1a30        subs	r0, r6, r0
@   0x08030e1e: e007        b.n	0x30e30
@   0x08030e20: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030e22: 0300        lsls	r0, r0, #12
@   0x08030e24: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08030e28: 8864        ldrh	r4, [r4, #2]
@   0x08030e2a: 19a0        adds	r0, r4, r6
@   0x08030e2c: 8811        ldrh	r1, [r2, #0]
@   0x08030e2e: 1a40        subs	r0, r0, r1
@   0x08030e30: 8050        strh	r0, [r2, #2]
@   0x08030e32: 6818        ldr	r0, [r3, #0]
@   0x08030e34: 2140        movs	r1, #64	@ 0x40
@   0x08030e36: 4308        orrs	r0, r1
@   0x08030e38: 6018        str	r0, [r3, #0]
@   0x08030e3a: 4642        mov	r2, r8
@   0x08030e3c: 6810        ldr	r0, [r2, #0]
@   0x08030e3e: 3006        adds	r0, #6
@   0x08030e40: 6010        str	r0, [r2, #0]
@   0x08030e42: 2001        movs	r0, #1
@   0x08030e44: bc08        pop	{r3}
@   0x08030e46: 4698        mov	r8, r3
@   0x08030e48: bcf0        pop	{r4, r5, r6, r7}
@   0x08030e4a: bc02        pop	{r1}
@   0x08030e4c: 4708        bx	r1

        thumb_func_start sub_08030D8C
sub_08030D8C: @ 0x08030d8c
        .incbin "baserom.gba", 0x30d8c, 0xc4
        thumb_func_end sub_08030D8C
