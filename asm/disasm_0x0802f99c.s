@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802f99c, 0x0802f9f0)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802f99c --end 0x802f9f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802f99c: b570        push	{r4, r5, r6, lr}
@   0x0802f99e: 1c04        adds	r4, r0, #0
@   0x0802f9a0: 1c0e        adds	r6, r1, #0
@   0x0802f9a2: 1c15        adds	r5, r2, #0
@   0x0802f9a4: 2b02        cmp	r3, #2
@   0x0802f9a6: dc0d        bgt.n	0x2f9c4
@   0x0802f9a8: 4805        ldr	r0, [pc, #20]	@ (0x2f9c0)
@   0x0802f9aa: 6802        ldr	r2, [r0, #0]
@   0x0802f9ac: 00e1        lsls	r1, r4, #3
@   0x0802f9ae: 00d8        lsls	r0, r3, #3
@   0x0802f9b0: 18c0        adds	r0, r0, r3
@   0x0802f9b2: 0080        lsls	r0, r0, #2
@   0x0802f9b4: 1809        adds	r1, r1, r0
@   0x0802f9b6: 1852        adds	r2, r2, r1
@   0x0802f9b8: 8515        strh	r5, [r2, #40]	@ 0x28
@   0x0802f9ba: 84d6        strh	r6, [r2, #38]	@ 0x26
@   0x0802f9bc: e010        b.n	0x2f9e0
@   0x0802f9be: 0000        movs	r0, r0
@   0x0802f9c0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f9c2: 0300        lsls	r0, r0, #12
@   0x0802f9c4: 2b03        cmp	r3, #3
@   0x0802f9c6: dd0b        ble.n	0x2f9e0
@   0x0802f9c8: 4807        ldr	r0, [pc, #28]	@ (0x2f9e8)
@   0x0802f9ca: 6800        ldr	r0, [r0, #0]
@   0x0802f9cc: 30c8        adds	r0, #200	@ 0xc8
@   0x0802f9ce: 0199        lsls	r1, r3, #6
@   0x0802f9d0: 4a06        ldr	r2, [pc, #24]	@ (0x2f9ec)
@   0x0802f9d2: 1889        adds	r1, r1, r2
@   0x0802f9d4: 6800        ldr	r0, [r0, #0]
@   0x0802f9d6: 1840        adds	r0, r0, r1
@   0x0802f9d8: 00e1        lsls	r1, r4, #3
@   0x0802f9da: 1840        adds	r0, r0, r1
@   0x0802f9dc: 8105        strh	r5, [r0, #8]
@   0x0802f9de: 80c6        strh	r6, [r0, #6]
@   0x0802f9e0: bc70        pop	{r4, r5, r6}
@   0x0802f9e2: bc01        pop	{r0}
@   0x0802f9e4: 4700        bx	r0
@   0x0802f9e6: 0000        movs	r0, r0
@   0x0802f9e8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f9ea: 0300        lsls	r0, r0, #12
@   0x0802f9ec: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>

        thumb_func_start sub_0802F99C
sub_0802F99C: @ 0x0802f99c
        .incbin "frog_us_baserom.gba", 0x2f99c, 0x54
        thumb_func_end sub_0802F99C
