@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026dcc, 0x08026e40)  (116 bytes, arm mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026dcc --end 0x8026e40 --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026dcc: b083b500    addlt	fp, r3, r0, lsl #10
@   0x08026dd0: 48084907    stmdami	r8, {r0, r1, r2, r8, fp, lr}
@   0x08026dd4: 200b9000    andcs	r9, fp, r0
@   0x08026dd8: 20009001    andcs	r9, r0, r1
@   0x08026ddc: 206d9002    rsbcs	r9, sp, r2
@   0x08026de0: 23362210    teqcs	r6, #16, 4
@   0x08026de4: f9acf7fa    @ <UNDEFINED> instruction: 0xf9acf7fa
@   0x08026de8: bc01b003    stclt	0, cr11, [r1], {3}
@   0x08026dec: 00004700    andeq	r4, r0, r0, lsl #14
@   0x08026df0: 083159d8    ldmdaeq	r1!, {r3, r4, r6, r7, r8, fp, ip, lr}
@   0x08026df4: 00000101    andeq	r0, r0, r1, lsl #2
@   0x08026df8: b081b510    addlt	fp, r1, r0, lsl r5
@   0x08026dfc: 00e02400    rsceq	r2, r0, r0, lsl #8
@   0x08026e00: 00c01b00    sbceq	r1, r0, r0, lsl #22
@   0x08026e04: 1840490b    stmdane	r0, {r0, r1, r3, r8, fp, lr}^
@   0x08026e08: 22022109    andcs	r2, r2, #1073741826	@ 0x40000002
@   0x08026e0c: f7fa2302    @ <UNDEFINED> instruction: 0xf7fa2302
@   0x08026e10: 1c60f801    stclne	8, cr15, [r0], #-4
@   0x08026e14: 0e040600    cdpeq	6, 0, cr0, cr4, cr0, {0}
@   0x08026e18: d9f02c05    ldmible	r0!, {r0, r2, sl, fp, sp}^
@   0x08026e1c: 4b074906    blmi	0x1f923c
@   0x08026e20: 90002000    andls	r2, r0, r0
@   0x08026e24: 2236206d    eorscs	r2, r6, #109	@ 0x6d
@   0x08026e28: fb72f7fa    @ <UNDEFINED> instruction: 0xfb72f7fa
@   0x08026e2c: bc10b001    ldclt	0, cr11, [r0], {1}
@   0x08026e30: 4700bc01    strmi	fp, [r0, -r1, lsl #24]
@   0x08026e34: 03004ef8    tsteq	r0, #248, 28	@ 0xf80
@   0x08026e38: 083159d8    ldmdaeq	r1!, {r3, r4, r6, r7, r8, fp, ip, lr}
@   0x08026e3c: 03006110    tsteq	r0, #16, 2

        arm_func_start sub_08026DCC
sub_08026DCC: @ 0x08026dcc
        .incbin "frog_us_baserom.gba", 0x26dcc, 0x74
        arm_func_end sub_08026DCC
