@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802afc0, 0x0802aff8)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802afc0 --end 0x802aff8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802afc0: b530        push	{r4, r5, lr}
@   0x0802afc2: 2300        movs	r3, #0
@   0x0802afc4: 4d0a        ldr	r5, [pc, #40]	@ (0x2aff0)
@   0x0802afc6: 4c0b        ldr	r4, [pc, #44]	@ (0x2aff4)
@   0x0802afc8: 00d8        lsls	r0, r3, #3
@   0x0802afca: 1942        adds	r2, r0, r5
@   0x0802afcc: 1900        adds	r0, r0, r4
@   0x0802afce: 6841        ldr	r1, [r0, #4]
@   0x0802afd0: 6800        ldr	r0, [r0, #0]
@   0x0802afd2: 6050        str	r0, [r2, #4]
@   0x0802afd4: 6091        str	r1, [r2, #8]
@   0x0802afd6: 1c58        adds	r0, r3, #1
@   0x0802afd8: 0600        lsls	r0, r0, #24
@   0x0802afda: 0e03        lsrs	r3, r0, #24
@   0x0802afdc: 2b03        cmp	r3, #3
@   0x0802afde: d9f3        bls.n	0x2afc8
@   0x0802afe0: f7ff        ffd0 	bl	0x2af84
@   0x0802afe4: f7ff        ff94 	bl	0x2af10
@   0x0802afe8: bc30        pop	{r4, r5}
@   0x0802afea: bc01        pop	{r0}
@   0x0802afec: 4700        bx	r0
@   0x0802afee: 0000        movs	r0, r0
@   0x0802aff0: 3570        adds	r5, #112	@ 0x70
@   0x0802aff2: 0300        lsls	r0, r0, #12
@   0x0802aff4: 7f68        ldrb	r0, [r5, #29]
@   0x0802aff6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802AFC0
sub_0802AFC0: @ 0x0802afc0
        .incbin "baserom.gba", 0x2afc0, 0x38
        thumb_func_end sub_0802AFC0
