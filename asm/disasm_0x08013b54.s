@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013b54, 0x08013ba4)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013b54 --end 0x8013ba4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013b54: b500        push	{lr}
@   0x08013b56: 490e        ldr	r1, [pc, #56]	@ (0x13b90)
@   0x08013b58: 2200        movs	r2, #0
@   0x08013b5a: 2302        movs	r3, #2
@   0x08013b5c: 730b        strb	r3, [r1, #12]
@   0x08013b5e: 2003        movs	r0, #3
@   0x08013b60: 7008        strb	r0, [r1, #0]
@   0x08013b62: 604a        str	r2, [r1, #4]
@   0x08013b64: 480b        ldr	r0, [pc, #44]	@ (0x13b94)
@   0x08013b66: 6042        str	r2, [r0, #4]
@   0x08013b68: 2110        movs	r1, #16
@   0x08013b6a: 7301        strb	r1, [r0, #12]
@   0x08013b6c: 7003        strb	r3, [r0, #0]
@   0x08013b6e: 490a        ldr	r1, [pc, #40]	@ (0x13b98)
@   0x08013b70: 2301        movs	r3, #1
@   0x08013b72: 2001        movs	r0, #1
@   0x08013b74: 7008        strb	r0, [r1, #0]
@   0x08013b76: 4809        ldr	r0, [pc, #36]	@ (0x13b9c)
@   0x08013b78: 7282        strb	r2, [r0, #10]
@   0x08013b7a: 4809        ldr	r0, [pc, #36]	@ (0x13ba0)
@   0x08013b7c: 3040        adds	r0, #64	@ 0x40
@   0x08013b7e: 7801        ldrb	r1, [r0, #0]
@   0x08013b80: 4319        orrs	r1, r3
@   0x08013b82: 7001        strb	r1, [r0, #0]
@   0x08013b84: 2002        movs	r0, #2
@   0x08013b86: f7fb        f955 	bl	0xee34
@   0x08013b8a: bc01        pop	{r0}
@   0x08013b8c: 4700        bx	r0
@   0x08013b8e: 0000        movs	r0, r0
@   0x08013b90: 6410        str	r0, [r2, #64]	@ 0x40
@   0x08013b92: 0300        lsls	r0, r0, #12
@   0x08013b94: 6400        str	r0, [r0, #64]	@ 0x40
@   0x08013b96: 0300        lsls	r0, r0, #12
@   0x08013b98: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08013b9a: 0300        lsls	r0, r0, #12
@   0x08013b9c: 6500        str	r0, [r0, #80]	@ 0x50
@   0x08013b9e: 0300        lsls	r0, r0, #12
@   0x08013ba0: 60a0        str	r0, [r4, #8]
@   0x08013ba2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013B54
sub_08013B54: @ 0x08013b54
        .incbin "frog_us_baserom.gba", 0x13b54, 0x50
        thumb_func_end sub_08013B54
