@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026290, 0x080262f4)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026290 --end 0x80262f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026290: b530        push	{r4, r5, lr}
@   0x08026292: 2300        movs	r3, #0
@   0x08026294: 4d15        ldr	r5, [pc, #84]	@ (0x262ec)
@   0x08026296: 4c16        ldr	r4, [pc, #88]	@ (0x262f0)
@   0x08026298: 00d8        lsls	r0, r3, #3
@   0x0802629a: 1942        adds	r2, r0, r5
@   0x0802629c: 1900        adds	r0, r0, r4
@   0x0802629e: 6841        ldr	r1, [r0, #4]
@   0x080262a0: 6800        ldr	r0, [r0, #0]
@   0x080262a2: 6050        str	r0, [r2, #4]
@   0x080262a4: 6091        str	r1, [r2, #8]
@   0x080262a6: 1c58        adds	r0, r3, #1
@   0x080262a8: 0600        lsls	r0, r0, #24
@   0x080262aa: 0e03        lsrs	r3, r0, #24
@   0x080262ac: 2b09        cmp	r3, #9
@   0x080262ae: d9f3        bls.n	0x26298
@   0x080262b0: f7ff        fd1c 	bl	0x25cec
@   0x080262b4: f7ff        fd40 	bl	0x25d38
@   0x080262b8: f7ff        fd64 	bl	0x25d84
@   0x080262bc: f7ff        fd88 	bl	0x25dd0
@   0x080262c0: f7ff        fdce 	bl	0x25e60
@   0x080262c4: f7ff        fe12 	bl	0x25eec
@   0x080262c8: f7ff        ff20 	bl	0x2610c
@   0x080262cc: f7ff        fe50 	bl	0x25f70
@   0x080262d0: f7ff        fb18 	bl	0x25904
@   0x080262d4: f7ff        fe8e 	bl	0x25ff4
@   0x080262d8: f7ff        feda 	bl	0x26090
@   0x080262dc: f7ff        ffb0 	bl	0x26240
@   0x080262e0: f7ff        ff8a 	bl	0x261f8
@   0x080262e4: bc30        pop	{r4, r5}
@   0x080262e6: bc01        pop	{r0}
@   0x080262e8: 4700        bx	r0
@   0x080262ea: 0000        movs	r0, r0
@   0x080262ec: 3570        adds	r5, #112	@ 0x70
@   0x080262ee: 0300        lsls	r0, r0, #12
@   0x080262f0: 4b20        ldr	r3, [pc, #128]	@ (0x26374)
@   0x080262f2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026290
sub_08026290: @ 0x08026290
        .incbin "baserom.gba", 0x26290, 0x64
        thumb_func_end sub_08026290
