@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020fe4, 0x080210a0)  (188 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020fe4 --end 0x80210a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020fe4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08020fe6: 4657        mov	r7, sl
@   0x08020fe8: 464e        mov	r6, r9
@   0x08020fea: 4645        mov	r5, r8
@   0x08020fec: b4e0        push	{r5, r6, r7}
@   0x08020fee: 1c04        adds	r4, r0, #0
@   0x08020ff0: 4689        mov	r9, r1
@   0x08020ff2: 4827        ldr	r0, [pc, #156]	@ (0x21090)
@   0x08020ff4: 1c21        adds	r1, r4, #0
@   0x08020ff6: 464a        mov	r2, r9
@   0x08020ff8: f7e5        fc1a 	bl	0x6830
@   0x08020ffc: 4308        orrs	r0, r1
@   0x08020ffe: 2800        cmp	r0, #0
@   0x08021000: d03e        beq.n	0x21080
@   0x08021002: 4a24        ldr	r2, [pc, #144]	@ (0x21094)
@   0x08021004: 4d24        ldr	r5, [pc, #144]	@ (0x21098)
@   0x08021006: 00e0        lsls	r0, r4, #3
@   0x08021008: 1b00        subs	r0, r0, r4
@   0x0802100a: 00c3        lsls	r3, r0, #3
@   0x0802100c: 1c28        adds	r0, r5, #0
@   0x0802100e: 302c        adds	r0, #44	@ 0x2c
@   0x08021010: 1818        adds	r0, r3, r0
@   0x08021012: 6811        ldr	r1, [r2, #0]
@   0x08021014: 6800        ldr	r0, [r0, #0]
@   0x08021016: 1a09        subs	r1, r1, r0
@   0x08021018: 1958        adds	r0, r3, r5
@   0x0802101a: 3032        adds	r0, #50	@ 0x32
@   0x0802101c: 4690        mov	r8, r2
@   0x0802101e: 7800        ldrb	r0, [r0, #0]
@   0x08021020: 4281        cmp	r1, r0
@   0x08021022: d32d        bcc.n	0x21080
@   0x08021024: 454c        cmp	r4, r9
@   0x08021026: dc2b        bgt.n	0x21080
@   0x08021028: 1c2e        adds	r6, r5, #0
@   0x0802102a: 481c        ldr	r0, [pc, #112]	@ (0x2109c)
@   0x0802102c: 4684        mov	ip, r0
@   0x0802102e: 1c18        adds	r0, r3, #0
@   0x08021030: 302c        adds	r0, #44	@ 0x2c
@   0x08021032: 1982        adds	r2, r0, r6
@   0x08021034: 1c98        adds	r0, r3, #2
@   0x08021036: 1983        adds	r3, r0, r6
@   0x08021038: 7951        ldrb	r1, [r2, #5]
@   0x0802103a: 2504        movs	r5, #4
@   0x0802103c: 5755        ldrsb	r5, [r2, r5]
@   0x0802103e: 46aa        mov	sl, r5
@   0x08021040: 8818        ldrh	r0, [r3, #0]
@   0x08021042: 4450        add	r0, sl
@   0x08021044: 8018        strh	r0, [r3, #0]
@   0x08021046: 0609        lsls	r1, r1, #24
@   0x08021048: 1609        asrs	r1, r1, #24
@   0x0802104a: 885f        ldrh	r7, [r3, #2]
@   0x0802104c: 1878        adds	r0, r7, r1
@   0x0802104e: 8058        strh	r0, [r3, #2]
@   0x08021050: 2002        movs	r0, #2
@   0x08021052: 4665        mov	r5, ip
@   0x08021054: 8a2d        ldrh	r5, [r5, #16]
@   0x08021056: 4028        ands	r0, r5
@   0x08021058: 2800        cmp	r0, #0
@   0x0802105a: d009        beq.n	0x21070
@   0x0802105c: 4667        mov	r7, ip
@   0x0802105e: 7b7f        ldrb	r7, [r7, #13]
@   0x08021060: 42bc        cmp	r4, r7
@   0x08021062: d105        bne.n	0x21070
@   0x08021064: 8870        ldrh	r0, [r6, #2]
@   0x08021066: 4450        add	r0, sl
@   0x08021068: 8070        strh	r0, [r6, #2]
@   0x0802106a: 88b5        ldrh	r5, [r6, #4]
@   0x0802106c: 1868        adds	r0, r5, r1
@   0x0802106e: 80b0        strh	r0, [r6, #4]
@   0x08021070: 4647        mov	r7, r8
@   0x08021072: 6838        ldr	r0, [r7, #0]
@   0x08021074: 6010        str	r0, [r2, #0]
@   0x08021076: 3238        adds	r2, #56	@ 0x38
@   0x08021078: 3338        adds	r3, #56	@ 0x38
@   0x0802107a: 3401        adds	r4, #1
@   0x0802107c: 454c        cmp	r4, r9
@   0x0802107e: dddb        ble.n	0x21038
@   0x08021080: bc38        pop	{r3, r4, r5}
@   0x08021082: 4698        mov	r8, r3
@   0x08021084: 46a1        mov	r9, r4
@   0x08021086: 46aa        mov	sl, r5
@   0x08021088: bcf0        pop	{r4, r5, r6, r7}
@   0x0802108a: bc01        pop	{r0}
@   0x0802108c: 4700        bx	r0
@   0x0802108e: 0000        movs	r0, r0
@   0x08021090: 6110        str	r0, [r2, #16]
@   0x08021092: 0300        lsls	r0, r0, #12
@   0x08021094: 5330        strh	r0, [r6, r4]
@   0x08021096: 0300        lsls	r0, r0, #12
@   0x08021098: 3720        adds	r7, #32
@   0x0802109a: 0300        lsls	r0, r0, #12
@   0x0802109c: 35e0        adds	r5, #224	@ 0xe0
@   0x0802109e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020FE4
sub_08020FE4: @ 0x08020fe4
        .incbin "frog_us_baserom.gba", 0x20fe4, 0xbc
        thumb_func_end sub_08020FE4
