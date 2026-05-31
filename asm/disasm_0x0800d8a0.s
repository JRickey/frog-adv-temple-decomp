@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d8a0, 0x0800d924)  (132 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d8a0 --end 0x800d924 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d8a0: b570        push	{r4, r5, r6, lr}
@   0x0800d8a2: 4c13        ldr	r4, [pc, #76]	@ (0xd8f0)
@   0x0800d8a4: 1c20        adds	r0, r4, #0
@   0x0800d8a6: 2103        movs	r1, #3
@   0x0800d8a8: 2200        movs	r2, #0
@   0x0800d8aa: f7f8        ff77 	bl	0x679c
@   0x0800d8ae: 0600        lsls	r0, r0, #24
@   0x0800d8b0: 1c25        adds	r5, r4, #0
@   0x0800d8b2: 2800        cmp	r0, #0
@   0x0800d8b4: d031        beq.n	0xd91a
@   0x0800d8b6: 2000        movs	r0, #0
@   0x0800d8b8: 4c0e        ldr	r4, [pc, #56]	@ (0xd8f4)
@   0x0800d8ba: 2308        movs	r3, #8
@   0x0800d8bc: 0602        lsls	r2, r0, #24
@   0x0800d8be: 1612        asrs	r2, r2, #24
@   0x0800d8c0: 1cd1        adds	r1, r2, #3
@   0x0800d8c2: 00c8        lsls	r0, r1, #3
@   0x0800d8c4: 1a40        subs	r0, r0, r1
@   0x0800d8c6: 00c0        lsls	r0, r0, #3
@   0x0800d8c8: 1900        adds	r0, r0, r4
@   0x0800d8ca: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x0800d8cc: 4319        orrs	r1, r3
@   0x0800d8ce: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0800d8d0: 3201        adds	r2, #1
@   0x0800d8d2: 0612        lsls	r2, r2, #24
@   0x0800d8d4: 0e10        lsrs	r0, r2, #24
@   0x0800d8d6: 1612        asrs	r2, r2, #24
@   0x0800d8d8: 2a04        cmp	r2, #4
@   0x0800d8da: ddef        ble.n	0xd8bc
@   0x0800d8dc: 1c28        adds	r0, r5, #0
@   0x0800d8de: 3033        adds	r0, #51	@ 0x33
@   0x0800d8e0: 7800        ldrb	r0, [r0, #0]
@   0x0800d8e2: 2801        cmp	r0, #1
@   0x0800d8e4: d010        beq.n	0xd908
@   0x0800d8e6: 2801        cmp	r0, #1
@   0x0800d8e8: dc06        bgt.n	0xd8f8
@   0x0800d8ea: 2800        cmp	r0, #0
@   0x0800d8ec: d009        beq.n	0xd902
@   0x0800d8ee: e016        b.n	0xd91e
@   0x0800d8f0: 6110        str	r0, [r2, #16]
@   0x0800d8f2: 0300        lsls	r0, r0, #12
@   0x0800d8f4: 3720        adds	r7, #32
@   0x0800d8f6: 0300        lsls	r0, r0, #12
@   0x0800d8f8: 2802        cmp	r0, #2
@   0x0800d8fa: d008        beq.n	0xd90e
@   0x0800d8fc: 2803        cmp	r0, #3
@   0x0800d8fe: d009        beq.n	0xd914
@   0x0800d900: e00d        b.n	0xd91e
@   0x0800d902: f01f        f8af 	bl	0x2ca64
@   0x0800d906: e00a        b.n	0xd91e
@   0x0800d908: f01e        fb7a 	bl	0x2c000
@   0x0800d90c: e007        b.n	0xd91e
@   0x0800d90e: f01e        fb23 	bl	0x2bf58
@   0x0800d912: e004        b.n	0xd91e
@   0x0800d914: f01f        f8ac 	bl	0x2ca70
@   0x0800d918: e001        b.n	0xd91e
@   0x0800d91a: f01e        ff67 	bl	0x2c7ec
@   0x0800d91e: bc70        pop	{r4, r5, r6}
@   0x0800d920: bc01        pop	{r0}
@   0x0800d922: 4700        bx	r0

        thumb_func_start sub_0800D8A0
sub_0800D8A0: @ 0x0800d8a0
        .incbin "frog_us_baserom.gba", 0xd8a0, 0x84
        thumb_func_end sub_0800D8A0
