@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019ef0, 0x08019fd8)  (232 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019ef0 --end 0x8019fd8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019ef0: b510        push	{r4, lr}
@   0x08019ef2: b081        sub	sp, #4
@   0x08019ef4: 4669        mov	r1, sp
@   0x08019ef6: 2000        movs	r0, #0
@   0x08019ef8: 8008        strh	r0, [r1, #0]
@   0x08019efa: 4a13        ldr	r2, [pc, #76]	@ (0x19f48)
@   0x08019efc: 6011        str	r1, [r2, #0]
@   0x08019efe: 4c13        ldr	r4, [pc, #76]	@ (0x19f4c)
@   0x08019f00: 6054        str	r4, [r2, #4]
@   0x08019f02: 4813        ldr	r0, [pc, #76]	@ (0x19f50)
@   0x08019f04: 6090        str	r0, [r2, #8]
@   0x08019f06: 6890        ldr	r0, [r2, #8]
@   0x08019f08: 4b12        ldr	r3, [pc, #72]	@ (0x19f54)
@   0x08019f0a: 4813        ldr	r0, [pc, #76]	@ (0x19f58)
@   0x08019f0c: 6800        ldr	r0, [r0, #0]
@   0x08019f0e: 0041        lsls	r1, r0, #1
@   0x08019f10: 1809        adds	r1, r1, r0
@   0x08019f12: 00c9        lsls	r1, r1, #3
@   0x08019f14: 1c18        adds	r0, r3, #0
@   0x08019f16: 3008        adds	r0, #8
@   0x08019f18: 1808        adds	r0, r1, r0
@   0x08019f1a: 6800        ldr	r0, [r0, #0]
@   0x08019f1c: 6010        str	r0, [r2, #0]
@   0x08019f1e: 480f        ldr	r0, [pc, #60]	@ (0x19f5c)
@   0x08019f20: 6050        str	r0, [r2, #4]
@   0x08019f22: 480f        ldr	r0, [pc, #60]	@ (0x19f60)
@   0x08019f24: 6090        str	r0, [r2, #8]
@   0x08019f26: 6890        ldr	r0, [r2, #8]
@   0x08019f28: 3304        adds	r3, #4
@   0x08019f2a: 18c9        adds	r1, r1, r3
@   0x08019f2c: 6808        ldr	r0, [r1, #0]
@   0x08019f2e: 6010        str	r0, [r2, #0]
@   0x08019f30: 6054        str	r4, [r2, #4]
@   0x08019f32: 480c        ldr	r0, [pc, #48]	@ (0x19f64)
@   0x08019f34: 6090        str	r0, [r2, #8]
@   0x08019f36: 6890        ldr	r0, [r2, #8]
@   0x08019f38: 490b        ldr	r1, [pc, #44]	@ (0x19f68)
@   0x08019f3a: 4a0c        ldr	r2, [pc, #48]	@ (0x19f6c)
@   0x08019f3c: 1c10        adds	r0, r2, #0
@   0x08019f3e: 8008        strh	r0, [r1, #0]
@   0x08019f40: b001        add	sp, #4
@   0x08019f42: bc10        pop	{r4}
@   0x08019f44: bc01        pop	{r0}
@   0x08019f46: 4700        bx	r0
@   0x08019f48: 00d4        lsls	r4, r2, #3
@   0x08019f4a: 0400        lsls	r0, r0, #16
@   0x08019f4c: 8000        strh	r0, [r0, #0]
@   0x08019f4e: 0600        lsls	r0, r0, #24
@   0x08019f50: 0400        lsls	r0, r0, #16
@   0x08019f52: 8100        strh	r0, [r0, #8]
@   0x08019f54: 1254        asrs	r4, r2, #9
@   0x08019f56: 080c        lsrs	r4, r1, #32
@   0x08019f58: 34b0        adds	r4, #176	@ 0xb0
@   0x08019f5a: 0300        lsls	r0, r0, #12
@   0x08019f5c: 01a0        lsls	r0, r4, #6
@   0x08019f5e: 0500        lsls	r0, r0, #20
@   0x08019f60: 0030        movs	r0, r6
@   0x08019f62: 8000        strh	r0, [r0, #0]
@   0x08019f64: 2000        movs	r0, #0
@   0x08019f66: 8000        strh	r0, [r0, #0]
@   0x08019f68: 000e        movs	r6, r1
@   0x08019f6a: 0400        lsls	r0, r0, #16
@   0x08019f6c: 1f08        subs	r0, r1, #4
@   0x08019f6e: 0000        movs	r0, r0
@   0x08019f70: b530        push	{r4, r5, lr}
@   0x08019f72: 0600        lsls	r0, r0, #24
@   0x08019f74: 0e00        lsrs	r0, r0, #24
@   0x08019f76: 1c01        adds	r1, r0, #0
@   0x08019f78: 2801        cmp	r0, #1
@   0x08019f7a: d00d        beq.n	0x19f98
@   0x08019f7c: 2801        cmp	r0, #1
@   0x08019f7e: dc02        bgt.n	0x19f86
@   0x08019f80: 2800        cmp	r0, #0
@   0x08019f82: d005        beq.n	0x19f90
@   0x08019f84: e011        b.n	0x19faa
@   0x08019f86: 2902        cmp	r1, #2
@   0x08019f88: d00a        beq.n	0x19fa0
@   0x08019f8a: 2903        cmp	r1, #3
@   0x08019f8c: d00c        beq.n	0x19fa8
@   0x08019f8e: e00c        b.n	0x19faa
@   0x08019f90: 4a00        ldr	r2, [pc, #0]	@ (0x19f94)
@   0x08019f92: e00a        b.n	0x19faa
@   0x08019f94: e000        b.n	0x19f98
@   0x08019f96: 0600        lsls	r0, r0, #24
@   0x08019f98: 4a00        ldr	r2, [pc, #0]	@ (0x19f9c)
@   0x08019f9a: e006        b.n	0x19faa
@   0x08019f9c: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08019fa0: 4a00        ldr	r2, [pc, #0]	@ (0x19fa4)
@   0x08019fa2: e002        b.n	0x19faa
@   0x08019fa4: f000        0600 	and.w	r6, r0, #0
@   0x08019fa8: 4a08        ldr	r2, [pc, #32]	@ (0x19fcc)
@   0x08019faa: 2100        movs	r1, #0
@   0x08019fac: 4c08        ldr	r4, [pc, #32]	@ (0x19fd0)
@   0x08019fae: 4b09        ldr	r3, [pc, #36]	@ (0x19fd4)
@   0x08019fb0: 7e65        ldrb	r5, [r4, #25]
@   0x08019fb2: 0328        lsls	r0, r5, #12
@   0x08019fb4: 1808        adds	r0, r1, r0
@   0x08019fb6: 8010        strh	r0, [r2, #0]
@   0x08019fb8: 3202        adds	r2, #2
@   0x08019fba: 1c48        adds	r0, r1, #1
@   0x08019fbc: 0400        lsls	r0, r0, #16
@   0x08019fbe: 0c01        lsrs	r1, r0, #16
@   0x08019fc0: 4299        cmp	r1, r3
@   0x08019fc2: d9f5        bls.n	0x19fb0
@   0x08019fc4: bc30        pop	{r4, r5}
@   0x08019fc6: bc01        pop	{r0}
@   0x08019fc8: 4700        bx	r0
@   0x08019fca: 0000        movs	r0, r0
@   0x08019fcc: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08019fd0: 6420        str	r0, [r4, #64]	@ 0x40
@   0x08019fd2: 0300        lsls	r0, r0, #12
@   0x08019fd4: 03ff        lsls	r7, r7, #15

        thumb_func_start sub_08019EF0
sub_08019EF0: @ 0x08019ef0
        .incbin "frog_us_baserom.gba", 0x19ef0, 0xe8
        thumb_func_end sub_08019EF0
