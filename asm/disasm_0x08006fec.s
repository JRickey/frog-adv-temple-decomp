@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006fec, 0x080070a0)  (180 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006fec --end 0x80070a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006fec: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08006fee: 4657        mov	r7, sl
@   0x08006ff0: 464e        mov	r6, r9
@   0x08006ff2: 4645        mov	r5, r8
@   0x08006ff4: b4e0        push	{r5, r6, r7}
@   0x08006ff6: 4682        mov	sl, r0
@   0x08006ff8: 0609        lsls	r1, r1, #24
@   0x08006ffa: 0e0b        lsrs	r3, r1, #24
@   0x08006ffc: 2000        movs	r0, #0
@   0x08006ffe: 4680        mov	r8, r0
@   0x08007000: 4903        ldr	r1, [pc, #12]	@ (0x7010)
@   0x08007002: 2004        movs	r0, #4
@   0x08007004: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08007006: 4008        ands	r0, r1
@   0x08007008: 2800        cmp	r0, #0
@   0x0800700a: d003        beq.n	0x7014
@   0x0800700c: 2000        movs	r0, #0
@   0x0800700e: e03c        b.n	0x708a
@   0x08007010: 3720        adds	r7, #32
@   0x08007012: 0300        lsls	r0, r0, #12
@   0x08007014: 2200        movs	r2, #0
@   0x08007016: 0618        lsls	r0, r3, #24
@   0x08007018: 1601        asrs	r1, r0, #24
@   0x0800701a: 4681        mov	r9, r0
@   0x0800701c: 4588        cmp	r8, r1
@   0x0800701e: da33        bge.n	0x7088
@   0x08007020: 4f1d        ldr	r7, [pc, #116]	@ (0x7098)
@   0x08007022: 0612        lsls	r2, r2, #24
@   0x08007024: 1611        asrs	r1, r2, #24
@   0x08007026: 00c8        lsls	r0, r1, #3
@   0x08007028: 1840        adds	r0, r0, r1
@   0x0800702a: 0080        lsls	r0, r0, #2
@   0x0800702c: 4651        mov	r1, sl
@   0x0800702e: 1844        adds	r4, r0, r1
@   0x08007030: 21fd        movs	r1, #253	@ 0xfd
@   0x08007032: 7ea0        ldrb	r0, [r4, #26]
@   0x08007034: 4001        ands	r1, r0
@   0x08007036: 76a1        strb	r1, [r4, #26]
@   0x08007038: 2001        movs	r0, #1
@   0x0800703a: 4001        ands	r1, r0
@   0x0800703c: 1c16        adds	r6, r2, #0
@   0x0800703e: 2900        cmp	r1, #0
@   0x08007040: d11c        bne.n	0x707c
@   0x08007042: 4d16        ldr	r5, [pc, #88]	@ (0x709c)
@   0x08007044: 79a9        ldrb	r1, [r5, #6]
@   0x08007046: 7a20        ldrb	r0, [r4, #8]
@   0x08007048: 4281        cmp	r1, r0
@   0x0800704a: d117        bne.n	0x707c
@   0x0800704c: 1c28        adds	r0, r5, #0
@   0x0800704e: 1c21        adds	r1, r4, #0
@   0x08007050: f000        fb28 	bl	0x76a4
@   0x08007054: 2800        cmp	r0, #0
@   0x08007056: d011        beq.n	0x707c
@   0x08007058: 7ead        ldrb	r5, [r5, #26]
@   0x0800705a: 2d03        cmp	r5, #3
@   0x0800705c: d904        bls.n	0x7068
@   0x0800705e: 2010        movs	r0, #16
@   0x08007060: 8a39        ldrh	r1, [r7, #16]
@   0x08007062: 4008        ands	r0, r1
@   0x08007064: 2800        cmp	r0, #0
@   0x08007066: d009        beq.n	0x707c
@   0x08007068: 2002        movs	r0, #2
@   0x0800706a: 7ea1        ldrb	r1, [r4, #26]
@   0x0800706c: 4308        orrs	r0, r1
@   0x0800706e: 76a0        strb	r0, [r4, #26]
@   0x08007070: 2002        movs	r0, #2
@   0x08007072: 8a39        ldrh	r1, [r7, #16]
@   0x08007074: 4308        orrs	r0, r1
@   0x08007076: 8238        strh	r0, [r7, #16]
@   0x08007078: 2001        movs	r0, #1
@   0x0800707a: 4680        mov	r8, r0
@   0x0800707c: 2180        movs	r1, #128	@ 0x80
@   0x0800707e: 0449        lsls	r1, r1, #17
@   0x08007080: 1870        adds	r0, r6, r1
@   0x08007082: 0e02        lsrs	r2, r0, #24
@   0x08007084: 4548        cmp	r0, r9
@   0x08007086: dbcc        blt.n	0x7022
@   0x08007088: 4640        mov	r0, r8
@   0x0800708a: bc38        pop	{r3, r4, r5}
@   0x0800708c: 4698        mov	r8, r3
@   0x0800708e: 46a1        mov	r9, r4
@   0x08007090: 46aa        mov	sl, r5
@   0x08007092: bcf0        pop	{r4, r5, r6, r7}
@   0x08007094: bc02        pop	{r1}
@   0x08007096: 4708        bx	r1
@   0x08007098: 35e0        adds	r5, #224	@ 0xe0
@   0x0800709a: 0300        lsls	r0, r0, #12
@   0x0800709c: 3720        adds	r7, #32
@   0x0800709e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08006FEC
sub_08006FEC: @ 0x08006fec
        .incbin "frog_us_baserom.gba", 0x6fec, 0xb4
        thumb_func_end sub_08006FEC
