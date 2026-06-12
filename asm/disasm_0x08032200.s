@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08032200, 0x080322e8)  (232 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8032200 --end 0x80322e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08032200: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08032202: 4647        mov	r7, r8
@   0x08032204: b480        push	{r7}
@   0x08032206: 1c06        adds	r6, r0, #0
@   0x08032208: 2103        movs	r1, #3
@   0x0803220a: 4008        ands	r0, r1
@   0x0803220c: 2800        cmp	r0, #0
@   0x0803220e: d165        bne.n	0x322dc
@   0x08032210: 4830        ldr	r0, [pc, #192]	@ (0x322d4)
@   0x08032212: 4680        mov	r8, r0
@   0x08032214: 6800        ldr	r0, [r0, #0]
@   0x08032216: 228c        movs	r2, #140	@ 0x8c
@   0x08032218: 0052        lsls	r2, r2, #1
@   0x0803221a: 1880        adds	r0, r0, r2
@   0x0803221c: 6805        ldr	r5, [r0, #0]
@   0x0803221e: 4b2e        ldr	r3, [pc, #184]	@ (0x322d8)
@   0x08032220: 18ef        adds	r7, r5, r3
@   0x08032222: 1c08        adds	r0, r1, #0
@   0x08032224: 783c        ldrb	r4, [r7, #0]
@   0x08032226: 4020        ands	r0, r4
@   0x08032228: 2801        cmp	r0, #1
@   0x0803222a: d157        bne.n	0x322dc
@   0x0803222c: 1c30        adds	r0, r6, #0
@   0x0803222e: 1c29        adds	r1, r5, #0
@   0x08032230: 2288        movs	r2, #136	@ 0x88
@   0x08032232: f7fc        f8af 	bl	0x2e394
@   0x08032236: 1c30        adds	r0, r6, #0
@   0x08032238: 3088        adds	r0, #136	@ 0x88
@   0x0803223a: 1c29        adds	r1, r5, #0
@   0x0803223c: 3188        adds	r1, #136	@ 0x88
@   0x0803223e: 2288        movs	r2, #136	@ 0x88
@   0x08032240: f7fc        f8a8 	bl	0x2e394
@   0x08032244: 248a        movs	r4, #138	@ 0x8a
@   0x08032246: 0064        lsls	r4, r4, #1
@   0x08032248: 1930        adds	r0, r6, r4
@   0x0803224a: 228c        movs	r2, #140	@ 0x8c
@   0x0803224c: 0052        lsls	r2, r2, #1
@   0x0803224e: 18a9        adds	r1, r5, r2
@   0x08032250: 2210        movs	r2, #16
@   0x08032252: f7fc        f89f 	bl	0x2e394
@   0x08032256: 2392        movs	r3, #146	@ 0x92
@   0x08032258: 005b        lsls	r3, r3, #1
@   0x0803225a: 18f0        adds	r0, r6, r3
@   0x0803225c: 2294        movs	r2, #148	@ 0x94
@   0x0803225e: 0052        lsls	r2, r2, #1
@   0x08032260: 18a9        adds	r1, r5, r2
@   0x08032262: 2210        movs	r2, #16
@   0x08032264: f7fc        f896 	bl	0x2e394
@   0x08032268: 239a        movs	r3, #154	@ 0x9a
@   0x0803226a: 005b        lsls	r3, r3, #1
@   0x0803226c: 18f0        adds	r0, r6, r3
@   0x0803226e: 229c        movs	r2, #156	@ 0x9c
@   0x08032270: 0052        lsls	r2, r2, #1
@   0x08032272: 18a9        adds	r1, r5, r2
@   0x08032274: 2210        movs	r2, #16
@   0x08032276: f7fc        f88d 	bl	0x2e394
@   0x0803227a: 2388        movs	r3, #136	@ 0x88
@   0x0803227c: 005b        lsls	r3, r3, #1
@   0x0803227e: 18f1        adds	r1, r6, r3
@   0x08032280: 192c        adds	r4, r5, r4
@   0x08032282: 6820        ldr	r0, [r4, #0]
@   0x08032284: 6008        str	r0, [r1, #0]
@   0x08032286: 22a4        movs	r2, #164	@ 0xa4
@   0x08032288: 0052        lsls	r2, r2, #1
@   0x0803228a: 18a8        adds	r0, r5, r2
@   0x0803228c: 8801        ldrh	r1, [r0, #0]
@   0x0803228e: 24a2        movs	r4, #162	@ 0xa2
@   0x08032290: 0064        lsls	r4, r4, #1
@   0x08032292: 1930        adds	r0, r6, r4
@   0x08032294: 8001        strh	r1, [r0, #0]
@   0x08032296: 21a5        movs	r1, #165	@ 0xa5
@   0x08032298: 0049        lsls	r1, r1, #1
@   0x0803229a: 1868        adds	r0, r5, r1
@   0x0803229c: 8800        ldrh	r0, [r0, #0]
@   0x0803229e: 3402        adds	r4, #2
@   0x080322a0: 1933        adds	r3, r6, r4
@   0x080322a2: 8018        strh	r0, [r3, #0]
@   0x080322a4: 23a6        movs	r3, #166	@ 0xa6
@   0x080322a6: 005b        lsls	r3, r3, #1
@   0x080322a8: 18e8        adds	r0, r5, r3
@   0x080322aa: 8800        ldrh	r0, [r0, #0]
@   0x080322ac: 18b2        adds	r2, r6, r2
@   0x080322ae: 8010        strh	r0, [r2, #0]
@   0x080322b0: 22a7        movs	r2, #167	@ 0xa7
@   0x080322b2: 0052        lsls	r2, r2, #1
@   0x080322b4: 18a8        adds	r0, r5, r2
@   0x080322b6: 8800        ldrh	r0, [r0, #0]
@   0x080322b8: 1871        adds	r1, r6, r1
@   0x080322ba: 8008        strh	r0, [r1, #0]
@   0x080322bc: 4644        mov	r4, r8
@   0x080322be: 6820        ldr	r0, [r4, #0]
@   0x080322c0: 7840        ldrb	r0, [r0, #1]
@   0x080322c2: 3a01        subs	r2, #1
@   0x080322c4: 18b1        adds	r1, r6, r2
@   0x080322c6: 7008        strb	r0, [r1, #0]
@   0x080322c8: 7838        ldrb	r0, [r7, #0]
@   0x080322ca: 18f3        adds	r3, r6, r3
@   0x080322cc: 7018        strb	r0, [r3, #0]
@   0x080322ce: 2001        movs	r0, #1
@   0x080322d0: e005        b.n	0x322de
@   0x080322d2: 0000        movs	r0, r0
@   0x080322d4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080322d6: 0300        lsls	r0, r0, #12
@   0x080322d8: 0151        lsls	r1, r2, #5
@   0x080322da: 0000        movs	r0, r0
@   0x080322dc: 2000        movs	r0, #0
@   0x080322de: bc08        pop	{r3}
@   0x080322e0: 4698        mov	r8, r3
@   0x080322e2: bcf0        pop	{r4, r5, r6, r7}
@   0x080322e4: bc02        pop	{r1}
@   0x080322e6: 4708        bx	r1

        thumb_func_start sub_08032200
sub_08032200: @ 0x08032200
        .incbin "baserom.gba", 0x32200, 0xe8
        thumb_func_end sub_08032200
