@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800cfdc, 0x0800d028)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800cfdc --end 0x800d028 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800cfdc: b570        push	{r4, r5, r6, lr}
@   0x0800cfde: 1c04        adds	r4, r0, #0
@   0x0800cfe0: 9804        ldr	r0, [sp, #16]
@   0x0800cfe2: 0412        lsls	r2, r2, #16
@   0x0800cfe4: 0c15        lsrs	r5, r2, #16
@   0x0800cfe6: 041b        lsls	r3, r3, #16
@   0x0800cfe8: 0c1b        lsrs	r3, r3, #16
@   0x0800cfea: 0400        lsls	r0, r0, #16
@   0x0800cfec: 0c06        lsrs	r6, r0, #16
@   0x0800cfee: 2202        movs	r2, #2
@   0x0800cff0: 5ea0        ldrsh	r0, [r4, r2]
@   0x0800cff2: 0409        lsls	r1, r1, #16
@   0x0800cff4: 140a        asrs	r2, r1, #16
@   0x0800cff6: 4290        cmp	r0, r2
@   0x0800cff8: dd12        ble.n	0xd020
@   0x0800cffa: 1c01        adds	r1, r0, #0
@   0x0800cffc: 0418        lsls	r0, r3, #16
@   0x0800cffe: 1400        asrs	r0, r0, #16
@   0x0800d000: 1810        adds	r0, r2, r0
@   0x0800d002: 4281        cmp	r1, r0
@   0x0800d004: da0c        bge.n	0xd020
@   0x0800d006: 2204        movs	r2, #4
@   0x0800d008: 5ea1        ldrsh	r1, [r4, r2]
@   0x0800d00a: 0428        lsls	r0, r5, #16
@   0x0800d00c: 1402        asrs	r2, r0, #16
@   0x0800d00e: 4291        cmp	r1, r2
@   0x0800d010: dd06        ble.n	0xd020
@   0x0800d012: 0430        lsls	r0, r6, #16
@   0x0800d014: 1400        asrs	r0, r0, #16
@   0x0800d016: 1810        adds	r0, r2, r0
@   0x0800d018: 4281        cmp	r1, r0
@   0x0800d01a: da01        bge.n	0xd020
@   0x0800d01c: 2001        movs	r0, #1
@   0x0800d01e: e000        b.n	0xd022
@   0x0800d020: 2000        movs	r0, #0
@   0x0800d022: bc70        pop	{r4, r5, r6}
@   0x0800d024: bc02        pop	{r1}
@   0x0800d026: 4708        bx	r1

        thumb_func_start sub_0800CFDC
sub_0800CFDC: @ 0x0800cfdc
        .incbin "frog_us_baserom.gba", 0xcfdc, 0x4c
        thumb_func_end sub_0800CFDC
