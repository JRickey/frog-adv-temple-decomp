@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013ae8, 0x08013b54)  (108 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013ae8 --end 0x8013b54 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013ae8: b500        push	{lr}
@   0x08013aea: b082        sub	sp, #8
@   0x08013aec: 4903        ldr	r1, [pc, #12]	@ (0x13afc)
@   0x08013aee: 7808        ldrb	r0, [r1, #0]
@   0x08013af0: 2800        cmp	r0, #0
@   0x08013af2: d005        beq.n	0x13b00
@   0x08013af4: 2801        cmp	r0, #1
@   0x08013af6: d006        beq.n	0x13b06
@   0x08013af8: e014        b.n	0x13b24
@   0x08013afa: 0000        movs	r0, r0
@   0x08013afc: 3610        adds	r6, #16
@   0x08013afe: 0300        lsls	r0, r0, #12
@   0x08013b00: 2001        movs	r0, #1
@   0x08013b02: 7008        strb	r0, [r1, #0]
@   0x08013b04: e00e        b.n	0x13b24
@   0x08013b06: f7fa        fe65 	bl	0xe7d4
@   0x08013b0a: f7ff        f8cf 	bl	0x12cac
@   0x08013b0e: 4b0d        ldr	r3, [pc, #52]	@ (0x13b44)
@   0x08013b10: 7898        ldrb	r0, [r3, #2]
@   0x08013b12: 9000        str	r0, [sp, #0]
@   0x08013b14: 480c        ldr	r0, [pc, #48]	@ (0x13b48)
@   0x08013b16: 9001        str	r0, [sp, #4]
@   0x08013b18: 6818        ldr	r0, [r3, #0]
@   0x08013b1a: 6859        ldr	r1, [r3, #4]
@   0x08013b1c: 689a        ldr	r2, [r3, #8]
@   0x08013b1e: 68db        ldr	r3, [r3, #12]
@   0x08013b20: f000        f89e 	bl	0x13c60
@   0x08013b24: 4b09        ldr	r3, [pc, #36]	@ (0x13b4c)
@   0x08013b26: 7898        ldrb	r0, [r3, #2]
@   0x08013b28: 9000        str	r0, [sp, #0]
@   0x08013b2a: 4809        ldr	r0, [pc, #36]	@ (0x13b50)
@   0x08013b2c: 9001        str	r0, [sp, #4]
@   0x08013b2e: 6818        ldr	r0, [r3, #0]
@   0x08013b30: 6859        ldr	r1, [r3, #4]
@   0x08013b32: 689a        ldr	r2, [r3, #8]
@   0x08013b34: 68db        ldr	r3, [r3, #12]
@   0x08013b36: f000        f893 	bl	0x13c60
@   0x08013b3a: f7ff        fae7 	bl	0x1310c
@   0x08013b3e: b002        add	sp, #8
@   0x08013b40: bc01        pop	{r0}
@   0x08013b42: 4700        bx	r0
@   0x08013b44: 6f08        ldr	r0, [r1, #112]	@ 0x70
@   0x08013b46: 0830        lsrs	r0, r6, #32
@   0x08013b48: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08013b4a: 0300        lsls	r0, r0, #12
@   0x08013b4c: 6f50        ldr	r0, [r2, #116]	@ 0x74
@   0x08013b4e: 0830        lsrs	r0, r6, #32
@   0x08013b50: 6580        str	r0, [r0, #88]	@ 0x58
@   0x08013b52: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013AE8
sub_08013AE8: @ 0x08013ae8
        .incbin "frog_us_baserom.gba", 0x13ae8, 0x6c
        thumb_func_end sub_08013AE8
