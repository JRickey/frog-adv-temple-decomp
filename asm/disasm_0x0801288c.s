@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801288c, 0x0801297c)  (240 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801288c --end 0x801297c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801288c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801288e: 464f        mov	r7, r9
@   0x08012890: 4646        mov	r6, r8
@   0x08012892: b4c0        push	{r6, r7}
@   0x08012894: 4b27        ldr	r3, [pc, #156]	@ (0x12934)
@   0x08012896: 1c1c        adds	r4, r3, #0
@   0x08012898: 3420        adds	r4, #32
@   0x0801289a: 4927        ldr	r1, [pc, #156]	@ (0x12938)
@   0x0801289c: 4a27        ldr	r2, [pc, #156]	@ (0x1293c)
@   0x0801289e: 1888        adds	r0, r1, r2
@   0x080128a0: 2700        movs	r7, #0
@   0x080128a2: 5fc0        ldrsh	r0, [r0, r7]
@   0x080128a4: 0042        lsls	r2, r0, #1
@   0x080128a6: 1812        adds	r2, r2, r0
@   0x080128a8: 0412        lsls	r2, r2, #16
@   0x080128aa: 4825        ldr	r0, [pc, #148]	@ (0x12940)
@   0x080128ac: 1809        adds	r1, r1, r0
@   0x080128ae: 2700        movs	r7, #0
@   0x080128b0: 5fc9        ldrsh	r1, [r1, r7]
@   0x080128b2: 0048        lsls	r0, r1, #1
@   0x080128b4: 1840        adds	r0, r0, r1
@   0x080128b6: 0400        lsls	r0, r0, #16
@   0x080128b8: 0c00        lsrs	r0, r0, #16
@   0x080128ba: 4684        mov	ip, r0
@   0x080128bc: 0c12        lsrs	r2, r2, #16
@   0x080128be: 4690        mov	r8, r2
@   0x080128c0: 7f1d        ldrb	r5, [r3, #28]
@   0x080128c2: 7f98        ldrb	r0, [r3, #30]
@   0x080128c4: 4681        mov	r9, r0
@   0x080128c6: 6a9e        ldr	r6, [r3, #40]	@ 0x28
@   0x080128c8: 7824        ldrb	r4, [r4, #0]
@   0x080128ca: 0923        lsrs	r3, r4, #4
@   0x080128cc: 2101        movs	r1, #1
@   0x080128ce: 1c18        adds	r0, r3, #0
@   0x080128d0: 4008        ands	r0, r1
@   0x080128d2: 2280        movs	r2, #128	@ 0x80
@   0x080128d4: 0492        lsls	r2, r2, #18
@   0x080128d6: 2800        cmp	r0, #0
@   0x080128d8: d000        beq.n	0x128dc
@   0x080128da: 4a1a        ldr	r2, [pc, #104]	@ (0x12944)
@   0x080128dc: 4c1a        ldr	r4, [pc, #104]	@ (0x12948)
@   0x080128de: 8b61        ldrh	r1, [r4, #26]
@   0x080128e0: 4660        mov	r0, ip
@   0x080128e2: 4348        muls	r0, r1
@   0x080128e4: 4440        add	r0, r8
@   0x080128e6: 0040        lsls	r0, r0, #1
@   0x080128e8: 1812        adds	r2, r2, r0
@   0x080128ea: 6871        ldr	r1, [r6, #4]
@   0x080128ec: 2000        movs	r0, #0
@   0x080128ee: 1c1e        adds	r6, r3, #0
@   0x080128f0: 4548        cmp	r0, r9
@   0x080128f2: d216        bcs.n	0x12922
@   0x080128f4: 46a4        mov	ip, r4
@   0x080128f6: 2300        movs	r3, #0
@   0x080128f8: 1c44        adds	r4, r0, #1
@   0x080128fa: 42ab        cmp	r3, r5
@   0x080128fc: d208        bcs.n	0x12910
@   0x080128fe: 8808        ldrh	r0, [r1, #0]
@   0x08012900: 8010        strh	r0, [r2, #0]
@   0x08012902: 3102        adds	r1, #2
@   0x08012904: 3202        adds	r2, #2
@   0x08012906: 1c58        adds	r0, r3, #1
@   0x08012908: 0600        lsls	r0, r0, #24
@   0x0801290a: 0e03        lsrs	r3, r0, #24
@   0x0801290c: 42ab        cmp	r3, r5
@   0x0801290e: d3f6        bcc.n	0x128fe
@   0x08012910: 4663        mov	r3, ip
@   0x08012912: 8b5b        ldrh	r3, [r3, #26]
@   0x08012914: 1b58        subs	r0, r3, r5
@   0x08012916: 0040        lsls	r0, r0, #1
@   0x08012918: 1812        adds	r2, r2, r0
@   0x0801291a: 0620        lsls	r0, r4, #24
@   0x0801291c: 0e00        lsrs	r0, r0, #24
@   0x0801291e: 4548        cmp	r0, r9
@   0x08012920: d3e9        bcc.n	0x128f6
@   0x08012922: 2101        movs	r1, #1
@   0x08012924: 1c30        adds	r0, r6, #0
@   0x08012926: 4008        ands	r0, r1
@   0x08012928: 2800        cmp	r0, #0
@   0x0801292a: d011        beq.n	0x12950
@   0x0801292c: 4905        ldr	r1, [pc, #20]	@ (0x12944)
@   0x0801292e: 4a07        ldr	r2, [pc, #28]	@ (0x1294c)
@   0x08012930: e011        b.n	0x12956
@   0x08012932: 0000        movs	r0, r0
@   0x08012934: 6e64        ldr	r4, [r4, #100]	@ 0x64
@   0x08012936: 0830        lsrs	r0, r6, #32
@   0x08012938: 3720        adds	r7, #32
@   0x0801293a: 0300        lsls	r0, r0, #12
@   0x0801293c: 0692        lsls	r2, r2, #26
@   0x0801293e: 0000        movs	r0, r0
@   0x08012940: 0694        lsls	r4, r2, #26
@   0x08012942: 0000        movs	r0, r0
@   0x08012944: 0000        movs	r0, r0
@   0x08012946: 0201        lsls	r1, r0, #8
@   0x08012948: 60a0        str	r0, [r4, #8]
@   0x0801294a: 0300        lsls	r0, r0, #12
@   0x0801294c: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08012950: 2180        movs	r1, #128	@ 0x80
@   0x08012952: 0489        lsls	r1, r1, #18
@   0x08012954: 4a07        ldr	r2, [pc, #28]	@ (0x12974)
@   0x08012956: 2001        movs	r0, #1
@   0x08012958: 4006        ands	r6, r0
@   0x0801295a: 1c30        adds	r0, r6, #0
@   0x0801295c: f7fd        fbc2 	bl	0x100e4
@   0x08012960: 4905        ldr	r1, [pc, #20]	@ (0x12978)
@   0x08012962: 2000        movs	r0, #0
@   0x08012964: 7288        strb	r0, [r1, #10]
@   0x08012966: bc18        pop	{r3, r4}
@   0x08012968: 4698        mov	r8, r3
@   0x0801296a: 46a1        mov	r9, r4
@   0x0801296c: bcf0        pop	{r4, r5, r6, r7}
@   0x0801296e: bc01        pop	{r0}
@   0x08012970: 4700        bx	r0
@   0x08012972: 0000        movs	r0, r0
@   0x08012974: e000        b.n	0x12978
@   0x08012976: 0600        lsls	r0, r0, #24
@   0x08012978: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x0801297a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801288C
sub_0801288C: @ 0x0801288c
        .incbin "frog_us_baserom.gba", 0x1288c, 0xf0
        thumb_func_end sub_0801288C
