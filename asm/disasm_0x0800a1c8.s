@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a1c8, 0x0800a214)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a1c8 --end 0x800a214 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a1c8: b530        push	{r4, r5, lr}
@   0x0800a1ca: 4d0f        ldr	r5, [pc, #60]	@ (0xa208)
@   0x0800a1cc: 7aac        ldrb	r4, [r5, #10]
@   0x0800a1ce: 1c20        adds	r0, r4, #0
@   0x0800a1d0: 2103        movs	r1, #3
@   0x0800a1d2: f029        fec3 	bl	0x33f5c
@   0x0800a1d6: 0600        lsls	r0, r0, #24
@   0x0800a1d8: 2800        cmp	r0, #0
@   0x0800a1da: d011        beq.n	0xa200
@   0x0800a1dc: 2c10        cmp	r4, #16
@   0x0800a1de: d00f        beq.n	0xa200
@   0x0800a1e0: 2400        movs	r4, #0
@   0x0800a1e2: f016        fce3 	bl	0x20bac
@   0x0800a1e6: 4809        ldr	r0, [pc, #36]	@ (0xa20c)
@   0x0800a1e8: 3032        adds	r0, #50	@ 0x32
@   0x0800a1ea: 7800        ldrb	r0, [r0, #0]
@   0x0800a1ec: 2801        cmp	r0, #1
@   0x0800a1ee: d104        bne.n	0xa1fa
@   0x0800a1f0: 4907        ldr	r1, [pc, #28]	@ (0xa210)
@   0x0800a1f2: 7aad        ldrb	r5, [r5, #10]
@   0x0800a1f4: 00a8        lsls	r0, r5, #2
@   0x0800a1f6: 1840        adds	r0, r0, r1
@   0x0800a1f8: 6804        ldr	r4, [r0, #0]
@   0x0800a1fa: 1c20        adds	r0, r4, #0
@   0x0800a1fc: f016        fcc4 	bl	0x20b88
@   0x0800a200: bc30        pop	{r4, r5}
@   0x0800a202: bc01        pop	{r0}
@   0x0800a204: 4700        bx	r0
@   0x0800a206: 0000        movs	r0, r0
@   0x0800a208: 5330        strh	r0, [r6, r4]
@   0x0800a20a: 0300        lsls	r0, r0, #12
@   0x0800a20c: 6110        str	r0, [r2, #16]
@   0x0800a20e: 0300        lsls	r0, r0, #12
@   0x0800a210: 0d98        lsrs	r0, r3, #22
@   0x0800a212: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_0800A1C8
sub_0800A1C8: @ 0x0800a1c8
        .incbin "frog_us_baserom.gba", 0xa1c8, 0x4c
        thumb_func_end sub_0800A1C8
