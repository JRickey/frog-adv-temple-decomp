@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031d2c, 0x08031dbc)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031d2c --end 0x8031dbc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031d2c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08031d2e: 1c02        adds	r2, r0, #0
@   0x08031d30: 1c0f        adds	r7, r1, #0
@   0x08031d32: 683c        ldr	r4, [r7, #0]
@   0x08031d34: 2a03        cmp	r2, #3
@   0x08031d36: dd3a        ble.n	0x31dae
@   0x08031d38: 4815        ldr	r0, [pc, #84]	@ (0x31d90)
@   0x08031d3a: 6803        ldr	r3, [r0, #0]
@   0x08031d3c: 1c18        adds	r0, r3, #0
@   0x08031d3e: 30c8        adds	r0, #200	@ 0xc8
@   0x08031d40: 6801        ldr	r1, [r0, #0]
@   0x08031d42: 0190        lsls	r0, r2, #6
@   0x08031d44: 1840        adds	r0, r0, r1
@   0x08031d46: 4913        ldr	r1, [pc, #76]	@ (0x31d94)
@   0x08031d48: 1840        adds	r0, r0, r1
@   0x08031d4a: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x08031d4c: 2180        movs	r1, #128	@ 0x80
@   0x08031d4e: 0149        lsls	r1, r1, #5
@   0x08031d50: 4008        ands	r0, r1
@   0x08031d52: 2800        cmp	r0, #0
@   0x08031d54: d02b        beq.n	0x31dae
@   0x08031d56: 88a0        ldrh	r0, [r4, #4]
@   0x08031d58: 0405        lsls	r5, r0, #16
@   0x08031d5a: 8864        ldrh	r4, [r4, #2]
@   0x08031d5c: 4325        orrs	r5, r4
@   0x08031d5e: 1c19        adds	r1, r3, #0
@   0x08031d60: 31c0        adds	r1, #192	@ 0xc0
@   0x08031d62: 00d0        lsls	r0, r2, #3
@   0x08031d64: 1a80        subs	r0, r0, r2
@   0x08031d66: 0080        lsls	r0, r0, #2
@   0x08031d68: 3870        subs	r0, #112	@ 0x70
@   0x08031d6a: 6809        ldr	r1, [r1, #0]
@   0x08031d6c: 180c        adds	r4, r1, r0
@   0x08031d6e: 6821        ldr	r1, [r4, #0]
@   0x08031d70: 6808        ldr	r0, [r1, #0]
@   0x08031d72: 3010        adds	r0, #16
@   0x08031d74: 180e        adds	r6, r1, r0
@   0x08031d76: f7fc        fb4f 	bl	0x2e418
@   0x08031d7a: 68e1        ldr	r1, [r4, #12]
@   0x08031d7c: 2900        cmp	r1, #0
@   0x08031d7e: d10b        bne.n	0x31d98
@   0x08031d80: 6860        ldr	r0, [r4, #4]
@   0x08031d82: 1941        adds	r1, r0, r5
@   0x08031d84: 42b1        cmp	r1, r6
@   0x08031d86: d900        bls.n	0x31d8a
@   0x08031d88: 1a35        subs	r5, r6, r0
@   0x08031d8a: 1c01        adds	r1, r0, #0
@   0x08031d8c: e009        b.n	0x31da2
@   0x08031d8e: 0000        movs	r0, r0
@   0x08031d90: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031d92: 0300        lsls	r0, r0, #12
@   0x08031d94: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08031d98: 1948        adds	r0, r1, r5
@   0x08031d9a: 42b0        cmp	r0, r6
@   0x08031d9c: d900        bls.n	0x31da0
@   0x08031d9e: 1a75        subs	r5, r6, r1
@   0x08031da0: 6860        ldr	r0, [r4, #4]
@   0x08031da2: 1940        adds	r0, r0, r5
@   0x08031da4: 60a0        str	r0, [r4, #8]
@   0x08031da6: 6125        str	r5, [r4, #16]
@   0x08031da8: 60e1        str	r1, [r4, #12]
@   0x08031daa: f7fc        fb25 	bl	0x2e3f8
@   0x08031dae: 6838        ldr	r0, [r7, #0]
@   0x08031db0: 3006        adds	r0, #6
@   0x08031db2: 6038        str	r0, [r7, #0]
@   0x08031db4: 2001        movs	r0, #1
@   0x08031db6: bcf0        pop	{r4, r5, r6, r7}
@   0x08031db8: bc02        pop	{r1}
@   0x08031dba: 4708        bx	r1

        thumb_func_start sub_08031D2C
sub_08031D2C: @ 0x08031d2c
        .incbin "frog_us_baserom.gba", 0x31d2c, 0x90
        thumb_func_end sub_08031D2C
