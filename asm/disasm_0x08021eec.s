@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08021eec, 0x08021f1c)  (48 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8021eec --end 0x8021f1c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08021eec: b530        push	{r4, r5, lr}
@   0x08021eee: 1c05        adds	r5, r0, #0
@   0x08021ef0: 060c        lsls	r4, r1, #24
@   0x08021ef2: 0e24        lsrs	r4, r4, #24
@   0x08021ef4: 1c20        adds	r0, r4, #0
@   0x08021ef6: f7ff        f821 	bl	0x20f3c
@   0x08021efa: 1c28        adds	r0, r5, #0
@   0x08021efc: 1c21        adds	r1, r4, #0
@   0x08021efe: f7ff        fd5d 	bl	0x219bc
@   0x08021f02: 00e0        lsls	r0, r4, #3
@   0x08021f04: 1b00        subs	r0, r0, r4
@   0x08021f06: 00c0        lsls	r0, r0, #3
@   0x08021f08: 4903        ldr	r1, [pc, #12]	@ (0x21f18)
@   0x08021f0a: 1840        adds	r0, r0, r1
@   0x08021f0c: f7e3        fd5a 	bl	0x59c4
@   0x08021f10: bc30        pop	{r4, r5}
@   0x08021f12: bc01        pop	{r0}
@   0x08021f14: 4700        bx	r0
@   0x08021f16: 0000        movs	r0, r0
@   0x08021f18: 3720        adds	r7, #32
@   0x08021f1a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08021EEC
sub_08021EEC: @ 0x08021eec
        .incbin "frog_us_baserom.gba", 0x21eec, 0x30
        thumb_func_end sub_08021EEC
