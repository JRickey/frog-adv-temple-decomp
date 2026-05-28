@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08005f50, 0x08005fc8)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8005f50 --end 0x8005fc8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08005f50: 0600        lsls	r0, r0, #24
@   0x08005f52: 0e00        lsrs	r0, r0, #24
@   0x08005f54: 1c02        adds	r2, r0, #0
@   0x08005f56: 0609        lsls	r1, r1, #24
@   0x08005f58: 0e09        lsrs	r1, r1, #24
@   0x08005f5a: 2801        cmp	r0, #1
@   0x08005f5c: d012        beq.n	0x5f84
@   0x08005f5e: 2801        cmp	r0, #1
@   0x08005f60: dc02        bgt.n	0x5f68
@   0x08005f62: 2800        cmp	r0, #0
@   0x08005f64: d003        beq.n	0x5f6e
@   0x08005f66: e02d        b.n	0x5fc4
@   0x08005f68: 2a02        cmp	r2, #2
@   0x08005f6a: d019        beq.n	0x5fa0
@   0x08005f6c: e02a        b.n	0x5fc4
@   0x08005f6e: 2901        cmp	r1, #1
@   0x08005f70: d022        beq.n	0x5fb8
@   0x08005f72: 2901        cmp	r1, #1
@   0x08005f74: dc02        bgt.n	0x5f7c
@   0x08005f76: 2900        cmp	r1, #0
@   0x08005f78: d010        beq.n	0x5f9c
@   0x08005f7a: e003        b.n	0x5f84
@   0x08005f7c: 2902        cmp	r1, #2
@   0x08005f7e: d01d        beq.n	0x5fbc
@   0x08005f80: 2903        cmp	r1, #3
@   0x08005f82: d01d        beq.n	0x5fc0
@   0x08005f84: 2901        cmp	r1, #1
@   0x08005f86: d009        beq.n	0x5f9c
@   0x08005f88: 2901        cmp	r1, #1
@   0x08005f8a: dc02        bgt.n	0x5f92
@   0x08005f8c: 2900        cmp	r1, #0
@   0x08005f8e: d005        beq.n	0x5f9c
@   0x08005f90: e006        b.n	0x5fa0
@   0x08005f92: 2902        cmp	r1, #2
@   0x08005f94: d010        beq.n	0x5fb8
@   0x08005f96: 2903        cmp	r1, #3
@   0x08005f98: d010        beq.n	0x5fbc
@   0x08005f9a: e001        b.n	0x5fa0
@   0x08005f9c: 2008        movs	r0, #8
@   0x08005f9e: e012        b.n	0x5fc6
@   0x08005fa0: 2901        cmp	r1, #1
@   0x08005fa2: d00b        beq.n	0x5fbc
@   0x08005fa4: 2901        cmp	r1, #1
@   0x08005fa6: dc02        bgt.n	0x5fae
@   0x08005fa8: 2900        cmp	r1, #0
@   0x08005faa: d005        beq.n	0x5fb8
@   0x08005fac: e00a        b.n	0x5fc4
@   0x08005fae: 2902        cmp	r1, #2
@   0x08005fb0: d004        beq.n	0x5fbc
@   0x08005fb2: 2903        cmp	r1, #3
@   0x08005fb4: d004        beq.n	0x5fc0
@   0x08005fb6: e005        b.n	0x5fc4
@   0x08005fb8: 2010        movs	r0, #16
@   0x08005fba: e004        b.n	0x5fc6
@   0x08005fbc: 2020        movs	r0, #32
@   0x08005fbe: e002        b.n	0x5fc6
@   0x08005fc0: 2040        movs	r0, #64	@ 0x40
@   0x08005fc2: e000        b.n	0x5fc6
@   0x08005fc4: 20ff        movs	r0, #255	@ 0xff
@   0x08005fc6: 4770        bx	lr

        thumb_func_start sub_08005F50
sub_08005F50: @ 0x08005f50
        .incbin "frog_us_baserom.gba", 0x5f50, 0x78
        thumb_func_end sub_08005F50
