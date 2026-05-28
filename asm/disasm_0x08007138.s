@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08007138, 0x08007228)  (240 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8007138 --end 0x8007228 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08007138: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800713a: 4657        mov	r7, sl
@   0x0800713c: 464e        mov	r6, r9
@   0x0800713e: 4645        mov	r5, r8
@   0x08007140: b4e0        push	{r5, r6, r7}
@   0x08007142: b084        sub	sp, #16
@   0x08007144: 9001        str	r0, [sp, #4]
@   0x08007146: 0609        lsls	r1, r1, #24
@   0x08007148: 0e0b        lsrs	r3, r1, #24
@   0x0800714a: 2000        movs	r0, #0
@   0x0800714c: 9002        str	r0, [sp, #8]
@   0x0800714e: 4904        ldr	r1, [pc, #16]	@ (0x7160)
@   0x08007150: 2004        movs	r0, #4
@   0x08007152: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08007154: 4008        ands	r0, r1
@   0x08007156: 2800        cmp	r0, #0
@   0x08007158: d004        beq.n	0x7164
@   0x0800715a: 2000        movs	r0, #0
@   0x0800715c: e055        b.n	0x720a
@   0x0800715e: 0000        movs	r0, r0
@   0x08007160: 3720        adds	r7, #32
@   0x08007162: 0300        lsls	r0, r0, #12
@   0x08007164: 2200        movs	r2, #0
@   0x08007166: 0618        lsls	r0, r3, #24
@   0x08007168: 1601        asrs	r1, r0, #24
@   0x0800716a: 9003        str	r0, [sp, #12]
@   0x0800716c: 9e02        ldr	r6, [sp, #8]
@   0x0800716e: 428e        cmp	r6, r1
@   0x08007170: da4a        bge.n	0x7208
@   0x08007172: 482a        ldr	r0, [pc, #168]	@ (0x721c)
@   0x08007174: 4682        mov	sl, r0
@   0x08007176: 492a        ldr	r1, [pc, #168]	@ (0x7220)
@   0x08007178: 4689        mov	r9, r1
@   0x0800717a: 0612        lsls	r2, r2, #24
@   0x0800717c: 1611        asrs	r1, r2, #24
@   0x0800717e: 00c8        lsls	r0, r1, #3
@   0x08007180: 1840        adds	r0, r0, r1
@   0x08007182: 0080        lsls	r0, r0, #2
@   0x08007184: 9901        ldr	r1, [sp, #4]
@   0x08007186: 1846        adds	r6, r0, r1
@   0x08007188: 2005        movs	r0, #5
@   0x0800718a: 7eb1        ldrb	r1, [r6, #26]
@   0x0800718c: 4008        ands	r0, r1
@   0x0800718e: 4690        mov	r8, r2
@   0x08007190: 2804        cmp	r0, #4
@   0x08007192: d132        bne.n	0x71fa
@   0x08007194: 4f23        ldr	r7, [pc, #140]	@ (0x7224)
@   0x08007196: 79ba        ldrb	r2, [r7, #6]
@   0x08007198: 7a30        ldrb	r0, [r6, #8]
@   0x0800719a: 4282        cmp	r2, r0
@   0x0800719c: d12d        bne.n	0x71fa
@   0x0800719e: 2100        movs	r1, #0
@   0x080071a0: 468c        mov	ip, r1
@   0x080071a2: 2f00        cmp	r7, #0
@   0x080071a4: d029        beq.n	0x71fa
@   0x080071a6: 2e00        cmp	r6, #0
@   0x080071a8: d027        beq.n	0x71fa
@   0x080071aa: 88f2        ldrh	r2, [r6, #6]
@   0x080071ac: 0413        lsls	r3, r2, #16
@   0x080071ae: 0c58        lsrs	r0, r3, #17
@   0x080071b0: 8871        ldrh	r1, [r6, #2]
@   0x080071b2: 1a08        subs	r0, r1, r0
@   0x080071b4: 0400        lsls	r0, r0, #16
@   0x080071b6: 0c00        lsrs	r0, r0, #16
@   0x080071b8: 4651        mov	r1, sl
@   0x080071ba: 4021        ands	r1, r4
@   0x080071bc: 4301        orrs	r1, r0
@   0x080071be: 88b2        ldrh	r2, [r6, #4]
@   0x080071c0: 0410        lsls	r0, r2, #16
@   0x080071c2: 0c02        lsrs	r2, r0, #16
@   0x080071c4: 0c40        lsrs	r0, r0, #17
@   0x080071c6: 8836        ldrh	r6, [r6, #0]
@   0x080071c8: 1a30        subs	r0, r6, r0
@   0x080071ca: 3801        subs	r0, #1
@   0x080071cc: 0400        lsls	r0, r0, #16
@   0x080071ce: 464e        mov	r6, r9
@   0x080071d0: 4031        ands	r1, r6
@   0x080071d2: 1c0c        adds	r4, r1, #0
@   0x080071d4: 4304        orrs	r4, r0
@   0x080071d6: 4650        mov	r0, sl
@   0x080071d8: 4028        ands	r0, r5
@   0x080071da: 4310        orrs	r0, r2
@   0x080071dc: 4030        ands	r0, r6
@   0x080071de: 1c05        adds	r5, r0, #0
@   0x080071e0: 431d        orrs	r5, r3
@   0x080071e2: 4660        mov	r0, ip
@   0x080071e4: 9000        str	r0, [sp, #0]
@   0x080071e6: 1c38        adds	r0, r7, #0
@   0x080071e8: 1c2a        adds	r2, r5, #0
@   0x080071ea: 1c21        adds	r1, r4, #0
@   0x080071ec: 2300        movs	r3, #0
@   0x080071ee: f005        fe6f 	bl	0xced0
@   0x080071f2: 2800        cmp	r0, #0
@   0x080071f4: d001        beq.n	0x71fa
@   0x080071f6: 2101        movs	r1, #1
@   0x080071f8: 9102        str	r1, [sp, #8]
@   0x080071fa: 2080        movs	r0, #128	@ 0x80
@   0x080071fc: 0440        lsls	r0, r0, #17
@   0x080071fe: 4440        add	r0, r8
@   0x08007200: 0e02        lsrs	r2, r0, #24
@   0x08007202: 9e03        ldr	r6, [sp, #12]
@   0x08007204: 42b0        cmp	r0, r6
@   0x08007206: dbb8        blt.n	0x717a
@   0x08007208: 9802        ldr	r0, [sp, #8]
@   0x0800720a: b004        add	sp, #16
@   0x0800720c: bc38        pop	{r3, r4, r5}
@   0x0800720e: 4698        mov	r8, r3
@   0x08007210: 46a1        mov	r9, r4
@   0x08007212: 46aa        mov	sl, r5
@   0x08007214: bcf0        pop	{r4, r5, r6, r7}
@   0x08007216: bc02        pop	{r1}
@   0x08007218: 4708        bx	r1
@   0x0800721a: 0000        movs	r0, r0
@   0x0800721c: 0000        movs	r0, r0
@   0x0800721e: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x08007222: 0000        movs	r0, r0
@   0x08007224: 3720        adds	r7, #32
@   0x08007226: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08007138
sub_08007138: @ 0x08007138
        .incbin "frog_us_baserom.gba", 0x7138, 0xf0
        thumb_func_end sub_08007138
