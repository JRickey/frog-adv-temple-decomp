@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002ae8, 0x08002b58)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002ae8 --end 0x8002b58 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002ae8: b510        push	{r4, lr}
@   0x08002aea: b081        sub	sp, #4
@   0x08002aec: 4910        ldr	r1, [pc, #64]	@ (0x2b30)
@   0x08002aee: 2015        movs	r0, #21
@   0x08002af0: 7688        strb	r0, [r1, #26]
@   0x08002af2: 2002        movs	r0, #2
@   0x08002af4: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x08002af6: 4310        orrs	r0, r2
@   0x08002af8: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x08002afa: 7ec8        ldrb	r0, [r1, #27]
@   0x08002afc: 2804        cmp	r0, #4
@   0x08002afe: d809        bhi.n	0x2b14
@   0x08002b00: 1c0c        adds	r4, r1, #0
@   0x08002b02: f007        fbe9 	bl	0xa2d8
@   0x08002b06: f7fd        fee9 	bl	0x8dc
@   0x08002b0a: f007        fc0d 	bl	0xa328
@   0x08002b0e: 7ee2        ldrb	r2, [r4, #27]
@   0x08002b10: 2a04        cmp	r2, #4
@   0x08002b12: d9f6        bls.n	0x2b02
@   0x08002b14: 2100        movs	r1, #0
@   0x08002b16: 4668        mov	r0, sp
@   0x08002b18: 7001        strb	r1, [r0, #0]
@   0x08002b1a: f010        fef5 	bl	0x13908
@   0x08002b1e: 4805        ldr	r0, [pc, #20]	@ (0x2b34)
@   0x08002b20: 3033        adds	r0, #51	@ 0x33
@   0x08002b22: 7800        ldrb	r0, [r0, #0]
@   0x08002b24: 3001        adds	r0, #1
@   0x08002b26: 0600        lsls	r0, r0, #24
@   0x08002b28: 1600        asrs	r0, r0, #24
@   0x08002b2a: f004        fea3 	bl	0x7874
@   0x08002b2e: e005        b.n	0x2b3c
@   0x08002b30: 3720        adds	r7, #32
@   0x08002b32: 0300        lsls	r0, r0, #12
@   0x08002b34: 6110        str	r0, [r2, #16]
@   0x08002b36: 0300        lsls	r0, r0, #12
@   0x08002b38: f7fd        fed0 	bl	0x8dc
@   0x08002b3c: 4668        mov	r0, sp
@   0x08002b3e: 4905        ldr	r1, [pc, #20]	@ (0x2b54)
@   0x08002b40: f007        fae0 	bl	0xa104
@   0x08002b44: 0600        lsls	r0, r0, #24
@   0x08002b46: 2800        cmp	r0, #0
@   0x08002b48: d0f6        beq.n	0x2b38
@   0x08002b4a: b001        add	sp, #4
@   0x08002b4c: bc10        pop	{r4}
@   0x08002b4e: bc01        pop	{r0}
@   0x08002b50: 4700        bx	r0
@   0x08002b52: 0000        movs	r0, r0
@   0x08002b54: a26d        add	r2, pc, #436	@ (adr r2, 0x2d0c)
@   0x08002b56: 0800        lsrs	r0, r0, #32

        thumb_func_start sub_08002AE8
sub_08002AE8: @ 0x08002ae8
        .incbin "frog_us_baserom.gba", 0x2ae8, 0x70
        thumb_func_end sub_08002AE8
