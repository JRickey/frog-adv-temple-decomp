@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024890, 0x080248e4)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024890 --end 0x80248e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024890: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08024892: b084        sub	sp, #16
@   0x08024894: 2600        movs	r6, #0
@   0x08024896: 2703        movs	r7, #3
@   0x08024898: 1c35        adds	r5, r6, #0
@   0x0802489a: 3543        adds	r5, #67	@ 0x43
@   0x0802489c: 4910        ldr	r1, [pc, #64]	@ (0x248e0)
@   0x0802489e: 00b0        lsls	r0, r6, #2
@   0x080248a0: 1840        adds	r0, r0, r1
@   0x080248a2: 6804        ldr	r4, [r0, #0]
@   0x080248a4: 1c30        adds	r0, r6, #0
@   0x080248a6: 2103        movs	r1, #3
@   0x080248a8: f00f        fb58 	bl	0x33f5c
@   0x080248ac: 0600        lsls	r0, r0, #24
@   0x080248ae: 0900        lsrs	r0, r0, #4
@   0x080248b0: 2181        movs	r1, #129	@ 0x81
@   0x080248b2: 0409        lsls	r1, r1, #16
@   0x080248b4: 1840        adds	r0, r0, r1
@   0x080248b6: 0c00        lsrs	r0, r0, #16
@   0x080248b8: 9000        str	r0, [sp, #0]
@   0x080248ba: 2004        movs	r0, #4
@   0x080248bc: 9001        str	r0, [sp, #4]
@   0x080248be: 9702        str	r7, [sp, #8]
@   0x080248c0: 9703        str	r7, [sp, #12]
@   0x080248c2: 1c28        adds	r0, r5, #0
@   0x080248c4: 1c21        adds	r1, r4, #0
@   0x080248c6: 2210        movs	r2, #16
@   0x080248c8: 230d        movs	r3, #13
@   0x080248ca: f7fc        fbe9 	bl	0x210a0
@   0x080248ce: 1c70        adds	r0, r6, #1
@   0x080248d0: 0600        lsls	r0, r0, #24
@   0x080248d2: 0e06        lsrs	r6, r0, #24
@   0x080248d4: 2e02        cmp	r6, #2
@   0x080248d6: d9df        bls.n	0x24898
@   0x080248d8: b004        add	sp, #16
@   0x080248da: bcf0        pop	{r4, r5, r6, r7}
@   0x080248dc: bc01        pop	{r0}
@   0x080248de: 4700        bx	r0
@   0x080248e0: 332c        adds	r3, #44	@ 0x2c
@   0x080248e2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024890
sub_08024890: @ 0x08024890
        .incbin "baserom.gba", 0x24890, 0x54
        thumb_func_end sub_08024890
