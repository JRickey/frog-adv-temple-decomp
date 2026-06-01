@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080159b0, 0x08015a00)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80159b0 --end 0x8015a00 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080159b0: b500        push	{lr}
@   0x080159b2: 4a0c        ldr	r2, [pc, #48]	@ (0x159e4)
@   0x080159b4: 2000        movs	r0, #0
@   0x080159b6: 7210        strb	r0, [r2, #8]
@   0x080159b8: 490b        ldr	r1, [pc, #44]	@ (0x159e8)
@   0x080159ba: 7208        strb	r0, [r1, #8]
@   0x080159bc: 7010        strb	r0, [r2, #0]
@   0x080159be: 7008        strb	r0, [r1, #0]
@   0x080159c0: 490a        ldr	r1, [pc, #40]	@ (0x159ec)
@   0x080159c2: 7008        strb	r0, [r1, #0]
@   0x080159c4: 490a        ldr	r1, [pc, #40]	@ (0x159f0)
@   0x080159c6: 7008        strb	r0, [r1, #0]
@   0x080159c8: 490a        ldr	r1, [pc, #40]	@ (0x159f4)
@   0x080159ca: 7008        strb	r0, [r1, #0]
@   0x080159cc: 7188        strb	r0, [r1, #6]
@   0x080159ce: 71c8        strb	r0, [r1, #7]
@   0x080159d0: 7288        strb	r0, [r1, #10]
@   0x080159d2: 72c8        strb	r0, [r1, #11]
@   0x080159d4: f7ff        ffac 	bl	0x15930
@   0x080159d8: 4907        ldr	r1, [pc, #28]	@ (0x159f8)
@   0x080159da: 4a08        ldr	r2, [pc, #32]	@ (0x159fc)
@   0x080159dc: 1c10        adds	r0, r2, #0
@   0x080159de: 8008        strh	r0, [r1, #0]
@   0x080159e0: bc01        pop	{r0}
@   0x080159e2: 4700        bx	r0
@   0x080159e4: 6540        str	r0, [r0, #84]	@ 0x54
@   0x080159e6: 0300        lsls	r0, r0, #12
@   0x080159e8: 6480        str	r0, [r0, #72]	@ 0x48
@   0x080159ea: 0300        lsls	r0, r0, #12
@   0x080159ec: 6500        str	r0, [r0, #80]	@ 0x50
@   0x080159ee: 0300        lsls	r0, r0, #12
@   0x080159f0: 6580        str	r0, [r0, #88]	@ 0x58
@   0x080159f2: 0300        lsls	r0, r0, #12
@   0x080159f4: 3610        adds	r6, #16
@   0x080159f6: 0300        lsls	r0, r0, #12
@   0x080159f8: 000c        movs	r4, r1
@   0x080159fa: 0400        lsls	r0, r0, #16
@   0x080159fc: 1e0d        subs	r5, r1, #0

        thumb_func_start sub_080159B0
sub_080159B0: @ 0x080159b0
        .incbin "frog_us_baserom.gba", 0x159b0, 0x50
        thumb_func_end sub_080159B0
