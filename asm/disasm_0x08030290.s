@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08030290, 0x0803030c)  (124 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8030290 --end 0x803030c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08030290: b510        push	{r4, lr}
@   0x08030292: 4817        ldr	r0, [pc, #92]	@ (0x302f0)
@   0x08030294: 6804        ldr	r4, [r0, #0]
@   0x08030296: 34d0        adds	r4, #208	@ 0xd0
@   0x08030298: f7fe        f8be 	bl	0x2e418
@   0x0803029c: 4915        ldr	r1, [pc, #84]	@ (0x302f4)
@   0x0803029e: 209a        movs	r0, #154	@ 0x9a
@   0x080302a0: 7008        strb	r0, [r1, #0]
@   0x080302a2: 3139        adds	r1, #57	@ 0x39
@   0x080302a4: 6960        ldr	r0, [r4, #20]
@   0x080302a6: 6008        str	r0, [r1, #0]
@   0x080302a8: 3104        adds	r1, #4
@   0x080302aa: 4813        ldr	r0, [pc, #76]	@ (0x302f8)
@   0x080302ac: 6008        str	r0, [r1, #0]
@   0x080302ae: 3024        adds	r0, #36	@ 0x24
@   0x080302b0: 2304        movs	r3, #4
@   0x080302b2: 8003        strh	r3, [r0, #0]
@   0x080302b4: 3002        adds	r0, #2
@   0x080302b6: 4911        ldr	r1, [pc, #68]	@ (0x302fc)
@   0x080302b8: 1c0a        adds	r2, r1, #0
@   0x080302ba: 8002        strh	r2, [r0, #0]
@   0x080302bc: 4910        ldr	r1, [pc, #64]	@ (0x30300)
@   0x080302be: 69a0        ldr	r0, [r4, #24]
@   0x080302c0: 6008        str	r0, [r1, #0]
@   0x080302c2: 3104        adds	r1, #4
@   0x080302c4: 480f        ldr	r0, [pc, #60]	@ (0x30304)
@   0x080302c6: 6008        str	r0, [r1, #0]
@   0x080302c8: 302c        adds	r0, #44	@ 0x2c
@   0x080302ca: 8003        strh	r3, [r0, #0]
@   0x080302cc: 3002        adds	r0, #2
@   0x080302ce: 8002        strh	r2, [r0, #0]
@   0x080302d0: 4a0d        ldr	r2, [pc, #52]	@ (0x30308)
@   0x080302d2: 8810        ldrh	r0, [r2, #0]
@   0x080302d4: 21c0        movs	r1, #192	@ 0xc0
@   0x080302d6: 4308        orrs	r0, r1
@   0x080302d8: 8010        strh	r0, [r2, #0]
@   0x080302da: 3a04        subs	r2, #4
@   0x080302dc: 8810        ldrh	r0, [r2, #0]
@   0x080302de: 2180        movs	r1, #128	@ 0x80
@   0x080302e0: 4308        orrs	r0, r1
@   0x080302e2: 8010        strh	r0, [r2, #0]
@   0x080302e4: f7fe        f888 	bl	0x2e3f8
@   0x080302e8: bc10        pop	{r4}
@   0x080302ea: bc01        pop	{r0}
@   0x080302ec: 4700        bx	r0
@   0x080302ee: 0000        movs	r0, r0
@   0x080302f0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080302f2: 0300        lsls	r0, r0, #12
@   0x080302f4: 0083        lsls	r3, r0, #2
@   0x080302f6: 0400        lsls	r0, r0, #16
@   0x080302f8: 00a0        lsls	r0, r4, #2
@   0x080302fa: 0400        lsls	r0, r0, #16
@   0x080302fc: b660        cpsie
@   0x080302fe: 0000        movs	r0, r0
@   0x08030300: 00c8        lsls	r0, r1, #3
@   0x08030302: 0400        lsls	r0, r0, #16
@   0x08030304: 00a4        lsls	r4, r4, #2
@   0x08030306: 0400        lsls	r0, r0, #16
@   0x08030308: 0106        lsls	r6, r0, #4
@   0x0803030a: 0400        lsls	r0, r0, #16

        thumb_func_start sub_08030290
sub_08030290: @ 0x08030290
        .incbin "frog_us_baserom.gba", 0x30290, 0x7c
        thumb_func_end sub_08030290
