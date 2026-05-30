@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003b8c, 0x08003bfc)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003b8c --end 0x8003bfc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003b8c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08003b8e: b082        sub	sp, #8
@   0x08003b90: 4817        ldr	r0, [pc, #92]	@ (0x3bf0)
@   0x08003b92: 4b18        ldr	r3, [pc, #96]	@ (0x3bf4)
@   0x08003b94: 2101        movs	r1, #1
@   0x08003b96: 9100        str	r1, [sp, #0]
@   0x08003b98: 2105        movs	r1, #5
@   0x08003b9a: 9101        str	r1, [sp, #4]
@   0x08003b9c: 2180        movs	r1, #128	@ 0x80
@   0x08003b9e: 220c        movs	r2, #12
@   0x08003ba0: f002        fcf4 	bl	0x658c
@   0x08003ba4: 200c        movs	r0, #12
@   0x08003ba6: 2100        movs	r1, #0
@   0x08003ba8: f009        f976 	bl	0xce98
@   0x08003bac: f006        f886 	bl	0x9cbc
@   0x08003bb0: 2700        movs	r7, #0
@   0x08003bb2: 4d11        ldr	r5, [pc, #68]	@ (0x3bf8)
@   0x08003bb4: 26ba        movs	r6, #186	@ 0xba
@   0x08003bb6: 03f6        lsls	r6, r6, #15
@   0x08003bb8: 7e28        ldrb	r0, [r5, #24]
@   0x08003bba: 7e69        ldrb	r1, [r5, #25]
@   0x08003bbc: 1434        asrs	r4, r6, #16
@   0x08003bbe: 220d        movs	r2, #13
@   0x08003bc0: 9200        str	r2, [sp, #0]
@   0x08003bc2: 2206        movs	r2, #6
@   0x08003bc4: 1c23        adds	r3, r4, #0
@   0x08003bc6: f009        f80f 	bl	0xcbe8
@   0x08003bca: 7e28        ldrb	r0, [r5, #24]
@   0x08003bcc: 7e69        ldrb	r1, [r5, #25]
@   0x08003bce: 220e        movs	r2, #14
@   0x08003bd0: 9200        str	r2, [sp, #0]
@   0x08003bd2: 2207        movs	r2, #7
@   0x08003bd4: 1c23        adds	r3, r4, #0
@   0x08003bd6: f009        f807 	bl	0xcbe8
@   0x08003bda: 2080        movs	r0, #128	@ 0x80
@   0x08003bdc: 0240        lsls	r0, r0, #9
@   0x08003bde: 1836        adds	r6, r6, r0
@   0x08003be0: 3701        adds	r7, #1
@   0x08003be2: 2f05        cmp	r7, #5
@   0x08003be4: dde8        ble.n	0x3bb8
@   0x08003be6: b002        add	sp, #8
@   0x08003be8: bcf0        pop	{r4, r5, r6, r7}
@   0x08003bea: bc01        pop	{r0}
@   0x08003bec: 4700        bx	r0
@   0x08003bee: 0000        movs	r0, r0
@   0x08003bf0: 6110        str	r0, [r2, #16]
@   0x08003bf2: 0300        lsls	r0, r0, #12
@   0x08003bf4: 9b2c        ldr	r3, [sp, #176]	@ 0xb0
@   0x08003bf6: 082f        lsrs	r7, r5, #32
@   0x08003bf8: 35e0        adds	r5, #224	@ 0xe0
@   0x08003bfa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08003B8C
sub_08003B8C: @ 0x08003b8c
        .incbin "frog_us_baserom.gba", 0x3b8c, 0x70
        thumb_func_end sub_08003B8C
