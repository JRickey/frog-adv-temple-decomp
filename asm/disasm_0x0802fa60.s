@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802fa60, 0x0802fab8)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802fa60 --end 0x802fab8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802fa60: b510        push	{r4, lr}
@   0x0802fa62: 1c02        adds	r2, r0, #0
@   0x0802fa64: 4813        ldr	r0, [pc, #76]	@ (0x2fab4)
@   0x0802fa66: 6804        ldr	r4, [r0, #0]
@   0x0802fa68: 1c20        adds	r0, r4, #0
@   0x0802fa6a: 30cc        adds	r0, #204	@ 0xcc
@   0x0802fa6c: 6801        ldr	r1, [r0, #0]
@   0x0802fa6e: 0090        lsls	r0, r2, #2
@   0x0802fa70: 1840        adds	r0, r0, r1
@   0x0802fa72: 6803        ldr	r3, [r0, #0]
@   0x0802fa74: 2b00        cmp	r3, #0
@   0x0802fa76: d01a        beq.n	0x2faae
@   0x0802fa78: 1c21        adds	r1, r4, #0
@   0x0802fa7a: 31c0        adds	r1, #192	@ 0xc0
@   0x0802fa7c: 00d0        lsls	r0, r2, #3
@   0x0802fa7e: 1a80        subs	r0, r0, r2
@   0x0802fa80: 0080        lsls	r0, r0, #2
@   0x0802fa82: 680c        ldr	r4, [r1, #0]
@   0x0802fa84: 1824        adds	r4, r4, r0
@   0x0802fa86: 8818        ldrh	r0, [r3, #0]
@   0x0802fa88: 8859        ldrh	r1, [r3, #2]
@   0x0802fa8a: 1842        adds	r2, r0, r1
@   0x0802fa8c: 8898        ldrh	r0, [r3, #4]
@   0x0802fa8e: 1882        adds	r2, r0, r2
@   0x0802fa90: 8999        ldrh	r1, [r3, #12]
@   0x0802fa92: 188a        adds	r2, r1, r2
@   0x0802fa94: 8a98        ldrh	r0, [r3, #20]
@   0x0802fa96: 1882        adds	r2, r0, r2
@   0x0802fa98: 8b9b        ldrh	r3, [r3, #28]
@   0x0802fa9a: 189a        adds	r2, r3, r2
@   0x0802fa9c: 0412        lsls	r2, r2, #16
@   0x0802fa9e: 0c12        lsrs	r2, r2, #16
@   0x0802faa0: 6820        ldr	r0, [r4, #0]
@   0x0802faa2: 0a11        lsrs	r1, r2, #8
@   0x0802faa4: 0612        lsls	r2, r2, #24
@   0x0802faa6: 0e12        lsrs	r2, r2, #24
@   0x0802faa8: f000        fb8c 	bl	0x301c4
@   0x0802faac: 82a0        strh	r0, [r4, #20]
@   0x0802faae: bc10        pop	{r4}
@   0x0802fab0: bc01        pop	{r0}
@   0x0802fab2: 4700        bx	r0
@   0x0802fab4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802fab6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802FA60
sub_0802FA60: @ 0x0802fa60
        .incbin "frog_us_baserom.gba", 0x2fa60, 0x58
        thumb_func_end sub_0802FA60
