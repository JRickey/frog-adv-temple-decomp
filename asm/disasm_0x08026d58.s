@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026d58, 0x08026dcc)  (116 bytes, arm mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026d58 --end 0x8026dcc --mode arm

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026d58: b083b500    addlt	fp, r3, r0, lsl #10
@   0x08026d5c: 48084907    stmdami	r8, {r0, r1, r2, r8, fp, lr}
@   0x08026d60: 200b9000    andcs	r9, fp, r0
@   0x08026d64: 20009001    andcs	r9, r0, r1
@   0x08026d68: 206d9002    rsbcs	r9, sp, r2
@   0x08026d6c: 23362210    teqcs	r6, #16, 4
@   0x08026d70: f9e6f7fa    @ <UNDEFINED> instruction: 0xf9e6f7fa
@   0x08026d74: bc01b003    stclt	0, cr11, [r1], {3}
@   0x08026d78: 00004700    andeq	r4, r0, r0, lsl #14
@   0x08026d7c: 08315a10    ldmdaeq	r1!, {r4, r9, fp, ip, lr}
@   0x08026d80: 00000101    andeq	r0, r0, r1, lsl #2
@   0x08026d84: b081b510    addlt	fp, r1, r0, lsl r5
@   0x08026d88: 00e02400    rsceq	r2, r0, r0, lsl #8
@   0x08026d8c: 00c01b00    sbceq	r1, r0, r0, lsl #22
@   0x08026d90: 1840490b    stmdane	r0, {r0, r1, r3, r8, fp, lr}^
@   0x08026d94: 22022109    andcs	r2, r2, #1073741826	@ 0x40000002
@   0x08026d98: f7fa2302    @ <UNDEFINED> instruction: 0xf7fa2302
@   0x08026d9c: 1c60f83b    stclne	8, cr15, [r0], #-236	@ 0xffffff14
@   0x08026da0: 0e040600    cdpeq	6, 0, cr0, cr4, cr0, {0}
@   0x08026da4: d9f02c05    ldmible	r0!, {r0, r2, sl, fp, sp}^
@   0x08026da8: 4b074906    blmi	0x1f91c8
@   0x08026dac: 90002000    andls	r2, r0, r0
@   0x08026db0: 2236206d    eorscs	r2, r6, #109	@ 0x6d
@   0x08026db4: fbacf7fa    @ <UNDEFINED> instruction: 0xfbacf7fa
@   0x08026db8: bc10b001    ldclt	0, cr11, [r0], {1}
@   0x08026dbc: 4700bc01    strmi	fp, [r0, -r1, lsl #24]
@   0x08026dc0: 03004ef8    tsteq	r0, #248, 28	@ 0xf80
@   0x08026dc4: 08315a10    ldmdaeq	r1!, {r4, r9, fp, ip, lr}
@   0x08026dc8: 03006110    tsteq	r0, #16, 2

        arm_func_start sub_08026D58
sub_08026D58: @ 0x08026d58
        .incbin "baserom.gba", 0x26d58, 0x74
        arm_func_end sub_08026D58
