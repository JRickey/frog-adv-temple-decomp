@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019fd8, 0x0801a0a4)  (204 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019fd8 --end 0x801a0a4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019fd8: b530        push	{r4, r5, lr}
@   0x08019fda: b081        sub	sp, #4
@   0x08019fdc: f7f0        f83e 	bl	0xa05c
@   0x08019fe0: 4668        mov	r0, sp
@   0x08019fe2: 2400        movs	r4, #0
@   0x08019fe4: 8004        strh	r4, [r0, #0]
@   0x08019fe6: 4b21        ldr	r3, [pc, #132]	@ (0x1a06c)
@   0x08019fe8: 6018        str	r0, [r3, #0]
@   0x08019fea: 20c0        movs	r0, #192	@ 0xc0
@   0x08019fec: 04c0        lsls	r0, r0, #19
@   0x08019fee: 6058        str	r0, [r3, #4]
@   0x08019ff0: 481f        ldr	r0, [pc, #124]	@ (0x1a070)
@   0x08019ff2: 6098        str	r0, [r3, #8]
@   0x08019ff4: 6898        ldr	r0, [r3, #8]
@   0x08019ff6: 491f        ldr	r1, [pc, #124]	@ (0x1a074)
@   0x08019ff8: 4a1f        ldr	r2, [pc, #124]	@ (0x1a078)
@   0x08019ffa: 1c10        adds	r0, r2, #0
@   0x08019ffc: 8008        strh	r0, [r1, #0]
@   0x08019ffe: 481f        ldr	r0, [pc, #124]	@ (0x1a07c)
@   0x0801a000: 8004        strh	r4, [r0, #0]
@   0x0801a002: 3004        adds	r0, #4
@   0x0801a004: 8004        strh	r4, [r0, #0]
@   0x0801a006: 3004        adds	r0, #4
@   0x0801a008: 8004        strh	r4, [r0, #0]
@   0x0801a00a: 3002        adds	r0, #2
@   0x0801a00c: 8004        strh	r4, [r0, #0]
@   0x0801a00e: 390e        subs	r1, #14
@   0x0801a010: 880a        ldrh	r2, [r1, #0]
@   0x0801a012: 481b        ldr	r0, [pc, #108]	@ (0x1a080)
@   0x0801a014: 4010        ands	r0, r2
@   0x0801a016: 8008        strh	r0, [r1, #0]
@   0x0801a018: 880a        ldrh	r2, [r1, #0]
@   0x0801a01a: 481a        ldr	r0, [pc, #104]	@ (0x1a084)
@   0x0801a01c: 4010        ands	r0, r2
@   0x0801a01e: 8008        strh	r0, [r1, #0]
@   0x0801a020: 4819        ldr	r0, [pc, #100]	@ (0x1a088)
@   0x0801a022: 2500        movs	r5, #0
@   0x0801a024: 8185        strh	r5, [r0, #12]
@   0x0801a026: 81c5        strh	r5, [r0, #14]
@   0x0801a028: 4a18        ldr	r2, [pc, #96]	@ (0x1a08c)
@   0x0801a02a: 4819        ldr	r0, [pc, #100]	@ (0x1a090)
@   0x0801a02c: 6801        ldr	r1, [r0, #0]
@   0x0801a02e: 0048        lsls	r0, r1, #1
@   0x0801a030: 1840        adds	r0, r0, r1
@   0x0801a032: 00c0        lsls	r0, r0, #3
@   0x0801a034: 3204        adds	r2, #4
@   0x0801a036: 1880        adds	r0, r0, r2
@   0x0801a038: 6800        ldr	r0, [r0, #0]
@   0x0801a03a: 6018        str	r0, [r3, #0]
@   0x0801a03c: 4815        ldr	r0, [pc, #84]	@ (0x1a094)
@   0x0801a03e: 6058        str	r0, [r3, #4]
@   0x0801a040: 4815        ldr	r0, [pc, #84]	@ (0x1a098)
@   0x0801a042: 6098        str	r0, [r3, #8]
@   0x0801a044: 6898        ldr	r0, [r3, #8]
@   0x0801a046: 4815        ldr	r0, [pc, #84]	@ (0x1a09c)
@   0x0801a048: 7004        strb	r4, [r0, #0]
@   0x0801a04a: 7044        strb	r4, [r0, #1]
@   0x0801a04c: 60c5        str	r5, [r0, #12]
@   0x0801a04e: 4914        ldr	r1, [pc, #80]	@ (0x1a0a0)
@   0x0801a050: 2008        movs	r0, #8
@   0x0801a052: 8dca        ldrh	r2, [r1, #46]	@ 0x2e
@   0x0801a054: 4050        eors	r0, r2
@   0x0801a056: 85c8        strh	r0, [r1, #46]	@ 0x2e
@   0x0801a058: f006        fda8 	bl	0x20bac
@   0x0801a05c: 200f        movs	r0, #15
@   0x0801a05e: f006        fd93 	bl	0x20b88
@   0x0801a062: b001        add	sp, #4
@   0x0801a064: bc30        pop	{r4, r5}
@   0x0801a066: bc01        pop	{r0}
@   0x0801a068: 4700        bx	r0
@   0x0801a06a: 0000        movs	r0, r0
@   0x0801a06c: 00d4        lsls	r4, r2, #3
@   0x0801a06e: 0400        lsls	r0, r0, #16
@   0x0801a070: 8000        strh	r0, [r0, #0]
@   0x0801a072: 8100        strh	r0, [r0, #8]
@   0x0801a074: 000e        movs	r6, r1
@   0x0801a076: 0400        lsls	r0, r0, #16
@   0x0801a078: 1f08        subs	r0, r1, #4
@   0x0801a07a: 0000        movs	r0, r0
@   0x0801a07c: 0040        lsls	r0, r0, #1
@   0x0801a07e: 0400        lsls	r0, r0, #16
@   0x0801a080: dfff        svc	255	@ 0xff
@   0x0801a082: 0000        movs	r0, r0
@   0x0801a084: bfff        itttt	<und>
@   0x0801a086: 0000        mov<und>	r0, r0
@   0x0801a088: 3550        add<und>	r5, #80	@ 0x50
@   0x0801a08a: 0300        lsl<und>	r0, r0, #12
@   0x0801a08c: 1254        asr<und>	r4, r2, #9
@   0x0801a08e: 080c        lsrs	r4, r1, #32
@   0x0801a090: 34b0        adds	r4, #176	@ 0xb0
@   0x0801a092: 0300        lsls	r0, r0, #12
@   0x0801a094: 8000        strh	r0, [r0, #0]
@   0x0801a096: 0600        lsls	r0, r0, #24
@   0x0801a098: 2000        movs	r0, #0
@   0x0801a09a: 8000        strh	r0, [r0, #0]
@   0x0801a09c: 34c0        adds	r4, #192	@ 0xc0
@   0x0801a09e: 0300        lsls	r0, r0, #12
@   0x0801a0a0: 6110        str	r0, [r2, #16]
@   0x0801a0a2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08019FD8
sub_08019FD8: @ 0x08019fd8
        .incbin "frog_us_baserom.gba", 0x19fd8, 0xcc
        thumb_func_end sub_08019FD8
