@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031ab4, 0x08031b84)  (208 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031ab4 --end 0x8031b84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031ab4: b510        push	{r4, lr}
@   0x08031ab6: 1c03        adds	r3, r0, #0
@   0x08031ab8: 1c0a        adds	r2, r1, #0
@   0x08031aba: 6814        ldr	r4, [r2, #0]
@   0x08031abc: 2b03        cmp	r3, #3
@   0x08031abe: dd09        ble.n	0x31ad4
@   0x08031ac0: 4808        ldr	r0, [pc, #32]	@ (0x31ae4)
@   0x08031ac2: 6800        ldr	r0, [r0, #0]
@   0x08031ac4: 30c8        adds	r0, #200	@ 0xc8
@   0x08031ac6: 6801        ldr	r1, [r0, #0]
@   0x08031ac8: 0198        lsls	r0, r3, #6
@   0x08031aca: 1840        adds	r0, r0, r1
@   0x08031acc: 4b06        ldr	r3, [pc, #24]	@ (0x31ae8)
@   0x08031ace: 18c1        adds	r1, r0, r3
@   0x08031ad0: 8860        ldrh	r0, [r4, #2]
@   0x08031ad2: 86c8        strh	r0, [r1, #54]	@ 0x36
@   0x08031ad4: 6810        ldr	r0, [r2, #0]
@   0x08031ad6: 3004        adds	r0, #4
@   0x08031ad8: 6010        str	r0, [r2, #0]
@   0x08031ada: 2001        movs	r0, #1
@   0x08031adc: bc10        pop	{r4}
@   0x08031ade: bc02        pop	{r1}
@   0x08031ae0: 4708        bx	r1
@   0x08031ae2: 0000        movs	r0, r0
@   0x08031ae4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031ae6: 0300        lsls	r0, r0, #12
@   0x08031ae8: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08031aec: b530        push	{r4, r5, lr}
@   0x08031aee: 1c02        adds	r2, r0, #0
@   0x08031af0: 1c0b        adds	r3, r1, #0
@   0x08031af2: 681c        ldr	r4, [r3, #0]
@   0x08031af4: 2a03        cmp	r2, #3
@   0x08031af6: dd1a        ble.n	0x31b2e
@   0x08031af8: 4808        ldr	r0, [pc, #32]	@ (0x31b1c)
@   0x08031afa: 6801        ldr	r1, [r0, #0]
@   0x08031afc: 31c8        adds	r1, #200	@ 0xc8
@   0x08031afe: 0190        lsls	r0, r2, #6
@   0x08031b00: 4a07        ldr	r2, [pc, #28]	@ (0x31b20)
@   0x08031b02: 1880        adds	r0, r0, r2
@   0x08031b04: 6809        ldr	r1, [r1, #0]
@   0x08031b06: 1809        adds	r1, r1, r0
@   0x08031b08: 1c0a        adds	r2, r1, #0
@   0x08031b0a: 3236        adds	r2, #54	@ 0x36
@   0x08031b0c: 2502        movs	r5, #2
@   0x08031b0e: 5f60        ldrsh	r0, [r4, r5]
@   0x08031b10: 8ec9        ldrh	r1, [r1, #54]	@ 0x36
@   0x08031b12: 1808        adds	r0, r1, r0
@   0x08031b14: 2800        cmp	r0, #0
@   0x08031b16: da05        bge.n	0x31b24
@   0x08031b18: 2000        movs	r0, #0
@   0x08031b1a: e007        b.n	0x31b2c
@   0x08031b1c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031b1e: 0300        lsls	r0, r0, #12
@   0x08031b20: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08031b24: 4905        ldr	r1, [pc, #20]	@ (0x31b3c)
@   0x08031b26: 4288        cmp	r0, r1
@   0x08031b28: dd00        ble.n	0x31b2c
@   0x08031b2a: 1c08        adds	r0, r1, #0
@   0x08031b2c: 8010        strh	r0, [r2, #0]
@   0x08031b2e: 6818        ldr	r0, [r3, #0]
@   0x08031b30: 3004        adds	r0, #4
@   0x08031b32: 6018        str	r0, [r3, #0]
@   0x08031b34: 2001        movs	r0, #1
@   0x08031b36: bc30        pop	{r4, r5}
@   0x08031b38: bc02        pop	{r1}
@   0x08031b3a: 4708        bx	r1
@   0x08031b3c: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x08031b40: b510        push	{r4, lr}
@   0x08031b42: 1c0c        adds	r4, r1, #0
@   0x08031b44: 6823        ldr	r3, [r4, #0]
@   0x08031b46: 7898        ldrb	r0, [r3, #2]
@   0x08031b48: 2800        cmp	r0, #0
@   0x08031b4a: d009        beq.n	0x31b60
@   0x08031b4c: 4803        ldr	r0, [pc, #12]	@ (0x31b5c)
@   0x08031b4e: 6802        ldr	r2, [r0, #0]
@   0x08031b50: 2101        movs	r1, #1
@   0x08031b52: 78db        ldrb	r3, [r3, #3]
@   0x08031b54: 4099        lsls	r1, r3
@   0x08031b56: 6890        ldr	r0, [r2, #8]
@   0x08031b58: 4308        orrs	r0, r1
@   0x08031b5a: e008        b.n	0x31b6e
@   0x08031b5c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031b5e: 0300        lsls	r0, r0, #12
@   0x08031b60: 4807        ldr	r0, [pc, #28]	@ (0x31b80)
@   0x08031b62: 6802        ldr	r2, [r0, #0]
@   0x08031b64: 2101        movs	r1, #1
@   0x08031b66: 78db        ldrb	r3, [r3, #3]
@   0x08031b68: 4099        lsls	r1, r3
@   0x08031b6a: 6890        ldr	r0, [r2, #8]
@   0x08031b6c: 4388        bics	r0, r1
@   0x08031b6e: 6090        str	r0, [r2, #8]
@   0x08031b70: 6820        ldr	r0, [r4, #0]
@   0x08031b72: 3004        adds	r0, #4
@   0x08031b74: 6020        str	r0, [r4, #0]
@   0x08031b76: 2001        movs	r0, #1
@   0x08031b78: bc10        pop	{r4}
@   0x08031b7a: bc02        pop	{r1}
@   0x08031b7c: 4708        bx	r1
@   0x08031b7e: 0000        movs	r0, r0
@   0x08031b80: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031b82: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08031AB4
sub_08031AB4: @ 0x08031ab4
        .incbin "frog_us_baserom.gba", 0x31ab4, 0xd0
        thumb_func_end sub_08031AB4
