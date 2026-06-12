@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08011288, 0x080112c0)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8011288 --end 0x80112c0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08011288: b500        push	{lr}
@   0x0801128a: 2005        movs	r0, #5
@   0x0801128c: 2103        movs	r1, #3
@   0x0801128e: f7ff        fbd9 	bl	0x10a44
@   0x08011292: f005        feb5 	bl	0x17000
@   0x08011296: bc01        pop	{r0}
@   0x08011298: 4700        bx	r0
@   0x0801129a: 0000        movs	r0, r0
@   0x0801129c: 4b06        ldr	r3, [pc, #24]	@ (0x112b8)
@   0x0801129e: 4907        ldr	r1, [pc, #28]	@ (0x112bc)
@   0x080112a0: 2200        movs	r2, #0
@   0x080112a2: 1c08        adds	r0, r1, #0
@   0x080112a4: 300f        adds	r0, #15
@   0x080112a6: 7002        strb	r2, [r0, #0]
@   0x080112a8: 3801        subs	r0, #1
@   0x080112aa: 4288        cmp	r0, r1
@   0x080112ac: dafb        bge.n	0x112a6
@   0x080112ae: 2000        movs	r0, #0
@   0x080112b0: 7018        strb	r0, [r3, #0]
@   0x080112b2: 7098        strb	r0, [r3, #2]
@   0x080112b4: 4770        bx	lr
@   0x080112b6: 0000        movs	r0, r0
@   0x080112b8: 6540        str	r0, [r0, #84]	@ 0x54
@   0x080112ba: 0300        lsls	r0, r0, #12
@   0x080112bc: 63f0        str	r0, [r6, #60]	@ 0x3c
@   0x080112be: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08011288
sub_08011288: @ 0x08011288
        .incbin "baserom.gba", 0x11288, 0x38
        thumb_func_end sub_08011288
