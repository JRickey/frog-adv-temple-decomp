@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08016928, 0x080169bc)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8016928 --end 0x80169bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08016928: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801692a: 210f        movs	r1, #15
@   0x0801692c: 4803        ldr	r0, [pc, #12]	@ (0x1693c)
@   0x0801692e: 7880        ldrb	r0, [r0, #2]
@   0x08016930: 2803        cmp	r0, #3
@   0x08016932: d005        beq.n	0x16940
@   0x08016934: 2805        cmp	r0, #5
@   0x08016936: d005        beq.n	0x16944
@   0x08016938: e005        b.n	0x16946
@   0x0801693a: 0000        movs	r0, r0
@   0x0801693c: 6110        str	r0, [r2, #16]
@   0x0801693e: 0300        lsls	r0, r0, #12
@   0x08016940: 2100        movs	r1, #0
@   0x08016942: e000        b.n	0x16946
@   0x08016944: 2101        movs	r1, #1
@   0x08016946: 1c0a        adds	r2, r1, #0
@   0x08016948: 2a0f        cmp	r2, #15
@   0x0801694a: d02c        beq.n	0x169a6
@   0x0801694c: 4817        ldr	r0, [pc, #92]	@ (0x169ac)
@   0x0801694e: 4684        mov	ip, r0
@   0x08016950: 4e17        ldr	r6, [pc, #92]	@ (0x169b0)
@   0x08016952: 6801        ldr	r1, [r0, #0]
@   0x08016954: 6870        ldr	r0, [r6, #4]
@   0x08016956: 1a09        subs	r1, r1, r0
@   0x08016958: 4f16        ldr	r7, [pc, #88]	@ (0x169b4)
@   0x0801695a: 0114        lsls	r4, r2, #4
@   0x0801695c: 19e5        adds	r5, r4, r7
@   0x0801695e: 78a8        ldrb	r0, [r5, #2]
@   0x08016960: 4281        cmp	r1, r0
@   0x08016962: d320        bcc.n	0x169a6
@   0x08016964: 7831        ldrb	r1, [r6, #0]
@   0x08016966: 8828        ldrh	r0, [r5, #0]
@   0x08016968: 4281        cmp	r1, r0
@   0x0801696a: d301        bcc.n	0x16970
@   0x0801696c: 2000        movs	r0, #0
@   0x0801696e: 7030        strb	r0, [r6, #0]
@   0x08016970: 1d38        adds	r0, r7, #4
@   0x08016972: 1820        adds	r0, r4, r0
@   0x08016974: 6803        ldr	r3, [r0, #0]
@   0x08016976: 4a10        ldr	r2, [pc, #64]	@ (0x169b8)
@   0x08016978: 7830        ldrb	r0, [r6, #0]
@   0x0801697a: 1c41        adds	r1, r0, #1
@   0x0801697c: 7031        strb	r1, [r6, #0]
@   0x0801697e: 0600        lsls	r0, r0, #24
@   0x08016980: 0d80        lsrs	r0, r0, #22
@   0x08016982: 18c0        adds	r0, r0, r3
@   0x08016984: 6800        ldr	r0, [r0, #0]
@   0x08016986: 6010        str	r0, [r2, #0]
@   0x08016988: 1c38        adds	r0, r7, #0
@   0x0801698a: 3008        adds	r0, #8
@   0x0801698c: 1820        adds	r0, r4, r0
@   0x0801698e: 6800        ldr	r0, [r0, #0]
@   0x08016990: 6050        str	r0, [r2, #4]
@   0x08016992: 89ad        ldrh	r5, [r5, #12]
@   0x08016994: 0868        lsrs	r0, r5, #1
@   0x08016996: 2180        movs	r1, #128	@ 0x80
@   0x08016998: 0609        lsls	r1, r1, #24
@   0x0801699a: 4308        orrs	r0, r1
@   0x0801699c: 6090        str	r0, [r2, #8]
@   0x0801699e: 6890        ldr	r0, [r2, #8]
@   0x080169a0: 4661        mov	r1, ip
@   0x080169a2: 6808        ldr	r0, [r1, #0]
@   0x080169a4: 6070        str	r0, [r6, #4]
@   0x080169a6: bcf0        pop	{r4, r5, r6, r7}
@   0x080169a8: bc01        pop	{r0}
@   0x080169aa: 4700        bx	r0
@   0x080169ac: 5330        strh	r0, [r6, r4]
@   0x080169ae: 0300        lsls	r0, r0, #12
@   0x080169b0: 5320        strh	r0, [r4, r4]
@   0x080169b2: 0300        lsls	r0, r0, #12
@   0x080169b4: 6888        ldr	r0, [r1, #8]
@   0x080169b6: 0830        lsrs	r0, r6, #32
@   0x080169b8: 00d4        lsls	r4, r2, #3
@   0x080169ba: 0400        lsls	r0, r0, #16

        thumb_func_start sub_08016928
sub_08016928: @ 0x08016928
        .incbin "frog_us_baserom.gba", 0x16928, 0x94
        thumb_func_end sub_08016928
