@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800de80, 0x0800df7c)  (252 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800de80 --end 0x800df7c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800de80: b510        push	{r4, lr}
@   0x0800de82: 4c0a        ldr	r4, [pc, #40]	@ (0xdeac)
@   0x0800de84: f7ff        fee4 	bl	0xdc50
@   0x0800de88: f000        f878 	bl	0xdf7c
@   0x0800de8c: f01f        fd34 	bl	0x2d8f8
@   0x0800de90: 4907        ldr	r1, [pc, #28]	@ (0xdeb0)
@   0x0800de92: 20fd        movs	r0, #253	@ 0xfd
@   0x0800de94: 780a        ldrb	r2, [r1, #0]
@   0x0800de96: 4010        ands	r0, r2
@   0x0800de98: 7008        strb	r0, [r1, #0]
@   0x0800de9a: 7aa0        ldrb	r0, [r4, #10]
@   0x0800de9c: 3801        subs	r0, #1
@   0x0800de9e: 280f        cmp	r0, #15
@   0x0800dea0: d831        bhi.n	0xdf06
@   0x0800dea2: 0080        lsls	r0, r0, #2
@   0x0800dea4: 4903        ldr	r1, [pc, #12]	@ (0xdeb4)
@   0x0800dea6: 1840        adds	r0, r0, r1
@   0x0800dea8: 6800        ldr	r0, [r0, #0]
@   0x0800deaa: 4687        mov	pc, r0
@   0x0800deac: 5330        strh	r0, [r6, r4]
@   0x0800deae: 0300        lsls	r0, r0, #12
@   0x0800deb0: 3570        adds	r5, #112	@ 0x70
@   0x0800deb2: 0300        lsls	r0, r0, #12
@   0x0800deb4: deb8        udf	#184	@ 0xb8
@   0x0800deb6: 0800        lsrs	r0, r0, #32
@   0x0800deb8: def8        udf	#248	@ 0xf8
@   0x0800deba: 0800        lsrs	r0, r0, #32
@   0x0800debc: def8        udf	#248	@ 0xf8
@   0x0800debe: 0800        lsrs	r0, r0, #32
@   0x0800dec0: df00        svc	0
@   0x0800dec2: 0800        lsrs	r0, r0, #32
@   0x0800dec4: def8        udf	#248	@ 0xf8
@   0x0800dec6: 0800        lsrs	r0, r0, #32
@   0x0800dec8: def8        udf	#248	@ 0xf8
@   0x0800deca: 0800        lsrs	r0, r0, #32
@   0x0800decc: df00        svc	0
@   0x0800dece: 0800        lsrs	r0, r0, #32
@   0x0800ded0: def8        udf	#248	@ 0xf8
@   0x0800ded2: 0800        lsrs	r0, r0, #32
@   0x0800ded4: def8        udf	#248	@ 0xf8
@   0x0800ded6: 0800        lsrs	r0, r0, #32
@   0x0800ded8: df00        svc	0
@   0x0800deda: 0800        lsrs	r0, r0, #32
@   0x0800dedc: def8        udf	#248	@ 0xf8
@   0x0800dede: 0800        lsrs	r0, r0, #32
@   0x0800dee0: def8        udf	#248	@ 0xf8
@   0x0800dee2: 0800        lsrs	r0, r0, #32
@   0x0800dee4: df00        svc	0
@   0x0800dee6: 0800        lsrs	r0, r0, #32
@   0x0800dee8: def8        udf	#248	@ 0xf8
@   0x0800deea: 0800        lsrs	r0, r0, #32
@   0x0800deec: def8        udf	#248	@ 0xf8
@   0x0800deee: 0800        lsrs	r0, r0, #32
@   0x0800def0: def8        udf	#248	@ 0xf8
@   0x0800def2: 0800        lsrs	r0, r0, #32
@   0x0800def4: df00        svc	0
@   0x0800def6: 0800        lsrs	r0, r0, #32
@   0x0800def8: 2002        movs	r0, #2
@   0x0800defa: f012        fe45 	bl	0x20b88
@   0x0800defe: e002        b.n	0xdf06
@   0x0800df00: 2001        movs	r0, #1
@   0x0800df02: f012        fe41 	bl	0x20b88
@   0x0800df06: 4805        ldr	r0, [pc, #20]	@ (0xdf1c)
@   0x0800df08: 7a80        ldrb	r0, [r0, #10]
@   0x0800df0a: 3801        subs	r0, #1
@   0x0800df0c: 280f        cmp	r0, #15
@   0x0800df0e: d830        bhi.n	0xdf72
@   0x0800df10: 0080        lsls	r0, r0, #2
@   0x0800df12: 4903        ldr	r1, [pc, #12]	@ (0xdf20)
@   0x0800df14: 1840        adds	r0, r0, r1
@   0x0800df16: 6800        ldr	r0, [r0, #0]
@   0x0800df18: 4687        mov	pc, r0
@   0x0800df1a: 0000        movs	r0, r0
@   0x0800df1c: 5330        strh	r0, [r6, r4]
@   0x0800df1e: 0300        lsls	r0, r0, #12
@   0x0800df20: df24        svc	36	@ 0x24
@   0x0800df22: 0800        lsrs	r0, r0, #32
@   0x0800df24: df64        svc	100	@ 0x64
@   0x0800df26: 0800        lsrs	r0, r0, #32
@   0x0800df28: df64        svc	100	@ 0x64
@   0x0800df2a: 0800        lsrs	r0, r0, #32
@   0x0800df2c: df6c        svc	108	@ 0x6c
@   0x0800df2e: 0800        lsrs	r0, r0, #32
@   0x0800df30: df64        svc	100	@ 0x64
@   0x0800df32: 0800        lsrs	r0, r0, #32
@   0x0800df34: df64        svc	100	@ 0x64
@   0x0800df36: 0800        lsrs	r0, r0, #32
@   0x0800df38: df6c        svc	108	@ 0x6c
@   0x0800df3a: 0800        lsrs	r0, r0, #32
@   0x0800df3c: df64        svc	100	@ 0x64
@   0x0800df3e: 0800        lsrs	r0, r0, #32
@   0x0800df40: df64        svc	100	@ 0x64
@   0x0800df42: 0800        lsrs	r0, r0, #32
@   0x0800df44: df6c        svc	108	@ 0x6c
@   0x0800df46: 0800        lsrs	r0, r0, #32
@   0x0800df48: df64        svc	100	@ 0x64
@   0x0800df4a: 0800        lsrs	r0, r0, #32
@   0x0800df4c: df64        svc	100	@ 0x64
@   0x0800df4e: 0800        lsrs	r0, r0, #32
@   0x0800df50: df6c        svc	108	@ 0x6c
@   0x0800df52: 0800        lsrs	r0, r0, #32
@   0x0800df54: df64        svc	100	@ 0x64
@   0x0800df56: 0800        lsrs	r0, r0, #32
@   0x0800df58: df64        svc	100	@ 0x64
@   0x0800df5a: 0800        lsrs	r0, r0, #32
@   0x0800df5c: df72        svc	114	@ 0x72
@   0x0800df5e: 0800        lsrs	r0, r0, #32
@   0x0800df60: df6c        svc	108	@ 0x6c
@   0x0800df62: 0800        lsrs	r0, r0, #32
@   0x0800df64: 2001        movs	r0, #1
@   0x0800df66: f00d        fdf5 	bl	0x1bb54
@   0x0800df6a: e002        b.n	0xdf72
@   0x0800df6c: 2002        movs	r0, #2
@   0x0800df6e: f00d        fdf1 	bl	0x1bb54
@   0x0800df72: f7ff        ff05 	bl	0xdd80
@   0x0800df76: bc10        pop	{r4}
@   0x0800df78: bc01        pop	{r0}
@   0x0800df7a: 4700        bx	r0

        thumb_func_start sub_0800DE80
sub_0800DE80: @ 0x0800de80
        .incbin "frog_us_baserom.gba", 0xde80, 0xfc
        thumb_func_end sub_0800DE80
