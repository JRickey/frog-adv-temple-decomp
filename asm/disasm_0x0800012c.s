@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800012c, 0x08000240)  (276 bytes, arm mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800012c --end 0x8000240 --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800012c: e92d4000    stmfd	sp!, {lr}
@   0x08000130: e14f0000    mrs	r0, SPSR
@   0x08000134: e92d0001    stmfd	sp!, {r0}
@   0x08000138: e10f0000    mrs	r0, CPSR
@   0x0800013c: e3c0101f    bic	r1, r0, #31
@   0x08000140: e380101f    orr	r1, r0, #31
@   0x08000144: e129f001    msr	CPSR_fc, r1
@   0x08000148: e92d4001    push	{r0, lr}
@   0x0800014c: e3a03301    mov	r3, #67108864	@ 0x4000000
@   0x08000150: e2833c02    add	r3, r3, #512	@ 0x200
@   0x08000154: e5932000    ldr	r2, [r3]
@   0x08000158: e0021822    and	r1, r2, r2, lsr #16
@   0x0800015c: e2110a02    ands	r0, r1, #8192	@ 0x2000
@   0x08000160: 1afffffe    bne	0x160
@   0x08000164: e3a02000    mov	r2, #0
@   0x08000168: e2110001    ands	r0, r1, #1
@   0x0800016c: 1a000022    bne	0x1fc
@   0x08000170: e2822004    add	r2, r2, #4
@   0x08000174: e2110002    ands	r0, r1, #2
@   0x08000178: 1a00001f    bne	0x1fc
@   0x0800017c: e2822004    add	r2, r2, #4
@   0x08000180: e2110004    ands	r0, r1, #4
@   0x08000184: 1a00001c    bne	0x1fc
@   0x08000188: e2822004    add	r2, r2, #4
@   0x0800018c: e2110008    ands	r0, r1, #8
@   0x08000190: 1a000019    bne	0x1fc
@   0x08000194: e2822004    add	r2, r2, #4
@   0x08000198: e2110010    ands	r0, r1, #16
@   0x0800019c: 1a000016    bne	0x1fc
@   0x080001a0: e2822004    add	r2, r2, #4
@   0x080001a4: e2110020    ands	r0, r1, #32
@   0x080001a8: 1a000013    bne	0x1fc
@   0x080001ac: e2822004    add	r2, r2, #4
@   0x080001b0: e2110040    ands	r0, r1, #64	@ 0x40
@   0x080001b4: 1a000010    bne	0x1fc
@   0x080001b8: e2822004    add	r2, r2, #4
@   0x080001bc: e2110080    ands	r0, r1, #128	@ 0x80
@   0x080001c0: 1a00000d    bne	0x1fc
@   0x080001c4: e2822004    add	r2, r2, #4
@   0x080001c8: e2110c01    ands	r0, r1, #256	@ 0x100
@   0x080001cc: 1a00000a    bne	0x1fc
@   0x080001d0: e2822004    add	r2, r2, #4
@   0x080001d4: e2110c02    ands	r0, r1, #512	@ 0x200
@   0x080001d8: 1a000007    bne	0x1fc
@   0x080001dc: e2822004    add	r2, r2, #4
@   0x080001e0: e2110b01    ands	r0, r1, #1024	@ 0x400
@   0x080001e4: 1a000004    bne	0x1fc
@   0x080001e8: e2822004    add	r2, r2, #4
@   0x080001ec: e2110b02    ands	r0, r1, #2048	@ 0x800
@   0x080001f0: 1a000001    bne	0x1fc
@   0x080001f4: e2822004    add	r2, r2, #4
@   0x080001f8: e2110a01    ands	r0, r1, #4096	@ 0x1000
@   0x080001fc: e1c300b2    strh	r0, [r3, #2]
@   0x08000200: e59f102c    ldr	r1, [pc, #44]	@ 0x234
@   0x08000204: e0811002    add	r1, r1, r2
@   0x08000208: e5910000    ldr	r0, [r1]
@   0x0800020c: e1a0e00f    mov	lr, pc
@   0x08000210: e12fff10    bx	r0
@   0x08000214: e8bd4001    pop	{r0, lr}
@   0x08000218: e129f000    msr	CPSR_fc, r0
@   0x0800021c: e8bd0001    ldmfd	sp!, {r0}
@   0x08000220: e169f000    msr	SPSR_fc, r0
@   0x08000224: e8bd4000    ldmfd	sp!, {lr}
@   0x08000228: e12fff1e    bx	lr
@   0x0800022c: 03007ffc    tsteq	r0, #252, 30	@ 0x3f0
@   0x08000230: 080002a5    stmdaeq	r0, {r0, r2, r5, r7, r9}
@   0x08000234: 08035d9c    stmdaeq	r3, {r2, r3, r4, r7, r8, sl, fp, ip, lr}
@   0x08000238: 082f9010    stmdaeq	pc!, {r4, ip, pc}	@ <UNPREDICTABLE>
@   0x0800023c: 0802ffd9    stmdaeq	r2, {r0, r3, r4, r6, r7, r8, r9, sl, fp, ip, sp, lr, pc}

        arm_func_start IntrMain
IntrMain: @ 0x0800012c
        .incbin "frog_us_baserom.gba", 0x12c, 0x114
        arm_func_end IntrMain
