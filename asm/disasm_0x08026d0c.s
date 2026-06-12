@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026d0c, 0x08026d34)  (40 bytes, arm mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026d0c --end 0x8026d34 --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026d0c: b083b500    addlt	fp, r3, r0, lsl #10
@   0x08026d10: 20d14907    sbcscs	r4, r1, r7, lsl #18
@   0x08026d14: 20099000    andcs	r9, r9, r0
@   0x08026d18: 20009001    andcs	r9, r0, r1
@   0x08026d1c: 206b9002    rsbcs	r9, fp, r2
@   0x08026d20: 230b2210    tstcs	fp, #16, 4
@   0x08026d24: fa0cf7fa    @ <UNDEFINED> instruction: 0xfa0cf7fa
@   0x08026d28: bc01b003    stclt	0, cr11, [r1], {3}
@   0x08026d2c: 00004700    andeq	r4, r0, r0, lsl #14
@   0x08026d30: 083159c0    ldmdaeq	r1!, {r6, r7, r8, fp, ip, lr}

        arm_func_start sub_08026D0C
sub_08026D0C: @ 0x08026d0c
        .incbin "baserom.gba", 0x26d0c, 0x28
        arm_func_end sub_08026D0C
