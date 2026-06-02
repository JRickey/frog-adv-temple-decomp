@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801ad10, 0x0801ada8)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801ad10 --end 0x801ada8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801ad10: b530        push	{r4, r5, lr}
@   0x0801ad12: b081        sub	sp, #4
@   0x0801ad14: 1c04        adds	r4, r0, #0
@   0x0801ad16: 0624        lsls	r4, r4, #24
@   0x0801ad18: 0e24        lsrs	r4, r4, #24
@   0x0801ad1a: 4a1a        ldr	r2, [pc, #104]	@ (0x1ad84)
@   0x0801ad1c: 481a        ldr	r0, [pc, #104]	@ (0x1ad88)
@   0x0801ad1e: 6150        str	r0, [r2, #20]
@   0x0801ad20: 3080        adds	r0, #128	@ 0x80
@   0x0801ad22: 6250        str	r0, [r2, #36]	@ 0x24
@   0x0801ad24: 4b19        ldr	r3, [pc, #100]	@ (0x1ad8c)
@   0x0801ad26: 481a        ldr	r0, [pc, #104]	@ (0x1ad90)
@   0x0801ad28: 6801        ldr	r1, [r0, #0]
@   0x0801ad2a: 0048        lsls	r0, r1, #1
@   0x0801ad2c: 1840        adds	r0, r0, r1
@   0x0801ad2e: 00c0        lsls	r0, r0, #3
@   0x0801ad30: 18c0        adds	r0, r0, r3
@   0x0801ad32: 4918        ldr	r1, [pc, #96]	@ (0x1ad94)
@   0x0801ad34: 7b0b        ldrb	r3, [r1, #12]
@   0x0801ad36: 784d        ldrb	r5, [r1, #1]
@   0x0801ad38: 1959        adds	r1, r3, r5
@   0x0801ad3a: 6800        ldr	r0, [r0, #0]
@   0x0801ad3c: 0089        lsls	r1, r1, #2
@   0x0801ad3e: 1809        adds	r1, r1, r0
@   0x0801ad40: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x0801ad42: 60d0        str	r0, [r2, #12]
@   0x0801ad44: 2000        movs	r0, #0
@   0x0801ad46: 2100        movs	r1, #0
@   0x0801ad48: 7210        strb	r0, [r2, #8]
@   0x0801ad4a: 8591        strh	r1, [r2, #44]	@ 0x2c
@   0x0801ad4c: 8611        strh	r1, [r2, #48]	@ 0x30
@   0x0801ad4e: 8651        strh	r1, [r2, #50]	@ 0x32
@   0x0801ad50: 2008        movs	r0, #8
@   0x0801ad52: 72d0        strb	r0, [r2, #11]
@   0x0801ad54: 4668        mov	r0, sp
@   0x0801ad56: 8001        strh	r1, [r0, #0]
@   0x0801ad58: 490f        ldr	r1, [pc, #60]	@ (0x1ad98)
@   0x0801ad5a: 6008        str	r0, [r1, #0]
@   0x0801ad5c: 480f        ldr	r0, [pc, #60]	@ (0x1ad9c)
@   0x0801ad5e: 6048        str	r0, [r1, #4]
@   0x0801ad60: 480f        ldr	r0, [pc, #60]	@ (0x1ada0)
@   0x0801ad62: 6088        str	r0, [r1, #8]
@   0x0801ad64: 6888        ldr	r0, [r1, #8]
@   0x0801ad66: 1c20        adds	r0, r4, #0
@   0x0801ad68: f7ff        fe7a 	bl	0x1aa60
@   0x0801ad6c: 480d        ldr	r0, [pc, #52]	@ (0x1ada4)
@   0x0801ad6e: 3401        adds	r4, #1
@   0x0801ad70: 00a4        lsls	r4, r4, #2
@   0x0801ad72: 1824        adds	r4, r4, r0
@   0x0801ad74: 6820        ldr	r0, [r4, #0]
@   0x0801ad76: f005        ff7f 	bl	0x20c78
@   0x0801ad7a: b001        add	sp, #4
@   0x0801ad7c: bc30        pop	{r4, r5}
@   0x0801ad7e: bc01        pop	{r0}
@   0x0801ad80: 4700        bx	r0
@   0x0801ad82: 0000        movs	r0, r0
@   0x0801ad84: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801ad86: 0300        lsls	r0, r0, #12
@   0x0801ad88: f84c        0600 	str.w	r0, [ip, <undefined>]
@   0x0801ad8c: 1254        asrs	r4, r2, #9
@   0x0801ad8e: 080c        lsrs	r4, r1, #32
@   0x0801ad90: 34b0        adds	r4, #176	@ 0xb0
@   0x0801ad92: 0300        lsls	r0, r0, #12
@   0x0801ad94: 3540        adds	r5, #64	@ 0x40
@   0x0801ad96: 0300        lsls	r0, r0, #12
@   0x0801ad98: 00d4        lsls	r4, r2, #3
@   0x0801ad9a: 0400        lsls	r0, r0, #16
@   0x0801ad9c: fbc0        0600 	smlal	r0, r6, r0, r0
@   0x0801ada0: 00c0        lsls	r0, r0, #3
@   0x0801ada2: 8100        strh	r0, [r0, #8]
@   0x0801ada4: da70        bge.n	0x1ae88
@   0x0801ada6: 081b        lsrs	r3, r3, #32

        thumb_func_start sub_0801AD10
sub_0801AD10: @ 0x0801ad10
        .incbin "frog_us_baserom.gba", 0x1ad10, 0x98
        thumb_func_end sub_0801AD10
