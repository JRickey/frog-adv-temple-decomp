@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803045c, 0x080304f4)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803045c --end 0x80304f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803045c: b570        push	{r4, r5, r6, lr}
@   0x0803045e: 1c03        adds	r3, r0, #0
@   0x08030460: 1c0d        adds	r5, r1, #0
@   0x08030462: 682e        ldr	r6, [r5, #0]
@   0x08030464: 2b03        cmp	r3, #3
@   0x08030466: dc0b        bgt.n	0x30480
@   0x08030468: 4904        ldr	r1, [pc, #16]	@ (0x3047c)
@   0x0803046a: 0098        lsls	r0, r3, #2
@   0x0803046c: 3010        adds	r0, #16
@   0x0803046e: 6809        ldr	r1, [r1, #0]
@   0x08030470: 180a        adds	r2, r1, r0
@   0x08030472: 00d8        lsls	r0, r3, #3
@   0x08030474: 308c        adds	r0, #140	@ 0x8c
@   0x08030476: 180c        adds	r4, r1, r0
@   0x08030478: e020        b.n	0x304bc
@   0x0803047a: 0000        movs	r0, r0
@   0x0803047c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803047e: 0300        lsls	r0, r0, #12
@   0x08030480: 4815        ldr	r0, [pc, #84]	@ (0x304d8)
@   0x08030482: 6801        ldr	r1, [r0, #0]
@   0x08030484: 1c08        adds	r0, r1, #0
@   0x08030486: 30cc        adds	r0, #204	@ 0xcc
@   0x08030488: 6800        ldr	r0, [r0, #0]
@   0x0803048a: 009a        lsls	r2, r3, #2
@   0x0803048c: 1810        adds	r0, r2, r0
@   0x0803048e: 3810        subs	r0, #16
@   0x08030490: 6800        ldr	r0, [r0, #0]
@   0x08030492: 2800        cmp	r0, #0
@   0x08030494: d024        beq.n	0x304e0
@   0x08030496: 1c08        adds	r0, r1, #0
@   0x08030498: 30c4        adds	r0, #196	@ 0xc4
@   0x0803049a: 6800        ldr	r0, [r0, #0]
@   0x0803049c: 1810        adds	r0, r2, r0
@   0x0803049e: 3810        subs	r0, #16
@   0x080304a0: 6800        ldr	r0, [r0, #0]
@   0x080304a2: 2800        cmp	r0, #0
@   0x080304a4: d01c        beq.n	0x304e0
@   0x080304a6: 1c08        adds	r0, r1, #0
@   0x080304a8: 30c8        adds	r0, #200	@ 0xc8
@   0x080304aa: 0199        lsls	r1, r3, #6
@   0x080304ac: 4a0b        ldr	r2, [pc, #44]	@ (0x304dc)
@   0x080304ae: 1889        adds	r1, r1, r2
@   0x080304b0: 6800        ldr	r0, [r0, #0]
@   0x080304b2: 1840        adds	r0, r0, r1
@   0x080304b4: 1c02        adds	r2, r0, #0
@   0x080304b6: 3238        adds	r2, #56	@ 0x38
@   0x080304b8: 1c04        adds	r4, r0, #0
@   0x080304ba: 3424        adds	r4, #36	@ 0x24
@   0x080304bc: 7870        ldrb	r0, [r6, #1]
@   0x080304be: 2800        cmp	r0, #0
@   0x080304c0: d00e        beq.n	0x304e0
@   0x080304c2: 6810        ldr	r0, [r2, #0]
@   0x080304c4: 2121        movs	r1, #33	@ 0x21
@   0x080304c6: 4008        ands	r0, r1
@   0x080304c8: 2800        cmp	r0, #0
@   0x080304ca: d009        beq.n	0x304e0
@   0x080304cc: 79a0        ldrb	r0, [r4, #6]
@   0x080304ce: 2800        cmp	r0, #0
@   0x080304d0: d006        beq.n	0x304e0
@   0x080304d2: 2000        movs	r0, #0
@   0x080304d4: e00b        b.n	0x304ee
@   0x080304d6: 0000        movs	r0, r0
@   0x080304d8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080304da: 0300        lsls	r0, r0, #12
@   0x080304dc: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x080304e0: 1c18        adds	r0, r3, #0
@   0x080304e2: f7fe        f91f 	bl	0x2e724
@   0x080304e6: 6828        ldr	r0, [r5, #0]
@   0x080304e8: 3002        adds	r0, #2
@   0x080304ea: 6028        str	r0, [r5, #0]
@   0x080304ec: 2001        movs	r0, #1
@   0x080304ee: bc70        pop	{r4, r5, r6}
@   0x080304f0: bc02        pop	{r1}
@   0x080304f2: 4708        bx	r1
