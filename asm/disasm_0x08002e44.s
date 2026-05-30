@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002e44, 0x08002e94)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002e44 --end 0x8002e94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002e44: b510        push	{r4, lr}
@   0x08002e46: f007        fa47 	bl	0xa2d8
@   0x08002e4a: f7fd        fd47 	bl	0x8dc
@   0x08002e4e: f007        fa6b 	bl	0xa328
@   0x08002e52: f006        fb51 	bl	0x94f8
@   0x08002e56: f006        fd95 	bl	0x9984
@   0x08002e5a: 4b0c        ldr	r3, [pc, #48]	@ (0x2e8c)
@   0x08002e5c: 2010        movs	r0, #16
@   0x08002e5e: 8a19        ldrh	r1, [r3, #16]
@   0x08002e60: 4008        ands	r0, r1
@   0x08002e62: 2800        cmp	r0, #0
@   0x08002e64: d00b        beq.n	0x2e7e
@   0x08002e66: 7e18        ldrb	r0, [r3, #24]
@   0x08002e68: 7e59        ldrb	r1, [r3, #25]
@   0x08002e6a: 2408        movs	r4, #8
@   0x08002e6c: 5f1a        ldrsh	r2, [r3, r4]
@   0x08002e6e: 240a        movs	r4, #10
@   0x08002e70: 5f1b        ldrsh	r3, [r3, r4]
@   0x08002e72: f009        ff89 	bl	0xcd88
@   0x08002e76: 0600        lsls	r0, r0, #24
@   0x08002e78: 0e00        lsrs	r0, r0, #24
@   0x08002e7a: f007        ff35 	bl	0xace8
@   0x08002e7e: 4904        ldr	r1, [pc, #16]	@ (0x2e90)
@   0x08002e80: 6948        ldr	r0, [r1, #20]
@   0x08002e82: 3001        adds	r0, #1
@   0x08002e84: 6148        str	r0, [r1, #20]
@   0x08002e86: bc10        pop	{r4}
@   0x08002e88: bc01        pop	{r0}
@   0x08002e8a: 4700        bx	r0
@   0x08002e8c: 35e0        adds	r5, #224	@ 0xe0
@   0x08002e8e: 0300        lsls	r0, r0, #12
@   0x08002e90: 5330        strh	r0, [r6, r4]
@   0x08002e92: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08002E44
sub_08002E44: @ 0x08002e44
        .incbin "frog_us_baserom.gba", 0x2e44, 0x50
        thumb_func_end sub_08002E44
