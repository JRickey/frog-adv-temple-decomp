@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080052cc, 0x08005308)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80052cc --end 0x8005308 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080052cc: b510        push	{r4, lr}
@   0x080052ce: b082        sub	sp, #8
@   0x080052d0: 4c0b        ldr	r4, [pc, #44]	@ (0x5300)
@   0x080052d2: 4b0c        ldr	r3, [pc, #48]	@ (0x5304)
@   0x080052d4: 2001        movs	r0, #1
@   0x080052d6: 9000        str	r0, [sp, #0]
@   0x080052d8: 2005        movs	r0, #5
@   0x080052da: 9001        str	r0, [sp, #4]
@   0x080052dc: 1c20        adds	r0, r4, #0
@   0x080052de: 2150        movs	r1, #80	@ 0x50
@   0x080052e0: 2210        movs	r2, #16
@   0x080052e2: f001        f953 	bl	0x658c
@   0x080052e6: 2010        movs	r0, #16
@   0x080052e8: 2100        movs	r1, #0
@   0x080052ea: f007        fdd5 	bl	0xce98
@   0x080052ee: f004        fce5 	bl	0x9cbc
@   0x080052f2: 3433        adds	r4, #51	@ 0x33
@   0x080052f4: 2000        movs	r0, #0
@   0x080052f6: 7020        strb	r0, [r4, #0]
@   0x080052f8: b002        add	sp, #8
@   0x080052fa: bc10        pop	{r4}
@   0x080052fc: bc01        pop	{r0}
@   0x080052fe: 4700        bx	r0
@   0x08005300: 6110        str	r0, [r2, #16]
@   0x08005302: 0300        lsls	r0, r0, #12
@   0x08005304: 9ce0        ldr	r4, [sp, #896]	@ 0x380
@   0x08005306: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_080052CC
sub_080052CC: @ 0x080052cc
        .incbin "frog_us_baserom.gba", 0x52cc, 0x3c
        thumb_func_end sub_080052CC
