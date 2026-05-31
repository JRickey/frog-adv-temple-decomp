@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012d88, 0x08012e2c)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012d88 --end 0x8012e2c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012d88: b510        push	{r4, lr}
@   0x08012d8a: b082        sub	sp, #8
@   0x08012d8c: 4816        ldr	r0, [pc, #88]	@ (0x12de8)
@   0x08012d8e: 1c04        adds	r4, r0, #0
@   0x08012d90: 3440        adds	r4, #64	@ 0x40
@   0x08012d92: 2001        movs	r0, #1
@   0x08012d94: 7821        ldrb	r1, [r4, #0]
@   0x08012d96: 4008        ands	r0, r1
@   0x08012d98: 2800        cmp	r0, #0
@   0x08012d9a: d00e        beq.n	0x12dba
@   0x08012d9c: 4913        ldr	r1, [pc, #76]	@ (0x12dec)
@   0x08012d9e: 4a14        ldr	r2, [pc, #80]	@ (0x12df0)
@   0x08012da0: 1c10        adds	r0, r2, #0
@   0x08012da2: 8008        strh	r0, [r1, #0]
@   0x08012da4: 3102        adds	r1, #2
@   0x08012da6: 4a13        ldr	r2, [pc, #76]	@ (0x12df4)
@   0x08012da8: 1c10        adds	r0, r2, #0
@   0x08012daa: 8008        strh	r0, [r1, #0]
@   0x08012dac: 2002        movs	r0, #2
@   0x08012dae: f7fc        f871 	bl	0xee94
@   0x08012db2: 20fe        movs	r0, #254	@ 0xfe
@   0x08012db4: 7821        ldrb	r1, [r4, #0]
@   0x08012db6: 4008        ands	r0, r1
@   0x08012db8: 7020        strb	r0, [r4, #0]
@   0x08012dba: 4b0f        ldr	r3, [pc, #60]	@ (0x12df8)
@   0x08012dbc: 7898        ldrb	r0, [r3, #2]
@   0x08012dbe: 9000        str	r0, [sp, #0]
@   0x08012dc0: 480e        ldr	r0, [pc, #56]	@ (0x12dfc)
@   0x08012dc2: 9001        str	r0, [sp, #4]
@   0x08012dc4: 6818        ldr	r0, [r3, #0]
@   0x08012dc6: 6859        ldr	r1, [r3, #4]
@   0x08012dc8: 689a        ldr	r2, [r3, #8]
@   0x08012dca: 68db        ldr	r3, [r3, #12]
@   0x08012dcc: f000        ff48 	bl	0x13c60
@   0x08012dd0: f7ff        ff6c 	bl	0x12cac
@   0x08012dd4: 2004        movs	r0, #4
@   0x08012dd6: 2104        movs	r1, #4
@   0x08012dd8: f7fd        fe34 	bl	0x10a44
@   0x08012ddc: f004        f910 	bl	0x17000
@   0x08012de0: b002        add	sp, #8
@   0x08012de2: bc10        pop	{r4}
@   0x08012de4: bc01        pop	{r0}
@   0x08012de6: 4700        bx	r0
@   0x08012de8: 60a0        str	r0, [r4, #8]
@   0x08012dea: 0300        lsls	r0, r0, #12
@   0x08012dec: 0050        lsls	r0, r2, #1
@   0x08012dee: 0400        lsls	r0, r0, #16
@   0x08012df0: 1744        asrs	r4, r0, #29
@   0x08012df2: 0000        movs	r0, r0
@   0x08012df4: 0e02        lsrs	r2, r0, #24
@   0x08012df6: 0000        movs	r0, r0
@   0x08012df8: 6f08        ldr	r0, [r1, #112]	@ 0x70
@   0x08012dfa: 0830        lsrs	r0, r6, #32
@   0x08012dfc: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08012dfe: 0300        lsls	r0, r0, #12
@   0x08012e00: b500        push	{lr}
@   0x08012e02: 2003        movs	r0, #3
@   0x08012e04: f7fb        fd2a 	bl	0xe85c
@   0x08012e08: 2002        movs	r0, #2
@   0x08012e0a: f7fc        f813 	bl	0xee34
@   0x08012e0e: f7fb        fe85 	bl	0xeb1c
@   0x08012e12: f7ff        ff95 	bl	0x12d40
@   0x08012e16: 2003        movs	r0, #3
@   0x08012e18: f7fc        fa18 	bl	0xf24c
@   0x08012e1c: 2003        movs	r0, #3
@   0x08012e1e: f7fb        fedd 	bl	0xebdc
@   0x08012e22: f003        fe0d 	bl	0x16a40
@   0x08012e26: bc01        pop	{r0}
@   0x08012e28: 4700        bx	r0

        thumb_func_start sub_08012D88
sub_08012D88: @ 0x08012d88
        .incbin "frog_us_baserom.gba", 0x12d88, 0xa4
        thumb_func_end sub_08012D88
