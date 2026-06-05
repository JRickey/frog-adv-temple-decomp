@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023fac, 0x08023ff8)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023fac --end 0x8023ff8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023fac: b530        push	{r4, r5, lr}
@   0x08023fae: 2400        movs	r4, #0
@   0x08023fb0: 4d0f        ldr	r5, [pc, #60]	@ (0x23ff0)
@   0x08023fb2: 00a0        lsls	r0, r4, #2
@   0x08023fb4: 1940        adds	r0, r0, r5
@   0x08023fb6: 6800        ldr	r0, [r0, #0]
@   0x08023fb8: 1ca1        adds	r1, r4, #2
@   0x08023fba: f7fd        fcff 	bl	0x219bc
@   0x08023fbe: 1c60        adds	r0, r4, #1
@   0x08023fc0: 0600        lsls	r0, r0, #24
@   0x08023fc2: 0e04        lsrs	r4, r0, #24
@   0x08023fc4: 2c07        cmp	r4, #7
@   0x08023fc6: d9f4        bls.n	0x23fb2
@   0x08023fc8: 4c0a        ldr	r4, [pc, #40]	@ (0x23ff4)
@   0x08023fca: 1c20        adds	r0, r4, #0
@   0x08023fcc: 2102        movs	r1, #2
@   0x08023fce: f7e2        fccd 	bl	0x696c
@   0x08023fd2: 1c20        adds	r0, r4, #0
@   0x08023fd4: 2103        movs	r1, #3
@   0x08023fd6: f7e2        fcc9 	bl	0x696c
@   0x08023fda: 2002        movs	r0, #2
@   0x08023fdc: 2109        movs	r1, #9
@   0x08023fde: f7fd        f801 	bl	0x20fe4
@   0x08023fe2: 2002        movs	r0, #2
@   0x08023fe4: 2109        movs	r1, #9
@   0x08023fe6: f7e1        fe93 	bl	0x5d10
@   0x08023fea: bc30        pop	{r4, r5}
@   0x08023fec: bc01        pop	{r0}
@   0x08023fee: 4700        bx	r0
@   0x08023ff0: 2d60        cmp	r5, #96	@ 0x60
@   0x08023ff2: 0831        lsrs	r1, r6, #32
@   0x08023ff4: 6110        str	r0, [r2, #16]
@   0x08023ff6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08023FAC
sub_08023FAC: @ 0x08023fac
        .incbin "frog_us_baserom.gba", 0x23fac, 0x4c
        thumb_func_end sub_08023FAC
