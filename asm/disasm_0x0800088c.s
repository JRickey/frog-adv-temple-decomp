@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800088c, 0x080008dc)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800088c --end 0x80008dc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800088c: b510        push	{r4, lr}
@   0x0800088e: 480d        ldr	r0, [pc, #52]	@ (0x8c4)
@   0x08000890: 8800        ldrh	r0, [r0, #0]
@   0x08000892: 0600        lsls	r0, r0, #24
@   0x08000894: 0e03        lsrs	r3, r0, #24
@   0x08000896: 2be3        cmp	r3, #227	@ 0xe3
@   0x08000898: d80e        bhi.n	0x8b8
@   0x0800089a: 490b        ldr	r1, [pc, #44]	@ (0x8c8)
@   0x0800089c: 4a0b        ldr	r2, [pc, #44]	@ (0x8cc)
@   0x0800089e: 480c        ldr	r0, [pc, #48]	@ (0x8d0)
@   0x080008a0: 1818        adds	r0, r3, r0
@   0x080008a2: 8814        ldrh	r4, [r2, #0]
@   0x080008a4: 7800        ldrb	r0, [r0, #0]
@   0x080008a6: 1820        adds	r0, r4, r0
@   0x080008a8: 8008        strh	r0, [r1, #0]
@   0x080008aa: 3104        adds	r1, #4
@   0x080008ac: 4809        ldr	r0, [pc, #36]	@ (0x8d4)
@   0x080008ae: 1818        adds	r0, r3, r0
@   0x080008b0: 8892        ldrh	r2, [r2, #4]
@   0x080008b2: 7800        ldrb	r0, [r0, #0]
@   0x080008b4: 1810        adds	r0, r2, r0
@   0x080008b6: 8008        strh	r0, [r1, #0]
@   0x080008b8: 4907        ldr	r1, [pc, #28]	@ (0x8d8)
@   0x080008ba: 2002        movs	r0, #2
@   0x080008bc: 8008        strh	r0, [r1, #0]
@   0x080008be: bc10        pop	{r4}
@   0x080008c0: bc01        pop	{r0}
@   0x080008c2: 4700        bx	r0
@   0x080008c4: 0006        movs	r6, r0
@   0x080008c6: 0400        lsls	r0, r0, #16
@   0x080008c8: 0010        movs	r0, r2
@   0x080008ca: 0400        lsls	r0, r0, #16
@   0x080008cc: 3550        adds	r5, #80	@ 0x50
@   0x080008ce: 0300        lsls	r0, r0, #12
@   0x080008d0: 53a0        strh	r0, [r4, r6]
@   0x080008d2: 0300        lsls	r0, r0, #12
@   0x080008d4: 3610        adds	r6, #16
@   0x080008d6: 0300        lsls	r0, r0, #12
@   0x080008d8: 0202        lsls	r2, r0, #8
@   0x080008da: 0400        lsls	r0, r0, #16

        thumb_func_start sub_0800088C
sub_0800088C: @ 0x0800088c
        .incbin "frog_us_baserom.gba", 0x88c, 0x50
        thumb_func_end sub_0800088C
