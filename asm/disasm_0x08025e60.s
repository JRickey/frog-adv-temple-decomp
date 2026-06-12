@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025e60, 0x08025eb4)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025e60 --end 0x8025eb4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025e60: b570        push	{r4, r5, r6, lr}
@   0x08025e62: b084        sub	sp, #16
@   0x08025e64: 2600        movs	r6, #0
@   0x08025e66: 1c35        adds	r5, r6, #0
@   0x08025e68: 352d        adds	r5, #45	@ 0x2d
@   0x08025e6a: 4911        ldr	r1, [pc, #68]	@ (0x25eb0)
@   0x08025e6c: 00b0        lsls	r0, r6, #2
@   0x08025e6e: 1840        adds	r0, r0, r1
@   0x08025e70: 6804        ldr	r4, [r0, #0]
@   0x08025e72: 1c30        adds	r0, r6, #0
@   0x08025e74: 210c        movs	r1, #12
@   0x08025e76: f00e        f871 	bl	0x33f5c
@   0x08025e7a: 0600        lsls	r0, r0, #24
@   0x08025e7c: 0900        lsrs	r0, r0, #4
@   0x08025e7e: 21b1        movs	r1, #177	@ 0xb1
@   0x08025e80: 0409        lsls	r1, r1, #16
@   0x08025e82: 1840        adds	r0, r0, r1
@   0x08025e84: 0c00        lsrs	r0, r0, #16
@   0x08025e86: 9000        str	r0, [sp, #0]
@   0x08025e88: 2005        movs	r0, #5
@   0x08025e8a: 9001        str	r0, [sp, #4]
@   0x08025e8c: 2003        movs	r0, #3
@   0x08025e8e: 9002        str	r0, [sp, #8]
@   0x08025e90: 9003        str	r0, [sp, #12]
@   0x08025e92: 1c28        adds	r0, r5, #0
@   0x08025e94: 1c21        adds	r1, r4, #0
@   0x08025e96: 2210        movs	r2, #16
@   0x08025e98: 2320        movs	r3, #32
@   0x08025e9a: f7fb        f901 	bl	0x210a0
@   0x08025e9e: 1c70        adds	r0, r6, #1
@   0x08025ea0: 0600        lsls	r0, r0, #24
@   0x08025ea2: 0e06        lsrs	r6, r0, #24
@   0x08025ea4: 2e12        cmp	r6, #18
@   0x08025ea6: d9de        bls.n	0x25e66
@   0x08025ea8: b004        add	sp, #16
@   0x08025eaa: bc70        pop	{r4, r5, r6}
@   0x08025eac: bc01        pop	{r0}
@   0x08025eae: 4700        bx	r0
@   0x08025eb0: 4a78        ldr	r2, [pc, #480]	@ (0x26094)
@   0x08025eb2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025E60
sub_08025E60: @ 0x08025e60
        .incbin "baserom.gba", 0x25e60, 0x54
        thumb_func_end sub_08025E60
