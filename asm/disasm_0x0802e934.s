@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e934, 0x0802ea2c)  (248 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e934 --end 0x802ea2c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e934: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802e936: 4657        mov	r7, sl
@   0x0802e938: 464e        mov	r6, r9
@   0x0802e93a: 4645        mov	r5, r8
@   0x0802e93c: b4e0        push	{r5, r6, r7}
@   0x0802e93e: 2200        movs	r2, #0
@   0x0802e940: 4811        ldr	r0, [pc, #68]	@ (0x2e988)
@   0x0802e942: 4682        mov	sl, r0
@   0x0802e944: 46d1        mov	r9, sl
@   0x0802e946: 00d0        lsls	r0, r2, #3
@   0x0802e948: 1c57        adds	r7, r2, #1
@   0x0802e94a: 1880        adds	r0, r0, r2
@   0x0802e94c: 0080        lsls	r0, r0, #2
@   0x0802e94e: 3020        adds	r0, #32
@   0x0802e950: 4680        mov	r8, r0
@   0x0802e952: 2504        movs	r5, #4
@   0x0802e954: 0092        lsls	r2, r2, #2
@   0x0802e956: 4694        mov	ip, r2
@   0x0802e958: 2601        movs	r6, #1
@   0x0802e95a: 4649        mov	r1, r9
@   0x0802e95c: 6808        ldr	r0, [r1, #0]
@   0x0802e95e: 4440        add	r0, r8
@   0x0802e960: 1942        adds	r2, r0, r5
@   0x0802e962: 8851        ldrh	r1, [r2, #2]
@   0x0802e964: 2302        movs	r3, #2
@   0x0802e966: 5ed0        ldrsh	r0, [r2, r3]
@   0x0802e968: 2800        cmp	r0, #0
@   0x0802e96a: d01d        beq.n	0x2e9a8
@   0x0802e96c: 8810        ldrh	r0, [r2, #0]
@   0x0802e96e: 1809        adds	r1, r1, r0
@   0x0802e970: 8011        strh	r1, [r2, #0]
@   0x0802e972: 8894        ldrh	r4, [r2, #4]
@   0x0802e974: 2004        movs	r0, #4
@   0x0802e976: 5e13        ldrsh	r3, [r2, r0]
@   0x0802e978: 2b00        cmp	r3, #0
@   0x0802e97a: dd07        ble.n	0x2e98c
@   0x0802e97c: 0408        lsls	r0, r1, #16
@   0x0802e97e: 1400        asrs	r0, r0, #16
@   0x0802e980: 4298        cmp	r0, r3
@   0x0802e982: dd09        ble.n	0x2e998
@   0x0802e984: e006        b.n	0x2e994
@   0x0802e986: 0000        movs	r0, r0
@   0x0802e988: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e98a: 0300        lsls	r0, r0, #12
@   0x0802e98c: 0408        lsls	r0, r1, #16
@   0x0802e98e: 1400        asrs	r0, r0, #16
@   0x0802e990: 4298        cmp	r0, r3
@   0x0802e992: da01        bge.n	0x2e998
@   0x0802e994: 1b08        subs	r0, r1, r4
@   0x0802e996: 8010        strh	r0, [r2, #0]
@   0x0802e998: 4649        mov	r1, r9
@   0x0802e99a: 6808        ldr	r0, [r1, #0]
@   0x0802e99c: 3010        adds	r0, #16
@   0x0802e99e: 4460        add	r0, ip
@   0x0802e9a0: 6801        ldr	r1, [r0, #0]
@   0x0802e9a2: 2240        movs	r2, #64	@ 0x40
@   0x0802e9a4: 4311        orrs	r1, r2
@   0x0802e9a6: 6001        str	r1, [r0, #0]
@   0x0802e9a8: 3508        adds	r5, #8
@   0x0802e9aa: 3e01        subs	r6, #1
@   0x0802e9ac: 2e00        cmp	r6, #0
@   0x0802e9ae: dad4        bge.n	0x2e95a
@   0x0802e9b0: 1c3a        adds	r2, r7, #0
@   0x0802e9b2: 2a02        cmp	r2, #2
@   0x0802e9b4: ddc7        ble.n	0x2e946
@   0x0802e9b6: 2200        movs	r2, #0
@   0x0802e9b8: e02b        b.n	0x2ea12
@   0x0802e9ba: 6808        ldr	r0, [r1, #0]
@   0x0802e9bc: 30cc        adds	r0, #204	@ 0xcc
@   0x0802e9be: 6801        ldr	r1, [r0, #0]
@   0x0802e9c0: 0090        lsls	r0, r2, #2
@   0x0802e9c2: 1840        adds	r0, r0, r1
@   0x0802e9c4: 6805        ldr	r5, [r0, #0]
@   0x0802e9c6: 1c57        adds	r7, r2, #1
@   0x0802e9c8: 2d00        cmp	r5, #0
@   0x0802e9ca: d021        beq.n	0x2ea10
@   0x0802e9cc: 1d2a        adds	r2, r5, #4
@   0x0802e9ce: 2601        movs	r6, #1
@   0x0802e9d0: 8851        ldrh	r1, [r2, #2]
@   0x0802e9d2: 2302        movs	r3, #2
@   0x0802e9d4: 5ed0        ldrsh	r0, [r2, r3]
@   0x0802e9d6: 2800        cmp	r0, #0
@   0x0802e9d8: d016        beq.n	0x2ea08
@   0x0802e9da: 8810        ldrh	r0, [r2, #0]
@   0x0802e9dc: 1809        adds	r1, r1, r0
@   0x0802e9de: 8011        strh	r1, [r2, #0]
@   0x0802e9e0: 8894        ldrh	r4, [r2, #4]
@   0x0802e9e2: 2004        movs	r0, #4
@   0x0802e9e4: 5e13        ldrsh	r3, [r2, r0]
@   0x0802e9e6: 2b00        cmp	r3, #0
@   0x0802e9e8: dd04        ble.n	0x2e9f4
@   0x0802e9ea: 0408        lsls	r0, r1, #16
@   0x0802e9ec: 1400        asrs	r0, r0, #16
@   0x0802e9ee: 4298        cmp	r0, r3
@   0x0802e9f0: dd06        ble.n	0x2ea00
@   0x0802e9f2: e003        b.n	0x2e9fc
@   0x0802e9f4: 0408        lsls	r0, r1, #16
@   0x0802e9f6: 1400        asrs	r0, r0, #16
@   0x0802e9f8: 4298        cmp	r0, r3
@   0x0802e9fa: da01        bge.n	0x2ea00
@   0x0802e9fc: 1b08        subs	r0, r1, r4
@   0x0802e9fe: 8010        strh	r0, [r2, #0]
@   0x0802ea00: 6ba8        ldr	r0, [r5, #56]	@ 0x38
@   0x0802ea02: 2140        movs	r1, #64	@ 0x40
@   0x0802ea04: 4308        orrs	r0, r1
@   0x0802ea06: 63a8        str	r0, [r5, #56]	@ 0x38
@   0x0802ea08: 3208        adds	r2, #8
@   0x0802ea0a: 3e01        subs	r6, #1
@   0x0802ea0c: 2e00        cmp	r6, #0
@   0x0802ea0e: dadf        bge.n	0x2e9d0
@   0x0802ea10: 1c3a        adds	r2, r7, #0
@   0x0802ea12: 4651        mov	r1, sl
@   0x0802ea14: 6808        ldr	r0, [r1, #0]
@   0x0802ea16: 7800        ldrb	r0, [r0, #0]
@   0x0802ea18: 4282        cmp	r2, r0
@   0x0802ea1a: dbce        blt.n	0x2e9ba
@   0x0802ea1c: bc38        pop	{r3, r4, r5}
@   0x0802ea1e: 4698        mov	r8, r3
@   0x0802ea20: 46a1        mov	r9, r4
@   0x0802ea22: 46aa        mov	sl, r5
@   0x0802ea24: bcf0        pop	{r4, r5, r6, r7}
@   0x0802ea26: bc01        pop	{r0}
@   0x0802ea28: 4700        bx	r0

        thumb_func_start sub_0802E934
sub_0802E934: @ 0x0802e934
        .incbin "frog_us_baserom.gba", 0x2e934, 0xf8
        thumb_func_end sub_0802E934
