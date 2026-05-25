@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000114, 0x0800012c)  (24 bytes, arm mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000114 --end 0x800012c --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000114: e92d0001    stmfd	sp!, {r0}
@   0x08000118: e10f0000    mrs	r0, CPSR
@   0x0800011c: e3800080    orr	r0, r0, #128	@ 0x80
@   0x08000120: e129f000    msr	CPSR_fc, r0
@   0x08000124: e8bd0001    ldmfd	sp!, {r0}
@   0x08000128: e12fff1e    bx	lr

        arm_func_start IntrDisable
IntrDisable: @ 0x08000114
        .incbin "frog_us_baserom.gba", 0x114, 0x18
        arm_func_end IntrDisable
