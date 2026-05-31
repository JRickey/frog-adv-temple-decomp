@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012e64, 0x08012f00)  (156 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012e64 --end 0x8012f00 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012e64: b510        push	{r4, lr}
@   0x08012e66: b082        sub	sp, #8
@   0x08012e68: 4814        ldr	r0, [pc, #80]	@ (0x12ebc)
@   0x08012e6a: 1c03        adds	r3, r0, #0
@   0x08012e6c: 3340        adds	r3, #64	@ 0x40
@   0x08012e6e: 781a        ldrb	r2, [r3, #0]
@   0x08012e70: 2001        movs	r0, #1
@   0x08012e72: 4010        ands	r0, r2
@   0x08012e74: 2800        cmp	r0, #0
@   0x08012e76: d00d        beq.n	0x12e94
@   0x08012e78: 4911        ldr	r1, [pc, #68]	@ (0x12ec0)
@   0x08012e7a: 4c12        ldr	r4, [pc, #72]	@ (0x12ec4)
@   0x08012e7c: 1c20        adds	r0, r4, #0
@   0x08012e7e: 8008        strh	r0, [r1, #0]
@   0x08012e80: 3102        adds	r1, #2
@   0x08012e82: 4c11        ldr	r4, [pc, #68]	@ (0x12ec8)
@   0x08012e84: 1c20        adds	r0, r4, #0
@   0x08012e86: 8008        strh	r0, [r1, #0]
@   0x08012e88: 20fe        movs	r0, #254	@ 0xfe
@   0x08012e8a: 4010        ands	r0, r2
@   0x08012e8c: 7018        strb	r0, [r3, #0]
@   0x08012e8e: 2002        movs	r0, #2
@   0x08012e90: f7fc        f800 	bl	0xee94
@   0x08012e94: f7ff        ff0a 	bl	0x12cac
@   0x08012e98: 4b0c        ldr	r3, [pc, #48]	@ (0x12ecc)
@   0x08012e9a: 7898        ldrb	r0, [r3, #2]
@   0x08012e9c: 9000        str	r0, [sp, #0]
@   0x08012e9e: 480c        ldr	r0, [pc, #48]	@ (0x12ed0)
@   0x08012ea0: 9001        str	r0, [sp, #4]
@   0x08012ea2: 6818        ldr	r0, [r3, #0]
@   0x08012ea4: 6859        ldr	r1, [r3, #4]
@   0x08012ea6: 689a        ldr	r2, [r3, #8]
@   0x08012ea8: 68db        ldr	r3, [r3, #12]
@   0x08012eaa: f000        fed9 	bl	0x13c60
@   0x08012eae: f004        f8a7 	bl	0x17000
@   0x08012eb2: b002        add	sp, #8
@   0x08012eb4: bc10        pop	{r4}
@   0x08012eb6: bc01        pop	{r0}
@   0x08012eb8: 4700        bx	r0
@   0x08012eba: 0000        movs	r0, r0
@   0x08012ebc: 60a0        str	r0, [r4, #8]
@   0x08012ebe: 0300        lsls	r0, r0, #12
@   0x08012ec0: 0050        lsls	r0, r2, #1
@   0x08012ec2: 0400        lsls	r0, r0, #16
@   0x08012ec4: 1744        asrs	r4, r0, #29
@   0x08012ec6: 0000        movs	r0, r0
@   0x08012ec8: 0e02        lsrs	r2, r0, #24
@   0x08012eca: 0000        movs	r0, r0
@   0x08012ecc: 6f08        ldr	r0, [r1, #112]	@ 0x70
@   0x08012ece: 0830        lsrs	r0, r6, #32
@   0x08012ed0: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08012ed2: 0300        lsls	r0, r0, #12
@   0x08012ed4: b500        push	{lr}
@   0x08012ed6: 2003        movs	r0, #3
@   0x08012ed8: f7fb        fcc0 	bl	0xe85c
@   0x08012edc: 2002        movs	r0, #2
@   0x08012ede: f7fb        ffa9 	bl	0xee34
@   0x08012ee2: f7fb        fe1b 	bl	0xeb1c
@   0x08012ee6: f7ff        ffa1 	bl	0x12e2c
@   0x08012eea: 2003        movs	r0, #3
@   0x08012eec: f7fc        f9ae 	bl	0xf24c
@   0x08012ef0: 2003        movs	r0, #3
@   0x08012ef2: f7fb        fe73 	bl	0xebdc
@   0x08012ef6: f003        fda3 	bl	0x16a40
@   0x08012efa: bc01        pop	{r0}
@   0x08012efc: 4700        bx	r0

        thumb_func_start sub_08012E64
sub_08012E64: @ 0x08012e64
        .incbin "frog_us_baserom.gba", 0x12e64, 0x9c
        thumb_func_end sub_08012E64
