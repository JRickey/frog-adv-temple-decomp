@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e00c, 0x0802e100)  (244 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e00c --end 0x802e100 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e00c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802e00e: b084        sub	sp, #16
@   0x0802e010: 1c0d        adds	r5, r1, #0
@   0x0802e012: 490c        ldr	r1, [pc, #48]	@ (0x2e044)
@   0x0802e014: 680a        ldr	r2, [r1, #0]
@   0x0802e016: 1c11        adds	r1, r2, #0
@   0x0802e018: 31c8        adds	r1, #200	@ 0xc8
@   0x0802e01a: 6809        ldr	r1, [r1, #0]
@   0x0802e01c: 0180        lsls	r0, r0, #6
@   0x0802e01e: 1840        adds	r0, r0, r1
@   0x0802e020: 303e        adds	r0, #62	@ 0x3e
@   0x0802e022: 7804        ldrb	r4, [r0, #0]
@   0x0802e024: 00a0        lsls	r0, r4, #2
@   0x0802e026: 2192        movs	r1, #146	@ 0x92
@   0x0802e028: 0049        lsls	r1, r1, #1
@   0x0802e02a: 1840        adds	r0, r0, r1
@   0x0802e02c: 1817        adds	r7, r2, r0
@   0x0802e02e: 683a        ldr	r2, [r7, #0]
@   0x0802e030: 2a00        cmp	r2, #0
@   0x0802e032: d109        bne.n	0x2e048
@   0x0802e034: 6869        ldr	r1, [r5, #4]
@   0x0802e036: 68a8        ldr	r0, [r5, #8]
@   0x0802e038: 4281        cmp	r1, r0
@   0x0802e03a: d23a        bcs.n	0x2e0b2
@   0x0802e03c: 60ea        str	r2, [r5, #12]
@   0x0802e03e: 612a        str	r2, [r5, #16]
@   0x0802e040: e037        b.n	0x2e0b2
@   0x0802e042: 0000        movs	r0, r0
@   0x0802e044: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e046: 0300        lsls	r0, r0, #12
@   0x0802e048: 68a9        ldr	r1, [r5, #8]
@   0x0802e04a: 6868        ldr	r0, [r5, #4]
@   0x0802e04c: 1a09        subs	r1, r1, r0
@   0x0802e04e: 3901        subs	r1, #1
@   0x0802e050: 2000        movs	r0, #0
@   0x0802e052: 6128        str	r0, [r5, #16]
@   0x0802e054: 60e8        str	r0, [r5, #12]
@   0x0802e056: 8aaa        ldrh	r2, [r5, #20]
@   0x0802e058: 01d0        lsls	r0, r2, #7
@   0x0802e05a: 8aea        ldrh	r2, [r5, #22]
@   0x0802e05c: 1810        adds	r0, r2, r0
@   0x0802e05e: 4a0d        ldr	r2, [pc, #52]	@ (0x2e094)
@   0x0802e060: 1880        adds	r0, r0, r2
@   0x0802e062: 1300        asrs	r0, r0, #12
@   0x0802e064: 1a46        subs	r6, r0, r1
@   0x0802e066: 2e00        cmp	r6, #0
@   0x0802e068: dd23        ble.n	0x2e0b2
@   0x0802e06a: aa02        add	r2, sp, #8
@   0x0802e06c: ab03        add	r3, sp, #12
@   0x0802e06e: 9400        str	r4, [sp, #0]
@   0x0802e070: 683c        ldr	r4, [r7, #0]
@   0x0802e072: 1c30        adds	r0, r6, #0
@   0x0802e074: a901        add	r1, sp, #4
@   0x0802e076: f005        fe37 	bl	0x33ce8
@   0x0802e07a: 1c03        adds	r3, r0, #0
@   0x0802e07c: 9a02        ldr	r2, [sp, #8]
@   0x0802e07e: 2a00        cmp	r2, #0
@   0x0802e080: d10c        bne.n	0x2e09c
@   0x0802e082: 9a01        ldr	r2, [sp, #4]
@   0x0802e084: 18d1        adds	r1, r2, r3
@   0x0802e086: 6868        ldr	r0, [r5, #4]
@   0x0802e088: 4281        cmp	r1, r0
@   0x0802e08a: d205        bcs.n	0x2e098
@   0x0802e08c: 60ea        str	r2, [r5, #12]
@   0x0802e08e: 612b        str	r3, [r5, #16]
@   0x0802e090: e00b        b.n	0x2e0aa
@   0x0802e092: 0000        movs	r0, r0
@   0x0802e094: 0fff        lsrs	r7, r7, #31
@   0x0802e096: 0000        movs	r0, r0
@   0x0802e098: 60a9        str	r1, [r5, #8]
@   0x0802e09a: e006        b.n	0x2e0aa
@   0x0802e09c: 9801        ldr	r0, [sp, #4]
@   0x0802e09e: 9903        ldr	r1, [sp, #12]
@   0x0802e0a0: 1840        adds	r0, r0, r1
@   0x0802e0a2: 60a8        str	r0, [r5, #8]
@   0x0802e0a4: 60ea        str	r2, [r5, #12]
@   0x0802e0a6: 1a59        subs	r1, r3, r1
@   0x0802e0a8: 6129        str	r1, [r5, #16]
@   0x0802e0aa: 42b3        cmp	r3, r6
@   0x0802e0ac: da01        bge.n	0x2e0b2
@   0x0802e0ae: 2000        movs	r0, #0
@   0x0802e0b0: 6038        str	r0, [r7, #0]
@   0x0802e0b2: b004        add	sp, #16
@   0x0802e0b4: bcf0        pop	{r4, r5, r6, r7}
@   0x0802e0b6: bc01        pop	{r0}
@   0x0802e0b8: 4700        bx	r0
@   0x0802e0ba: 0000        movs	r0, r0
@   0x0802e0bc: b510        push	{r4, lr}
@   0x0802e0be: 0600        lsls	r0, r0, #24
@   0x0802e0c0: 0e01        lsrs	r1, r0, #24
@   0x0802e0c2: 480a        ldr	r0, [pc, #40]	@ (0x2e0ec)
@   0x0802e0c4: 6802        ldr	r2, [r0, #0]
@   0x0802e0c6: 7813        ldrb	r3, [r2, #0]
@   0x0802e0c8: 428b        cmp	r3, r1
@   0x0802e0ca: d015        beq.n	0x2e0f8
@   0x0802e0cc: 248c        movs	r4, #140	@ 0x8c
@   0x0802e0ce: 0064        lsls	r4, r4, #1
@   0x0802e0d0: 1910        adds	r0, r2, r4
@   0x0802e0d2: 6800        ldr	r0, [r0, #0]
@   0x0802e0d4: 343a        adds	r4, #58	@ 0x3a
@   0x0802e0d6: 1900        adds	r0, r0, r4
@   0x0802e0d8: 7804        ldrb	r4, [r0, #0]
@   0x0802e0da: 42a1        cmp	r1, r4
@   0x0802e0dc: d900        bls.n	0x2e0e0
@   0x0802e0de: 7801        ldrb	r1, [r0, #0]
@   0x0802e0e0: 7011        strb	r1, [r2, #0]
@   0x0802e0e2: 2900        cmp	r1, #0
@   0x0802e0e4: d104        bne.n	0x2e0f0
@   0x0802e0e6: f001        ff37 	bl	0x2ff58
@   0x0802e0ea: e005        b.n	0x2e0f8
@   0x0802e0ec: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e0ee: 0300        lsls	r0, r0, #12
@   0x0802e0f0: 2b00        cmp	r3, #0
@   0x0802e0f2: d101        bne.n	0x2e0f8
@   0x0802e0f4: f002        f8cc 	bl	0x30290
@   0x0802e0f8: bc10        pop	{r4}
@   0x0802e0fa: bc01        pop	{r0}
@   0x0802e0fc: 4700        bx	r0

        thumb_func_start sub_0802E00C
sub_0802E00C: @ 0x0802e00c
        .incbin "frog_us_baserom.gba", 0x2e00c, 0xf4
        thumb_func_end sub_0802E00C
