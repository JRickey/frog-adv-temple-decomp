@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000240, 0x080002a4)  (100 bytes, arm mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000240 --end 0x80002a4 --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000240: e92d4000    stmfd	sp!, {lr}
@   0x08000244: e51f3014    ldr	r3, [pc, #-20]	@ 0x238
@   0x08000248: e5932000    ldr	r2, [r3]
@   0x0800024c: e3520000    cmp	r2, #0
@   0x08000250: 0a00000e    beq	0x290
@   0x08000254: e3a00301    mov	r0, #67108864	@ 0x4000000
@   0x08000258: e5901200    ldr	r1, [r0, #512]	@ 0x200
@   0x0800025c: e92d0003    push	{r0, r1}
@   0x08000260: e3c11001    bic	r1, r1, #1
@   0x08000264: e5801200    str	r1, [r0, #512]	@ 0x200
@   0x08000268: 110f0000    mrsne	r0, CPSR
@   0x0800026c: 13c00080    bicne	r0, r0, #128	@ 0x80
@   0x08000270: 1129f000    msrne	CPSR_fc, r0
@   0x08000274: e51f0040    ldr	r0, [pc, #-64]	@ 0x23c
@   0x08000278: e1a0e00f    mov	lr, pc
@   0x0800027c: e12fff10    bx	r0
@   0x08000280: e8bd0003    pop	{r0, r1}
@   0x08000284: e5801200    str	r1, [r0, #512]	@ 0x200
@   0x08000288: e8bd4000    ldmfd	sp!, {lr}
@   0x0800028c: e12fff1e    bx	lr
@   0x08000290: e51f005c    ldr	r0, [pc, #-92]	@ 0x23c
@   0x08000294: e1a0e00f    mov	lr, pc
@   0x08000298: e12fff10    bx	r0
@   0x0800029c: e8bd4000    ldmfd	sp!, {lr}
@   0x080002a0: e12fff1e    bx	lr

        arm_func_start sub_08000240
sub_08000240: @ 0x08000240
        .incbin "frog_us_baserom.gba", 0x240, 0x64
        arm_func_end sub_08000240
