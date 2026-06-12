@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024dbc, 0x08024fd0)  (532 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024dbc --end 0x8024fd0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024dbc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08024dbe: 464f        mov	r7, r9
@   0x08024dc0: 4646        mov	r6, r8
@   0x08024dc2: b4c0        push	{r6, r7}
@   0x08024dc4: 2500        movs	r5, #0
@   0x08024dc6: 4e1f        ldr	r6, [pc, #124]	@ (0x24e44)
@   0x08024dc8: 481f        ldr	r0, [pc, #124]	@ (0x24e48)
@   0x08024dca: 4681        mov	r9, r0
@   0x08024dcc: 491f        ldr	r1, [pc, #124]	@ (0x24e4c)
@   0x08024dce: 1989        adds	r1, r1, r6
@   0x08024dd0: 4688        mov	r8, r1
@   0x08024dd2: 4f1f        ldr	r7, [pc, #124]	@ (0x24e50)
@   0x08024dd4: 2204        movs	r2, #4
@   0x08024dd6: 5eb0        ldrsh	r0, [r6, r2]
@   0x08024dd8: 4548        cmp	r0, r9
@   0x08024dda: dc03        bgt.n	0x24de4
@   0x08024ddc: 2302        movs	r3, #2
@   0x08024dde: 5ef0        ldrsh	r0, [r6, r3]
@   0x08024de0: 42b8        cmp	r0, r7
@   0x08024de2: dd0e        ble.n	0x24e02
@   0x08024de4: 4c1b        ldr	r4, [pc, #108]	@ (0x24e54)
@   0x08024de6: 1930        adds	r0, r6, r4
@   0x08024de8: 8800        ldrh	r0, [r0, #0]
@   0x08024dea: 491b        ldr	r1, [pc, #108]	@ (0x24e58)
@   0x08024dec: 1840        adds	r0, r0, r1
@   0x08024dee: 0400        lsls	r0, r0, #16
@   0x08024df0: 0c00        lsrs	r0, r0, #16
@   0x08024df2: 280c        cmp	r0, #12
@   0x08024df4: d805        bhi.n	0x24e02
@   0x08024df6: 4642        mov	r2, r8
@   0x08024df8: 2300        movs	r3, #0
@   0x08024dfa: 5ed0        ldrsh	r0, [r2, r3]
@   0x08024dfc: 42b8        cmp	r0, r7
@   0x08024dfe: d100        bne.n	0x24e02
@   0x08024e00: e0cc        b.n	0x24f9c
@   0x08024e02: 4916        ldr	r1, [pc, #88]	@ (0x24e5c)
@   0x08024e04: 00a8        lsls	r0, r5, #2
@   0x08024e06: 1840        adds	r0, r0, r1
@   0x08024e08: 6800        ldr	r0, [r0, #0]
@   0x08024e0a: 1c2c        adds	r4, r5, #0
@   0x08024e0c: 344e        adds	r4, #78	@ 0x4e
@   0x08024e0e: 1c21        adds	r1, r4, #0
@   0x08024e10: f7fc        fdd4 	bl	0x219bc
@   0x08024e14: 4812        ldr	r0, [pc, #72]	@ (0x24e60)
@   0x08024e16: 1c21        adds	r1, r4, #0
@   0x08024e18: f7e1        fda8 	bl	0x696c
@   0x08024e1c: 1c68        adds	r0, r5, #1
@   0x08024e1e: 0600        lsls	r0, r0, #24
@   0x08024e20: 0e05        lsrs	r5, r0, #24
@   0x08024e22: 2d0e        cmp	r5, #14
@   0x08024e24: d9d6        bls.n	0x24dd4
@   0x08024e26: 4807        ldr	r0, [pc, #28]	@ (0x24e44)
@   0x08024e28: 2402        movs	r4, #2
@   0x08024e2a: 5f02        ldrsh	r2, [r0, r4]
@   0x08024e2c: 4f0d        ldr	r7, [pc, #52]	@ (0x24e64)
@   0x08024e2e: 19c4        adds	r4, r0, r7
@   0x08024e30: 2300        movs	r3, #0
@   0x08024e32: 5ee1        ldrsh	r1, [r4, r3]
@   0x08024e34: 1a52        subs	r2, r2, r1
@   0x08024e36: 1c03        adds	r3, r0, #0
@   0x08024e38: 2a00        cmp	r2, #0
@   0x08024e3a: db15        blt.n	0x24e68
@   0x08024e3c: 885f        ldrh	r7, [r3, #2]
@   0x08024e3e: 8824        ldrh	r4, [r4, #0]
@   0x08024e40: 1b38        subs	r0, r7, r4
@   0x08024e42: e014        b.n	0x24e6e
@   0x08024e44: 3720        adds	r7, #32
@   0x08024e46: 0300        lsls	r0, r0, #12
@   0x08024e48: 024b        lsls	r3, r1, #9
@   0x08024e4a: 0000        movs	r0, r0
@   0x08024e4c: 1112        asrs	r2, r2, #4
@   0x08024e4e: 0000        movs	r0, r0
@   0x08024e50: 015b        lsls	r3, r3, #5
@   0x08024e52: 0000        movs	r0, r0
@   0x08024e54: 1114        asrs	r4, r2, #4
@   0x08024e56: 0000        movs	r0, r0
@   0x08024e58: fe3e        ffff 			@ <UNDEFINED> instruction: 0xfe3effff
@   0x08024e5c: 3f88        subs	r7, #136	@ 0x88
@   0x08024e5e: 0831        lsrs	r1, r6, #32
@   0x08024e60: 6110        str	r0, [r2, #16]
@   0x08024e62: 0300        lsls	r0, r0, #12
@   0x08024e64: 1182        asrs	r2, r0, #6
@   0x08024e66: 0000        movs	r0, r0
@   0x08024e68: 8824        ldrh	r4, [r4, #0]
@   0x08024e6a: 8859        ldrh	r1, [r3, #2]
@   0x08024e6c: 1a60        subs	r0, r4, r1
@   0x08024e6e: 0400        lsls	r0, r0, #16
@   0x08024e70: 0c00        lsrs	r0, r0, #16
@   0x08024e72: 4680        mov	r8, r0
@   0x08024e74: 2204        movs	r2, #4
@   0x08024e76: 5e98        ldrsh	r0, [r3, r2]
@   0x08024e78: 4c05        ldr	r4, [pc, #20]	@ (0x24e90)
@   0x08024e7a: 191a        adds	r2, r3, r4
@   0x08024e7c: 2700        movs	r7, #0
@   0x08024e7e: 5fd1        ldrsh	r1, [r2, r7]
@   0x08024e80: 1a40        subs	r0, r0, r1
@   0x08024e82: 2800        cmp	r0, #0
@   0x08024e84: db06        blt.n	0x24e94
@   0x08024e86: 8899        ldrh	r1, [r3, #4]
@   0x08024e88: 8812        ldrh	r2, [r2, #0]
@   0x08024e8a: 1a88        subs	r0, r1, r2
@   0x08024e8c: e005        b.n	0x24e9a
@   0x08024e8e: 0000        movs	r0, r0
@   0x08024e90: 1184        asrs	r4, r0, #6
@   0x08024e92: 0000        movs	r0, r0
@   0x08024e94: 8812        ldrh	r2, [r2, #0]
@   0x08024e96: 889c        ldrh	r4, [r3, #4]
@   0x08024e98: 1b10        subs	r0, r2, r4
@   0x08024e9a: 0400        lsls	r0, r0, #16
@   0x08024e9c: 0c00        lsrs	r0, r0, #16
@   0x08024e9e: 4681        mov	r9, r0
@   0x08024ea0: 2702        movs	r7, #2
@   0x08024ea2: 5fd8        ldrsh	r0, [r3, r7]
@   0x08024ea4: 4905        ldr	r1, [pc, #20]	@ (0x24ebc)
@   0x08024ea6: 185a        adds	r2, r3, r1
@   0x08024ea8: 2400        movs	r4, #0
@   0x08024eaa: 5f11        ldrsh	r1, [r2, r4]
@   0x08024eac: 1a40        subs	r0, r0, r1
@   0x08024eae: 2800        cmp	r0, #0
@   0x08024eb0: db06        blt.n	0x24ec0
@   0x08024eb2: 885f        ldrh	r7, [r3, #2]
@   0x08024eb4: 8812        ldrh	r2, [r2, #0]
@   0x08024eb6: 1ab8        subs	r0, r7, r2
@   0x08024eb8: e005        b.n	0x24ec6
@   0x08024eba: 0000        movs	r0, r0
@   0x08024ebc: 129a        asrs	r2, r3, #10
@   0x08024ebe: 0000        movs	r0, r0
@   0x08024ec0: 8812        ldrh	r2, [r2, #0]
@   0x08024ec2: 8859        ldrh	r1, [r3, #2]
@   0x08024ec4: 1a50        subs	r0, r2, r1
@   0x08024ec6: 0400        lsls	r0, r0, #16
@   0x08024ec8: 0c00        lsrs	r0, r0, #16
@   0x08024eca: 1c06        adds	r6, r0, #0
@   0x08024ecc: 2204        movs	r2, #4
@   0x08024ece: 5e98        ldrsh	r0, [r3, r2]
@   0x08024ed0: 4c05        ldr	r4, [pc, #20]	@ (0x24ee8)
@   0x08024ed2: 191a        adds	r2, r3, r4
@   0x08024ed4: 2700        movs	r7, #0
@   0x08024ed6: 5fd1        ldrsh	r1, [r2, r7]
@   0x08024ed8: 1a40        subs	r0, r0, r1
@   0x08024eda: 2800        cmp	r0, #0
@   0x08024edc: db06        blt.n	0x24eec
@   0x08024ede: 8899        ldrh	r1, [r3, #4]
@   0x08024ee0: 8812        ldrh	r2, [r2, #0]
@   0x08024ee2: 1a88        subs	r0, r1, r2
@   0x08024ee4: e005        b.n	0x24ef2
@   0x08024ee6: 0000        movs	r0, r0
@   0x08024ee8: 129c        asrs	r4, r3, #10
@   0x08024eea: 0000        movs	r0, r0
@   0x08024eec: 8812        ldrh	r2, [r2, #0]
@   0x08024eee: 889c        ldrh	r4, [r3, #4]
@   0x08024ef0: 1b10        subs	r0, r2, r4
@   0x08024ef2: 0400        lsls	r0, r0, #16
@   0x08024ef4: 0c00        lsrs	r0, r0, #16
@   0x08024ef6: 1c05        adds	r5, r0, #0
@   0x08024ef8: 2702        movs	r7, #2
@   0x08024efa: 5fd8        ldrsh	r0, [r3, r7]
@   0x08024efc: 4905        ldr	r1, [pc, #20]	@ (0x24f14)
@   0x08024efe: 185a        adds	r2, r3, r1
@   0x08024f00: 2400        movs	r4, #0
@   0x08024f02: 5f11        ldrsh	r1, [r2, r4]
@   0x08024f04: 1a40        subs	r0, r0, r1
@   0x08024f06: 2800        cmp	r0, #0
@   0x08024f08: db06        blt.n	0x24f18
@   0x08024f0a: 885f        ldrh	r7, [r3, #2]
@   0x08024f0c: 8812        ldrh	r2, [r2, #0]
@   0x08024f0e: 1ab8        subs	r0, r7, r2
@   0x08024f10: e005        b.n	0x24f1e
@   0x08024f12: 0000        movs	r0, r0
@   0x08024f14: 13b2        asrs	r2, r6, #14
@   0x08024f16: 0000        movs	r0, r0
@   0x08024f18: 8812        ldrh	r2, [r2, #0]
@   0x08024f1a: 8859        ldrh	r1, [r3, #2]
@   0x08024f1c: 1a50        subs	r0, r2, r1
@   0x08024f1e: 0400        lsls	r0, r0, #16
@   0x08024f20: 0c00        lsrs	r0, r0, #16
@   0x08024f22: 1c04        adds	r4, r0, #0
@   0x08024f24: 2204        movs	r2, #4
@   0x08024f26: 5e98        ldrsh	r0, [r3, r2]
@   0x08024f28: 4f05        ldr	r7, [pc, #20]	@ (0x24f40)
@   0x08024f2a: 19da        adds	r2, r3, r7
@   0x08024f2c: 2700        movs	r7, #0
@   0x08024f2e: 5fd1        ldrsh	r1, [r2, r7]
@   0x08024f30: 1a40        subs	r0, r0, r1
@   0x08024f32: 2800        cmp	r0, #0
@   0x08024f34: db06        blt.n	0x24f44
@   0x08024f36: 889b        ldrh	r3, [r3, #4]
@   0x08024f38: 8812        ldrh	r2, [r2, #0]
@   0x08024f3a: 1a98        subs	r0, r3, r2
@   0x08024f3c: e005        b.n	0x24f4a
@   0x08024f3e: 0000        movs	r0, r0
@   0x08024f40: 13b4        asrs	r4, r6, #14
@   0x08024f42: 0000        movs	r0, r0
@   0x08024f44: 8812        ldrh	r2, [r2, #0]
@   0x08024f46: 889b        ldrh	r3, [r3, #4]
@   0x08024f48: 1ad0        subs	r0, r2, r3
@   0x08024f4a: 0400        lsls	r0, r0, #16
@   0x08024f4c: 0c02        lsrs	r2, r0, #16
@   0x08024f4e: 4912        ldr	r1, [pc, #72]	@ (0x24f98)
@   0x08024f50: 2002        movs	r0, #2
@   0x08024f52: 8a09        ldrh	r1, [r1, #16]
@   0x08024f54: 4008        ands	r0, r1
@   0x08024f56: 2800        cmp	r0, #0
@   0x08024f58: d119        bne.n	0x24f8e
@   0x08024f5a: 4641        mov	r1, r8
@   0x08024f5c: 0408        lsls	r0, r1, #16
@   0x08024f5e: 1400        asrs	r0, r0, #16
@   0x08024f60: 2849        cmp	r0, #73	@ 0x49
@   0x08024f62: dc04        bgt.n	0x24f6e
@   0x08024f64: 464b        mov	r3, r9
@   0x08024f66: 0418        lsls	r0, r3, #16
@   0x08024f68: 1400        asrs	r0, r0, #16
@   0x08024f6a: 2849        cmp	r0, #73	@ 0x49
@   0x08024f6c: dd0f        ble.n	0x24f8e
@   0x08024f6e: 0430        lsls	r0, r6, #16
@   0x08024f70: 1400        asrs	r0, r0, #16
@   0x08024f72: 2849        cmp	r0, #73	@ 0x49
@   0x08024f74: dc03        bgt.n	0x24f7e
@   0x08024f76: 0428        lsls	r0, r5, #16
@   0x08024f78: 1400        asrs	r0, r0, #16
@   0x08024f7a: 2849        cmp	r0, #73	@ 0x49
@   0x08024f7c: dd07        ble.n	0x24f8e
@   0x08024f7e: 0420        lsls	r0, r4, #16
@   0x08024f80: 1400        asrs	r0, r0, #16
@   0x08024f82: 2849        cmp	r0, #73	@ 0x49
@   0x08024f84: dc12        bgt.n	0x24fac
@   0x08024f86: 0410        lsls	r0, r2, #16
@   0x08024f88: 1400        asrs	r0, r0, #16
@   0x08024f8a: 2849        cmp	r0, #73	@ 0x49
@   0x08024f8c: dc0e        bgt.n	0x24fac
@   0x08024f8e: 2006        movs	r0, #6
@   0x08024f90: f7fb        ff18 	bl	0x20dc4
@   0x08024f94: e00d        b.n	0x24fb2
@   0x08024f96: 0000        movs	r0, r0
@   0x08024f98: 35e0        adds	r5, #224	@ 0xe0
@   0x08024f9a: 0300        lsls	r0, r0, #12
@   0x08024f9c: 204e        movs	r0, #78	@ 0x4e
@   0x08024f9e: 215c        movs	r1, #92	@ 0x5c
@   0x08024fa0: f7e0        feb6 	bl	0x5d10
@   0x08024fa4: 2006        movs	r0, #6
@   0x08024fa6: f7fb        ff69 	bl	0x20e7c
@   0x08024faa: e00a        b.n	0x24fc2
@   0x08024fac: 2006        movs	r0, #6
@   0x08024fae: f7fb        ff65 	bl	0x20e7c
@   0x08024fb2: 204e        movs	r0, #78	@ 0x4e
@   0x08024fb4: 215c        movs	r1, #92	@ 0x5c
@   0x08024fb6: f7fc        f815 	bl	0x20fe4
@   0x08024fba: 204e        movs	r0, #78	@ 0x4e
@   0x08024fbc: 215c        movs	r1, #92	@ 0x5c
@   0x08024fbe: f7e0        fea7 	bl	0x5d10
@   0x08024fc2: bc18        pop	{r3, r4}
@   0x08024fc4: 4698        mov	r8, r3
@   0x08024fc6: 46a1        mov	r9, r4
@   0x08024fc8: bcf0        pop	{r4, r5, r6, r7}
@   0x08024fca: bc01        pop	{r0}
@   0x08024fcc: 4700        bx	r0

        thumb_func_start sub_08024DBC
sub_08024DBC: @ 0x08024dbc
        .incbin "baserom.gba", 0x24dbc, 0x214
        thumb_func_end sub_08024DBC
