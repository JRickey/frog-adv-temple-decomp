@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08033910, 0x08033948)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8033910 --end 0x8033948 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08033910: 1c0a        adds	r2, r1, #0
@   0x08033912: 0600        lsls	r0, r0, #24
@   0x08033914: 0e01        lsrs	r1, r0, #24
@   0x08033916: 2903        cmp	r1, #3
@   0x08033918: d814        bhi.n	0x33944
@   0x0803391a: 4806        ldr	r0, [pc, #24]	@ (0x33934)
@   0x0803391c: 7001        strb	r1, [r0, #0]
@   0x0803391e: 4906        ldr	r1, [pc, #24]	@ (0x33938)
@   0x08033920: 7800        ldrb	r0, [r0, #0]
@   0x08033922: 0080        lsls	r0, r0, #2
@   0x08033924: 4b05        ldr	r3, [pc, #20]	@ (0x3393c)
@   0x08033926: 18c0        adds	r0, r0, r3
@   0x08033928: 6008        str	r0, [r1, #0]
@   0x0803392a: 4805        ldr	r0, [pc, #20]	@ (0x33940)
@   0x0803392c: 6010        str	r0, [r2, #0]
@   0x0803392e: 2000        movs	r0, #0
@   0x08033930: e009        b.n	0x33946
@   0x08033932: 0000        movs	r0, r0
@   0x08033934: 3430        adds	r4, #48	@ 0x30
@   0x08033936: 0300        lsls	r0, r0, #12
@   0x08033938: 3438        adds	r4, #56	@ 0x38
@   0x0803393a: 0300        lsls	r0, r0, #12
@   0x0803393c: 0100        lsls	r0, r0, #4
@   0x0803393e: 0400        lsls	r0, r0, #16
@   0x08033940: 38ed        subs	r0, #237	@ 0xed
@   0x08033942: 0803        lsrs	r3, r0, #32
@   0x08033944: 2001        movs	r0, #1
@   0x08033946: 4770        bx	lr

        thumb_func_start sub_08033910
sub_08033910: @ 0x08033910
        .incbin "frog_us_baserom.gba", 0x33910, 0x38
        thumb_func_end sub_08033910
