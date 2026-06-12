@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024ae8, 0x08024b3c)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024ae8 --end 0x8024b3c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024ae8: b530        push	{r4, r5, lr}
@   0x08024aea: 2300        movs	r3, #0
@   0x08024aec: 4d11        ldr	r5, [pc, #68]	@ (0x24b34)
@   0x08024aee: 4c12        ldr	r4, [pc, #72]	@ (0x24b38)
@   0x08024af0: 00d8        lsls	r0, r3, #3
@   0x08024af2: 1942        adds	r2, r0, r5
@   0x08024af4: 1900        adds	r0, r0, r4
@   0x08024af6: 6841        ldr	r1, [r0, #4]
@   0x08024af8: 6800        ldr	r0, [r0, #0]
@   0x08024afa: 6050        str	r0, [r2, #4]
@   0x08024afc: 6091        str	r1, [r2, #8]
@   0x08024afe: 1c58        adds	r0, r3, #1
@   0x08024b00: 0600        lsls	r0, r0, #24
@   0x08024b02: 0e03        lsrs	r3, r0, #24
@   0x08024b04: 2b08        cmp	r3, #8
@   0x08024b06: d9f3        bls.n	0x24af0
@   0x08024b08: f7ff        fe50 	bl	0x247ac
@   0x08024b0c: f7ff        fe74 	bl	0x247f8
@   0x08024b10: f7ff        fe98 	bl	0x24844
@   0x08024b14: f7ff        febc 	bl	0x24890
@   0x08024b18: f7ff        ff00 	bl	0x2491c
@   0x08024b1c: f7ff        ff44 	bl	0x249a8
@   0x08024b20: f7ff        ff7e 	bl	0x24a20
@   0x08024b24: f7ff        ffa2 	bl	0x24a6c
@   0x08024b28: f7ff        ffb6 	bl	0x24a98
@   0x08024b2c: bc30        pop	{r4, r5}
@   0x08024b2e: bc01        pop	{r0}
@   0x08024b30: 4700        bx	r0
@   0x08024b32: 0000        movs	r0, r0
@   0x08024b34: 3570        adds	r5, #112	@ 0x70
@   0x08024b36: 0300        lsls	r0, r0, #12
@   0x08024b38: 3358        adds	r3, #88	@ 0x58
@   0x08024b3a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024AE8
sub_08024AE8: @ 0x08024ae8
        .incbin "baserom.gba", 0x24ae8, 0x54
        thumb_func_end sub_08024AE8
