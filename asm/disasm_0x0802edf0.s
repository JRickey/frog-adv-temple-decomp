@ Refined Thumb listing for sub_0802EDF0.
@ Range: [0x0802edf0, 0x0802eef8)  (264 bytes)

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0802EDF0
sub_0802EDF0: @ 0x0802edf0
        push    {r4, r5, r6, r7, lr}
        mov     r7, sl
        mov     r6, r9
        mov     r5, r8
        push    {r5, r6, r7}
        movs    r0, #0
        mov     r9, r0
        ldr     r1, _0802EE08            @ =gpSoundSystem (0x030065e0)
        ldr     r0, [r1, #0]
        mov     sl, r1
        b       _0802EEE4
        .align  2, 0
_0802EE08: .4byte 0x030065e0
_0802EE0C:
        ldr     r4, [r1, #0]
        adds    r0, r4, #0
        adds    r0, #0xcc
        ldr     r0, [r0, #0]
        mov     r1, r9
        lsls    r3, r1, #2
        adds    r0, r3, r0
        ldr     r2, [r0, #0]
        cmp     r2, #0
        beq     _0802EEDC
        ldr     r0, [r2, #0x38]
        movs    r1, #0x80
        lsls    r1, r1, #4
        ands    r0, r1
        cmp     r0, #0
        beq     _0802EEDC
        adds    r0, r4, #0
        adds    r0, #0xc4
        ldr     r0, [r0, #0]
        adds    r0, r3, r0
        ldr     r7, [r0, #0]
        cmp     r7, #0
        beq     _0802EEDC
        adds    r3, r2, #0
        adds    r3, #0x2c
        ldrb    r0, [r3, #7]
        cmp     r0, #0
        bne     _0802EED8
        ldrb    r0, [r3, #6]
        strb    r0, [r3, #7]
        ldrh    r0, [r3, #4]
        adds    r6, r0, #0
        cmp     r6, #0
        bne     _0802EE76
        ldr     r1, [r2, #0x38]
        movs    r0, #0x80
        lsls    r0, r0, #7
        ands    r0, r1
        cmp     r0, #0
        beq     _0802EE68
        ldrh    r0, [r3, #2]
        strh    r0, [r3, #4]
        ldrh    r1, [r2, #0x2c]
        negs    r0, r1
        strh    r0, [r2, #0x2c]
        b       _0802EE6E
_0802EE68:
        ldr     r0, _0802EEA4            @ =0xffffb7ff
        ands    r1, r0
        str     r1, [r2, #0x38]
_0802EE6E:
        ldrh    r0, [r3, #4]
        adds    r6, r0, #0
        cmp     r6, #0
        beq     _0802EEDC
_0802EE76:
        movs    r1, #0
        ldrsh   r0, [r3, r1]
        ldr     r1, [r7, #0xc]
        adds    r5, r1, r0
        movs    r0, #0
        mov     r8, r0
        ldr     r4, [r7, #0]
        adds    r2, r4, #0
        adds    r2, #0x10
        ldr     r0, [r7, #8]
        mov     ip, r1
        cmp     ip, r0
        bhi     _0802EEA8
        cmp     r5, r2
        bcc     _0802EEC2
        ldr     r1, [r7, #0x10]
        adds    r1, r5, r1
        ldr     r0, [r4, #0]
        adds    r0, r2, r0
        cmp     r1, r0
        bls     _0802EEBC
        b       _0802EEC2
        .align  2, 0
_0802EEA4: .4byte 0xffffb7ff
_0802EEA8:
        ldr     r0, [r7, #0x10]
        subs    r0, r5, r0
        cmp     r0, r2
        bcc     _0802EEB8
        ldr     r0, [r4, #0]
        adds    r0, r2, r0
        cmp     r5, r0
        bls     _0802EEBC
_0802EEB8:
        movs    r1, #1
        mov     r8, r1
_0802EEBC:
        mov     r0, r8
        cmp     r0, #0
        beq     _0802EED0
_0802EEC2:
        mov     r5, ip
        ldrh    r1, [r3, #2]
        subs    r0, r1, r6
        movs    r1, #0
        strh    r0, [r3, #2]
        strh    r1, [r3, #4]
        b       _0802EED4
_0802EED0:
        subs    r0, r6, #1
        strh    r0, [r3, #4]
_0802EED4:
        str     r5, [r7, #0xc]
        b       _0802EEDC
_0802EED8:
        subs    r0, #1
        strb    r0, [r3, #7]
_0802EEDC:
        movs    r0, #1
        add     r9, r0
        mov     r1, sl
        ldr     r0, [r1, #0]
_0802EEE4:
        ldrb    r0, [r0, #0]
        cmp     r9, r0
        blt     _0802EE0C
        pop     {r3, r4, r5}
        mov     r8, r3
        mov     r9, r4
        mov     sl, r5
        pop     {r4, r5, r6, r7}
        pop     {r0}
        bx      r0
        thumb_func_end sub_0802EDF0
