@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080058fc, 0x08005960)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80058fc --end 0x8005960 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080058fc: b530        push	{r4, r5, lr}
@   0x080058fe: 1c04        adds	r4, r0, #0
@   0x08005900: 1c0d        adds	r5, r1, #0
@   0x08005902: f004        f987 	bl	0x9c14
@   0x08005906: 2800        cmp	r0, #0
@   0x08005908: d101        bne.n	0x590e
@   0x0800590a: 2009        movs	r0, #9
@   0x0800590c: 7020        strb	r0, [r4, #0]
@   0x0800590e: 1c28        adds	r0, r5, #0
@   0x08005910: f005        fb1e 	bl	0xaf50
@   0x08005914: 4c11        ldr	r4, [pc, #68]	@ (0x595c)
@   0x08005916: 1c21        adds	r1, r4, #0
@   0x08005918: 312a        adds	r1, #42	@ 0x2a
@   0x0800591a: 2000        movs	r0, #0
@   0x0800591c: 7008        strb	r0, [r1, #0]
@   0x0800591e: 1c20        adds	r0, r4, #0
@   0x08005920: 2105        movs	r1, #5
@   0x08005922: 2204        movs	r2, #4
@   0x08005924: f000        fece 	bl	0x66c4
@   0x08005928: 2200        movs	r2, #0
@   0x0800592a: 1c25        adds	r5, r4, #0
@   0x0800592c: 1c28        adds	r0, r5, #0
@   0x0800592e: 3033        adds	r0, #51	@ 0x33
@   0x08005930: 0612        lsls	r2, r2, #24
@   0x08005932: 1614        asrs	r4, r2, #24
@   0x08005934: 7800        ldrb	r0, [r0, #0]
@   0x08005936: 4120        asrs	r0, r4
@   0x08005938: 2101        movs	r1, #1
@   0x0800593a: 4008        ands	r0, r1
@   0x0800593c: 2800        cmp	r0, #0
@   0x0800593e: d104        bne.n	0x594a
@   0x08005940: 0e12        lsrs	r2, r2, #24
@   0x08005942: 1c28        adds	r0, r5, #0
@   0x08005944: 2105        movs	r1, #5
@   0x08005946: f000        febd 	bl	0x66c4
@   0x0800594a: 1c60        adds	r0, r4, #1
@   0x0800594c: 0600        lsls	r0, r0, #24
@   0x0800594e: 0e02        lsrs	r2, r0, #24
@   0x08005950: 1600        asrs	r0, r0, #24
@   0x08005952: 2803        cmp	r0, #3
@   0x08005954: ddea        ble.n	0x592c
@   0x08005956: bc30        pop	{r4, r5}
@   0x08005958: bc01        pop	{r0}
@   0x0800595a: 4700        bx	r0
@   0x0800595c: 6110        str	r0, [r2, #16]
@   0x0800595e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080058FC
sub_080058FC: @ 0x080058fc
        .incbin "frog_us_baserom.gba", 0x58fc, 0x64
        thumb_func_end sub_080058FC
