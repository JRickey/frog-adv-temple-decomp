@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08021f64, 0x0802205c)  (248 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8021f64 --end 0x802205c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08021f64: b570        push	{r4, r5, r6, lr}
@   0x08021f66: 4656        mov	r6, sl
@   0x08021f68: 464d        mov	r5, r9
@   0x08021f6a: 4644        mov	r4, r8
@   0x08021f6c: b470        push	{r4, r5, r6}
@   0x08021f6e: b084        sub	sp, #16
@   0x08021f70: 4838        ldr	r0, [pc, #224]	@ (0x22054)
@   0x08021f72: 4680        mov	r8, r0
@   0x08021f74: 6801        ldr	r1, [r0, #0]
@   0x08021f76: 2080        movs	r0, #128	@ 0x80
@   0x08021f78: 00c0        lsls	r0, r0, #3
@   0x08021f7a: 4681        mov	r9, r0
@   0x08021f7c: 4e36        ldr	r6, [pc, #216]	@ (0x22058)
@   0x08021f7e: 9600        str	r6, [sp, #0]
@   0x08021f80: 2507        movs	r5, #7
@   0x08021f82: 9501        str	r5, [sp, #4]
@   0x08021f84: 2402        movs	r4, #2
@   0x08021f86: 9402        str	r4, [sp, #8]
@   0x08021f88: 2003        movs	r0, #3
@   0x08021f8a: 4682        mov	sl, r0
@   0x08021f8c: 9003        str	r0, [sp, #12]
@   0x08021f8e: 204c        movs	r0, #76	@ 0x4c
@   0x08021f90: 464a        mov	r2, r9
@   0x08021f92: 2313        movs	r3, #19
@   0x08021f94: f7ff        f884 	bl	0x210a0
@   0x08021f98: 4640        mov	r0, r8
@   0x08021f9a: 6841        ldr	r1, [r0, #4]
@   0x08021f9c: 9600        str	r6, [sp, #0]
@   0x08021f9e: 9501        str	r5, [sp, #4]
@   0x08021fa0: 9402        str	r4, [sp, #8]
@   0x08021fa2: 4650        mov	r0, sl
@   0x08021fa4: 9003        str	r0, [sp, #12]
@   0x08021fa6: 204d        movs	r0, #77	@ 0x4d
@   0x08021fa8: 464a        mov	r2, r9
@   0x08021faa: 2313        movs	r3, #19
@   0x08021fac: f7ff        f878 	bl	0x210a0
@   0x08021fb0: 4640        mov	r0, r8
@   0x08021fb2: 6881        ldr	r1, [r0, #8]
@   0x08021fb4: 9600        str	r6, [sp, #0]
@   0x08021fb6: 9501        str	r5, [sp, #4]
@   0x08021fb8: 9402        str	r4, [sp, #8]
@   0x08021fba: 4650        mov	r0, sl
@   0x08021fbc: 9003        str	r0, [sp, #12]
@   0x08021fbe: 204e        movs	r0, #78	@ 0x4e
@   0x08021fc0: 464a        mov	r2, r9
@   0x08021fc2: 2313        movs	r3, #19
@   0x08021fc4: f7ff        f86c 	bl	0x210a0
@   0x08021fc8: 4640        mov	r0, r8
@   0x08021fca: 68c1        ldr	r1, [r0, #12]
@   0x08021fcc: 9600        str	r6, [sp, #0]
@   0x08021fce: 9501        str	r5, [sp, #4]
@   0x08021fd0: 9402        str	r4, [sp, #8]
@   0x08021fd2: 4650        mov	r0, sl
@   0x08021fd4: 9003        str	r0, [sp, #12]
@   0x08021fd6: 204f        movs	r0, #79	@ 0x4f
@   0x08021fd8: 464a        mov	r2, r9
@   0x08021fda: 2313        movs	r3, #19
@   0x08021fdc: f7ff        f860 	bl	0x210a0
@   0x08021fe0: 4640        mov	r0, r8
@   0x08021fe2: 6901        ldr	r1, [r0, #16]
@   0x08021fe4: 9600        str	r6, [sp, #0]
@   0x08021fe6: 9501        str	r5, [sp, #4]
@   0x08021fe8: 9402        str	r4, [sp, #8]
@   0x08021fea: 4650        mov	r0, sl
@   0x08021fec: 9003        str	r0, [sp, #12]
@   0x08021fee: 2050        movs	r0, #80	@ 0x50
@   0x08021ff0: 464a        mov	r2, r9
@   0x08021ff2: 2313        movs	r3, #19
@   0x08021ff4: f7ff        f854 	bl	0x210a0
@   0x08021ff8: 4640        mov	r0, r8
@   0x08021ffa: 6941        ldr	r1, [r0, #20]
@   0x08021ffc: 9600        str	r6, [sp, #0]
@   0x08021ffe: 9501        str	r5, [sp, #4]
@   0x08022000: 9402        str	r4, [sp, #8]
@   0x08022002: 4650        mov	r0, sl
@   0x08022004: 9003        str	r0, [sp, #12]
@   0x08022006: 2051        movs	r0, #81	@ 0x51
@   0x08022008: 464a        mov	r2, r9
@   0x0802200a: 2313        movs	r3, #19
@   0x0802200c: f7ff        f848 	bl	0x210a0
@   0x08022010: 4640        mov	r0, r8
@   0x08022012: 6981        ldr	r1, [r0, #24]
@   0x08022014: 9600        str	r6, [sp, #0]
@   0x08022016: 9501        str	r5, [sp, #4]
@   0x08022018: 9402        str	r4, [sp, #8]
@   0x0802201a: 9403        str	r4, [sp, #12]
@   0x0802201c: 2052        movs	r0, #82	@ 0x52
@   0x0802201e: 464a        mov	r2, r9
@   0x08022020: 2313        movs	r3, #19
@   0x08022022: f7ff        f83d 	bl	0x210a0
@   0x08022026: 4640        mov	r0, r8
@   0x08022028: 69c1        ldr	r1, [r0, #28]
@   0x0802202a: 9600        str	r6, [sp, #0]
@   0x0802202c: 9501        str	r5, [sp, #4]
@   0x0802202e: 9402        str	r4, [sp, #8]
@   0x08022030: 9403        str	r4, [sp, #12]
@   0x08022032: 2053        movs	r0, #83	@ 0x53
@   0x08022034: 464a        mov	r2, r9
@   0x08022036: 2313        movs	r3, #19
@   0x08022038: f7ff        f832 	bl	0x210a0
@   0x0802203c: 204c        movs	r0, #76	@ 0x4c
@   0x0802203e: f7e4        f9d5 	bl	0x63ec
@   0x08022042: b004        add	sp, #16
@   0x08022044: bc38        pop	{r3, r4, r5}
@   0x08022046: 4698        mov	r8, r3
@   0x08022048: 46a1        mov	r9, r4
@   0x0802204a: 46aa        mov	sl, r5
@   0x0802204c: bc70        pop	{r4, r5, r6}
@   0x0802204e: bc01        pop	{r0}
@   0x08022050: 4700        bx	r0
@   0x08022052: 0000        movs	r0, r0
@   0x08022054: 13c8        asrs	r0, r1, #15
@   0x08022056: 0831        lsrs	r1, r6, #32
@   0x08022058: 01a5        lsls	r5, r4, #6

        thumb_func_start sub_08021F64
sub_08021F64: @ 0x08021f64
        .incbin "frog_us_baserom.gba", 0x21f64, 0xf8
        thumb_func_end sub_08021F64
