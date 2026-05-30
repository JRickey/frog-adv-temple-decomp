@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080090fc, 0x08009140)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80090fc --end 0x8009140 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080090fc: b530        push	{r4, r5, lr}
@   0x080090fe: b086        sub	sp, #24
@   0x08009100: 1c04        adds	r4, r0, #0
@   0x08009102: 1c0d        adds	r5, r1, #0
@   0x08009104: 0612        lsls	r2, r2, #24
@   0x08009106: 0e12        lsrs	r2, r2, #24
@   0x08009108: 061b        lsls	r3, r3, #24
@   0x0800910a: 0e1b        lsrs	r3, r3, #24
@   0x0800910c: 480b        ldr	r0, [pc, #44]	@ (0x913c)
@   0x0800910e: 0424        lsls	r4, r4, #16
@   0x08009110: 1424        asrs	r4, r4, #16
@   0x08009112: 042d        lsls	r5, r5, #16
@   0x08009114: 142d        asrs	r5, r5, #16
@   0x08009116: 2103        movs	r1, #3
@   0x08009118: 9100        str	r1, [sp, #0]
@   0x0800911a: 2101        movs	r1, #1
@   0x0800911c: 9101        str	r1, [sp, #4]
@   0x0800911e: 2100        movs	r1, #0
@   0x08009120: 9102        str	r1, [sp, #8]
@   0x08009122: 9203        str	r2, [sp, #12]
@   0x08009124: 9304        str	r3, [sp, #16]
@   0x08009126: 2110        movs	r1, #16
@   0x08009128: 9105        str	r1, [sp, #20]
@   0x0800912a: 2100        movs	r1, #0
@   0x0800912c: 1c22        adds	r2, r4, #0
@   0x0800912e: 1c2b        adds	r3, r5, #0
@   0x08009130: f001        faee 	bl	0xa710
@   0x08009134: b006        add	sp, #24
@   0x08009136: bc30        pop	{r4, r5}
@   0x08009138: bc01        pop	{r0}
@   0x0800913a: 4700        bx	r0
@   0x0800913c: 3720        adds	r7, #32
@   0x0800913e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080090FC
sub_080090FC: @ 0x080090fc
        .incbin "frog_us_baserom.gba", 0x90fc, 0x44
        thumb_func_end sub_080090FC
