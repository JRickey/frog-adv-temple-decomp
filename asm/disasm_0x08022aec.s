@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022aec, 0x08022b4c)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022aec --end 0x8022b4c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022aec: b530        push	{r4, r5, lr}
@   0x08022aee: 2300        movs	r3, #0
@   0x08022af0: 4d14        ldr	r5, [pc, #80]	@ (0x22b44)
@   0x08022af2: 4c15        ldr	r4, [pc, #84]	@ (0x22b48)
@   0x08022af4: 00d8        lsls	r0, r3, #3
@   0x08022af6: 1942        adds	r2, r0, r5
@   0x08022af8: 1900        adds	r0, r0, r4
@   0x08022afa: 6841        ldr	r1, [r0, #4]
@   0x08022afc: 6800        ldr	r0, [r0, #0]
@   0x08022afe: 6050        str	r0, [r2, #4]
@   0x08022b00: 6091        str	r1, [r2, #8]
@   0x08022b02: 1c58        adds	r0, r3, #1
@   0x08022b04: 0600        lsls	r0, r0, #24
@   0x08022b06: 0e03        lsrs	r3, r0, #24
@   0x08022b08: 2b06        cmp	r3, #6
@   0x08022b0a: d9f3        bls.n	0x22af4
@   0x08022b0c: f7ff        fe10 	bl	0x22730
@   0x08022b10: f7ff        fb74 	bl	0x221fc
@   0x08022b14: f7ff        fbd2 	bl	0x222bc
@   0x08022b18: f7ff        feb4 	bl	0x22884
@   0x08022b1c: f7ff        fe4a 	bl	0x227b4
@   0x08022b20: f7ff        fa9c 	bl	0x2205c
@   0x08022b24: f7ff        fe88 	bl	0x22838
@   0x08022b28: f7ff        facc 	bl	0x220c4
@   0x08022b2c: f7ff        fc18 	bl	0x22360
@   0x08022b30: f7ff        fece 	bl	0x228d0
@   0x08022b34: f7ff        fa16 	bl	0x21f64
@   0x08022b38: f7ff        ffb0 	bl	0x22a9c
@   0x08022b3c: bc30        pop	{r4, r5}
@   0x08022b3e: bc01        pop	{r0}
@   0x08022b40: 4700        bx	r0
@   0x08022b42: 0000        movs	r0, r0
@   0x08022b44: 3570        adds	r5, #112	@ 0x70
@   0x08022b46: 0300        lsls	r0, r0, #12
@   0x08022b48: 1450        asrs	r0, r2, #17
@   0x08022b4a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08022AEC
sub_08022AEC: @ 0x08022aec
        .incbin "frog_us_baserom.gba", 0x22aec, 0x60
        thumb_func_end sub_08022AEC
