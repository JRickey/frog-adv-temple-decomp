@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028a98, 0x08028b94)  (252 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028a98 --end 0x8028b94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028a98: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08028a9a: b084        sub	sp, #16
@   0x08028a9c: 4918        ldr	r1, [pc, #96]	@ (0x28b00)
@   0x08028a9e: 4e19        ldr	r6, [pc, #100]	@ (0x28b04)
@   0x08028aa0: 9600        str	r6, [sp, #0]
@   0x08028aa2: 2506        movs	r5, #6
@   0x08028aa4: 9501        str	r5, [sp, #4]
@   0x08028aa6: 2702        movs	r7, #2
@   0x08028aa8: 9702        str	r7, [sp, #8]
@   0x08028aaa: 2403        movs	r4, #3
@   0x08028aac: 9403        str	r4, [sp, #12]
@   0x08028aae: 205f        movs	r0, #95	@ 0x5f
@   0x08028ab0: 2210        movs	r2, #16
@   0x08028ab2: 2349        movs	r3, #73	@ 0x49
@   0x08028ab4: f7f8        faf4 	bl	0x210a0
@   0x08028ab8: 4913        ldr	r1, [pc, #76]	@ (0x28b08)
@   0x08028aba: 9600        str	r6, [sp, #0]
@   0x08028abc: 9501        str	r5, [sp, #4]
@   0x08028abe: 9702        str	r7, [sp, #8]
@   0x08028ac0: 9403        str	r4, [sp, #12]
@   0x08028ac2: 2060        movs	r0, #96	@ 0x60
@   0x08028ac4: 2210        movs	r2, #16
@   0x08028ac6: 2349        movs	r3, #73	@ 0x49
@   0x08028ac8: f7f8        faea 	bl	0x210a0
@   0x08028acc: 4c0f        ldr	r4, [pc, #60]	@ (0x28b0c)
@   0x08028ace: 1c20        adds	r0, r4, #0
@   0x08028ad0: 2103        movs	r1, #3
@   0x08028ad2: 2206        movs	r2, #6
@   0x08028ad4: f7dd        fe62 	bl	0x679c
@   0x08028ad8: 0600        lsls	r0, r0, #24
@   0x08028ada: 2800        cmp	r0, #0
@   0x08028adc: d01e        beq.n	0x28b1c
@   0x08028ade: 1c20        adds	r0, r4, #0
@   0x08028ae0: 2103        movs	r1, #3
@   0x08028ae2: 2205        movs	r2, #5
@   0x08028ae4: f7dd        fe5a 	bl	0x679c
@   0x08028ae8: 0600        lsls	r0, r0, #24
@   0x08028aea: 2800        cmp	r0, #0
@   0x08028aec: d016        beq.n	0x28b1c
@   0x08028aee: 4808        ldr	r0, [pc, #32]	@ (0x28b10)
@   0x08028af0: 4a08        ldr	r2, [pc, #32]	@ (0x28b14)
@   0x08028af2: 1881        adds	r1, r0, r2
@   0x08028af4: 700f        strb	r7, [r1, #0]
@   0x08028af6: 4908        ldr	r1, [pc, #32]	@ (0x28b18)
@   0x08028af8: 1840        adds	r0, r0, r1
@   0x08028afa: 2114        movs	r1, #20
@   0x08028afc: e03f        b.n	0x28b7e
@   0x08028afe: 0000        movs	r0, r0
@   0x08028b00: 6f24        ldr	r4, [r4, #112]	@ 0x70
@   0x08028b02: 0831        lsrs	r1, r6, #32
@   0x08028b04: 02f5        lsls	r5, r6, #11
@   0x08028b06: 0000        movs	r0, r0
@   0x08028b08: 6f44        ldr	r4, [r0, #116]	@ 0x74
@   0x08028b0a: 0831        lsrs	r1, r6, #32
@   0x08028b0c: 6110        str	r0, [r2, #16]
@   0x08028b0e: 0300        lsls	r0, r0, #12
@   0x08028b10: 3720        adds	r7, #32
@   0x08028b12: 0300        lsls	r0, r0, #12
@   0x08028b14: 13ca        asrs	r2, r1, #15
@   0x08028b16: 0000        movs	r0, r0
@   0x08028b18: 13da        asrs	r2, r3, #15
@   0x08028b1a: 0000        movs	r0, r0
@   0x08028b1c: 4c0a        ldr	r4, [pc, #40]	@ (0x28b48)
@   0x08028b1e: 1c20        adds	r0, r4, #0
@   0x08028b20: 2103        movs	r1, #3
@   0x08028b22: 2205        movs	r2, #5
@   0x08028b24: f7dd        fe3a 	bl	0x679c
@   0x08028b28: 0600        lsls	r0, r0, #24
@   0x08028b2a: 2800        cmp	r0, #0
@   0x08028b2c: d112        bne.n	0x28b54
@   0x08028b2e: 1c20        adds	r0, r4, #0
@   0x08028b30: 2103        movs	r1, #3
@   0x08028b32: 2206        movs	r2, #6
@   0x08028b34: f7dd        fe32 	bl	0x679c
@   0x08028b38: 0600        lsls	r0, r0, #24
@   0x08028b3a: 2800        cmp	r0, #0
@   0x08028b3c: d00a        beq.n	0x28b54
@   0x08028b3e: 4803        ldr	r0, [pc, #12]	@ (0x28b4c)
@   0x08028b40: 4a03        ldr	r2, [pc, #12]	@ (0x28b50)
@   0x08028b42: 1880        adds	r0, r0, r2
@   0x08028b44: 2101        movs	r1, #1
@   0x08028b46: e01a        b.n	0x28b7e
@   0x08028b48: 6110        str	r0, [r2, #16]
@   0x08028b4a: 0300        lsls	r0, r0, #12
@   0x08028b4c: 3720        adds	r7, #32
@   0x08028b4e: 0300        lsls	r0, r0, #12
@   0x08028b50: 13ca        asrs	r2, r1, #15
@   0x08028b52: 0000        movs	r0, r0
@   0x08028b54: 4c0c        ldr	r4, [pc, #48]	@ (0x28b88)
@   0x08028b56: 1c20        adds	r0, r4, #0
@   0x08028b58: 2103        movs	r1, #3
@   0x08028b5a: 2205        movs	r2, #5
@   0x08028b5c: f7dd        fe1e 	bl	0x679c
@   0x08028b60: 0600        lsls	r0, r0, #24
@   0x08028b62: 2800        cmp	r0, #0
@   0x08028b64: d00c        beq.n	0x28b80
@   0x08028b66: 1c20        adds	r0, r4, #0
@   0x08028b68: 2103        movs	r1, #3
@   0x08028b6a: 2206        movs	r2, #6
@   0x08028b6c: f7dd        fe16 	bl	0x679c
@   0x08028b70: 0600        lsls	r0, r0, #24
@   0x08028b72: 2800        cmp	r0, #0
@   0x08028b74: d104        bne.n	0x28b80
@   0x08028b76: 4805        ldr	r0, [pc, #20]	@ (0x28b8c)
@   0x08028b78: 4905        ldr	r1, [pc, #20]	@ (0x28b90)
@   0x08028b7a: 1840        adds	r0, r0, r1
@   0x08028b7c: 2103        movs	r1, #3
@   0x08028b7e: 7001        strb	r1, [r0, #0]
@   0x08028b80: b004        add	sp, #16
@   0x08028b82: bcf0        pop	{r4, r5, r6, r7}
@   0x08028b84: bc01        pop	{r0}
@   0x08028b86: 4700        bx	r0
@   0x08028b88: 6110        str	r0, [r2, #16]
@   0x08028b8a: 0300        lsls	r0, r0, #12
@   0x08028b8c: 3720        adds	r7, #32
@   0x08028b8e: 0300        lsls	r0, r0, #12
@   0x08028b90: 13ca        asrs	r2, r1, #15

        thumb_func_start sub_08028A98
sub_08028A98: @ 0x08028a98
        .incbin "baserom.gba", 0x28a98, 0xfc
        thumb_func_end sub_08028A98
