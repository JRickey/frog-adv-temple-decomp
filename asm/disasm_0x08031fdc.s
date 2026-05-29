@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031fdc, 0x08032094)  (184 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031fdc --end 0x8032094 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031fdc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08031fde: 4647        mov	r7, r8
@   0x08031fe0: b480        push	{r7}
@   0x08031fe2: 4680        mov	r8, r0
@   0x08031fe4: 4815        ldr	r0, [pc, #84]	@ (0x3203c)
@   0x08031fe6: 6801        ldr	r1, [r0, #0]
@   0x08031fe8: 228c        movs	r2, #140	@ 0x8c
@   0x08031fea: 0052        lsls	r2, r2, #1
@   0x08031fec: 1889        adds	r1, r1, r2
@   0x08031fee: 680d        ldr	r5, [r1, #0]
@   0x08031ff0: 4913        ldr	r1, [pc, #76]	@ (0x32040)
@   0x08031ff2: 186b        adds	r3, r5, r1
@   0x08031ff4: 781a        ldrb	r2, [r3, #0]
@   0x08031ff6: 2103        movs	r1, #3
@   0x08031ff8: 4011        ands	r1, r2
@   0x08031ffa: 4684        mov	ip, r0
@   0x08031ffc: 2903        cmp	r1, #3
@   0x08031ffe: d143        bne.n	0x32088
@   0x08032000: 20fc        movs	r0, #252	@ 0xfc
@   0x08032002: 4010        ands	r0, r2
@   0x08032004: 7018        strb	r0, [r3, #0]
@   0x08032006: 4642        mov	r2, r8
@   0x08032008: 2a00        cmp	r2, #0
@   0x0803200a: d034        beq.n	0x32076
@   0x0803200c: 2400        movs	r4, #0
@   0x0803200e: 4661        mov	r1, ip
@   0x08032010: 6808        ldr	r0, [r1, #0]
@   0x08032012: 7800        ldrb	r0, [r0, #0]
@   0x08032014: 3004        adds	r0, #4
@   0x08032016: 4284        cmp	r4, r0
@   0x08032018: da2d        bge.n	0x32076
@   0x0803201a: 2288        movs	r2, #136	@ 0x88
@   0x0803201c: 0052        lsls	r2, r2, #1
@   0x0803201e: 18ae        adds	r6, r5, r2
@   0x08032020: 2500        movs	r5, #0
@   0x08032022: 2700        movs	r7, #0
@   0x08032024: 6830        ldr	r0, [r6, #0]
@   0x08032026: 1828        adds	r0, r5, r0
@   0x08032028: 7900        ldrb	r0, [r0, #4]
@   0x0803202a: 2800        cmp	r0, #0
@   0x0803202c: d01b        beq.n	0x32066
@   0x0803202e: 4640        mov	r0, r8
@   0x08032030: 2801        cmp	r0, #1
@   0x08032032: d107        bne.n	0x32044
@   0x08032034: 1c20        adds	r0, r4, #0
@   0x08032036: f7fd        fcdb 	bl	0x2f9f0
@   0x0803203a: e00f        b.n	0x3205c
@   0x0803203c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803203e: 0300        lsls	r0, r0, #12
@   0x08032040: 0151        lsls	r1, r2, #5
@   0x08032042: 0000        movs	r0, r0
@   0x08032044: 480f        ldr	r0, [pc, #60]	@ (0x32084)
@   0x08032046: 6800        ldr	r0, [r0, #0]
@   0x08032048: 218a        movs	r1, #138	@ 0x8a
@   0x0803204a: 0049        lsls	r1, r1, #1
@   0x0803204c: 1840        adds	r0, r0, r1
@   0x0803204e: 6801        ldr	r1, [r0, #0]
@   0x08032050: 0120        lsls	r0, r4, #4
@   0x08032052: 1840        adds	r0, r0, r1
@   0x08032054: 6007        str	r7, [r0, #0]
@   0x08032056: 1c20        adds	r0, r4, #0
@   0x08032058: f7fc        fb64 	bl	0x2e724
@   0x0803205c: 6830        ldr	r0, [r6, #0]
@   0x0803205e: 1828        adds	r0, r5, r0
@   0x08032060: 7107        strb	r7, [r0, #4]
@   0x08032062: 4a08        ldr	r2, [pc, #32]	@ (0x32084)
@   0x08032064: 4694        mov	ip, r2
@   0x08032066: 350c        adds	r5, #12
@   0x08032068: 3401        adds	r4, #1
@   0x0803206a: 4661        mov	r1, ip
@   0x0803206c: 6808        ldr	r0, [r1, #0]
@   0x0803206e: 7800        ldrb	r0, [r0, #0]
@   0x08032070: 3004        adds	r0, #4
@   0x08032072: 4284        cmp	r4, r0
@   0x08032074: dbd6        blt.n	0x32024
@   0x08032076: 4662        mov	r2, ip
@   0x08032078: 6811        ldr	r1, [r2, #0]
@   0x0803207a: 2000        movs	r0, #0
@   0x0803207c: 7048        strb	r0, [r1, #1]
@   0x0803207e: 2001        movs	r0, #1
@   0x08032080: e003        b.n	0x3208a
@   0x08032082: 0000        movs	r0, r0
@   0x08032084: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032086: 0300        lsls	r0, r0, #12
@   0x08032088: 2000        movs	r0, #0
@   0x0803208a: bc08        pop	{r3}
@   0x0803208c: 4698        mov	r8, r3
@   0x0803208e: bcf0        pop	{r4, r5, r6, r7}
@   0x08032090: bc02        pop	{r1}
@   0x08032092: 4708        bx	r1

        thumb_func_start sub_08031FDC
sub_08031FDC: @ 0x08031fdc
        .incbin "frog_us_baserom.gba", 0x31fdc, 0xb8
        thumb_func_end sub_08031FDC
