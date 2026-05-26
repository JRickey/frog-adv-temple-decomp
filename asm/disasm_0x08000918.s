@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000918, 0x08000b6c)  (596 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000918 --end 0x8000b6c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000918: b570        push	{r4, r5, r6, lr}
@   0x0800091a: b08d        sub	sp, #52	@ 0x34
@   0x0800091c: 4668        mov	r0, sp
@   0x0800091e: 3029        adds	r0, #41	@ 0x29
@   0x08000920: 2100        movs	r1, #0
@   0x08000922: 7001        strb	r1, [r0, #0]
@   0x08000924: 4909        ldr	r1, [pc, #36]	@ (0x94c)
@   0x08000926: 7a49        ldrb	r1, [r1, #9]
@   0x08000928: 1c06        adds	r6, r0, #0
@   0x0800092a: 2908        cmp	r1, #8
@   0x0800092c: d002        beq.n	0x934
@   0x0800092e: 2918        cmp	r1, #24
@   0x08000930: d000        beq.n	0x934
@   0x08000932: e115        b.n	0xb60
@   0x08000934: f020        f944 	bl	0x20bc0
@   0x08000938: 7830        ldrb	r0, [r6, #0]
@   0x0800093a: 280d        cmp	r0, #13
@   0x0800093c: d900        bls.n	0x940
@   0x0800093e: e107        b.n	0xb50
@   0x08000940: 0080        lsls	r0, r0, #2
@   0x08000942: 4903        ldr	r1, [pc, #12]	@ (0x950)
@   0x08000944: 1840        adds	r0, r0, r1
@   0x08000946: 6800        ldr	r0, [r0, #0]
@   0x08000948: 4687        mov	pc, r0
@   0x0800094a: 0000        movs	r0, r0
@   0x0800094c: 5330        strh	r0, [r6, r4]
@   0x0800094e: 0300        lsls	r0, r0, #12
@   0x08000950: 0954        lsrs	r4, r2, #5
@   0x08000952: 0800        lsrs	r0, r0, #32
@   0x08000954: 098c        lsrs	r4, r1, #6
@   0x08000956: 0800        lsrs	r0, r0, #32
@   0x08000958: 09a0        lsrs	r0, r4, #6
@   0x0800095a: 0800        lsrs	r0, r0, #32
@   0x0800095c: 09c8        lsrs	r0, r1, #7
@   0x0800095e: 0800        lsrs	r0, r0, #32
@   0x08000960: 09e4        lsrs	r4, r4, #7
@   0x08000962: 0800        lsrs	r0, r0, #32
@   0x08000964: 0a68        lsrs	r0, r5, #9
@   0x08000966: 0800        lsrs	r0, r0, #32
@   0x08000968: 0a7e        lsrs	r6, r7, #9
@   0x0800096a: 0800        lsrs	r0, r0, #32
@   0x0800096c: 0aa4        lsrs	r4, r4, #10
@   0x0800096e: 0800        lsrs	r0, r0, #32
@   0x08000970: 0adc        lsrs	r4, r3, #11
@   0x08000972: 0800        lsrs	r0, r0, #32
@   0x08000974: 0b1c        lsrs	r4, r3, #12
@   0x08000976: 0800        lsrs	r0, r0, #32
@   0x08000978: 0b50        lsrs	r0, r2, #13
@   0x0800097a: 0800        lsrs	r0, r0, #32
@   0x0800097c: 0b50        lsrs	r0, r2, #13
@   0x0800097e: 0800        lsrs	r0, r0, #32
@   0x08000980: 0b50        lsrs	r0, r2, #13
@   0x08000982: 0800        lsrs	r0, r0, #32
@   0x08000984: 0b50        lsrs	r0, r2, #13
@   0x08000986: 0800        lsrs	r0, r0, #32
@   0x08000988: 0b4c        lsrs	r4, r1, #13
@   0x0800098a: 0800        lsrs	r0, r0, #32
@   0x0800098c: a90b        add	r1, sp, #44	@ 0x2c
@   0x0800098e: 4668        mov	r0, sp
@   0x08000990: f000        f982 	bl	0xc98
@   0x08000994: 2001        movs	r0, #1
@   0x08000996: 7030        strb	r0, [r6, #0]
@   0x08000998: a90a        add	r1, sp, #40	@ 0x28
@   0x0800099a: 2000        movs	r0, #0
@   0x0800099c: 7008        strb	r0, [r1, #0]
@   0x0800099e: e0d7        b.n	0xb50
@   0x080009a0: ac0a        add	r4, sp, #40	@ 0x28
@   0x080009a2: 4907        ldr	r1, [pc, #28]	@ (0x9c0)
@   0x080009a4: 1c20        adds	r0, r4, #0
@   0x080009a6: f009        fbad 	bl	0xa104
@   0x080009aa: 0600        lsls	r0, r0, #24
@   0x080009ac: 2800        cmp	r0, #0
@   0x080009ae: d100        bne.n	0x9b2
@   0x080009b0: e0c4        b.n	0xb3c
@   0x080009b2: 2002        movs	r0, #2
@   0x080009b4: 7030        strb	r0, [r6, #0]
@   0x080009b6: 4903        ldr	r1, [pc, #12]	@ (0x9c4)
@   0x080009b8: 2000        movs	r0, #0
@   0x080009ba: 6148        str	r0, [r1, #20]
@   0x080009bc: 7020        strb	r0, [r4, #0]
@   0x080009be: e0bd        b.n	0xb3c
@   0x080009c0: 0cb1        lsrs	r1, r6, #18
@   0x080009c2: 0800        lsrs	r0, r0, #32
@   0x080009c4: 5330        strh	r0, [r6, r4]
@   0x080009c6: 0300        lsls	r0, r0, #12
@   0x080009c8: a80a        add	r0, sp, #40	@ 0x28
@   0x080009ca: f009        f9e7 	bl	0x9d9c
@   0x080009ce: 2800        cmp	r0, #0
@   0x080009d0: d100        bne.n	0x9d4
@   0x080009d2: e0bd        b.n	0xb50
@   0x080009d4: 2003        movs	r0, #3
@   0x080009d6: 7030        strb	r0, [r6, #0]
@   0x080009d8: 4901        ldr	r1, [pc, #4]	@ (0x9e0)
@   0x080009da: 2000        movs	r0, #0
@   0x080009dc: 6148        str	r0, [r1, #20]
@   0x080009de: e0b7        b.n	0xb50
@   0x080009e0: 5330        strh	r0, [r6, r4]
@   0x080009e2: 0300        lsls	r0, r0, #12
@   0x080009e4: f7ff        fd6e 	bl	0x4c4
@   0x080009e8: 4905        ldr	r1, [pc, #20]	@ (0xa00)
@   0x080009ea: 8008        strh	r0, [r1, #0]
@   0x080009ec: 0400        lsls	r0, r0, #16
@   0x080009ee: 0c00        lsrs	r0, r0, #16
@   0x080009f0: 2840        cmp	r0, #64	@ 0x40
@   0x080009f2: d107        bne.n	0xa04
@   0x080009f4: 2006        movs	r0, #6
@   0x080009f6: 7030        strb	r0, [r6, #0]
@   0x080009f8: f00d        fb32 	bl	0xe060
@   0x080009fc: e0a8        b.n	0xb50
@   0x080009fe: 0000        movs	r0, r0
@   0x08000a00: 5398        strh	r0, [r3, r6]
@   0x08000a02: 0300        lsls	r0, r0, #12
@   0x08000a04: 4904        ldr	r1, [pc, #16]	@ (0xa18)
@   0x08000a06: 2308        movs	r3, #8
@   0x08000a08: 1c18        adds	r0, r3, #0
@   0x08000a0a: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08000a0c: 4008        ands	r0, r1
@   0x08000a0e: 2800        cmp	r0, #0
@   0x08000a10: d004        beq.n	0xa1c
@   0x08000a12: 2004        movs	r0, #4
@   0x08000a14: 7030        strb	r0, [r6, #0]
@   0x08000a16: e09b        b.n	0xb50
@   0x08000a18: 3720        adds	r7, #32
@   0x08000a1a: 0300        lsls	r0, r0, #12
@   0x08000a1c: 4a09        ldr	r2, [pc, #36]	@ (0xa44)
@   0x08000a1e: 8dd1        ldrh	r1, [r2, #46]	@ 0x2e
@   0x08000a20: 2002        movs	r0, #2
@   0x08000a22: 4008        ands	r0, r1
@   0x08000a24: 2800        cmp	r0, #0
@   0x08000a26: d00f        beq.n	0xa48
@   0x08000a28: 1c10        adds	r0, r2, #0
@   0x08000a2a: 2102        movs	r1, #2
@   0x08000a2c: f005        ff8c 	bl	0x6948
@   0x08000a30: f009        f8b6 	bl	0x9ba0
@   0x08000a34: 3801        subs	r0, #1
@   0x08000a36: 0600        lsls	r0, r0, #24
@   0x08000a38: 0e00        lsrs	r0, r0, #24
@   0x08000a3a: f00d        fde1 	bl	0xe600
@   0x08000a3e: 2005        movs	r0, #5
@   0x08000a40: 7030        strb	r0, [r6, #0]
@   0x08000a42: e085        b.n	0xb50
@   0x08000a44: 6110        str	r0, [r2, #16]
@   0x08000a46: 0300        lsls	r0, r0, #12
@   0x08000a48: 1c18        adds	r0, r3, #0
@   0x08000a4a: 4008        ands	r0, r1
@   0x08000a4c: 2800        cmp	r0, #0
@   0x08000a4e: d006        beq.n	0xa5e
@   0x08000a50: 1c10        adds	r0, r2, #0
@   0x08000a52: 2108        movs	r1, #8
@   0x08000a54: f005        ff78 	bl	0x6948
@   0x08000a58: 200d        movs	r0, #13
@   0x08000a5a: 7030        strb	r0, [r6, #0]
@   0x08000a5c: e078        b.n	0xb50
@   0x08000a5e: a90b        add	r1, sp, #44	@ 0x2c
@   0x08000a60: 4668        mov	r0, sp
@   0x08000a62: f000        f943 	bl	0xcec
@   0x08000a66: e073        b.n	0xb50
@   0x08000a68: f00e        fa92 	bl	0xef90
@   0x08000a6c: aa0b        add	r2, sp, #44	@ 0x2c
@   0x08000a6e: 1c30        adds	r0, r6, #0
@   0x08000a70: 4669        mov	r1, sp
@   0x08000a72: f000        f95b 	bl	0xd2c
@   0x08000a76: a90a        add	r1, sp, #40	@ 0x28
@   0x08000a78: 2000        movs	r0, #0
@   0x08000a7a: 7008        strb	r0, [r1, #0]
@   0x08000a7c: e068        b.n	0xb50
@   0x08000a7e: f7ff        fd21 	bl	0x4c4
@   0x08000a82: 4906        ldr	r1, [pc, #24]	@ (0xa9c)
@   0x08000a84: 8008        strh	r0, [r1, #0]
@   0x08000a86: f00f        f963 	bl	0xfd50
@   0x08000a8a: 2800        cmp	r0, #0
@   0x08000a8c: d160        bne.n	0xb50
@   0x08000a8e: 2003        movs	r0, #3
@   0x08000a90: 7030        strb	r0, [r6, #0]
@   0x08000a92: 4803        ldr	r0, [pc, #12]	@ (0xaa0)
@   0x08000a94: 2102        movs	r1, #2
@   0x08000a96: f005        ff57 	bl	0x6948
@   0x08000a9a: e059        b.n	0xb50
@   0x08000a9c: 5398        strh	r0, [r3, r6]
@   0x08000a9e: 0300        lsls	r0, r0, #12
@   0x08000aa0: 6110        str	r0, [r2, #16]
@   0x08000aa2: 0300        lsls	r0, r0, #12
@   0x08000aa4: f7ff        fd0e 	bl	0x4c4
@   0x08000aa8: 490a        ldr	r1, [pc, #40]	@ (0xad4)
@   0x08000aaa: 8008        strh	r0, [r1, #0]
@   0x08000aac: f00d        fdfc 	bl	0xe6a8
@   0x08000ab0: 0600        lsls	r0, r0, #24
@   0x08000ab2: 0e04        lsrs	r4, r0, #24
@   0x08000ab4: 2c00        cmp	r4, #0
@   0x08000ab6: d105        bne.n	0xac4
@   0x08000ab8: f00e        fa6a 	bl	0xef90
@   0x08000abc: 2007        movs	r0, #7
@   0x08000abe: 7030        strb	r0, [r6, #0]
@   0x08000ac0: a80a        add	r0, sp, #40	@ 0x28
@   0x08000ac2: 7004        strb	r4, [r0, #0]
@   0x08000ac4: 4804        ldr	r0, [pc, #16]	@ (0xad8)
@   0x08000ac6: 7800        ldrb	r0, [r0, #0]
@   0x08000ac8: 2800        cmp	r0, #0
@   0x08000aca: d141        bne.n	0xb50
@   0x08000acc: 2003        movs	r0, #3
@   0x08000ace: 7030        strb	r0, [r6, #0]
@   0x08000ad0: e03e        b.n	0xb50
@   0x08000ad2: 0000        movs	r0, r0
@   0x08000ad4: 5398        strh	r0, [r3, r6]
@   0x08000ad6: 0300        lsls	r0, r0, #12
@   0x08000ad8: 5328        strh	r0, [r5, r4]
@   0x08000ada: 0300        lsls	r0, r0, #12
@   0x08000adc: ac0a        add	r4, sp, #40	@ 0x28
@   0x08000ade: 2000        movs	r0, #0
@   0x08000ae0: 5620        ldrsb	r0, [r4, r0]
@   0x08000ae2: 2800        cmp	r0, #0
@   0x08000ae4: d105        bne.n	0xaf2
@   0x08000ae6: 20bf        movs	r0, #191	@ 0xbf
@   0x08000ae8: f00f        fdd4 	bl	0x10694
@   0x08000aec: 7820        ldrb	r0, [r4, #0]
@   0x08000aee: 3001        adds	r0, #1
@   0x08000af0: 7020        strb	r0, [r4, #0]
@   0x08000af2: 7824        ldrb	r4, [r4, #0]
@   0x08000af4: 0624        lsls	r4, r4, #24
@   0x08000af6: 1624        asrs	r4, r4, #24
@   0x08000af8: 2c01        cmp	r4, #1
@   0x08000afa: d129        bne.n	0xb50
@   0x08000afc: f00f        fddc 	bl	0x106b8
@   0x08000b00: 0600        lsls	r0, r0, #24
@   0x08000b02: 2800        cmp	r0, #0
@   0x08000b04: d124        bne.n	0xb50
@   0x08000b06: 4803        ldr	r0, [pc, #12]	@ (0xb14)
@   0x08000b08: 2104        movs	r1, #4
@   0x08000b0a: 7001        strb	r1, [r0, #0]
@   0x08000b0c: 7184        strb	r4, [r0, #6]
@   0x08000b0e: 4802        ldr	r0, [pc, #8]	@ (0xb18)
@   0x08000b10: 7241        strb	r1, [r0, #9]
@   0x08000b12: e01d        b.n	0xb50
@   0x08000b14: 3480        adds	r4, #128	@ 0x80
@   0x08000b16: 0300        lsls	r0, r0, #12
@   0x08000b18: 5330        strh	r0, [r6, r4]
@   0x08000b1a: 0300        lsls	r0, r0, #12
@   0x08000b1c: ad0a        add	r5, sp, #40	@ 0x28
@   0x08000b1e: 4909        ldr	r1, [pc, #36]	@ (0xb44)
@   0x08000b20: 1c28        adds	r0, r5, #0
@   0x08000b22: f009        faef 	bl	0xa104
@   0x08000b26: 0600        lsls	r0, r0, #24
@   0x08000b28: 2800        cmp	r0, #0
@   0x08000b2a: d007        beq.n	0xb3c
@   0x08000b2c: 2002        movs	r0, #2
@   0x08000b2e: 7030        strb	r0, [r6, #0]
@   0x08000b30: 4805        ldr	r0, [pc, #20]	@ (0xb48)
@   0x08000b32: 2400        movs	r4, #0
@   0x08000b34: 6144        str	r4, [r0, #20]
@   0x08000b36: f009        fb47 	bl	0xa1c8
@   0x08000b3a: 702c        strb	r4, [r5, #0]
@   0x08000b3c: f7ff        fece 	bl	0x8dc
@   0x08000b40: e006        b.n	0xb50
@   0x08000b42: 0000        movs	r0, r0
@   0x08000b44: a26d        add	r2, pc, #436	@ (adr r2, 0xcfc)
@   0x08000b46: 0800        lsrs	r0, r0, #32
@   0x08000b48: 5330        strh	r0, [r6, r4]
@   0x08000b4a: 0300        lsls	r0, r0, #12
@   0x08000b4c: f000        f900 	bl	0xd50
@   0x08000b50: 4805        ldr	r0, [pc, #20]	@ (0xb68)
@   0x08000b52: 7a40        ldrb	r0, [r0, #9]
@   0x08000b54: 2808        cmp	r0, #8
@   0x08000b56: d100        bne.n	0xb5a
@   0x08000b58: e6ec        b.n	0x934
@   0x08000b5a: 2818        cmp	r0, #24
@   0x08000b5c: d100        bne.n	0xb60
@   0x08000b5e: e6e9        b.n	0x934
@   0x08000b60: b00d        add	sp, #52	@ 0x34
@   0x08000b62: bc70        pop	{r4, r5, r6}
@   0x08000b64: bc01        pop	{r0}
@   0x08000b66: 4700        bx	r0
@   0x08000b68: 5330        strh	r0, [r6, r4]
@   0x08000b6a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08000918
sub_08000918: @ 0x08000918
        .incbin "frog_us_baserom.gba", 0x918, 0x254
        thumb_func_end sub_08000918
