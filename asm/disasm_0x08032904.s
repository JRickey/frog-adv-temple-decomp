@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08032904, 0x0803299c)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8032904 --end 0x803299c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08032904: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08032906: 464f        mov	r7, r9
@   0x08032908: 4646        mov	r6, r8
@   0x0803290a: b4c0        push	{r6, r7}
@   0x0803290c: 1c07        adds	r7, r0, #0
@   0x0803290e: 4688        mov	r8, r1
@   0x08032910: 1c14        adds	r4, r2, #0
@   0x08032912: 4699        mov	r9, r3
@   0x08032914: f7fb        ff06 	bl	0x2e724
@   0x08032918: 0624        lsls	r4, r4, #24
@   0x0803291a: 0e24        lsrs	r4, r4, #24
@   0x0803291c: 1c20        adds	r0, r4, #0
@   0x0803291e: 1c39        adds	r1, r7, #0
@   0x08032920: f7fb        ff50 	bl	0x2e7c4
@   0x08032924: 4d1c        ldr	r5, [pc, #112]	@ (0x32998)
@   0x08032926: 6829        ldr	r1, [r5, #0]
@   0x08032928: 00ba        lsls	r2, r7, #2
@   0x0803292a: 1c08        adds	r0, r1, #0
@   0x0803292c: 3010        adds	r0, #16
@   0x0803292e: 1880        adds	r0, r0, r2
@   0x08032930: 2300        movs	r3, #0
@   0x08032932: 6003        str	r3, [r0, #0]
@   0x08032934: 007a        lsls	r2, r7, #1
@   0x08032936: 1c08        adds	r0, r1, #0
@   0x08032938: 30ac        adds	r0, #172	@ 0xac
@   0x0803293a: 1880        adds	r0, r0, r2
@   0x0803293c: 2200        movs	r2, #0
@   0x0803293e: 466c        mov	r4, sp
@   0x08032940: 8ba4        ldrh	r4, [r4, #28]
@   0x08032942: 8004        strh	r4, [r0, #0]
@   0x08032944: 00fc        lsls	r4, r7, #3
@   0x08032946: 1c20        adds	r0, r4, #0
@   0x08032948: 308c        adds	r0, #140	@ 0x8c
@   0x0803294a: 1809        adds	r1, r1, r0
@   0x0803294c: 20ff        movs	r0, #255	@ 0xff
@   0x0803294e: 0200        lsls	r0, r0, #8
@   0x08032950: 8088        strh	r0, [r1, #4]
@   0x08032952: 464e        mov	r6, r9
@   0x08032954: 71ce        strb	r6, [r1, #7]
@   0x08032956: 718a        strb	r2, [r1, #6]
@   0x08032958: 2f02        cmp	r7, #2
@   0x0803295a: dc16        bgt.n	0x3298a
@   0x0803295c: 19e1        adds	r1, r4, r7
@   0x0803295e: 0089        lsls	r1, r1, #2
@   0x08032960: 3120        adds	r1, #32
@   0x08032962: 6828        ldr	r0, [r5, #0]
@   0x08032964: 1840        adds	r0, r0, r1
@   0x08032966: 8802        ldrh	r2, [r0, #0]
@   0x08032968: 8b84        ldrh	r4, [r0, #28]
@   0x0803296a: 1911        adds	r1, r2, r4
@   0x0803296c: 8441        strh	r1, [r0, #34]	@ 0x22
@   0x0803296e: 4646        mov	r6, r8
@   0x08032970: 0231        lsls	r1, r6, #8
@   0x08032972: 8001        strh	r1, [r0, #0]
@   0x08032974: 8043        strh	r3, [r0, #2]
@   0x08032976: 8383        strh	r3, [r0, #28]
@   0x08032978: 83c3        strh	r3, [r0, #30]
@   0x0803297a: 8403        strh	r3, [r0, #32]
@   0x0803297c: 8283        strh	r3, [r0, #20]
@   0x0803297e: 82c3        strh	r3, [r0, #22]
@   0x08032980: 8083        strh	r3, [r0, #4]
@   0x08032982: 80c3        strh	r3, [r0, #6]
@   0x08032984: 8183        strh	r3, [r0, #12]
@   0x08032986: 81c3        strh	r3, [r0, #14]
@   0x08032988: 8243        strh	r3, [r0, #18]
@   0x0803298a: bc18        pop	{r3, r4}
@   0x0803298c: 4698        mov	r8, r3
@   0x0803298e: 46a1        mov	r9, r4
@   0x08032990: bcf0        pop	{r4, r5, r6, r7}
@   0x08032992: bc01        pop	{r0}
@   0x08032994: 4700        bx	r0
@   0x08032996: 0000        movs	r0, r0
@   0x08032998: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803299a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08032904
sub_08032904: @ 0x08032904
        .incbin "frog_us_baserom.gba", 0x32904, 0x98
        thumb_func_end sub_08032904
