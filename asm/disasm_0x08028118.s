@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028118, 0x08028188)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028118 --end 0x8028188 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028118: b510        push	{r4, lr}
@   0x0802811a: b082        sub	sp, #8
@   0x0802811c: 4c16        ldr	r4, [pc, #88]	@ (0x28178)
@   0x0802811e: 1c20        adds	r0, r4, #0
@   0x08028120: 2105        movs	r1, #5
@   0x08028122: 2200        movs	r2, #0
@   0x08028124: f7de        fb3a 	bl	0x679c
@   0x08028128: 0600        lsls	r0, r0, #24
@   0x0802812a: 2800        cmp	r0, #0
@   0x0802812c: d009        beq.n	0x28142
@   0x0802812e: 4913        ldr	r1, [pc, #76]	@ (0x2817c)
@   0x08028130: 2000        movs	r0, #0
@   0x08028132: 9000        str	r0, [sp, #0]
@   0x08028134: 2001        movs	r0, #1
@   0x08028136: 9001        str	r0, [sp, #4]
@   0x08028138: 204a        movs	r0, #74	@ 0x4a
@   0x0802813a: 229b        movs	r2, #155	@ 0x9b
@   0x0802813c: 2330        movs	r3, #48	@ 0x30
@   0x0802813e: f7f9        fddd 	bl	0x21cfc
@   0x08028142: 1c20        adds	r0, r4, #0
@   0x08028144: 2105        movs	r1, #5
@   0x08028146: 2205        movs	r2, #5
@   0x08028148: f7de        fb28 	bl	0x679c
@   0x0802814c: 0600        lsls	r0, r0, #24
@   0x0802814e: 2800        cmp	r0, #0
@   0x08028150: d009        beq.n	0x28166
@   0x08028152: 490b        ldr	r1, [pc, #44]	@ (0x28180)
@   0x08028154: 4a0b        ldr	r2, [pc, #44]	@ (0x28184)
@   0x08028156: 2000        movs	r0, #0
@   0x08028158: 9000        str	r0, [sp, #0]
@   0x0802815a: 2001        movs	r0, #1
@   0x0802815c: 9001        str	r0, [sp, #4]
@   0x0802815e: 204b        movs	r0, #75	@ 0x4b
@   0x08028160: 2330        movs	r3, #48	@ 0x30
@   0x08028162: f7f9        fdcb 	bl	0x21cfc
@   0x08028166: 204a        movs	r0, #74	@ 0x4a
@   0x08028168: 214b        movs	r1, #75	@ 0x4b
@   0x0802816a: f7dd        fdd1 	bl	0x5d10
@   0x0802816e: b002        add	sp, #8
@   0x08028170: bc10        pop	{r4}
@   0x08028172: bc01        pop	{r0}
@   0x08028174: 4700        bx	r0
@   0x08028176: 0000        movs	r0, r0
@   0x08028178: 6110        str	r0, [r2, #16]
@   0x0802817a: 0300        lsls	r0, r0, #12
@   0x0802817c: 045b        lsls	r3, r3, #17
@   0x0802817e: 0000        movs	r0, r0
@   0x08028180: 06b3        lsls	r3, r6, #26
@   0x08028182: 0000        movs	r0, r0
@   0x08028184: 012b        lsls	r3, r5, #4

        thumb_func_start sub_08028118
sub_08028118: @ 0x08028118
        .incbin "baserom.gba", 0x28118, 0x70
        thumb_func_end sub_08028118
