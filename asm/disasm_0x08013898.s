@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013898, 0x08013908)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013898 --end 0x8013908 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013898: b500        push	{lr}
@   0x0801389a: b082        sub	sp, #8
@   0x0801389c: 4903        ldr	r1, [pc, #12]	@ (0x138ac)
@   0x0801389e: 7808        ldrb	r0, [r1, #0]
@   0x080138a0: 2800        cmp	r0, #0
@   0x080138a2: d005        beq.n	0x138b0
@   0x080138a4: 2801        cmp	r0, #1
@   0x080138a6: d006        beq.n	0x138b6
@   0x080138a8: e014        b.n	0x138d4
@   0x080138aa: 0000        movs	r0, r0
@   0x080138ac: 3610        adds	r6, #16
@   0x080138ae: 0300        lsls	r0, r0, #12
@   0x080138b0: 2001        movs	r0, #1
@   0x080138b2: 7008        strb	r0, [r1, #0]
@   0x080138b4: e00e        b.n	0x138d4
@   0x080138b6: f7fa        ff8d 	bl	0xe7d4
@   0x080138ba: f7ff        f9f7 	bl	0x12cac
@   0x080138be: 4b0e        ldr	r3, [pc, #56]	@ (0x138f8)
@   0x080138c0: 7898        ldrb	r0, [r3, #2]
@   0x080138c2: 9000        str	r0, [sp, #0]
@   0x080138c4: 480d        ldr	r0, [pc, #52]	@ (0x138fc)
@   0x080138c6: 9001        str	r0, [sp, #4]
@   0x080138c8: 6818        ldr	r0, [r3, #0]
@   0x080138ca: 6859        ldr	r1, [r3, #4]
@   0x080138cc: 689a        ldr	r2, [r3, #8]
@   0x080138ce: 68db        ldr	r3, [r3, #12]
@   0x080138d0: f000        f9c6 	bl	0x13c60
@   0x080138d4: 4b0a        ldr	r3, [pc, #40]	@ (0x13900)
@   0x080138d6: 7898        ldrb	r0, [r3, #2]
@   0x080138d8: 9000        str	r0, [sp, #0]
@   0x080138da: 480a        ldr	r0, [pc, #40]	@ (0x13904)
@   0x080138dc: 9001        str	r0, [sp, #4]
@   0x080138de: 6818        ldr	r0, [r3, #0]
@   0x080138e0: 6859        ldr	r1, [r3, #4]
@   0x080138e2: 689a        ldr	r2, [r3, #8]
@   0x080138e4: 68db        ldr	r3, [r3, #12]
@   0x080138e6: f000        f9bb 	bl	0x13c60
@   0x080138ea: f7ff        fc0f 	bl	0x1310c
@   0x080138ee: f003        fb87 	bl	0x17000
@   0x080138f2: b002        add	sp, #8
@   0x080138f4: bc01        pop	{r0}
@   0x080138f6: 4700        bx	r0
@   0x080138f8: 6f08        ldr	r0, [r1, #112]	@ 0x70
@   0x080138fa: 0830        lsrs	r0, r6, #32
@   0x080138fc: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x080138fe: 0300        lsls	r0, r0, #12
@   0x08013900: 6f50        ldr	r0, [r2, #116]	@ 0x74
@   0x08013902: 0830        lsrs	r0, r6, #32
@   0x08013904: 6580        str	r0, [r0, #88]	@ 0x58
@   0x08013906: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013898
sub_08013898: @ 0x08013898
        .incbin "frog_us_baserom.gba", 0x13898, 0x70
        thumb_func_end sub_08013898
