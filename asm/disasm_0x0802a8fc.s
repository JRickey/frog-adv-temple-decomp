@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802a8fc, 0x0802a9fc)  (256 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802a8fc --end 0x802a9fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a8fc: b530        push	{r4, r5, lr}
@   0x0802a8fe: 4a0f        ldr	r2, [pc, #60]	@ (0x2a93c)
@   0x0802a900: 490f        ldr	r1, [pc, #60]	@ (0x2a940)
@   0x0802a902: 1850        adds	r0, r2, r1
@   0x0802a904: 7800        ldrb	r0, [r0, #0]
@   0x0802a906: 2803        cmp	r0, #3
@   0x0802a908: d152        bne.n	0x2a9b0
@   0x0802a90a: 3101        adds	r1, #1
@   0x0802a90c: 1850        adds	r0, r2, r1
@   0x0802a90e: 7800        ldrb	r0, [r0, #0]
@   0x0802a910: 2802        cmp	r0, #2
@   0x0802a912: d003        beq.n	0x2a91c
@   0x0802a914: 2806        cmp	r0, #6
@   0x0802a916: d001        beq.n	0x2a91c
@   0x0802a918: 280a        cmp	r0, #10
@   0x0802a91a: d115        bne.n	0x2a948
@   0x0802a91c: 2099        movs	r0, #153	@ 0x99
@   0x0802a91e: 0080        lsls	r0, r0, #2
@   0x0802a920: 1814        adds	r4, r2, r0
@   0x0802a922: 3864        subs	r0, #100	@ 0x64
@   0x0802a924: 8821        ldrh	r1, [r4, #0]
@   0x0802a926: 4008        ands	r0, r1
@   0x0802a928: 2800        cmp	r0, #0
@   0x0802a92a: d016        beq.n	0x2a95a
@   0x0802a92c: 202b        movs	r0, #43	@ 0x2b
@   0x0802a92e: f7f6        f9a3 	bl	0x20c78
@   0x0802a932: 4804        ldr	r0, [pc, #16]	@ (0x2a944)
@   0x0802a934: 8822        ldrh	r2, [r4, #0]
@   0x0802a936: 4010        ands	r0, r2
@   0x0802a938: 8020        strh	r0, [r4, #0]
@   0x0802a93a: e00e        b.n	0x2a95a
@   0x0802a93c: 3720        adds	r7, #32
@   0x0802a93e: 0300        lsls	r0, r0, #12
@   0x0802a940: 024a        lsls	r2, r1, #9
@   0x0802a942: 0000        movs	r0, r0
@   0x0802a944: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x0802a948: 2199        movs	r1, #153	@ 0x99
@   0x0802a94a: 0089        lsls	r1, r1, #2
@   0x0802a94c: 1850        adds	r0, r2, r1
@   0x0802a94e: 2280        movs	r2, #128	@ 0x80
@   0x0802a950: 0092        lsls	r2, r2, #2
@   0x0802a952: 1c11        adds	r1, r2, #0
@   0x0802a954: 8802        ldrh	r2, [r0, #0]
@   0x0802a956: 4311        orrs	r1, r2
@   0x0802a958: 8001        strh	r1, [r0, #0]
@   0x0802a95a: 4b11        ldr	r3, [pc, #68]	@ (0x2a9a0)
@   0x0802a95c: 2099        movs	r0, #153	@ 0x99
@   0x0802a95e: 0080        lsls	r0, r0, #2
@   0x0802a960: 181d        adds	r5, r3, r0
@   0x0802a962: 882a        ldrh	r2, [r5, #0]
@   0x0802a964: 2402        movs	r4, #2
@   0x0802a966: 2002        movs	r0, #2
@   0x0802a968: 4010        ands	r0, r2
@   0x0802a96a: 2800        cmp	r0, #0
@   0x0802a96c: d13c        bne.n	0x2a9e8
@   0x0802a96e: 2080        movs	r0, #128	@ 0x80
@   0x0802a970: 0200        lsls	r0, r0, #8
@   0x0802a972: 4010        ands	r0, r2
@   0x0802a974: 2800        cmp	r0, #0
@   0x0802a976: d037        beq.n	0x2a9e8
@   0x0802a978: 480a        ldr	r0, [pc, #40]	@ (0x2a9a4)
@   0x0802a97a: 1819        adds	r1, r3, r0
@   0x0802a97c: 2005        movs	r0, #5
@   0x0802a97e: 7008        strb	r0, [r1, #0]
@   0x0802a980: 4322        orrs	r2, r4
@   0x0802a982: 4809        ldr	r0, [pc, #36]	@ (0x2a9a8)
@   0x0802a984: 1819        adds	r1, r3, r0
@   0x0802a986: 2006        movs	r0, #6
@   0x0802a988: 7008        strb	r0, [r1, #0]
@   0x0802a98a: 20a7        movs	r0, #167	@ 0xa7
@   0x0802a98c: 0080        lsls	r0, r0, #2
@   0x0802a98e: 1819        adds	r1, r3, r0
@   0x0802a990: 8808        ldrh	r0, [r1, #0]
@   0x0802a992: 4320        orrs	r0, r4
@   0x0802a994: 8008        strh	r0, [r1, #0]
@   0x0802a996: 4805        ldr	r0, [pc, #20]	@ (0x2a9ac)
@   0x0802a998: 4002        ands	r2, r0
@   0x0802a99a: 802a        strh	r2, [r5, #0]
@   0x0802a99c: e024        b.n	0x2a9e8
@   0x0802a99e: 0000        movs	r0, r0
@   0x0802a9a0: 3720        adds	r7, #32
@   0x0802a9a2: 0300        lsls	r0, r0, #12
@   0x0802a9a4: 024a        lsls	r2, r1, #9
@   0x0802a9a6: 0000        movs	r0, r0
@   0x0802a9a8: 0282        lsls	r2, r0, #10
@   0x0802a9aa: 0000        movs	r0, r0
@   0x0802a9ac: 7fff        ldrb	r7, [r7, #31]
@   0x0802a9ae: 0000        movs	r0, r0
@   0x0802a9b0: 2199        movs	r1, #153	@ 0x99
@   0x0802a9b2: 0089        lsls	r1, r1, #2
@   0x0802a9b4: 1853        adds	r3, r2, r1
@   0x0802a9b6: 8819        ldrh	r1, [r3, #0]
@   0x0802a9b8: 2480        movs	r4, #128	@ 0x80
@   0x0802a9ba: 0224        lsls	r4, r4, #8
@   0x0802a9bc: 1c20        adds	r0, r4, #0
@   0x0802a9be: 4008        ands	r0, r1
@   0x0802a9c0: 2800        cmp	r0, #0
@   0x0802a9c2: d004        beq.n	0x2a9ce
@   0x0802a9c4: 2002        movs	r0, #2
@   0x0802a9c6: 4308        orrs	r0, r1
@   0x0802a9c8: 490b        ldr	r1, [pc, #44]	@ (0x2a9f8)
@   0x0802a9ca: 4008        ands	r0, r1
@   0x0802a9cc: 8018        strh	r0, [r3, #0]
@   0x0802a9ce: 20a7        movs	r0, #167	@ 0xa7
@   0x0802a9d0: 0080        lsls	r0, r0, #2
@   0x0802a9d2: 1812        adds	r2, r2, r0
@   0x0802a9d4: 8811        ldrh	r1, [r2, #0]
@   0x0802a9d6: 1c20        adds	r0, r4, #0
@   0x0802a9d8: 4008        ands	r0, r1
@   0x0802a9da: 2800        cmp	r0, #0
@   0x0802a9dc: d004        beq.n	0x2a9e8
@   0x0802a9de: 2002        movs	r0, #2
@   0x0802a9e0: 4308        orrs	r0, r1
@   0x0802a9e2: 4905        ldr	r1, [pc, #20]	@ (0x2a9f8)
@   0x0802a9e4: 4008        ands	r0, r1
@   0x0802a9e6: 8010        strh	r0, [r2, #0]
@   0x0802a9e8: 200a        movs	r0, #10
@   0x0802a9ea: 210b        movs	r1, #11
@   0x0802a9ec: f7db        f990 	bl	0x5d10
@   0x0802a9f0: bc30        pop	{r4, r5}
@   0x0802a9f2: bc01        pop	{r0}
@   0x0802a9f4: 4700        bx	r0
@   0x0802a9f6: 0000        movs	r0, r0
@   0x0802a9f8: 7fff        ldrb	r7, [r7, #31]

        thumb_func_start Entity10_UpdateStatus
Entity10_UpdateStatus: @ 0x0802a8fc
        .incbin "frog_us_baserom.gba", 0x2a8fc, 0x100
        thumb_func_end Entity10_UpdateStatus
