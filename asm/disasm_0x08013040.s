@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013040, 0x0801310c)  (204 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013040 --end 0x801310c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013040: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08013042: 464f        mov	r7, r9
@   0x08013044: 4646        mov	r6, r8
@   0x08013046: b4c0        push	{r6, r7}
@   0x08013048: b083        sub	sp, #12
@   0x0801304a: 4c29        ldr	r4, [pc, #164]	@ (0x130f0)
@   0x0801304c: 4a29        ldr	r2, [pc, #164]	@ (0x130f4)
@   0x0801304e: 20d3        movs	r0, #211	@ 0xd3
@   0x08013050: 0140        lsls	r0, r0, #5
@   0x08013052: 1813        adds	r3, r2, r0
@   0x08013054: 6820        ldr	r0, [r4, #0]
@   0x08013056: 6819        ldr	r1, [r3, #0]
@   0x08013058: 1a40        subs	r0, r0, r1
@   0x0801305a: 2807        cmp	r0, #7
@   0x0801305c: d940        bls.n	0x130e0
@   0x0801305e: 4d26        ldr	r5, [pc, #152]	@ (0x130f8)
@   0x08013060: 1951        adds	r1, r2, r5
@   0x08013062: 780f        ldrb	r7, [r1, #0]
@   0x08013064: 2f01        cmp	r7, #1
@   0x08013066: d901        bls.n	0x1306c
@   0x08013068: 2000        movs	r0, #0
@   0x0801306a: 7008        strb	r0, [r1, #0]
@   0x0801306c: 6820        ldr	r0, [r4, #0]
@   0x0801306e: 6018        str	r0, [r3, #0]
@   0x08013070: 2600        movs	r6, #0
@   0x08013072: 4688        mov	r8, r1
@   0x08013074: 4821        ldr	r0, [pc, #132]	@ (0x130fc)
@   0x08013076: 30d4        adds	r0, #212	@ 0xd4
@   0x08013078: 7800        ldrb	r0, [r0, #0]
@   0x0801307a: 4130        asrs	r0, r6
@   0x0801307c: 2101        movs	r1, #1
@   0x0801307e: 4008        ands	r0, r1
@   0x08013080: 2800        cmp	r0, #0
@   0x08013082: d022        beq.n	0x130ca
@   0x08013084: 4d1e        ldr	r5, [pc, #120]	@ (0x13100)
@   0x08013086: 0070        lsls	r0, r6, #1
@   0x08013088: 1980        adds	r0, r0, r6
@   0x0801308a: 00c2        lsls	r2, r0, #3
@   0x0801308c: 1953        adds	r3, r2, r5
@   0x0801308e: 7a18        ldrb	r0, [r3, #8]
@   0x08013090: 0904        lsrs	r4, r0, #4
@   0x08013092: 1c20        adds	r0, r4, #0
@   0x08013094: 4008        ands	r0, r1
@   0x08013096: 491b        ldr	r1, [pc, #108]	@ (0x13104)
@   0x08013098: 4689        mov	r9, r1
@   0x0801309a: 2800        cmp	r0, #0
@   0x0801309c: d001        beq.n	0x130a2
@   0x0801309e: 4f1a        ldr	r7, [pc, #104]	@ (0x13108)
@   0x080130a0: 46b9        mov	r9, r7
@   0x080130a2: 1c28        adds	r0, r5, #0
@   0x080130a4: 3010        adds	r0, #16
@   0x080130a6: 1810        adds	r0, r2, r0
@   0x080130a8: 6800        ldr	r0, [r0, #0]
@   0x080130aa: 4684        mov	ip, r0
@   0x080130ac: 7998        ldrb	r0, [r3, #6]
@   0x080130ae: 7919        ldrb	r1, [r3, #4]
@   0x080130b0: 881a        ldrh	r2, [r3, #0]
@   0x080130b2: 885b        ldrh	r3, [r3, #2]
@   0x080130b4: 9400        str	r4, [sp, #0]
@   0x080130b6: 4645        mov	r5, r8
@   0x080130b8: 782d        ldrb	r5, [r5, #0]
@   0x080130ba: 00ac        lsls	r4, r5, #2
@   0x080130bc: 4464        add	r4, ip
@   0x080130be: 6824        ldr	r4, [r4, #0]
@   0x080130c0: 9401        str	r4, [sp, #4]
@   0x080130c2: 464f        mov	r7, r9
@   0x080130c4: 9702        str	r7, [sp, #8]
@   0x080130c6: f7fd        f8c9 	bl	0x1025c
@   0x080130ca: 1c70        adds	r0, r6, #1
@   0x080130cc: 0600        lsls	r0, r0, #24
@   0x080130ce: 0e06        lsrs	r6, r0, #24
@   0x080130d0: 2e07        cmp	r6, #7
@   0x080130d2: d9cf        bls.n	0x13074
@   0x080130d4: 4807        ldr	r0, [pc, #28]	@ (0x130f4)
@   0x080130d6: 4908        ldr	r1, [pc, #32]	@ (0x130f8)
@   0x080130d8: 1840        adds	r0, r0, r1
@   0x080130da: 7801        ldrb	r1, [r0, #0]
@   0x080130dc: 3101        adds	r1, #1
@   0x080130de: 7001        strb	r1, [r0, #0]
@   0x080130e0: b003        add	sp, #12
@   0x080130e2: bc18        pop	{r3, r4}
@   0x080130e4: 4698        mov	r8, r3
@   0x080130e6: 46a1        mov	r9, r4
@   0x080130e8: bcf0        pop	{r4, r5, r6, r7}
@   0x080130ea: bc01        pop	{r0}
@   0x080130ec: 4700        bx	r0
@   0x080130ee: 0000        movs	r0, r0
@   0x080130f0: 5330        strh	r0, [r6, r4]
@   0x080130f2: 0300        lsls	r0, r0, #12
@   0x080130f4: 3720        adds	r7, #32
@   0x080130f6: 0300        lsls	r0, r0, #12
@   0x080130f8: 1a5b        subs	r3, r3, r1
@   0x080130fa: 0000        movs	r0, r0
@   0x080130fc: 3610        adds	r6, #16
@   0x080130fe: 0300        lsls	r0, r0, #12
@   0x08013100: 70ec        strb	r4, [r5, #3]
@   0x08013102: 0830        lsrs	r0, r6, #32
@   0x08013104: e000        b.n	0x13108
@   0x08013106: 0600        lsls	r0, r0, #24
@   0x08013108: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600

        thumb_func_start sub_08013040
sub_08013040: @ 0x08013040
        .incbin "frog_us_baserom.gba", 0x13040, 0xcc
        thumb_func_end sub_08013040
