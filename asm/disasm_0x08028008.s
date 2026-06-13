@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028008, 0x08028084)  (124 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028008 --end 0x8028084 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028008: b500        push	{lr}
@   0x0802800a: b084        sub	sp, #16
@   0x0802800c: 4808        ldr	r0, [pc, #32]	@ (0x28030)
@   0x0802800e: 6900        ldr	r0, [r0, #16]
@   0x08028010: 2800        cmp	r0, #0
@   0x08028012: d113        bne.n	0x2803c
@   0x08028014: 4907        ldr	r1, [pc, #28]	@ (0x28034)
@   0x08028016: 4808        ldr	r0, [pc, #32]	@ (0x28038)
@   0x08028018: 9000        str	r0, [sp, #0]
@   0x0802801a: 200a        movs	r0, #10
@   0x0802801c: 9001        str	r0, [sp, #4]
@   0x0802801e: 2003        movs	r0, #3
@   0x08028020: 9002        str	r0, [sp, #8]
@   0x08028022: 9003        str	r0, [sp, #12]
@   0x08028024: 2044        movs	r0, #68	@ 0x44
@   0x08028026: 2200        movs	r2, #0
@   0x08028028: 233e        movs	r3, #62	@ 0x3e
@   0x0802802a: f7f9        f839 	bl	0x210a0
@   0x0802802e: e014        b.n	0x2805a
@   0x08028030: 6110        str	r0, [r2, #16]
@   0x08028032: 0300        lsls	r0, r0, #12
@   0x08028034: 6cf8        ldr	r0, [r7, #76]	@ 0x4c
@   0x08028036: 0831        lsrs	r1, r6, #32
@   0x08028038: 01c1        lsls	r1, r0, #7
@   0x0802803a: 0000        movs	r0, r0
@   0x0802803c: 2801        cmp	r0, #1
@   0x0802803e: d10c        bne.n	0x2805a
@   0x08028040: 490c        ldr	r1, [pc, #48]	@ (0x28074)
@   0x08028042: 480d        ldr	r0, [pc, #52]	@ (0x28078)
@   0x08028044: 9000        str	r0, [sp, #0]
@   0x08028046: 200a        movs	r0, #10
@   0x08028048: 9001        str	r0, [sp, #4]
@   0x0802804a: 2003        movs	r0, #3
@   0x0802804c: 9002        str	r0, [sp, #8]
@   0x0802804e: 9003        str	r0, [sp, #12]
@   0x08028050: 2044        movs	r0, #68	@ 0x44
@   0x08028052: 2200        movs	r2, #0
@   0x08028054: 233e        movs	r3, #62	@ 0x3e
@   0x08028056: f7f9        f823 	bl	0x210a0
@   0x0802805a: 4808        ldr	r0, [pc, #32]	@ (0x2807c)
@   0x0802805c: 4908        ldr	r1, [pc, #32]	@ (0x28080)
@   0x0802805e: 1840        adds	r0, r0, r1
@   0x08028060: 2280        movs	r2, #128	@ 0x80
@   0x08028062: 0092        lsls	r2, r2, #2
@   0x08028064: 1c11        adds	r1, r2, #0
@   0x08028066: 8802        ldrh	r2, [r0, #0]
@   0x08028068: 4311        orrs	r1, r2
@   0x0802806a: 8001        strh	r1, [r0, #0]
@   0x0802806c: b004        add	sp, #16
@   0x0802806e: bc01        pop	{r0}
@   0x08028070: 4700        bx	r0
@   0x08028072: 0000        movs	r0, r0
@   0x08028074: 6d10        ldr	r0, [r2, #80]	@ 0x50
@   0x08028076: 0831        lsrs	r1, r6, #32
@   0x08028078: 01c1        lsls	r1, r0, #7
@   0x0802807a: 0000        movs	r0, r0
@   0x0802807c: 3720        adds	r7, #32
@   0x0802807e: 0300        lsls	r0, r0, #12
@   0x08028080: 0f14        lsrs	r4, r2, #28

        thumb_func_start sub_08028008
sub_08028008: @ 0x08028008
        .incbin "baserom.gba", 0x28008, 0x7c
        thumb_func_end sub_08028008
