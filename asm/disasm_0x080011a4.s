@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080011a4, 0x08001214)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80011a4 --end 0x8001214 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080011a4: b510        push	{r4, lr}
@   0x080011a6: 4906        ldr	r1, [pc, #24]	@ (0x11c0)
@   0x080011a8: 2004        movs	r0, #4
@   0x080011aa: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x080011ac: 4008        ands	r0, r1
@   0x080011ae: 2800        cmp	r0, #0
@   0x080011b0: d00a        beq.n	0x11c8
@   0x080011b2: 4804        ldr	r0, [pc, #16]	@ (0x11c4)
@   0x080011b4: 2108        movs	r1, #8
@   0x080011b6: 2201        movs	r2, #1
@   0x080011b8: f005        fa84 	bl	0x66c4
@   0x080011bc: e023        b.n	0x1206
@   0x080011be: 0000        movs	r0, r0
@   0x080011c0: 3720        adds	r7, #32
@   0x080011c2: 0300        lsls	r0, r0, #12
@   0x080011c4: 6110        str	r0, [r2, #16]
@   0x080011c6: 0300        lsls	r0, r0, #12
@   0x080011c8: 4c10        ldr	r4, [pc, #64]	@ (0x120c)
@   0x080011ca: 1c20        adds	r0, r4, #0
@   0x080011cc: 2105        movs	r1, #5
@   0x080011ce: 220f        movs	r2, #15
@   0x080011d0: f005        fae4 	bl	0x679c
@   0x080011d4: 0600        lsls	r0, r0, #24
@   0x080011d6: 2800        cmp	r0, #0
@   0x080011d8: d003        beq.n	0x11e2
@   0x080011da: 2008        movs	r0, #8
@   0x080011dc: 8de1        ldrh	r1, [r4, #46]	@ 0x2e
@   0x080011de: 4308        orrs	r0, r1
@   0x080011e0: 85e0        strh	r0, [r4, #46]	@ 0x2e
@   0x080011e2: 4b0b        ldr	r3, [pc, #44]	@ (0x1210)
@   0x080011e4: 2010        movs	r0, #16
@   0x080011e6: 8a1c        ldrh	r4, [r3, #16]
@   0x080011e8: 4020        ands	r0, r4
@   0x080011ea: 2800        cmp	r0, #0
@   0x080011ec: d00b        beq.n	0x1206
@   0x080011ee: 7e18        ldrb	r0, [r3, #24]
@   0x080011f0: 7e59        ldrb	r1, [r3, #25]
@   0x080011f2: 2408        movs	r4, #8
@   0x080011f4: 5f1a        ldrsh	r2, [r3, r4]
@   0x080011f6: 240a        movs	r4, #10
@   0x080011f8: 5f1b        ldrsh	r3, [r3, r4]
@   0x080011fa: f00b        fdc5 	bl	0xcd88
@   0x080011fe: 0600        lsls	r0, r0, #24
@   0x08001200: 0e00        lsrs	r0, r0, #24
@   0x08001202: f009        fcbf 	bl	0xab84
@   0x08001206: bc10        pop	{r4}
@   0x08001208: bc01        pop	{r0}
@   0x0800120a: 4700        bx	r0
@   0x0800120c: 6110        str	r0, [r2, #16]
@   0x0800120e: 0300        lsls	r0, r0, #12
@   0x08001210: 35e0        adds	r5, #224	@ 0xe0
@   0x08001212: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080011A4
sub_080011A4: @ 0x080011a4
        .incbin "frog_us_baserom.gba", 0x11a4, 0x70
        thumb_func_end sub_080011A4
