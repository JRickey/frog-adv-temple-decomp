@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ea2c, 0x0802ea80)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ea2c --end 0x802ea80 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ea2c: b530        push	{r4, r5, lr}
@   0x0802ea2e: 1c05        adds	r5, r0, #0
@   0x0802ea30: 1c0c        adds	r4, r1, #0
@   0x0802ea32: 2a02        cmp	r2, #2
@   0x0802ea34: dc12        bgt.n	0x2ea5c
@   0x0802ea36: 4b08        ldr	r3, [pc, #32]	@ (0x2ea58)
@   0x0802ea38: 6818        ldr	r0, [r3, #0]
@   0x0802ea3a: 00d1        lsls	r1, r2, #3
@   0x0802ea3c: 1889        adds	r1, r1, r2
@   0x0802ea3e: 0089        lsls	r1, r1, #2
@   0x0802ea40: 1840        adds	r0, r0, r1
@   0x0802ea42: 3039        adds	r0, #57	@ 0x39
@   0x0802ea44: 7004        strb	r4, [r0, #0]
@   0x0802ea46: 6818        ldr	r0, [r3, #0]
@   0x0802ea48: 1840        adds	r0, r0, r1
@   0x0802ea4a: 0862        lsrs	r2, r4, #1
@   0x0802ea4c: 3038        adds	r0, #56	@ 0x38
@   0x0802ea4e: 7002        strb	r2, [r0, #0]
@   0x0802ea50: 6818        ldr	r0, [r3, #0]
@   0x0802ea52: 1840        adds	r0, r0, r1
@   0x0802ea54: 86c5        strh	r5, [r0, #54]	@ 0x36
@   0x0802ea56: e00e        b.n	0x2ea76
@   0x0802ea58: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ea5a: 0300        lsls	r0, r0, #12
@   0x0802ea5c: 2a03        cmp	r2, #3
@   0x0802ea5e: dd0a        ble.n	0x2ea76
@   0x0802ea60: 4806        ldr	r0, [pc, #24]	@ (0x2ea7c)
@   0x0802ea62: 6801        ldr	r1, [r0, #0]
@   0x0802ea64: 31c8        adds	r1, #200	@ 0xc8
@   0x0802ea66: 0190        lsls	r0, r2, #6
@   0x0802ea68: 6809        ldr	r1, [r1, #0]
@   0x0802ea6a: 1840        adds	r0, r0, r1
@   0x0802ea6c: 38ec        subs	r0, #236	@ 0xec
@   0x0802ea6e: 7144        strb	r4, [r0, #5]
@   0x0802ea70: 0861        lsrs	r1, r4, #1
@   0x0802ea72: 7101        strb	r1, [r0, #4]
@   0x0802ea74: 8045        strh	r5, [r0, #2]
@   0x0802ea76: bc30        pop	{r4, r5}
@   0x0802ea78: bc01        pop	{r0}
@   0x0802ea7a: 4700        bx	r0
@   0x0802ea7c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ea7e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802EA2C
sub_0802EA2C: @ 0x0802ea2c
        .incbin "frog_us_baserom.gba", 0x2ea2c, 0x54
        thumb_func_end sub_0802EA2C
