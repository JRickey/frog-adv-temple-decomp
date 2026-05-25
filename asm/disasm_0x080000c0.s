@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080000c0, 0x080000fc)  (60 bytes, arm mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80000c0 --end 0x80000fc --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080000c0: e3a000d2    mov	r0, #210	@ 0xd2
@   0x080000c4: e129f000    msr	CPSR_fc, r0
@   0x080000c8: e59fd028    ldr	sp, [pc, #40]	@ 0xf8
@   0x080000cc: e3a0001f    mov	r0, #31
@   0x080000d0: e129f000    msr	CPSR_fc, r0
@   0x080000d4: e59fd018    ldr	sp, [pc, #24]	@ 0xf4
@   0x080000d8: e59f114c    ldr	r1, [pc, #332]	@ 0x22c
@   0x080000dc: e28f0048    add	r0, pc, #72	@ 0x48
@   0x080000e0: e5810000    str	r0, [r1]
@   0x080000e4: e59f1144    ldr	r1, [pc, #324]	@ 0x230
@   0x080000e8: e1a0e00f    mov	lr, pc
@   0x080000ec: e12fff11    bx	r1
@   0x080000f0: eafffff2    b	0xc0
@   0x080000f4: 03007f00    tsteq	r0, #0, 30
@   0x080000f8: 03007fa0    tsteq	r0, #160, 30	@ 0x280

        arm_func_start _start
_start: @ 0x080000c0
        .incbin "frog_us_baserom.gba", 0xc0, 0x3c
        arm_func_end _start
