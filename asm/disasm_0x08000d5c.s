@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000d5c, 0x08000e0c)  (176 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000d5c --end 0x8000e0c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000d5c: b530        push	{r4, r5, lr}
@   0x08000d5e: b082        sub	sp, #8
@   0x08000d60: 4827        ldr	r0, [pc, #156]	@ (0xe00)
@   0x08000d62: 4b28        ldr	r3, [pc, #160]	@ (0xe04)
@   0x08000d64: 2101        movs	r1, #1
@   0x08000d66: 9100        str	r1, [sp, #0]
@   0x08000d68: 2105        movs	r1, #5
@   0x08000d6a: 9101        str	r1, [sp, #4]
@   0x08000d6c: 2164        movs	r1, #100	@ 0x64
@   0x08000d6e: 2202        movs	r2, #2
@   0x08000d70: f005        fc0c 	bl	0x658c
@   0x08000d74: 2003        movs	r0, #3
@   0x08000d76: 2100        movs	r1, #0
@   0x08000d78: f00c        f88e 	bl	0xce98
@   0x08000d7c: f008        ff9e 	bl	0x9cbc
@   0x08000d80: 4c21        ldr	r4, [pc, #132]	@ (0xe08)
@   0x08000d82: 7e20        ldrb	r0, [r4, #24]
@   0x08000d84: 7e61        ldrb	r1, [r4, #25]
@   0x08000d86: 220e        movs	r2, #14
@   0x08000d88: 9200        str	r2, [sp, #0]
@   0x08000d8a: 220d        movs	r2, #13
@   0x08000d8c: 2324        movs	r3, #36	@ 0x24
@   0x08000d8e: f00b        ff2b 	bl	0xcbe8
@   0x08000d92: 7e20        ldrb	r0, [r4, #24]
@   0x08000d94: 7e61        ldrb	r1, [r4, #25]
@   0x08000d96: 250d        movs	r5, #13
@   0x08000d98: 9500        str	r5, [sp, #0]
@   0x08000d9a: 220e        movs	r2, #14
@   0x08000d9c: 2324        movs	r3, #36	@ 0x24
@   0x08000d9e: f00b        ff23 	bl	0xcbe8
@   0x08000da2: 7e20        ldrb	r0, [r4, #24]
@   0x08000da4: 7e61        ldrb	r1, [r4, #25]
@   0x08000da6: 9500        str	r5, [sp, #0]
@   0x08000da8: 220e        movs	r2, #14
@   0x08000daa: 2323        movs	r3, #35	@ 0x23
@   0x08000dac: f00b        ff1c 	bl	0xcbe8
@   0x08000db0: 7e20        ldrb	r0, [r4, #24]
@   0x08000db2: 7e61        ldrb	r1, [r4, #25]
@   0x08000db4: 9500        str	r5, [sp, #0]
@   0x08000db6: 220e        movs	r2, #14
@   0x08000db8: 2322        movs	r3, #34	@ 0x22
@   0x08000dba: f00b        ff15 	bl	0xcbe8
@   0x08000dbe: 7e20        ldrb	r0, [r4, #24]
@   0x08000dc0: 7e61        ldrb	r1, [r4, #25]
@   0x08000dc2: 9500        str	r5, [sp, #0]
@   0x08000dc4: 220e        movs	r2, #14
@   0x08000dc6: 2321        movs	r3, #33	@ 0x21
@   0x08000dc8: f00b        ff0e 	bl	0xcbe8
@   0x08000dcc: 7e20        ldrb	r0, [r4, #24]
@   0x08000dce: 7e61        ldrb	r1, [r4, #25]
@   0x08000dd0: 9500        str	r5, [sp, #0]
@   0x08000dd2: 220e        movs	r2, #14
@   0x08000dd4: 2320        movs	r3, #32
@   0x08000dd6: f00b        ff07 	bl	0xcbe8
@   0x08000dda: 7e20        ldrb	r0, [r4, #24]
@   0x08000ddc: 7e61        ldrb	r1, [r4, #25]
@   0x08000dde: 9500        str	r5, [sp, #0]
@   0x08000de0: 220e        movs	r2, #14
@   0x08000de2: 231f        movs	r3, #31
@   0x08000de4: f00b        ff00 	bl	0xcbe8
@   0x08000de8: 7e20        ldrb	r0, [r4, #24]
@   0x08000dea: 7e61        ldrb	r1, [r4, #25]
@   0x08000dec: 9500        str	r5, [sp, #0]
@   0x08000dee: 220e        movs	r2, #14
@   0x08000df0: 231e        movs	r3, #30
@   0x08000df2: f00b        fef9 	bl	0xcbe8
@   0x08000df6: b002        add	sp, #8
@   0x08000df8: bc30        pop	{r4, r5}
@   0x08000dfa: bc01        pop	{r0}
@   0x08000dfc: 4700        bx	r0
@   0x08000dfe: 0000        movs	r0, r0
@   0x08000e00: 6110        str	r0, [r2, #16]
@   0x08000e02: 0300        lsls	r0, r0, #12
@   0x08000e04: 99e8        ldr	r1, [sp, #928]	@ 0x3a0
@   0x08000e06: 082f        lsrs	r7, r5, #32
@   0x08000e08: 35e0        adds	r5, #224	@ 0xe0
@   0x08000e0a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08000D5C
sub_08000D5C: @ 0x08000d5c
        .incbin "frog_us_baserom.gba", 0xd5c, 0xb0
        thumb_func_end sub_08000D5C
