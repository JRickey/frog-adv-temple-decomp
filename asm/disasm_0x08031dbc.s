@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031dbc, 0x08031e24)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031dbc --end 0x8031e24 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031dbc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08031dbe: 4818        ldr	r0, [pc, #96]	@ (0x31e20)
@   0x08031dc0: 6804        ldr	r4, [r0, #0]
@   0x08031dc2: 218c        movs	r1, #140	@ 0x8c
@   0x08031dc4: 0049        lsls	r1, r1, #1
@   0x08031dc6: 1860        adds	r0, r4, r1
@   0x08031dc8: 6807        ldr	r7, [r0, #0]
@   0x08031dca: 22a5        movs	r2, #165	@ 0xa5
@   0x08031dcc: 0052        lsls	r2, r2, #1
@   0x08031dce: 18be        adds	r6, r7, r2
@   0x08031dd0: 8830        ldrh	r0, [r6, #0]
@   0x08031dd2: 0201        lsls	r1, r0, #8
@   0x08031dd4: 0240        lsls	r0, r0, #9
@   0x08031dd6: 1840        adds	r0, r0, r1
@   0x08031dd8: 0140        lsls	r0, r0, #5
@   0x08031dda: 21e1        movs	r1, #225	@ 0xe1
@   0x08031ddc: 0109        lsls	r1, r1, #4
@   0x08031dde: f002        f881 	bl	0x33ee4
@   0x08031de2: 21a4        movs	r1, #164	@ 0xa4
@   0x08031de4: 0049        lsls	r1, r1, #1
@   0x08031de6: 187d        adds	r5, r7, r1
@   0x08031de8: 882a        ldrh	r2, [r5, #0]
@   0x08031dea: 4350        muls	r0, r2
@   0x08031dec: 0b00        lsrs	r0, r0, #12
@   0x08031dee: 22a6        movs	r2, #166	@ 0xa6
@   0x08031df0: 0052        lsls	r2, r2, #1
@   0x08031df2: 18b9        adds	r1, r7, r2
@   0x08031df4: 8008        strh	r0, [r1, #0]
@   0x08031df6: 8831        ldrh	r1, [r6, #0]
@   0x08031df8: 0048        lsls	r0, r1, #1
@   0x08031dfa: 1840        adds	r0, r0, r1
@   0x08031dfc: 0440        lsls	r0, r0, #17
@   0x08031dfe: 8862        ldrh	r2, [r4, #2]
@   0x08031e00: 0091        lsls	r1, r2, #2
@   0x08031e02: 1889        adds	r1, r1, r2
@   0x08031e04: f002        f86e 	bl	0x33ee4
@   0x08031e08: 0300        lsls	r0, r0, #12
@   0x08031e0a: 8829        ldrh	r1, [r5, #0]
@   0x08031e0c: f002        f86a 	bl	0x33ee4
@   0x08031e10: 22a7        movs	r2, #167	@ 0xa7
@   0x08031e12: 0052        lsls	r2, r2, #1
@   0x08031e14: 18b9        adds	r1, r7, r2
@   0x08031e16: 8008        strh	r0, [r1, #0]
@   0x08031e18: bcf0        pop	{r4, r5, r6, r7}
@   0x08031e1a: bc01        pop	{r0}
@   0x08031e1c: 4700        bx	r0
@   0x08031e1e: 0000        movs	r0, r0
@   0x08031e20: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031e22: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08031DBC
sub_08031DBC: @ 0x08031dbc
        .incbin "frog_us_baserom.gba", 0x31dbc, 0x68
        thumb_func_end sub_08031DBC
