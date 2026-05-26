@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800cb80, 0x0800cd88)  (520 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800cb80 --end 0x800cd88 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800cb80: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800cb82: 4647        mov	r7, r8
@   0x0800cb84: b480        push	{r7}
@   0x0800cb86: 9e06        ldr	r6, [sp, #24]
@   0x0800cb88: 0600        lsls	r0, r0, #24
@   0x0800cb8a: 0609        lsls	r1, r1, #24
@   0x0800cb8c: 0e09        lsrs	r1, r1, #24
@   0x0800cb8e: 0636        lsls	r6, r6, #24
@   0x0800cb90: 041b        lsls	r3, r3, #16
@   0x0800cb92: 141b        asrs	r3, r3, #16
@   0x0800cb94: 4c11        ldr	r4, [pc, #68]	@ (0xcbdc)
@   0x0800cb96: 0d40        lsrs	r0, r0, #21
@   0x0800cb98: 1900        adds	r0, r0, r4
@   0x0800cb9a: 7905        ldrb	r5, [r0, #4]
@   0x0800cb9c: 1c2c        adds	r4, r5, #0
@   0x0800cb9e: 435c        muls	r4, r3
@   0x0800cba0: 0412        lsls	r2, r2, #16
@   0x0800cba2: 13d2        asrs	r2, r2, #15
@   0x0800cba4: 008d        lsls	r5, r1, #2
@   0x0800cba6: 186d        adds	r5, r5, r1
@   0x0800cba8: 032d        lsls	r5, r5, #12
@   0x0800cbaa: 0064        lsls	r4, r4, #1
@   0x0800cbac: 192c        adds	r4, r5, r4
@   0x0800cbae: 1914        adds	r4, r2, r4
@   0x0800cbb0: 4f0b        ldr	r7, [pc, #44]	@ (0xcbe0)
@   0x0800cbb2: 46b8        mov	r8, r7
@   0x0800cbb4: 4444        add	r4, r8
@   0x0800cbb6: 490b        ldr	r1, [pc, #44]	@ (0xcbe4)
@   0x0800cbb8: 8827        ldrh	r7, [r4, #0]
@   0x0800cbba: 4039        ands	r1, r7
@   0x0800cbbc: 8021        strh	r1, [r4, #0]
@   0x0800cbbe: 7900        ldrb	r0, [r0, #4]
@   0x0800cbc0: 4358        muls	r0, r3
@   0x0800cbc2: 0040        lsls	r0, r0, #1
@   0x0800cbc4: 182d        adds	r5, r5, r0
@   0x0800cbc6: 1952        adds	r2, r2, r5
@   0x0800cbc8: 4442        add	r2, r8
@   0x0800cbca: 0d36        lsrs	r6, r6, #20
@   0x0800cbcc: 8810        ldrh	r0, [r2, #0]
@   0x0800cbce: 4306        orrs	r6, r0
@   0x0800cbd0: 8016        strh	r6, [r2, #0]
@   0x0800cbd2: bc08        pop	{r3}
@   0x0800cbd4: 4698        mov	r8, r3
@   0x0800cbd6: bcf0        pop	{r4, r5, r6, r7}
@   0x0800cbd8: bc01        pop	{r0}
@   0x0800cbda: 4700        bx	r0
@   0x0800cbdc: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800cbde: 0830        lsrs	r0, r6, #32
@   0x0800cbe0: 0000        movs	r0, r0
@   0x0800cbe2: 0203        lsls	r3, r0, #8
@   0x0800cbe4: fc0f        0000 			@ <UNDEFINED> instruction: 0xfc0f0000
@   0x0800cbe8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800cbea: 4647        mov	r7, r8
@   0x0800cbec: b480        push	{r7}
@   0x0800cbee: 9e06        ldr	r6, [sp, #24]
@   0x0800cbf0: 0600        lsls	r0, r0, #24
@   0x0800cbf2: 0609        lsls	r1, r1, #24
@   0x0800cbf4: 0e09        lsrs	r1, r1, #24
@   0x0800cbf6: 0636        lsls	r6, r6, #24
@   0x0800cbf8: 0e36        lsrs	r6, r6, #24
@   0x0800cbfa: 041b        lsls	r3, r3, #16
@   0x0800cbfc: 141b        asrs	r3, r3, #16
@   0x0800cbfe: 4c11        ldr	r4, [pc, #68]	@ (0xcc44)
@   0x0800cc00: 0d40        lsrs	r0, r0, #21
@   0x0800cc02: 1900        adds	r0, r0, r4
@   0x0800cc04: 7905        ldrb	r5, [r0, #4]
@   0x0800cc06: 1c2c        adds	r4, r5, #0
@   0x0800cc08: 435c        muls	r4, r3
@   0x0800cc0a: 0412        lsls	r2, r2, #16
@   0x0800cc0c: 13d2        asrs	r2, r2, #15
@   0x0800cc0e: 008d        lsls	r5, r1, #2
@   0x0800cc10: 186d        adds	r5, r5, r1
@   0x0800cc12: 032d        lsls	r5, r5, #12
@   0x0800cc14: 0064        lsls	r4, r4, #1
@   0x0800cc16: 192c        adds	r4, r5, r4
@   0x0800cc18: 1914        adds	r4, r2, r4
@   0x0800cc1a: 4f0b        ldr	r7, [pc, #44]	@ (0xcc48)
@   0x0800cc1c: 46b8        mov	r8, r7
@   0x0800cc1e: 4444        add	r4, r8
@   0x0800cc20: 490a        ldr	r1, [pc, #40]	@ (0xcc4c)
@   0x0800cc22: 8827        ldrh	r7, [r4, #0]
@   0x0800cc24: 4039        ands	r1, r7
@   0x0800cc26: 8021        strh	r1, [r4, #0]
@   0x0800cc28: 7900        ldrb	r0, [r0, #4]
@   0x0800cc2a: 4358        muls	r0, r3
@   0x0800cc2c: 0040        lsls	r0, r0, #1
@   0x0800cc2e: 182d        adds	r5, r5, r0
@   0x0800cc30: 1952        adds	r2, r2, r5
@   0x0800cc32: 4442        add	r2, r8
@   0x0800cc34: 8810        ldrh	r0, [r2, #0]
@   0x0800cc36: 4306        orrs	r6, r0
@   0x0800cc38: 8016        strh	r6, [r2, #0]
@   0x0800cc3a: bc08        pop	{r3}
@   0x0800cc3c: 4698        mov	r8, r3
@   0x0800cc3e: bcf0        pop	{r4, r5, r6, r7}
@   0x0800cc40: bc01        pop	{r0}
@   0x0800cc42: 4700        bx	r0
@   0x0800cc44: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800cc46: 0830        lsrs	r0, r6, #32
@   0x0800cc48: 0000        movs	r0, r0
@   0x0800cc4a: 0203        lsls	r3, r0, #8
@   0x0800cc4c: fff0        0000 	vrev64.8	d16, d0
@   0x0800cc50: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800cc52: 4647        mov	r7, r8
@   0x0800cc54: b480        push	{r7}
@   0x0800cc56: 9e06        ldr	r6, [sp, #24]
@   0x0800cc58: 0600        lsls	r0, r0, #24
@   0x0800cc5a: 0609        lsls	r1, r1, #24
@   0x0800cc5c: 0e09        lsrs	r1, r1, #24
@   0x0800cc5e: 0636        lsls	r6, r6, #24
@   0x0800cc60: 041b        lsls	r3, r3, #16
@   0x0800cc62: 141b        asrs	r3, r3, #16
@   0x0800cc64: 4c11        ldr	r4, [pc, #68]	@ (0xccac)
@   0x0800cc66: 0d40        lsrs	r0, r0, #21
@   0x0800cc68: 1900        adds	r0, r0, r4
@   0x0800cc6a: 7905        ldrb	r5, [r0, #4]
@   0x0800cc6c: 1c2c        adds	r4, r5, #0
@   0x0800cc6e: 435c        muls	r4, r3
@   0x0800cc70: 0412        lsls	r2, r2, #16
@   0x0800cc72: 13d2        asrs	r2, r2, #15
@   0x0800cc74: 008d        lsls	r5, r1, #2
@   0x0800cc76: 186d        adds	r5, r5, r1
@   0x0800cc78: 032d        lsls	r5, r5, #12
@   0x0800cc7a: 0064        lsls	r4, r4, #1
@   0x0800cc7c: 192c        adds	r4, r5, r4
@   0x0800cc7e: 1914        adds	r4, r2, r4
@   0x0800cc80: 4f0b        ldr	r7, [pc, #44]	@ (0xccb0)
@   0x0800cc82: 46b8        mov	r8, r7
@   0x0800cc84: 4444        add	r4, r8
@   0x0800cc86: 490b        ldr	r1, [pc, #44]	@ (0xccb4)
@   0x0800cc88: 8827        ldrh	r7, [r4, #0]
@   0x0800cc8a: 4039        ands	r1, r7
@   0x0800cc8c: 8021        strh	r1, [r4, #0]
@   0x0800cc8e: 7900        ldrb	r0, [r0, #4]
@   0x0800cc90: 4358        muls	r0, r3
@   0x0800cc92: 0040        lsls	r0, r0, #1
@   0x0800cc94: 182d        adds	r5, r5, r0
@   0x0800cc96: 1952        adds	r2, r2, r5
@   0x0800cc98: 4442        add	r2, r8
@   0x0800cc9a: 0ab6        lsrs	r6, r6, #10
@   0x0800cc9c: 8810        ldrh	r0, [r2, #0]
@   0x0800cc9e: 4306        orrs	r6, r0
@   0x0800cca0: 8016        strh	r6, [r2, #0]
@   0x0800cca2: bc08        pop	{r3}
@   0x0800cca4: 4698        mov	r8, r3
@   0x0800cca6: bcf0        pop	{r4, r5, r6, r7}
@   0x0800cca8: bc01        pop	{r0}
@   0x0800ccaa: 4700        bx	r0
@   0x0800ccac: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800ccae: 0830        lsrs	r0, r6, #32
@   0x0800ccb0: 0000        movs	r0, r0
@   0x0800ccb2: 0203        lsls	r3, r0, #8
@   0x0800ccb4: bfff        itttt	<und>
@   0x0800ccb6: 0000        mov<und>	r0, r0
@   0x0800ccb8: b5f0        push<und>	{r4, r5, r6, r7, lr}
@   0x0800ccba: 4647        mov<und>	r7, r8
@   0x0800ccbc: b480        push<und>	{r7}
@   0x0800ccbe: 9e06        ldr	r6, [sp, #24]
@   0x0800ccc0: 0600        lsls	r0, r0, #24
@   0x0800ccc2: 0609        lsls	r1, r1, #24
@   0x0800ccc4: 0e09        lsrs	r1, r1, #24
@   0x0800ccc6: 0636        lsls	r6, r6, #24
@   0x0800ccc8: 041b        lsls	r3, r3, #16
@   0x0800ccca: 141b        asrs	r3, r3, #16
@   0x0800cccc: 4c11        ldr	r4, [pc, #68]	@ (0xcd14)
@   0x0800ccce: 0d40        lsrs	r0, r0, #21
@   0x0800ccd0: 1900        adds	r0, r0, r4
@   0x0800ccd2: 7905        ldrb	r5, [r0, #4]
@   0x0800ccd4: 1c2c        adds	r4, r5, #0
@   0x0800ccd6: 435c        muls	r4, r3
@   0x0800ccd8: 0412        lsls	r2, r2, #16
@   0x0800ccda: 13d2        asrs	r2, r2, #15
@   0x0800ccdc: 008d        lsls	r5, r1, #2
@   0x0800ccde: 186d        adds	r5, r5, r1
@   0x0800cce0: 032d        lsls	r5, r5, #12
@   0x0800cce2: 0064        lsls	r4, r4, #1
@   0x0800cce4: 192c        adds	r4, r5, r4
@   0x0800cce6: 1914        adds	r4, r2, r4
@   0x0800cce8: 4f0b        ldr	r7, [pc, #44]	@ (0xcd18)
@   0x0800ccea: 46b8        mov	r8, r7
@   0x0800ccec: 4444        add	r4, r8
@   0x0800ccee: 490b        ldr	r1, [pc, #44]	@ (0xcd1c)
@   0x0800ccf0: 8827        ldrh	r7, [r4, #0]
@   0x0800ccf2: 4039        ands	r1, r7
@   0x0800ccf4: 8021        strh	r1, [r4, #0]
@   0x0800ccf6: 7900        ldrb	r0, [r0, #4]
@   0x0800ccf8: 4358        muls	r0, r3
@   0x0800ccfa: 0040        lsls	r0, r0, #1
@   0x0800ccfc: 182d        adds	r5, r5, r0
@   0x0800ccfe: 1952        adds	r2, r2, r5
@   0x0800cd00: 4442        add	r2, r8
@   0x0800cd02: 0b36        lsrs	r6, r6, #12
@   0x0800cd04: 8810        ldrh	r0, [r2, #0]
@   0x0800cd06: 4306        orrs	r6, r0
@   0x0800cd08: 8016        strh	r6, [r2, #0]
@   0x0800cd0a: bc08        pop	{r3}
@   0x0800cd0c: 4698        mov	r8, r3
@   0x0800cd0e: bcf0        pop	{r4, r5, r6, r7}
@   0x0800cd10: bc01        pop	{r0}
@   0x0800cd12: 4700        bx	r0
@   0x0800cd14: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800cd16: 0830        lsrs	r0, r6, #32
@   0x0800cd18: 0000        movs	r0, r0
@   0x0800cd1a: 0203        lsls	r3, r0, #8
@   0x0800cd1c: cfff        ldmia	r7, {r0, r1, r2, r3, r4, r5, r6, r7}
@   0x0800cd1e: 0000        movs	r0, r0
@   0x0800cd20: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800cd22: 4647        mov	r7, r8
@   0x0800cd24: b480        push	{r7}
@   0x0800cd26: 9e06        ldr	r6, [sp, #24]
@   0x0800cd28: 0600        lsls	r0, r0, #24
@   0x0800cd2a: 0609        lsls	r1, r1, #24
@   0x0800cd2c: 0e09        lsrs	r1, r1, #24
@   0x0800cd2e: 0636        lsls	r6, r6, #24
@   0x0800cd30: 041b        lsls	r3, r3, #16
@   0x0800cd32: 141b        asrs	r3, r3, #16
@   0x0800cd34: 4c11        ldr	r4, [pc, #68]	@ (0xcd7c)
@   0x0800cd36: 0d40        lsrs	r0, r0, #21
@   0x0800cd38: 1900        adds	r0, r0, r4
@   0x0800cd3a: 7905        ldrb	r5, [r0, #4]
@   0x0800cd3c: 1c2c        adds	r4, r5, #0
@   0x0800cd3e: 435c        muls	r4, r3
@   0x0800cd40: 0412        lsls	r2, r2, #16
@   0x0800cd42: 13d2        asrs	r2, r2, #15
@   0x0800cd44: 008d        lsls	r5, r1, #2
@   0x0800cd46: 186d        adds	r5, r5, r1
@   0x0800cd48: 032d        lsls	r5, r5, #12
@   0x0800cd4a: 0064        lsls	r4, r4, #1
@   0x0800cd4c: 192c        adds	r4, r5, r4
@   0x0800cd4e: 1914        adds	r4, r2, r4
@   0x0800cd50: 4f0b        ldr	r7, [pc, #44]	@ (0xcd80)
@   0x0800cd52: 46b8        mov	r8, r7
@   0x0800cd54: 4444        add	r4, r8
@   0x0800cd56: 490b        ldr	r1, [pc, #44]	@ (0xcd84)
@   0x0800cd58: 8827        ldrh	r7, [r4, #0]
@   0x0800cd5a: 4039        ands	r1, r7
@   0x0800cd5c: 8021        strh	r1, [r4, #0]
@   0x0800cd5e: 7900        ldrb	r0, [r0, #4]
@   0x0800cd60: 4358        muls	r0, r3
@   0x0800cd62: 0040        lsls	r0, r0, #1
@   0x0800cd64: 182d        adds	r5, r5, r0
@   0x0800cd66: 1952        adds	r2, r2, r5
@   0x0800cd68: 4442        add	r2, r8
@   0x0800cd6a: 0d36        lsrs	r6, r6, #20
@   0x0800cd6c: 8810        ldrh	r0, [r2, #0]
@   0x0800cd6e: 4306        orrs	r6, r0
@   0x0800cd70: 8016        strh	r6, [r2, #0]
@   0x0800cd72: bc08        pop	{r3}
@   0x0800cd74: 4698        mov	r8, r3
@   0x0800cd76: bcf0        pop	{r4, r5, r6, r7}
@   0x0800cd78: bc01        pop	{r0}
@   0x0800cd7a: 4700        bx	r0
@   0x0800cd7c: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800cd7e: 0830        lsrs	r0, r6, #32
@   0x0800cd80: 0000        movs	r0, r0
@   0x0800cd82: 0203        lsls	r3, r0, #8
@   0x0800cd84: f3ff        0000 			@ <UNDEFINED> instruction: 0xf3ff0000

        thumb_func_start sub_0800CB80
sub_0800CB80: @ 0x0800cb80
        .incbin "frog_us_baserom.gba", 0xcb80, 0x208
        thumb_func_end sub_0800CB80
