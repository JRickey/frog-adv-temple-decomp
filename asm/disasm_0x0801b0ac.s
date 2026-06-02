@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b0ac, 0x0801b144)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b0ac --end 0x801b144 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b0ac: b500        push	{lr}
@   0x0801b0ae: 490f        ldr	r1, [pc, #60]	@ (0x1b0ec)
@   0x0801b0b0: 2202        movs	r2, #2
@   0x0801b0b2: 5e88        ldrsh	r0, [r1, r2]
@   0x0801b0b4: 2204        movs	r2, #4
@   0x0801b0b6: 5e89        ldrsh	r1, [r1, r2]
@   0x0801b0b8: f7ee        f842 	bl	0x9140
@   0x0801b0bc: 480c        ldr	r0, [pc, #48]	@ (0x1b0f0)
@   0x0801b0be: 7800        ldrb	r0, [r0, #0]
@   0x0801b0c0: f7ff        fb08 	bl	0x1a6d4
@   0x0801b0c4: 2002        movs	r0, #2
@   0x0801b0c6: f7f3        fd89 	bl	0xebdc
@   0x0801b0ca: 490a        ldr	r1, [pc, #40]	@ (0x1b0f4)
@   0x0801b0cc: 480a        ldr	r0, [pc, #40]	@ (0x1b0f8)
@   0x0801b0ce: 7a80        ldrb	r0, [r0, #10]
@   0x0801b0d0: 0080        lsls	r0, r0, #2
@   0x0801b0d2: 1840        adds	r0, r0, r1
@   0x0801b0d4: 6800        ldr	r0, [r0, #0]
@   0x0801b0d6: f018        fdff 	bl	0x33cd8
@   0x0801b0da: f7ee        fcbd 	bl	0x9a58
@   0x0801b0de: f7ee        f853 	bl	0x9188
@   0x0801b0e2: f7ef        f921 	bl	0xa328
@   0x0801b0e6: bc01        pop	{r0}
@   0x0801b0e8: 4700        bx	r0
@   0x0801b0ea: 0000        movs	r0, r0
@   0x0801b0ec: 3720        adds	r7, #32
@   0x0801b0ee: 0300        lsls	r0, r0, #12
@   0x0801b0f0: 0d84        lsrs	r4, r0, #22
@   0x0801b0f2: 080c        lsrs	r4, r1, #32
@   0x0801b0f4: 0cb8        lsrs	r0, r7, #18
@   0x0801b0f6: 080c        lsrs	r4, r1, #32
@   0x0801b0f8: 5330        strh	r0, [r6, r4]
@   0x0801b0fa: 0300        lsls	r0, r0, #12
@   0x0801b0fc: b510        push	{r4, lr}
@   0x0801b0fe: 0600        lsls	r0, r0, #24
@   0x0801b100: 0e03        lsrs	r3, r0, #24
@   0x0801b102: 480f        ldr	r0, [pc, #60]	@ (0x1b140)
@   0x0801b104: 2400        movs	r4, #0
@   0x0801b106: 8004        strh	r4, [r0, #0]
@   0x0801b108: 3004        adds	r0, #4
@   0x0801b10a: 8004        strh	r4, [r0, #0]
@   0x0801b10c: 3004        adds	r0, #4
@   0x0801b10e: 8004        strh	r4, [r0, #0]
@   0x0801b110: 3002        adds	r0, #2
@   0x0801b112: 8004        strh	r4, [r0, #0]
@   0x0801b114: 2180        movs	r1, #128	@ 0x80
@   0x0801b116: 04c9        lsls	r1, r1, #19
@   0x0801b118: 880a        ldrh	r2, [r1, #0]
@   0x0801b11a: 480a        ldr	r0, [pc, #40]	@ (0x1b144)
@   0x0801b11c: 4010        ands	r0, r2
@   0x0801b11e: 8008        strh	r0, [r1, #0]
@   0x0801b120: 880a        ldrh	r2, [r1, #0]
@   0x0801b122: 4809        ldr	r0, [pc, #36]	@ (0x1b148)
@   0x0801b124: 4010        ands	r0, r2
@   0x0801b126: 8008        strh	r0, [r1, #0]
@   0x0801b128: 2b00        cmp	r3, #0
@   0x0801b12a: d100        bne.n	0x1b12e
@   0x0801b12c: 2301        movs	r3, #1
@   0x0801b12e: 4807        ldr	r0, [pc, #28]	@ (0x1b14c)
@   0x0801b130: 7004        strb	r4, [r0, #0]
@   0x0801b132: 4907        ldr	r1, [pc, #28]	@ (0x1b150)
@   0x0801b134: 1dd8        adds	r0, r3, #7
@   0x0801b136: 7248        strb	r0, [r1, #9]
@   0x0801b138: bc10        pop	{r4}
@   0x0801b13a: bc01        pop	{r0}
@   0x0801b13c: 4700        bx	r0
@   0x0801b13e: 0000        movs	r0, r0
@   0x0801b140: 0040        lsls	r0, r0, #1
@   0x0801b142: 0400        lsls	r0, r0, #16

        thumb_func_start sub_0801B0AC
sub_0801B0AC: @ 0x0801b0ac
        .incbin "frog_us_baserom.gba", 0x1b0ac, 0x98
        thumb_func_end sub_0801B0AC
