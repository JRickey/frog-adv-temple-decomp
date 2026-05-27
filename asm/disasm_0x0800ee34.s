@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ee34, 0x0800ee94)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ee34 --end 0x800ee94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ee34: 0600        lsls	r0, r0, #24
@   0x0800ee36: 0e00        lsrs	r0, r0, #24
@   0x0800ee38: 1c01        adds	r1, r0, #0
@   0x0800ee3a: 2801        cmp	r0, #1
@   0x0800ee3c: d010        beq.n	0xee60
@   0x0800ee3e: 2801        cmp	r0, #1
@   0x0800ee40: dc02        bgt.n	0xee48
@   0x0800ee42: 2800        cmp	r0, #0
@   0x0800ee44: d005        beq.n	0xee52
@   0x0800ee46: e021        b.n	0xee8c
@   0x0800ee48: 2902        cmp	r1, #2
@   0x0800ee4a: d011        beq.n	0xee70
@   0x0800ee4c: 2903        cmp	r1, #3
@   0x0800ee4e: d017        beq.n	0xee80
@   0x0800ee50: e01c        b.n	0xee8c
@   0x0800ee52: 2280        movs	r2, #128	@ 0x80
@   0x0800ee54: 04d2        lsls	r2, r2, #19
@   0x0800ee56: 8811        ldrh	r1, [r2, #0]
@   0x0800ee58: 4800        ldr	r0, [pc, #0]	@ (0xee5c)
@   0x0800ee5a: e015        b.n	0xee88
@   0x0800ee5c: feff        0000 			@ <UNDEFINED> instruction: 0xfeff0000
@   0x0800ee60: 2280        movs	r2, #128	@ 0x80
@   0x0800ee62: 04d2        lsls	r2, r2, #19
@   0x0800ee64: 8811        ldrh	r1, [r2, #0]
@   0x0800ee66: 4801        ldr	r0, [pc, #4]	@ (0xee6c)
@   0x0800ee68: e00e        b.n	0xee88
@   0x0800ee6a: 0000        movs	r0, r0
@   0x0800ee6c: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x0800ee70: 2280        movs	r2, #128	@ 0x80
@   0x0800ee72: 04d2        lsls	r2, r2, #19
@   0x0800ee74: 8811        ldrh	r1, [r2, #0]
@   0x0800ee76: 4801        ldr	r0, [pc, #4]	@ (0xee7c)
@   0x0800ee78: e006        b.n	0xee88
@   0x0800ee7a: 0000        movs	r0, r0
@   0x0800ee7c: fbff        0000 			@ <UNDEFINED> instruction: 0xfbff0000
@   0x0800ee80: 2280        movs	r2, #128	@ 0x80
@   0x0800ee82: 04d2        lsls	r2, r2, #19
@   0x0800ee84: 8811        ldrh	r1, [r2, #0]
@   0x0800ee86: 4802        ldr	r0, [pc, #8]	@ (0xee90)
@   0x0800ee88: 4008        ands	r0, r1
@   0x0800ee8a: 8010        strh	r0, [r2, #0]
@   0x0800ee8c: 4770        bx	lr
@   0x0800ee8e: 0000        movs	r0, r0
@   0x0800ee90: f7ff        0000 			@ <UNDEFINED> instruction: 0xf7ff0000

        thumb_func_start sub_0800EE34
sub_0800EE34: @ 0x0800ee34
        .incbin "frog_us_baserom.gba", 0xee34, 0x60
        thumb_func_end sub_0800EE34
