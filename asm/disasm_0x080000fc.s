@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080000fc, 0x08000114)  (24 bytes, arm mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80000fc --end 0x8000114 --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080000fc: e92d0001    stmfd	sp!, {r0}
@   0x08000100: e10f0000    mrs	r0, CPSR
@   0x08000104: e3c00080    bic	r0, r0, #128	@ 0x80
@   0x08000108: e129f000    msr	CPSR_fc, r0
@   0x0800010c: e8bd0001    ldmfd	sp!, {r0}
@   0x08000110: e12fff1e    bx	lr

        arm_func_start IntrEnable
IntrEnable: @ 0x080000fc
        .incbin "frog_us_baserom.gba", 0xfc, 0x18
        arm_func_end IntrEnable
