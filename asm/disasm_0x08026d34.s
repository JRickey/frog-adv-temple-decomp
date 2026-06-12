@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026d34, 0x08026d58)  (36 bytes, arm mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026d34 --end 0x8026d58 --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026d34: b081b500    addlt	fp, r1, r0, lsl #10
@   0x08026d38: 4b064905    blmi	0x1b9154
@   0x08026d3c: 90002000    andls	r2, r0, r0
@   0x08026d40: 220b206b    andcs	r2, fp, #107	@ 0x6b
@   0x08026d44: fbe4f7fa    @ <UNDEFINED> instruction: 0xfbe4f7fa
@   0x08026d48: bc01b001    stclt	0, cr11, [r1], {1}
@   0x08026d4c: 00004700    andeq	r4, r0, r0, lsl #14
@   0x08026d50: 083159c0    ldmdaeq	r1!, {r6, r7, r8, fp, ip, lr}
@   0x08026d54: 03006110    tsteq	r0, #16, 2

        arm_func_start sub_08026D34
sub_08026D34: @ 0x08026d34
        .incbin "baserom.gba", 0x26d34, 0x24
        arm_func_end sub_08026D34
