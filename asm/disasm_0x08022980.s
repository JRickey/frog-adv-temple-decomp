@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022980, 0x080229a4)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022980 --end 0x80229a4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022980: b500        push	{lr}
@   0x08022982: b081        sub	sp, #4
@   0x08022984: 4905        ldr	r1, [pc, #20]	@ (0x2299c)
@   0x08022986: 4b06        ldr	r3, [pc, #24]	@ (0x229a0)
@   0x08022988: 2014        movs	r0, #20
@   0x0802298a: 9000        str	r0, [sp, #0]
@   0x0802298c: 2002        movs	r0, #2
@   0x0802298e: 2202        movs	r2, #2
@   0x08022990: f7fe        fdbe 	bl	0x21510
@   0x08022994: b001        add	sp, #4
@   0x08022996: bc01        pop	{r0}
@   0x08022998: 4700        bx	r0
@   0x0802299a: 0000        movs	r0, r0
@   0x0802299c: 1418        asrs	r0, r3, #16
@   0x0802299e: 0831        lsrs	r1, r6, #32
@   0x080229a0: 6110        str	r0, [r2, #16]
@   0x080229a2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08022980
sub_08022980: @ 0x08022980
        .incbin "frog_us_baserom.gba", 0x22980, 0x24
        thumb_func_end sub_08022980
