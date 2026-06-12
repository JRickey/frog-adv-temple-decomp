@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802651c, 0x080265d4)  (184 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802651c --end 0x80265d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802651c: b500        push	{lr}
@   0x0802651e: b084        sub	sp, #16
@   0x08026520: 4808        ldr	r0, [pc, #32]	@ (0x26544)
@   0x08026522: 2205        movs	r2, #5
@   0x08026524: 5682        ldrsb	r2, [r0, r2]
@   0x08026526: 2a03        cmp	r2, #3
@   0x08026528: d110        bne.n	0x2654c
@   0x0802652a: 4907        ldr	r1, [pc, #28]	@ (0x26548)
@   0x0802652c: 20e1        movs	r0, #225	@ 0xe1
@   0x0802652e: 9000        str	r0, [sp, #0]
@   0x08026530: 200a        movs	r0, #10
@   0x08026532: 9001        str	r0, [sp, #4]
@   0x08026534: 9202        str	r2, [sp, #8]
@   0x08026536: 2002        movs	r0, #2
@   0x08026538: 9003        str	r0, [sp, #12]
@   0x0802653a: 2200        movs	r2, #0
@   0x0802653c: 2334        movs	r3, #52	@ 0x34
@   0x0802653e: f7fa        fdaf 	bl	0x210a0
@   0x08026542: e010        b.n	0x26566
@   0x08026544: 35e0        adds	r5, #224	@ 0xe0
@   0x08026546: 0300        lsls	r0, r0, #12
@   0x08026548: 4b80        ldr	r3, [pc, #512]	@ (0x2674c)
@   0x0802654a: 0831        lsrs	r1, r6, #32
@   0x0802654c: 490f        ldr	r1, [pc, #60]	@ (0x2658c)
@   0x0802654e: 20e1        movs	r0, #225	@ 0xe1
@   0x08026550: 9000        str	r0, [sp, #0]
@   0x08026552: 200a        movs	r0, #10
@   0x08026554: 9001        str	r0, [sp, #4]
@   0x08026556: 2003        movs	r0, #3
@   0x08026558: 9002        str	r0, [sp, #8]
@   0x0802655a: 2002        movs	r0, #2
@   0x0802655c: 9003        str	r0, [sp, #12]
@   0x0802655e: 2200        movs	r2, #0
@   0x08026560: 2334        movs	r3, #52	@ 0x34
@   0x08026562: f7fa        fd9d 	bl	0x210a0
@   0x08026566: 480a        ldr	r0, [pc, #40]	@ (0x26590)
@   0x08026568: 7940        ldrb	r0, [r0, #5]
@   0x0802656a: 2804        cmp	r0, #4
@   0x0802656c: d114        bne.n	0x26598
@   0x0802656e: 4909        ldr	r1, [pc, #36]	@ (0x26594)
@   0x08026570: 20f1        movs	r0, #241	@ 0xf1
@   0x08026572: 9000        str	r0, [sp, #0]
@   0x08026574: 200a        movs	r0, #10
@   0x08026576: 9001        str	r0, [sp, #4]
@   0x08026578: 2003        movs	r0, #3
@   0x0802657a: 9002        str	r0, [sp, #8]
@   0x0802657c: 2002        movs	r0, #2
@   0x0802657e: 9003        str	r0, [sp, #12]
@   0x08026580: 2003        movs	r0, #3
@   0x08026582: 2200        movs	r2, #0
@   0x08026584: 2334        movs	r3, #52	@ 0x34
@   0x08026586: f7fa        fd8b 	bl	0x210a0
@   0x0802658a: e013        b.n	0x265b4
@   0x0802658c: 4ba0        ldr	r3, [pc, #640]	@ (0x26810)
@   0x0802658e: 0831        lsrs	r1, r6, #32
@   0x08026590: 35e0        adds	r5, #224	@ 0xe0
@   0x08026592: 0300        lsls	r0, r0, #12
@   0x08026594: 4bc0        ldr	r3, [pc, #768]	@ (0x26898)
@   0x08026596: 0831        lsrs	r1, r6, #32
@   0x08026598: 490c        ldr	r1, [pc, #48]	@ (0x265cc)
@   0x0802659a: 20f1        movs	r0, #241	@ 0xf1
@   0x0802659c: 9000        str	r0, [sp, #0]
@   0x0802659e: 200a        movs	r0, #10
@   0x080265a0: 9001        str	r0, [sp, #4]
@   0x080265a2: 2003        movs	r0, #3
@   0x080265a4: 9002        str	r0, [sp, #8]
@   0x080265a6: 2002        movs	r0, #2
@   0x080265a8: 9003        str	r0, [sp, #12]
@   0x080265aa: 2003        movs	r0, #3
@   0x080265ac: 2200        movs	r2, #0
@   0x080265ae: 2334        movs	r3, #52	@ 0x34
@   0x080265b0: f7fa        fd76 	bl	0x210a0
@   0x080265b4: 4806        ldr	r0, [pc, #24]	@ (0x265d0)
@   0x080265b6: 1c02        adds	r2, r0, #0
@   0x080265b8: 32da        adds	r2, #218	@ 0xda
@   0x080265ba: 2102        movs	r1, #2
@   0x080265bc: 7011        strb	r1, [r2, #0]
@   0x080265be: 30d9        adds	r0, #217	@ 0xd9
@   0x080265c0: 21fc        movs	r1, #252	@ 0xfc
@   0x080265c2: 7001        strb	r1, [r0, #0]
@   0x080265c4: b004        add	sp, #16
@   0x080265c6: bc01        pop	{r0}
@   0x080265c8: 4700        bx	r0
@   0x080265ca: 0000        movs	r0, r0
@   0x080265cc: 4be0        ldr	r3, [pc, #896]	@ (0x26950)
@   0x080265ce: 0831        lsrs	r1, r6, #32
@   0x080265d0: 3720        adds	r7, #32
@   0x080265d2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802651C
sub_0802651C: @ 0x0802651c
        .incbin "baserom.gba", 0x2651c, 0xb8
        thumb_func_end sub_0802651C
