@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d9c8, 0x0800d9fc)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d9c8 --end 0x800d9fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d9c8: b530        push	{r4, r5, lr}
@   0x0800d9ca: f003        fd0d 	bl	0x113e8
@   0x0800d9ce: 4a07        ldr	r2, [pc, #28]	@ (0xd9ec)
@   0x0800d9d0: 4c07        ldr	r4, [pc, #28]	@ (0xd9f0)
@   0x0800d9d2: 8923        ldrh	r3, [r4, #8]
@   0x0800d9d4: 4d07        ldr	r5, [pc, #28]	@ (0xd9f4)
@   0x0800d9d6: 1951        adds	r1, r2, r5
@   0x0800d9d8: 800b        strh	r3, [r1, #0]
@   0x0800d9da: 8961        ldrh	r1, [r4, #10]
@   0x0800d9dc: 4b06        ldr	r3, [pc, #24]	@ (0xd9f8)
@   0x0800d9de: 18d2        adds	r2, r2, r3
@   0x0800d9e0: 8011        strh	r1, [r2, #0]
@   0x0800d9e2: f000        f845 	bl	0xda70
@   0x0800d9e6: bc30        pop	{r4, r5}
@   0x0800d9e8: bc02        pop	{r1}
@   0x0800d9ea: 4708        bx	r1
@   0x0800d9ec: 3720        adds	r7, #32
@   0x0800d9ee: 0300        lsls	r0, r0, #12
@   0x0800d9f0: 35e0        adds	r5, #224	@ 0xe0
@   0x0800d9f2: 0300        lsls	r0, r0, #12
@   0x0800d9f4: 0692        lsls	r2, r2, #26
@   0x0800d9f6: 0000        movs	r0, r0
@   0x0800d9f8: 0694        lsls	r4, r2, #26
@   0x0800d9fa: 0000        movs	r0, r0

        thumb_func_start sub_0800D9C8
sub_0800D9C8: @ 0x0800d9c8
        .incbin "frog_us_baserom.gba", 0xd9c8, 0x34
        thumb_func_end sub_0800D9C8
