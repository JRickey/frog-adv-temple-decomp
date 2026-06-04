@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801977c, 0x08019834)  (184 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801977c --end 0x8019834 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801977c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801977e: 4647        mov	r7, r8
@   0x08019780: b480        push	{r7}
@   0x08019782: 1c06        adds	r6, r0, #0
@   0x08019784: 1c0c        adds	r4, r1, #0
@   0x08019786: 4694        mov	ip, r2
@   0x08019788: 061b        lsls	r3, r3, #24
@   0x0801978a: 0e1b        lsrs	r3, r3, #24
@   0x0801978c: 1c1a        adds	r2, r3, #0
@   0x0801978e: 78f0        ldrb	r0, [r6, #3]
@   0x08019790: 78e1        ldrb	r1, [r4, #3]
@   0x08019792: 4288        cmp	r0, r1
@   0x08019794: d900        bls.n	0x19798
@   0x08019796: 1c08        adds	r0, r1, #0
@   0x08019798: 0600        lsls	r0, r0, #24
@   0x0801979a: 0e07        lsrs	r7, r0, #24
@   0x0801979c: 78b0        ldrb	r0, [r6, #2]
@   0x0801979e: 78a1        ldrb	r1, [r4, #2]
@   0x080197a0: 4288        cmp	r0, r1
@   0x080197a2: d900        bls.n	0x197a6
@   0x080197a4: 1c08        adds	r0, r1, #0
@   0x080197a6: 0600        lsls	r0, r0, #24
@   0x080197a8: 0e00        lsrs	r0, r0, #24
@   0x080197aa: 4680        mov	r8, r0
@   0x080197ac: 7861        ldrb	r1, [r4, #1]
@   0x080197ae: 0148        lsls	r0, r1, #5
@   0x080197b0: 7824        ldrb	r4, [r4, #0]
@   0x080197b2: 1820        adds	r0, r4, r0
@   0x080197b4: 0040        lsls	r0, r0, #1
@   0x080197b6: 4661        mov	r1, ip
@   0x080197b8: 180c        adds	r4, r1, r0
@   0x080197ba: 2b01        cmp	r3, #1
@   0x080197bc: d00e        beq.n	0x197dc
@   0x080197be: 2b01        cmp	r3, #1
@   0x080197c0: dc02        bgt.n	0x197c8
@   0x080197c2: 2b00        cmp	r3, #0
@   0x080197c4: d005        beq.n	0x197d2
@   0x080197c6: e012        b.n	0x197ee
@   0x080197c8: 2a02        cmp	r2, #2
@   0x080197ca: d00b        beq.n	0x197e4
@   0x080197cc: 2a03        cmp	r2, #3
@   0x080197ce: d00d        beq.n	0x197ec
@   0x080197d0: e00d        b.n	0x197ee
@   0x080197d2: 4d01        ldr	r5, [pc, #4]	@ (0x197d8)
@   0x080197d4: e00b        b.n	0x197ee
@   0x080197d6: 0000        movs	r0, r0
@   0x080197d8: e000        b.n	0x197dc
@   0x080197da: 0600        lsls	r0, r0, #24
@   0x080197dc: 4d00        ldr	r5, [pc, #0]	@ (0x197e0)
@   0x080197de: e006        b.n	0x197ee
@   0x080197e0: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x080197e4: 4d00        ldr	r5, [pc, #0]	@ (0x197e8)
@   0x080197e6: e002        b.n	0x197ee
@   0x080197e8: f000        0600 	and.w	r6, r0, #0
@   0x080197ec: 4d0f        ldr	r5, [pc, #60]	@ (0x1982c)
@   0x080197ee: 7871        ldrb	r1, [r6, #1]
@   0x080197f0: 0148        lsls	r0, r1, #5
@   0x080197f2: 7836        ldrb	r6, [r6, #0]
@   0x080197f4: 1830        adds	r0, r6, r0
@   0x080197f6: 0040        lsls	r0, r0, #1
@   0x080197f8: 182d        adds	r5, r5, r0
@   0x080197fa: 2100        movs	r1, #0
@   0x080197fc: 42b9        cmp	r1, r7
@   0x080197fe: d20f        bcs.n	0x19820
@   0x08019800: 4b0b        ldr	r3, [pc, #44]	@ (0x19830)
@   0x08019802: 2280        movs	r2, #128	@ 0x80
@   0x08019804: 0612        lsls	r2, r2, #24
@   0x08019806: 4640        mov	r0, r8
@   0x08019808: 4302        orrs	r2, r0
@   0x0801980a: 601c        str	r4, [r3, #0]
@   0x0801980c: 605d        str	r5, [r3, #4]
@   0x0801980e: 609a        str	r2, [r3, #8]
@   0x08019810: 6898        ldr	r0, [r3, #8]
@   0x08019812: 3440        adds	r4, #64	@ 0x40
@   0x08019814: 3540        adds	r5, #64	@ 0x40
@   0x08019816: 1c48        adds	r0, r1, #1
@   0x08019818: 0600        lsls	r0, r0, #24
@   0x0801981a: 0e01        lsrs	r1, r0, #24
@   0x0801981c: 42b9        cmp	r1, r7
@   0x0801981e: d3f4        bcc.n	0x1980a
@   0x08019820: bc08        pop	{r3}
@   0x08019822: 4698        mov	r8, r3
@   0x08019824: bcf0        pop	{r4, r5, r6, r7}
@   0x08019826: bc01        pop	{r0}
@   0x08019828: 4700        bx	r0
@   0x0801982a: 0000        movs	r0, r0
@   0x0801982c: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08019830: 00d4        lsls	r4, r2, #3
@   0x08019832: 0400        lsls	r0, r0, #16

        thumb_func_start sub_0801977C
sub_0801977C: @ 0x0801977c
        .incbin "frog_us_baserom.gba", 0x1977c, 0xb8
        thumb_func_end sub_0801977C
