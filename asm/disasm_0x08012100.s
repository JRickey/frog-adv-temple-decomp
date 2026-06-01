@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012100, 0x08012180)  (128 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012100 --end 0x8012180 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012100: b510        push	{r4, lr}
@   0x08012102: b081        sub	sp, #4
@   0x08012104: 4a15        ldr	r2, [pc, #84]	@ (0x1215c)
@   0x08012106: 202a        movs	r0, #42	@ 0x2a
@   0x08012108: 1880        adds	r0, r0, r2
@   0x0801210a: 4684        mov	ip, r0
@   0x0801210c: 21f0        movs	r1, #240	@ 0xf0
@   0x0801210e: 1c08        adds	r0, r1, #0
@   0x08012110: 4663        mov	r3, ip
@   0x08012112: 781b        ldrb	r3, [r3, #0]
@   0x08012114: 4018        ands	r0, r3
@   0x08012116: 2300        movs	r3, #0
@   0x08012118: 4664        mov	r4, ip
@   0x0801211a: 7020        strb	r0, [r4, #0]
@   0x0801211c: 322b        adds	r2, #43	@ 0x2b
@   0x0801211e: 7810        ldrb	r0, [r2, #0]
@   0x08012120: 4001        ands	r1, r0
@   0x08012122: 7011        strb	r1, [r2, #0]
@   0x08012124: 480e        ldr	r0, [pc, #56]	@ (0x12160)
@   0x08012126: 7043        strb	r3, [r0, #1]
@   0x08012128: 30ff        adds	r0, #255	@ 0xff
@   0x0801212a: 7003        strb	r3, [r0, #0]
@   0x0801212c: 480d        ldr	r0, [pc, #52]	@ (0x12164)
@   0x0801212e: 490e        ldr	r1, [pc, #56]	@ (0x12168)
@   0x08012130: 1840        adds	r0, r0, r1
@   0x08012132: 7003        strb	r3, [r0, #0]
@   0x08012134: 480d        ldr	r0, [pc, #52]	@ (0x1216c)
@   0x08012136: 2100        movs	r1, #0
@   0x08012138: 86c3        strh	r3, [r0, #54]	@ 0x36
@   0x0801213a: 7001        strb	r1, [r0, #0]
@   0x0801213c: 7081        strb	r1, [r0, #2]
@   0x0801213e: 480c        ldr	r0, [pc, #48]	@ (0x12170)
@   0x08012140: 7281        strb	r1, [r0, #10]
@   0x08012142: 4668        mov	r0, sp
@   0x08012144: 8003        strh	r3, [r0, #0]
@   0x08012146: 490b        ldr	r1, [pc, #44]	@ (0x12174)
@   0x08012148: 6008        str	r0, [r1, #0]
@   0x0801214a: 480b        ldr	r0, [pc, #44]	@ (0x12178)
@   0x0801214c: 6048        str	r0, [r1, #4]
@   0x0801214e: 480b        ldr	r0, [pc, #44]	@ (0x1217c)
@   0x08012150: 6088        str	r0, [r1, #8]
@   0x08012152: 6888        ldr	r0, [r1, #8]
@   0x08012154: b001        add	sp, #4
@   0x08012156: bc10        pop	{r4}
@   0x08012158: bc01        pop	{r0}
@   0x0801215a: 4700        bx	r0
@   0x0801215c: 6110        str	r0, [r2, #16]
@   0x0801215e: 0300        lsls	r0, r0, #12
@   0x08012160: 53a0        strh	r0, [r4, r6]
@   0x08012162: 0300        lsls	r0, r0, #12
@   0x08012164: 3720        adds	r7, #32
@   0x08012166: 0300        lsls	r0, r0, #12
@   0x08012168: 1a5b        subs	r3, r3, r1
@   0x0801216a: 0000        movs	r0, r0
@   0x0801216c: 6480        str	r0, [r0, #72]	@ 0x48
@   0x0801216e: 0300        lsls	r0, r0, #12
@   0x08012170: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08012172: 0300        lsls	r0, r0, #12
@   0x08012174: 00d4        lsls	r4, r2, #3
@   0x08012176: 0400        lsls	r0, r0, #16
@   0x08012178: 0000        movs	r0, r0
@   0x0801217a: 0202        lsls	r2, r0, #8
@   0x0801217c: 8000        strh	r0, [r0, #0]
@   0x0801217e: 8100        strh	r0, [r0, #8]

        thumb_func_start sub_08012100
sub_08012100: @ 0x08012100
        .incbin "frog_us_baserom.gba", 0x12100, 0x80
        thumb_func_end sub_08012100
