@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027794, 0x080277f4)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027794 --end 0x80277f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027794: b530        push	{r4, r5, lr}
@   0x08027796: 2300        movs	r3, #0
@   0x08027798: 4d14        ldr	r5, [pc, #80]	@ (0x277ec)
@   0x0802779a: 4c15        ldr	r4, [pc, #84]	@ (0x277f0)
@   0x0802779c: 00d8        lsls	r0, r3, #3
@   0x0802779e: 1942        adds	r2, r0, r5
@   0x080277a0: 1900        adds	r0, r0, r4
@   0x080277a2: 6841        ldr	r1, [r0, #4]
@   0x080277a4: 6800        ldr	r0, [r0, #0]
@   0x080277a6: 6050        str	r0, [r2, #4]
@   0x080277a8: 6091        str	r1, [r2, #8]
@   0x080277aa: 1c58        adds	r0, r3, #1
@   0x080277ac: 0600        lsls	r0, r0, #24
@   0x080277ae: 0e03        lsrs	r3, r0, #24
@   0x080277b0: 2b09        cmp	r3, #9
@   0x080277b2: d9f3        bls.n	0x2779c
@   0x080277b4: f7ff        fdac 	bl	0x27310
@   0x080277b8: f7ff        fdd0 	bl	0x2735c
@   0x080277bc: f7ff        fdf4 	bl	0x273a8
@   0x080277c0: f7ff        fe18 	bl	0x273f4
@   0x080277c4: f7ff        fe64 	bl	0x27490
@   0x080277c8: f7ff        fe78 	bl	0x274bc
@   0x080277cc: f7ff        fec4 	bl	0x27558
@   0x080277d0: f7ff        fed8 	bl	0x27584
@   0x080277d4: f7ff        feec 	bl	0x275b0
@   0x080277d8: f7ff        ff2c 	bl	0x27634
@   0x080277dc: f7ff        ff6c 	bl	0x276b8
@   0x080277e0: f7ff        ffb0 	bl	0x27744
@   0x080277e4: bc30        pop	{r4, r5}
@   0x080277e6: bc01        pop	{r0}
@   0x080277e8: 4700        bx	r0
@   0x080277ea: 0000        movs	r0, r0
@   0x080277ec: 3570        adds	r5, #112	@ 0x70
@   0x080277ee: 0300        lsls	r0, r0, #12
@   0x080277f0: 6710        str	r0, [r2, #112]	@ 0x70
@   0x080277f2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027794
sub_08027794: @ 0x08027794
        .incbin "baserom.gba", 0x27794, 0x60
        thumb_func_end sub_08027794
