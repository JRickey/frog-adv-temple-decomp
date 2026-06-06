@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015220, 0x080152b0)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015220 --end 0x80152b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015220: b500        push	{lr}
@   0x08015222: 2003        movs	r0, #3
@   0x08015224: f7f9 fb1a   bl	0xe85c
@   0x08015228: f7f9 fc78   bl	0xeb1c
@   0x0801522c: 2003        movs	r0, #3
@   0x0801522e: f7fa f80d   bl	0xf24c
@   0x08015232: f7ff ffaf   bl	0x15194
@   0x08015236: 4809        ldr	r0, [pc, #36]	@ (0x1525c)
@   0x08015238: 3033        adds	r0, #51	@ 0x33
@   0x0801523a: 7800        ldrb	r0, [r0, #0]
@   0x0801523c: 2801        cmp	r0, #1
@   0x0801523e: d117        bne.n	0x15270
@   0x08015240: 4a07        ldr	r2, [pc, #28]	@ (0x15260)
@   0x08015242: 4808        ldr	r0, [pc, #32]	@ (0x15264)
@   0x08015244: 6010        str	r0, [r2, #0]
@   0x08015246: 2180        movs	r1, #128	@ 0x80
@   0x08015248: 0489        lsls	r1, r1, #18
@   0x0801524a: 6051        str	r1, [r2, #4]
@   0x0801524c: 4806        ldr	r0, [pc, #24]	@ (0x15268)
@   0x0801524e: 6090        str	r0, [r2, #8]
@   0x08015250: 6890        ldr	r0, [r2, #8]
@   0x08015252: 4a06        ldr	r2, [pc, #24]	@ (0x1526c)
@   0x08015254: 2000        movs	r0, #0
@   0x08015256: f7fa ff45   bl	0x100e4
@   0x0801525a: e016        b.n	0x1528a
@   0x0801525c: 6110 0300   .word	0x03006110
@   0x08015260: 00d4 0400   .word	0x040000d4
@   0x08015264: c312 0819   .word	0x0819c312
@   0x08015268: 8000 8000   .word	0x80008000
@   0x0801526c: e000 0600   .word	0x0600e000
@   0x08015270: 4a0b        ldr	r2, [pc, #44]	@ (0x152a0)
@   0x08015272: 480c        ldr	r0, [pc, #48]	@ (0x152a4)
@   0x08015274: 6010        str	r0, [r2, #0]
@   0x08015276: 2180        movs	r1, #128	@ 0x80
@   0x08015278: 0489        lsls	r1, r1, #18
@   0x0801527a: 6051        str	r1, [r2, #4]
@   0x0801527c: 480a        ldr	r0, [pc, #40]	@ (0x152a8)
@   0x0801527e: 6090        str	r0, [r2, #8]
@   0x08015280: 6890        ldr	r0, [r2, #8]
@   0x08015282: 4a0a        ldr	r2, [pc, #40]	@ (0x152ac)
@   0x08015284: 2000        movs	r0, #0
@   0x08015286: f7fa ff2d   bl	0x100e4
@   0x0801528a: 2003        movs	r0, #3
@   0x0801528c: f7f9 fca6   bl	0xebdc
@   0x08015290: f001 fbd6   bl	0x16a40
@   0x08015294: 2002        movs	r0, #2
@   0x08015296: f7f9 fdcd   bl	0xee34
@   0x0801529a: bc01        pop	{r0}
@   0x0801529c: 4700        bx	r0
@   0x0801529e: 0000        movs	r0, r0
@   0x080152a0: 00d4 0400   .word	0x040000d4
@   0x080152a4: cfde 0819   .word	0x0819cfde
@   0x080152a8: 8000 8000   .word	0x80008000
@   0x080152ac: e000 0600   .word	0x0600e000

        thumb_func_start sub_08015220
sub_08015220: @ 0x08015220
        .incbin "frog_us_baserom.gba", 0x15220, 0x90
        thumb_func_end sub_08015220
