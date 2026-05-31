@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802abb0, 0x0802ac60)  (176 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802abb0 --end 0x802ac60 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802abb0: b500        push	{lr}
@   0x0802abb2: b083        sub	sp, #12
@   0x0802abb4: 4907        ldr	r1, [pc, #28]	@ (0x2abd4)
@   0x0802abb6: 4808        ldr	r0, [pc, #32]	@ (0x2abd8)
@   0x0802abb8: 9000        str	r0, [sp, #0]
@   0x0802abba: 2003        movs	r0, #3
@   0x0802abbc: 9001        str	r0, [sp, #4]
@   0x0802abbe: 2000        movs	r0, #0
@   0x0802abc0: 9002        str	r0, [sp, #8]
@   0x0802abc2: 200c        movs	r0, #12
@   0x0802abc4: 2210        movs	r2, #16
@   0x0802abc6: 2352        movs	r3, #82	@ 0x52
@   0x0802abc8: f7f6        faba 	bl	0x21140
@   0x0802abcc: b003        add	sp, #12
@   0x0802abce: bc01        pop	{r0}
@   0x0802abd0: 4700        bx	r0
@   0x0802abd2: 0000        movs	r0, r0
@   0x0802abd4: 7ddc        ldrb	r4, [r3, #23]
@   0x0802abd6: 0831        lsrs	r1, r6, #32
@   0x0802abd8: 0101        lsls	r1, r0, #4
@   0x0802abda: 0000        movs	r0, r0
@   0x0802abdc: b530        push	{r4, r5, lr}
@   0x0802abde: f7ff        fe8d 	bl	0x2a8fc
@   0x0802abe2: f7ff        ff0b 	bl	0x2a9fc
@   0x0802abe6: 4805        ldr	r0, [pc, #20]	@ (0x2abfc)
@   0x0802abe8: 302b        adds	r0, #43	@ 0x2b
@   0x0802abea: 7800        ldrb	r0, [r0, #0]
@   0x0802abec: 2801        cmp	r0, #1
@   0x0802abee: d807        bhi.n	0x2ac00
@   0x0802abf0: f7ff        fc58 	bl	0x2a4a4
@   0x0802abf4: f7ff        fbce 	bl	0x2a394
@   0x0802abf8: e029        b.n	0x2ac4e
@   0x0802abfa: 0000        movs	r0, r0
@   0x0802abfc: 6110        str	r0, [r2, #16]
@   0x0802abfe: 0300        lsls	r0, r0, #12
@   0x0802ac00: 2000        movs	r0, #0
@   0x0802ac02: 4c16        ldr	r4, [pc, #88]	@ (0x2ac5c)
@   0x0802ac04: 2308        movs	r3, #8
@   0x0802ac06: 0602        lsls	r2, r0, #24
@   0x0802ac08: 1612        asrs	r2, r2, #24
@   0x0802ac0a: 1c11        adds	r1, r2, #0
@   0x0802ac0c: 310e        adds	r1, #14
@   0x0802ac0e: 00c8        lsls	r0, r1, #3
@   0x0802ac10: 1a40        subs	r0, r0, r1
@   0x0802ac12: 00c0        lsls	r0, r0, #3
@   0x0802ac14: 1900        adds	r0, r0, r4
@   0x0802ac16: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x0802ac18: 4319        orrs	r1, r3
@   0x0802ac1a: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0802ac1c: 3201        adds	r2, #1
@   0x0802ac1e: 0612        lsls	r2, r2, #24
@   0x0802ac20: 0e10        lsrs	r0, r2, #24
@   0x0802ac22: 1612        asrs	r2, r2, #24
@   0x0802ac24: 2a01        cmp	r2, #1
@   0x0802ac26: ddee        ble.n	0x2ac06
@   0x0802ac28: 2000        movs	r0, #0
@   0x0802ac2a: 4c0c        ldr	r4, [pc, #48]	@ (0x2ac5c)
@   0x0802ac2c: 2308        movs	r3, #8
@   0x0802ac2e: 0602        lsls	r2, r0, #24
@   0x0802ac30: 1612        asrs	r2, r2, #24
@   0x0802ac32: 1c11        adds	r1, r2, #0
@   0x0802ac34: 3110        adds	r1, #16
@   0x0802ac36: 00c8        lsls	r0, r1, #3
@   0x0802ac38: 1a40        subs	r0, r0, r1
@   0x0802ac3a: 00c0        lsls	r0, r0, #3
@   0x0802ac3c: 1900        adds	r0, r0, r4
@   0x0802ac3e: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x0802ac40: 4319        orrs	r1, r3
@   0x0802ac42: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0802ac44: 3201        adds	r2, #1
@   0x0802ac46: 0612        lsls	r2, r2, #24
@   0x0802ac48: 0e10        lsrs	r0, r2, #24
@   0x0802ac4a: 2a00        cmp	r2, #0
@   0x0802ac4c: ddef        ble.n	0x2ac2e
@   0x0802ac4e: f7ff        ff61 	bl	0x2ab14
@   0x0802ac52: f7ff        fc71 	bl	0x2a538
@   0x0802ac56: bc30        pop	{r4, r5}
@   0x0802ac58: bc01        pop	{r0}
@   0x0802ac5a: 4700        bx	r0
@   0x0802ac5c: 3720        adds	r7, #32
@   0x0802ac5e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802ABB0
sub_0802ABB0: @ 0x0802abb0
        .incbin "frog_us_baserom.gba", 0x2abb0, 0xb0
        thumb_func_end sub_0802ABB0
