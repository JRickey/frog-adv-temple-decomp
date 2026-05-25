@ sub_08000430: helper function called from AgbMain's prologue (bl at 0x2AE).
@ 148 bytes; prologue `push {r4, lr}` at 0x430. Literal pool at the tail
@ (0x080004A4-0x080004C3) holds REG_IE (0x04000200) plus 7 IWRAM struct
@ base addresses: gGameStuff at 0x03005330, and 6 adjacent IWRAM bases at
@ 0x03003480..0x030035E0. The function also writes 0x1F40 to REG_DISPCNT
@ (0x04000000) inline via shift-construction at 0x490-0x49A (enable all
@ BGs + OBJ in 1D char-mapping mode).
@
@ Calls: sub_080020B30, sub_080017364, sub_08000072C, sub_080000820.
@ Range:  [0x08000430, 0x080004c4)  (148 bytes, thumb mode).
@ Name `sub_08000430` until purpose is identified — likely Init1, the
@ initialization routine called once before the main dispatch loop.

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08000430
sub_08000430: @ 0x08000430
        push    {r4, lr}
        .4byte  0xfb7df020                      @ bl sub_080020b30 (TBD)
        ldr     r0, .Lsub_08000430_regIE        @ -> 0x04000200 (REG_IE)
        movs    r2, #0
        strh    r2, [r0, #0]                    @ REG_IE = 0 (disable all IRQs)
        ldr     r0, .Lsub_08000430_gGameStuff   @ -> 0x03005330
        movs    r1, #13
        str     r1, [r0, #28]                   @ gGameStuff+0x1C = 13
        movs    r4, #0
        str     r4, [r0, #0]                    @ gGameStuff+0x00 = 0
        strb    r2, [r0, #16]                   @ gGameStuff+0x10 = 0
        strb    r2, [r0, #24]                   @ gGameStuff+0x18 = 0
        str     r4, [r0, #20]                   @ gGameStuff+0x14 = 0
        strb    r2, [r0, #10]                   @ gGameStuff.pendingMode = 0
        str     r4, [r0, #4]                    @ gGameStuff+0x04 = 0
        ldr     r0, .Lsub_08000430_iwram3480    @ -> 0x03003480
        strb    r2, [r0, #5]                    @ +5 = 0
        strb    r2, [r0, #0]                    @ +0 = 0
        ldr     r0, .Lsub_08000430_iwram34a0    @ -> 0x030034A0
        strb    r2, [r0, #1]                    @ +1 = 0
        ldr     r1, .Lsub_08000430_iwram34b4    @ -> 0x030034B4
        movs    r0, #1
        strb    r0, [r1, #0]                    @ +0 = 1
        strb    r0, [r1, #1]                    @ +1 = 1
        movs    r0, #5
        strb    r0, [r1, #2]                    @ +2 = 5
        strb    r0, [r1, #3]                    @ +3 = 5
        ldr     r1, .Lsub_08000430_iwram35e0    @ -> 0x030035E0
        strb    r0, [r1, #0]                    @ +0 = 5
        strb    r2, [r1, #4]                    @ +4 = 0
        ldr     r0, .Lsub_08000430_iwram34b0    @ -> 0x030034B0
        str     r4, [r0, #0]                    @ *(u32*)0x030034B0 = 0
        .4byte  0xff77f016                      @ bl sub_080017364 (TBD)
        .4byte  0xf959f000                      @ bl sub_08000072c (TBD)
        ldr     r0, .Lsub_08000430_iwram3550    @ -> 0x03003550
        strh    r4, [r0, #0]                    @ 8 halfword zero-fill
        strh    r4, [r0, #2]
        strh    r4, [r0, #4]
        strh    r4, [r0, #6]
        strh    r4, [r0, #8]
        strh    r4, [r0, #10]
        strh    r4, [r0, #12]
        strh    r4, [r0, #14]
        .4byte  0xf9c8f000                      @ bl sub_080000820 (TBD)
        movs    r1, #128                        @ r1 = 0x80
        lsls    r1, r1, #19                     @ r1 = 0x04000000 = REG_DISPCNT
        movs    r2, #250                        @ r2 = 0xFA
        lsls    r2, r2, #5                      @ r2 = 0x1F40
        adds    r0, r2, #0                      @ r0 = 0x1F40 (BG0..BG3 + OBJ on, OBJ 1D)
        strh    r0, [r1, #0]                    @ REG_DISPCNT = 0x1F40
        pop     {r4}                            @ interwork-style return
        pop     {r0}
        bx      r0
        .short  0                               @ alignment pad before literal pool
.Lsub_08000430_regIE:
        .word   0x04000200
.Lsub_08000430_gGameStuff:
        .word   0x03005330
.Lsub_08000430_iwram3480:
        .word   0x03003480
.Lsub_08000430_iwram34a0:
        .word   0x030034a0
.Lsub_08000430_iwram34b4:
        .word   0x030034b4
.Lsub_08000430_iwram35e0:
        .word   0x030035e0
.Lsub_08000430_iwram34b0:
        .word   0x030034b0
.Lsub_08000430_iwram3550:
        .word   0x03003550
        thumb_func_end sub_08000430
