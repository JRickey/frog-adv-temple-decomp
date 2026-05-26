@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009cbc, 0x08009d9c)  (224 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009cbc --end 0x8009d9c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009cbc: b530        push	{r4, r5, lr}
@   0x08009cbe: 4c2f        ldr	r4, [pc, #188]	@ (0x9d7c)
@   0x08009cc0: 7aa0        ldrb	r0, [r4, #10]
@   0x08009cc2: 2103        movs	r1, #3
@   0x08009cc4: f02a        f94a 	bl	0x33f5c
@   0x08009cc8: 0600        lsls	r0, r0, #24
@   0x08009cca: 2800        cmp	r0, #0
@   0x08009ccc: d012        beq.n	0x9cf4
@   0x08009cce: 7aa0        ldrb	r0, [r4, #10]
@   0x08009cd0: 2810        cmp	r0, #16
@   0x08009cd2: d00f        beq.n	0x9cf4
@   0x08009cd4: 2500        movs	r5, #0
@   0x08009cd6: f016        ff69 	bl	0x20bac
@   0x08009cda: 4829        ldr	r0, [pc, #164]	@ (0x9d80)
@   0x08009cdc: 3032        adds	r0, #50	@ 0x32
@   0x08009cde: 7800        ldrb	r0, [r0, #0]
@   0x08009ce0: 2801        cmp	r0, #1
@   0x08009ce2: d104        bne.n	0x9cee
@   0x08009ce4: 4927        ldr	r1, [pc, #156]	@ (0x9d84)
@   0x08009ce6: 7aa4        ldrb	r4, [r4, #10]
@   0x08009ce8: 00a0        lsls	r0, r4, #2
@   0x08009cea: 1840        adds	r0, r0, r1
@   0x08009cec: 6805        ldr	r5, [r0, #0]
@   0x08009cee: 1c28        adds	r0, r5, #0
@   0x08009cf0: f016        ff4a 	bl	0x20b88
@   0x08009cf4: f000        f9b2 	bl	0xa05c
@   0x08009cf8: 4923        ldr	r1, [pc, #140]	@ (0x9d88)
@   0x08009cfa: 2000        movs	r0, #0
@   0x08009cfc: 5608        ldrsb	r0, [r1, r0]
@   0x08009cfe: 2202        movs	r2, #2
@   0x08009d00: 5e89        ldrsh	r1, [r1, r2]
@   0x08009d02: 2200        movs	r2, #0
@   0x08009d04: f7fd        fd52 	bl	0x77ac
@   0x08009d08: 4d20        ldr	r5, [pc, #128]	@ (0x9d8c)
@   0x08009d0a: 4c1c        ldr	r4, [pc, #112]	@ (0x9d7c)
@   0x08009d0c: 7aa1        ldrb	r1, [r4, #10]
@   0x08009d0e: 0088        lsls	r0, r1, #2
@   0x08009d10: 1940        adds	r0, r0, r5
@   0x08009d12: 6800        ldr	r0, [r0, #0]
@   0x08009d14: f029        ffe0 	bl	0x33cd8
@   0x08009d18: 481d        ldr	r0, [pc, #116]	@ (0x9d90)
@   0x08009d1a: 7aa2        ldrb	r2, [r4, #10]
@   0x08009d1c: 1810        adds	r0, r2, r0
@   0x08009d1e: 7800        ldrb	r0, [r0, #0]
@   0x08009d20: f005        fa94 	bl	0xf24c
@   0x08009d24: 491b        ldr	r1, [pc, #108]	@ (0x9d94)
@   0x08009d26: 7aa2        ldrb	r2, [r4, #10]
@   0x08009d28: 0090        lsls	r0, r2, #2
@   0x08009d2a: 1840        adds	r0, r0, r1
@   0x08009d2c: 6800        ldr	r0, [r0, #0]
@   0x08009d2e: f029        ffd3 	bl	0x33cd8
@   0x08009d32: 7aa1        ldrb	r1, [r4, #10]
@   0x08009d34: 0088        lsls	r0, r1, #2
@   0x08009d36: 1940        adds	r0, r0, r5
@   0x08009d38: 6800        ldr	r0, [r0, #0]
@   0x08009d3a: f029        ffcd 	bl	0x33cd8
@   0x08009d3e: 4a10        ldr	r2, [pc, #64]	@ (0x9d80)
@   0x08009d40: 2001        movs	r0, #1
@   0x08009d42: 4240        negs	r0, r0
@   0x08009d44: 17c1        asrs	r1, r0, #31
@   0x08009d46: 6150        str	r0, [r2, #20]
@   0x08009d48: 6191        str	r1, [r2, #24]
@   0x08009d4a: 61d0        str	r0, [r2, #28]
@   0x08009d4c: 6211        str	r1, [r2, #32]
@   0x08009d4e: f000        fbe7 	bl	0xa520
@   0x08009d52: 4911        ldr	r1, [pc, #68]	@ (0x9d98)
@   0x08009d54: 7aa2        ldrb	r2, [r4, #10]
@   0x08009d56: 0090        lsls	r0, r2, #2
@   0x08009d58: 1840        adds	r0, r0, r1
@   0x08009d5a: 6800        ldr	r0, [r0, #0]
@   0x08009d5c: f029        ffbc 	bl	0x33cd8
@   0x08009d60: f7ff        fe7a 	bl	0x9a58
@   0x08009d64: f7ff        fa10 	bl	0x9188
@   0x08009d68: f7f6        fdb8 	bl	0x8dc
@   0x08009d6c: f000        fadc 	bl	0xa328
@   0x08009d70: 2000        movs	r0, #0
@   0x08009d72: 6160        str	r0, [r4, #20]
@   0x08009d74: bc30        pop	{r4, r5}
@   0x08009d76: bc01        pop	{r0}
@   0x08009d78: 4700        bx	r0
@   0x08009d7a: 0000        movs	r0, r0
@   0x08009d7c: 5330        strh	r0, [r6, r4]
@   0x08009d7e: 0300        lsls	r0, r0, #12
@   0x08009d80: 6110        str	r0, [r2, #16]
@   0x08009d82: 0300        lsls	r0, r0, #12
@   0x08009d84: 0d98        lsrs	r0, r3, #22
@   0x08009d86: 080c        lsrs	r4, r1, #32
@   0x08009d88: 35e0        adds	r5, #224	@ 0xe0
@   0x08009d8a: 0300        lsls	r0, r0, #12
@   0x08009d8c: 0cfc        lsrs	r4, r7, #19
@   0x08009d8e: 080c        lsrs	r4, r1, #32
@   0x08009d90: 0d84        lsrs	r4, r0, #22
@   0x08009d92: 080c        lsrs	r4, r1, #32
@   0x08009d94: 0c74        lsrs	r4, r6, #17
@   0x08009d96: 080c        lsrs	r4, r1, #32
@   0x08009d98: 0cb8        lsrs	r0, r7, #18
@   0x08009d9a: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_08009CBC
sub_08009CBC: @ 0x08009cbc
        .incbin "frog_us_baserom.gba", 0x9cbc, 0xe0
        thumb_func_end sub_08009CBC
