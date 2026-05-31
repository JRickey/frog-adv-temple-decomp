@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802a9fc, 0x0802aae8)  (236 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802a9fc --end 0x802aae8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a9fc: b510        push	{r4, lr}
@   0x0802a9fe: 4905        ldr	r1, [pc, #20]	@ (0x2aa14)
@   0x0802aa00: 4805        ldr	r0, [pc, #20]	@ (0x2aa18)
@   0x0802aa02: 180b        adds	r3, r1, r0
@   0x0802aa04: 7818        ldrb	r0, [r3, #0]
@   0x0802aa06: 2801        cmp	r0, #1
@   0x0802aa08: d022        beq.n	0x2aa50
@   0x0802aa0a: 2801        cmp	r0, #1
@   0x0802aa0c: dc06        bgt.n	0x2aa1c
@   0x0802aa0e: 2800        cmp	r0, #0
@   0x0802aa10: d009        beq.n	0x2aa26
@   0x0802aa12: e05c        b.n	0x2aace
@   0x0802aa14: 3720        adds	r7, #32
@   0x0802aa16: 0300        lsls	r0, r0, #12
@   0x0802aa18: 02ba        lsls	r2, r7, #10
@   0x0802aa1a: 0000        movs	r0, r0
@   0x0802aa1c: 2802        cmp	r0, #2
@   0x0802aa1e: d022        beq.n	0x2aa66
@   0x0802aa20: 2803        cmp	r0, #3
@   0x0802aa22: d03b        beq.n	0x2aa9c
@   0x0802aa24: e053        b.n	0x2aace
@   0x0802aa26: 24b5        movs	r4, #181	@ 0xb5
@   0x0802aa28: 00a4        lsls	r4, r4, #2
@   0x0802aa2a: 190a        adds	r2, r1, r4
@   0x0802aa2c: 8811        ldrh	r1, [r2, #0]
@   0x0802aa2e: 2002        movs	r0, #2
@   0x0802aa30: 4008        ands	r0, r1
@   0x0802aa32: 2800        cmp	r0, #0
@   0x0802aa34: d14b        bne.n	0x2aace
@   0x0802aa36: 2080        movs	r0, #128	@ 0x80
@   0x0802aa38: 0200        lsls	r0, r0, #8
@   0x0802aa3a: 4008        ands	r0, r1
@   0x0802aa3c: 2800        cmp	r0, #0
@   0x0802aa3e: d046        beq.n	0x2aace
@   0x0802aa40: 2002        movs	r0, #2
@   0x0802aa42: 4308        orrs	r0, r1
@   0x0802aa44: 4901        ldr	r1, [pc, #4]	@ (0x2aa4c)
@   0x0802aa46: 4008        ands	r0, r1
@   0x0802aa48: 8010        strh	r0, [r2, #0]
@   0x0802aa4a: e040        b.n	0x2aace
@   0x0802aa4c: 7fff        ldrb	r7, [r7, #31]
@   0x0802aa4e: 0000        movs	r0, r0
@   0x0802aa50: 20b5        movs	r0, #181	@ 0xb5
@   0x0802aa52: 0080        lsls	r0, r0, #2
@   0x0802aa54: 180c        adds	r4, r1, r0
@   0x0802aa56: 8821        ldrh	r1, [r4, #0]
@   0x0802aa58: 2002        movs	r0, #2
@   0x0802aa5a: 4008        ands	r0, r1
@   0x0802aa5c: 0400        lsls	r0, r0, #16
@   0x0802aa5e: 0c02        lsrs	r2, r0, #16
@   0x0802aa60: 2a00        cmp	r2, #0
@   0x0802aa62: d134        bne.n	0x2aace
@   0x0802aa64: e00b        b.n	0x2aa7e
@   0x0802aa66: 22b5        movs	r2, #181	@ 0xb5
@   0x0802aa68: 0092        lsls	r2, r2, #2
@   0x0802aa6a: 188c        adds	r4, r1, r2
@   0x0802aa6c: 8821        ldrh	r1, [r4, #0]
@   0x0802aa6e: 1c0a        adds	r2, r1, #0
@   0x0802aa70: 4002        ands	r2, r0
@   0x0802aa72: 2a00        cmp	r2, #0
@   0x0802aa74: d003        beq.n	0x2aa7e
@   0x0802aa76: 2022        movs	r0, #34	@ 0x22
@   0x0802aa78: f7f6        f8fe 	bl	0x20c78
@   0x0802aa7c: e027        b.n	0x2aace
@   0x0802aa7e: 2080        movs	r0, #128	@ 0x80
@   0x0802aa80: 0200        lsls	r0, r0, #8
@   0x0802aa82: 4008        ands	r0, r1
@   0x0802aa84: 2800        cmp	r0, #0
@   0x0802aa86: d022        beq.n	0x2aace
@   0x0802aa88: 701a        strb	r2, [r3, #0]
@   0x0802aa8a: 2002        movs	r0, #2
@   0x0802aa8c: 4308        orrs	r0, r1
@   0x0802aa8e: 4902        ldr	r1, [pc, #8]	@ (0x2aa98)
@   0x0802aa90: 4008        ands	r0, r1
@   0x0802aa92: 8020        strh	r0, [r4, #0]
@   0x0802aa94: e01b        b.n	0x2aace
@   0x0802aa96: 0000        movs	r0, r0
@   0x0802aa98: 7fff        ldrb	r7, [r7, #31]
@   0x0802aa9a: 0000        movs	r0, r0
@   0x0802aa9c: 24b5        movs	r4, #181	@ 0xb5
@   0x0802aa9e: 00a4        lsls	r4, r4, #2
@   0x0802aaa0: 190b        adds	r3, r1, r4
@   0x0802aaa2: 881a        ldrh	r2, [r3, #0]
@   0x0802aaa4: 2002        movs	r0, #2
@   0x0802aaa6: 4010        ands	r0, r2
@   0x0802aaa8: 2800        cmp	r0, #0
@   0x0802aaaa: d003        beq.n	0x2aab4
@   0x0802aaac: 2073        movs	r0, #115	@ 0x73
@   0x0802aaae: f7f6        f8e3 	bl	0x20c78
@   0x0802aab2: e00c        b.n	0x2aace
@   0x0802aab4: 2080        movs	r0, #128	@ 0x80
@   0x0802aab6: 0200        lsls	r0, r0, #8
@   0x0802aab8: 4010        ands	r0, r2
@   0x0802aaba: 2800        cmp	r0, #0
@   0x0802aabc: d007        beq.n	0x2aace
@   0x0802aabe: 4907        ldr	r1, [pc, #28]	@ (0x2aadc)
@   0x0802aac0: 2008        movs	r0, #8
@   0x0802aac2: 8dcc        ldrh	r4, [r1, #46]	@ 0x2e
@   0x0802aac4: 4320        orrs	r0, r4
@   0x0802aac6: 85c8        strh	r0, [r1, #46]	@ 0x2e
@   0x0802aac8: 4805        ldr	r0, [pc, #20]	@ (0x2aae0)
@   0x0802aaca: 4010        ands	r0, r2
@   0x0802aacc: 8018        strh	r0, [r3, #0]
@   0x0802aace: 4805        ldr	r0, [pc, #20]	@ (0x2aae4)
@   0x0802aad0: f7da        ff78 	bl	0x59c4
@   0x0802aad4: bc10        pop	{r4}
@   0x0802aad6: bc01        pop	{r0}
@   0x0802aad8: 4700        bx	r0
@   0x0802aada: 0000        movs	r0, r0
@   0x0802aadc: 6110        str	r0, [r2, #16]
@   0x0802aade: 0300        lsls	r0, r0, #12
@   0x0802aae0: 7fff        ldrb	r7, [r7, #31]
@   0x0802aae2: 0000        movs	r0, r0
@   0x0802aae4: 39c0        subs	r1, #192	@ 0xc0
@   0x0802aae6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802A9FC
sub_0802A9FC: @ 0x0802a9fc
        .incbin "frog_us_baserom.gba", 0x2a9fc, 0xec
        thumb_func_end sub_0802A9FC
