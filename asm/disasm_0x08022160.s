@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022160, 0x080221fc)  (156 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022160 --end 0x80221fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022160: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08022162: 4647        mov	r7, r8
@   0x08022164: b480        push	{r7}
@   0x08022166: 4a20        ldr	r2, [pc, #128]	@ (0x221e8)
@   0x08022168: 2004        movs	r0, #4
@   0x0802216a: 5e11        ldrsh	r1, [r2, r0]
@   0x0802216c: 481f        ldr	r0, [pc, #124]	@ (0x221ec)
@   0x0802216e: 4281        cmp	r1, r0
@   0x08022170: dd35        ble.n	0x221de
@   0x08022172: 2600        movs	r6, #0
@   0x08022174: 4690        mov	r8, r2
@   0x08022176: 4f1e        ldr	r7, [pc, #120]	@ (0x221f0)
@   0x08022178: 1c34        adds	r4, r6, #0
@   0x0802217a: 3427        adds	r4, #39	@ 0x27
@   0x0802217c: 481d        ldr	r0, [pc, #116]	@ (0x221f4)
@   0x0802217e: 1c21        adds	r1, r4, #0
@   0x08022180: f7e4        fbf4 	bl	0x696c
@   0x08022184: 00e0        lsls	r0, r4, #3
@   0x08022186: 1b00        subs	r0, r0, r4
@   0x08022188: 00c0        lsls	r0, r0, #3
@   0x0802218a: 4641        mov	r1, r8
@   0x0802218c: 1845        adds	r5, r0, r1
@   0x0802218e: 2003        movs	r0, #3
@   0x08022190: 75e8        strb	r0, [r5, #23]
@   0x08022192: 4919        ldr	r1, [pc, #100]	@ (0x221f8)
@   0x08022194: 00b0        lsls	r0, r6, #2
@   0x08022196: 1840        adds	r0, r0, r1
@   0x08022198: 6800        ldr	r0, [r0, #0]
@   0x0802219a: 1c21        adds	r1, r4, #0
@   0x0802219c: f7ff        fc0e 	bl	0x219bc
@   0x080221a0: 2104        movs	r1, #4
@   0x080221a2: 5e68        ldrsh	r0, [r5, r1]
@   0x080221a4: 42b8        cmp	r0, r7
@   0x080221a6: dd01        ble.n	0x221ac
@   0x080221a8: 2002        movs	r0, #2
@   0x080221aa: 75e8        strb	r0, [r5, #23]
@   0x080221ac: 1c70        adds	r0, r6, #1
@   0x080221ae: 0600        lsls	r0, r0, #24
@   0x080221b0: 0e06        lsrs	r6, r0, #24
@   0x080221b2: 2e07        cmp	r6, #7
@   0x080221b4: d9e0        bls.n	0x22178
@   0x080221b6: 2027        movs	r0, #39	@ 0x27
@   0x080221b8: 2129        movs	r1, #41	@ 0x29
@   0x080221ba: f7fe        ff13 	bl	0x20fe4
@   0x080221be: 202a        movs	r0, #42	@ 0x2a
@   0x080221c0: 212c        movs	r1, #44	@ 0x2c
@   0x080221c2: f7fe        ff0f 	bl	0x20fe4
@   0x080221c6: 2027        movs	r0, #39	@ 0x27
@   0x080221c8: 212c        movs	r1, #44	@ 0x2c
@   0x080221ca: f7e3        fda1 	bl	0x5d10
@   0x080221ce: 202d        movs	r0, #45	@ 0x2d
@   0x080221d0: 212e        movs	r1, #46	@ 0x2e
@   0x080221d2: f7fe        ff07 	bl	0x20fe4
@   0x080221d6: 202d        movs	r0, #45	@ 0x2d
@   0x080221d8: 212e        movs	r1, #46	@ 0x2e
@   0x080221da: f7e3        fd99 	bl	0x5d10
@   0x080221de: bc08        pop	{r3}
@   0x080221e0: 4698        mov	r8, r3
@   0x080221e2: bcf0        pop	{r4, r5, r6, r7}
@   0x080221e4: bc01        pop	{r0}
@   0x080221e6: 4700        bx	r0
@   0x080221e8: 3720        adds	r7, #32
@   0x080221ea: 0300        lsls	r0, r0, #12
@   0x080221ec: 02b7        lsls	r7, r6, #10
@   0x080221ee: 0000        movs	r0, r0
@   0x080221f0: 037f        lsls	r7, r7, #13
@   0x080221f2: 0000        movs	r0, r0
@   0x080221f4: 6110        str	r0, [r2, #16]
@   0x080221f6: 0300        lsls	r0, r0, #12
@   0x080221f8: 12a8        asrs	r0, r5, #10
@   0x080221fa: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08022160
sub_08022160: @ 0x08022160
        .incbin "frog_us_baserom.gba", 0x22160, 0x9c
        thumb_func_end sub_08022160
