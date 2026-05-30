@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080044a4, 0x08004508)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80044a4 --end 0x8004508 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080044a4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080044a6: 4647        mov	r7, r8
@   0x080044a8: b480        push	{r7}
@   0x080044aa: 1c04        adds	r4, r0, #0
@   0x080044ac: 1c0d        adds	r5, r1, #0
@   0x080044ae: 1c16        adds	r6, r2, #0
@   0x080044b0: 4698        mov	r8, r3
@   0x080044b2: 9f06        ldr	r7, [sp, #24]
@   0x080044b4: 2002        movs	r0, #2
@   0x080044b6: 1c21        adds	r1, r4, #0
@   0x080044b8: f003        f8d2 	bl	0x7660
@   0x080044bc: 2000        movs	r0, #0
@   0x080044be: 2103        movs	r1, #3
@   0x080044c0: 1c2a        adds	r2, r5, #0
@   0x080044c2: f002        ff0d 	bl	0x72e0
@   0x080044c6: 2001        movs	r0, #1
@   0x080044c8: 2104        movs	r1, #4
@   0x080044ca: 1c32        adds	r2, r6, #0
@   0x080044cc: f002        ff08 	bl	0x72e0
@   0x080044d0: f005        ff02 	bl	0xa2d8
@   0x080044d4: f7fc        fa02 	bl	0x8dc
@   0x080044d8: f005        ff26 	bl	0xa328
@   0x080044dc: f005        f80c 	bl	0x94f8
@   0x080044e0: f005        fa50 	bl	0x9984
@   0x080044e4: 4640        mov	r0, r8
@   0x080044e6: 1c39        adds	r1, r7, #0
@   0x080044e8: 9a07        ldr	r2, [sp, #28]
@   0x080044ea: 9b08        ldr	r3, [sp, #32]
@   0x080044ec: f000        f80c 	bl	0x4508
@   0x080044f0: 4904        ldr	r1, [pc, #16]	@ (0x4504)
@   0x080044f2: 6948        ldr	r0, [r1, #20]
@   0x080044f4: 3001        adds	r0, #1
@   0x080044f6: 6148        str	r0, [r1, #20]
@   0x080044f8: bc08        pop	{r3}
@   0x080044fa: 4698        mov	r8, r3
@   0x080044fc: bcf0        pop	{r4, r5, r6, r7}
@   0x080044fe: bc01        pop	{r0}
@   0x08004500: 4700        bx	r0
@   0x08004502: 0000        movs	r0, r0
@   0x08004504: 5330        strh	r0, [r6, r4]
@   0x08004506: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080044A4
sub_080044A4: @ 0x080044a4
        .incbin "frog_us_baserom.gba", 0x44a4, 0x64
        thumb_func_end sub_080044A4
