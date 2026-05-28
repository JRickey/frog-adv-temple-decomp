@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08005ed8, 0x08005f50)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8005ed8 --end 0x8005f50 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08005ed8: 0600        lsls	r0, r0, #24
@   0x08005eda: 0e00        lsrs	r0, r0, #24
@   0x08005edc: 1c02        adds	r2, r0, #0
@   0x08005ede: 0609        lsls	r1, r1, #24
@   0x08005ee0: 0e09        lsrs	r1, r1, #24
@   0x08005ee2: 2801        cmp	r0, #1
@   0x08005ee4: d012        beq.n	0x5f0c
@   0x08005ee6: 2801        cmp	r0, #1
@   0x08005ee8: dc02        bgt.n	0x5ef0
@   0x08005eea: 2800        cmp	r0, #0
@   0x08005eec: d003        beq.n	0x5ef6
@   0x08005eee: e02c        b.n	0x5f4a
@   0x08005ef0: 2a02        cmp	r2, #2
@   0x08005ef2: d018        beq.n	0x5f26
@   0x08005ef4: e029        b.n	0x5f4a
@   0x08005ef6: 2901        cmp	r1, #1
@   0x08005ef8: d023        beq.n	0x5f42
@   0x08005efa: 2901        cmp	r1, #1
@   0x08005efc: dc02        bgt.n	0x5f04
@   0x08005efe: 2900        cmp	r1, #0
@   0x08005f00: d01d        beq.n	0x5f3e
@   0x08005f02: e003        b.n	0x5f0c
@   0x08005f04: 2902        cmp	r1, #2
@   0x08005f06: d01e        beq.n	0x5f46
@   0x08005f08: 2903        cmp	r1, #3
@   0x08005f0a: d00a        beq.n	0x5f22
@   0x08005f0c: 2901        cmp	r1, #1
@   0x08005f0e: d01a        beq.n	0x5f46
@   0x08005f10: 2901        cmp	r1, #1
@   0x08005f12: dc02        bgt.n	0x5f1a
@   0x08005f14: 2900        cmp	r1, #0
@   0x08005f16: d014        beq.n	0x5f42
@   0x08005f18: e005        b.n	0x5f26
@   0x08005f1a: 2902        cmp	r1, #2
@   0x08005f1c: d013        beq.n	0x5f46
@   0x08005f1e: 2903        cmp	r1, #3
@   0x08005f20: d101        bne.n	0x5f26
@   0x08005f22: 2040        movs	r0, #64	@ 0x40
@   0x08005f24: e012        b.n	0x5f4c
@   0x08005f26: 2901        cmp	r1, #1
@   0x08005f28: d009        beq.n	0x5f3e
@   0x08005f2a: 2901        cmp	r1, #1
@   0x08005f2c: dc02        bgt.n	0x5f34
@   0x08005f2e: 2900        cmp	r1, #0
@   0x08005f30: d005        beq.n	0x5f3e
@   0x08005f32: e00a        b.n	0x5f4a
@   0x08005f34: 2902        cmp	r1, #2
@   0x08005f36: d004        beq.n	0x5f42
@   0x08005f38: 2903        cmp	r1, #3
@   0x08005f3a: d004        beq.n	0x5f46
@   0x08005f3c: e005        b.n	0x5f4a
@   0x08005f3e: 2008        movs	r0, #8
@   0x08005f40: e004        b.n	0x5f4c
@   0x08005f42: 2010        movs	r0, #16
@   0x08005f44: e002        b.n	0x5f4c
@   0x08005f46: 2020        movs	r0, #32
@   0x08005f48: e000        b.n	0x5f4c
@   0x08005f4a: 20ff        movs	r0, #255	@ 0xff
@   0x08005f4c: 4770        bx	lr

        thumb_func_start sub_08005ED8
sub_08005ED8: @ 0x08005ed8
        .incbin "frog_us_baserom.gba", 0x5ed8, 0x78
        thumb_func_end sub_08005ED8
