@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08014020, 0x08014064)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8014020 --end 0x8014064 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08014020: b500        push	{lr}
@   0x08014022: 2002        movs	r0, #2
@   0x08014024: f7fa        fc1a 	bl	0xe85c
@   0x08014028: f7fa        fd78 	bl	0xeb1c
@   0x0801402c: 4909        ldr	r1, [pc, #36]	@ (0x14054)
@   0x0801402e: 2000        movs	r0, #0
@   0x08014030: 7288        strb	r0, [r1, #10]
@   0x08014032: f7fd        f933 	bl	0x1129c
@   0x08014036: 2006        movs	r0, #6
@   0x08014038: 2102        movs	r1, #2
@   0x0801403a: f7fc        fc8d 	bl	0x10958
@   0x0801403e: 2002        movs	r0, #2
@   0x08014040: f7fb        f904 	bl	0xf24c
@   0x08014044: 2002        movs	r0, #2
@   0x08014046: f7fa        fdc9 	bl	0xebdc
@   0x0801404a: f002        fcf9 	bl	0x16a40
@   0x0801404e: bc01        pop	{r0}
@   0x08014050: 4700        bx	r0
@   0x08014052: 0000        movs	r0, r0
@   0x08014054: 6500        str	r0, [r0, #80]	@ 0x50
@   0x08014056: 0300        lsls	r0, r0, #12
@   0x08014058: 4901        ldr	r1, [pc, #4]	@ (0x14060)
@   0x0801405a: 2000        movs	r0, #0
@   0x0801405c: 7288        strb	r0, [r1, #10]
@   0x0801405e: 4770        bx	lr
@   0x08014060: 6500        str	r0, [r0, #80]	@ 0x50
@   0x08014062: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08014020
sub_08014020: @ 0x08014020
        .incbin "frog_us_baserom.gba", 0x14020, 0x44
        thumb_func_end sub_08014020
