@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000764, 0x08000790)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000764 --end 0x8000790 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000764: b500        push	{lr}
@   0x08000766: 1c01        adds	r1, r0, #0
@   0x08000768: 0609        lsls	r1, r1, #24
@   0x0800076a: 0e09        lsrs	r1, r1, #24
@   0x0800076c: 4b06        ldr	r3, [pc, #24]	@ (0x788)
@   0x0800076e: 69da        ldr	r2, [r3, #28]
@   0x08000770: 206d        movs	r0, #109	@ 0x6d
@   0x08000772: 4350        muls	r0, r2
@   0x08000774: 4a05        ldr	r2, [pc, #20]	@ (0x78c)
@   0x08000776: 1880        adds	r0, r0, r2
@   0x08000778: 61d8        str	r0, [r3, #28]
@   0x0800077a: f033        fbef 	bl	0x33f5c
@   0x0800077e: 0600        lsls	r0, r0, #24
@   0x08000780: 0e00        lsrs	r0, r0, #24
@   0x08000782: bc02        pop	{r1}
@   0x08000784: 4708        bx	r1
@   0x08000786: 0000        movs	r0, r0
@   0x08000788: 5330        strh	r0, [r6, r4]
@   0x0800078a: 0300        lsls	r0, r0, #12
@   0x0800078c: 03fd        lsls	r5, r7, #15

        thumb_func_start sub_08000764
sub_08000764: @ 0x08000764
        .incbin "frog_us_baserom.gba", 0x764, 0x2c
        thumb_func_end sub_08000764
