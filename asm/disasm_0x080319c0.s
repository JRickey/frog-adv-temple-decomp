@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080319c0, 0x080319fc)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80319c0 --end 0x80319fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080319c0: b530        push	{r4, r5, lr}
@   0x080319c2: 1c04        adds	r4, r0, #0
@   0x080319c4: 1c0d        adds	r5, r1, #0
@   0x080319c6: 2c01        cmp	r4, #1
@   0x080319c8: dd01        ble.n	0x319ce
@   0x080319ca: 2c03        cmp	r4, #3
@   0x080319cc: d10d        bne.n	0x319ea
@   0x080319ce: 2000        movs	r0, #0
@   0x080319d0: 1c21        adds	r1, r4, #0
@   0x080319d2: f7fd        ff5d 	bl	0x2f890
@   0x080319d6: 4808        ldr	r0, [pc, #32]	@ (0x319f8)
@   0x080319d8: 6801        ldr	r1, [r0, #0]
@   0x080319da: 00a0        lsls	r0, r4, #2
@   0x080319dc: 3110        adds	r1, #16
@   0x080319de: 1809        adds	r1, r1, r0
@   0x080319e0: 6808        ldr	r0, [r1, #0]
@   0x080319e2: 22a0        movs	r2, #160	@ 0xa0
@   0x080319e4: 0092        lsls	r2, r2, #2
@   0x080319e6: 4310        orrs	r0, r2
@   0x080319e8: 6008        str	r0, [r1, #0]
@   0x080319ea: 6828        ldr	r0, [r5, #0]
@   0x080319ec: 3002        adds	r0, #2
@   0x080319ee: 6028        str	r0, [r5, #0]
@   0x080319f0: 2001        movs	r0, #1
@   0x080319f2: bc30        pop	{r4, r5}
@   0x080319f4: bc02        pop	{r1}
@   0x080319f6: 4708        bx	r1
@   0x080319f8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080319fa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080319C0
sub_080319C0: @ 0x080319c0
        .incbin "frog_us_baserom.gba", 0x319c0, 0x3c
        thumb_func_end sub_080319C0
