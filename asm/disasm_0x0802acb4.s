@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802acb4, 0x0802af10)  (604 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802acb4 --end 0x802af10 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802acb4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802acb6: 4c93        ldr	r4, [pc, #588]	@ (0x2af04)
@   0x0802acb8: 1c20        adds	r0, r4, #0
@   0x0802acba: 3072        adds	r0, #114	@ 0x72
@   0x0802acbc: 2100        movs	r1, #0
@   0x0802acbe: 5e40        ldrsh	r0, [r0, r1]
@   0x0802acc0: 2118        movs	r1, #24
@   0x0802acc2: f009        f827 	bl	0x33d14
@   0x0802acc6: 0400        lsls	r0, r0, #16
@   0x0802acc8: 0c05        lsrs	r5, r0, #16
@   0x0802acca: 3474        adds	r4, #116	@ 0x74
@   0x0802accc: 2100        movs	r1, #0
@   0x0802acce: 5e60        ldrsh	r0, [r4, r1]
@   0x0802acd0: 2118        movs	r1, #24
@   0x0802acd2: f009        f81f 	bl	0x33d14
@   0x0802acd6: 0400        lsls	r0, r0, #16
@   0x0802acd8: 0c07        lsrs	r7, r0, #16
@   0x0802acda: 4c8b        ldr	r4, [pc, #556]	@ (0x2af08)
@   0x0802acdc: 1c20        adds	r0, r4, #0
@   0x0802acde: 2102        movs	r1, #2
@   0x0802ace0: f7db        fe44 	bl	0x696c
@   0x0802ace4: 2d05        cmp	r5, #5
@   0x0802ace6: d119        bne.n	0x2ad1c
@   0x0802ace8: 2f03        cmp	r7, #3
@   0x0802acea: d117        bne.n	0x2ad1c
@   0x0802acec: 1c20        adds	r0, r4, #0
@   0x0802acee: 2108        movs	r1, #8
@   0x0802acf0: 2204        movs	r2, #4
@   0x0802acf2: f7db        fd53 	bl	0x679c
@   0x0802acf6: 0600        lsls	r0, r0, #24
@   0x0802acf8: 2800        cmp	r0, #0
@   0x0802acfa: d10f        bne.n	0x2ad1c
@   0x0802acfc: 1c20        adds	r0, r4, #0
@   0x0802acfe: 2105        movs	r1, #5
@   0x0802ad00: 2200        movs	r2, #0
@   0x0802ad02: f7db        fd4b 	bl	0x679c
@   0x0802ad06: 0600        lsls	r0, r0, #24
@   0x0802ad08: 2800        cmp	r0, #0
@   0x0802ad0a: d007        beq.n	0x2ad1c
@   0x0802ad0c: 1c20        adds	r0, r4, #0
@   0x0802ad0e: 2105        movs	r1, #5
@   0x0802ad10: 2200        movs	r2, #0
@   0x0802ad12: f7db        fcd7 	bl	0x66c4
@   0x0802ad16: 2075        movs	r0, #117	@ 0x75
@   0x0802ad18: f7f5        ffae 	bl	0x20c78
@   0x0802ad1c: 0428        lsls	r0, r5, #16
@   0x0802ad1e: 1401        asrs	r1, r0, #16
@   0x0802ad20: 1c06        adds	r6, r0, #0
@   0x0802ad22: 2906        cmp	r1, #6
@   0x0802ad24: d11a        bne.n	0x2ad5c
@   0x0802ad26: 2f03        cmp	r7, #3
@   0x0802ad28: d118        bne.n	0x2ad5c
@   0x0802ad2a: 4c77        ldr	r4, [pc, #476]	@ (0x2af08)
@   0x0802ad2c: 1c20        adds	r0, r4, #0
@   0x0802ad2e: 2108        movs	r1, #8
@   0x0802ad30: 2205        movs	r2, #5
@   0x0802ad32: f7db        fd33 	bl	0x679c
@   0x0802ad36: 0600        lsls	r0, r0, #24
@   0x0802ad38: 2800        cmp	r0, #0
@   0x0802ad3a: d10f        bne.n	0x2ad5c
@   0x0802ad3c: 1c20        adds	r0, r4, #0
@   0x0802ad3e: 2105        movs	r1, #5
@   0x0802ad40: 2201        movs	r2, #1
@   0x0802ad42: f7db        fd2b 	bl	0x679c
@   0x0802ad46: 0600        lsls	r0, r0, #24
@   0x0802ad48: 2800        cmp	r0, #0
@   0x0802ad4a: d007        beq.n	0x2ad5c
@   0x0802ad4c: 1c20        adds	r0, r4, #0
@   0x0802ad4e: 2105        movs	r1, #5
@   0x0802ad50: 2201        movs	r2, #1
@   0x0802ad52: f7db        fcb7 	bl	0x66c4
@   0x0802ad56: 2075        movs	r0, #117	@ 0x75
@   0x0802ad58: f7f5        ff8e 	bl	0x20c78
@   0x0802ad5c: 1430        asrs	r0, r6, #16
@   0x0802ad5e: 2808        cmp	r0, #8
@   0x0802ad60: d13c        bne.n	0x2addc
@   0x0802ad62: 0438        lsls	r0, r7, #16
@   0x0802ad64: 1401        asrs	r1, r0, #16
@   0x0802ad66: 1c05        adds	r5, r0, #0
@   0x0802ad68: 2905        cmp	r1, #5
@   0x0802ad6a: d118        bne.n	0x2ad9e
@   0x0802ad6c: 4c66        ldr	r4, [pc, #408]	@ (0x2af08)
@   0x0802ad6e: 1c20        adds	r0, r4, #0
@   0x0802ad70: 2108        movs	r1, #8
@   0x0802ad72: 2206        movs	r2, #6
@   0x0802ad74: f7db        fd12 	bl	0x679c
@   0x0802ad78: 0600        lsls	r0, r0, #24
@   0x0802ad7a: 2800        cmp	r0, #0
@   0x0802ad7c: d10f        bne.n	0x2ad9e
@   0x0802ad7e: 1c20        adds	r0, r4, #0
@   0x0802ad80: 2105        movs	r1, #5
@   0x0802ad82: 2202        movs	r2, #2
@   0x0802ad84: f7db        fd0a 	bl	0x679c
@   0x0802ad88: 0600        lsls	r0, r0, #24
@   0x0802ad8a: 2800        cmp	r0, #0
@   0x0802ad8c: d007        beq.n	0x2ad9e
@   0x0802ad8e: 1c20        adds	r0, r4, #0
@   0x0802ad90: 2105        movs	r1, #5
@   0x0802ad92: 2202        movs	r2, #2
@   0x0802ad94: f7db        fc96 	bl	0x66c4
@   0x0802ad98: 2075        movs	r0, #117	@ 0x75
@   0x0802ad9a: f7f5        ff6d 	bl	0x20c78
@   0x0802ad9e: 1430        asrs	r0, r6, #16
@   0x0802ada0: 2808        cmp	r0, #8
@   0x0802ada2: d11b        bne.n	0x2addc
@   0x0802ada4: 1428        asrs	r0, r5, #16
@   0x0802ada6: 2806        cmp	r0, #6
@   0x0802ada8: d118        bne.n	0x2addc
@   0x0802adaa: 4c57        ldr	r4, [pc, #348]	@ (0x2af08)
@   0x0802adac: 1c20        adds	r0, r4, #0
@   0x0802adae: 2108        movs	r1, #8
@   0x0802adb0: 2207        movs	r2, #7
@   0x0802adb2: f7db        fcf3 	bl	0x679c
@   0x0802adb6: 0600        lsls	r0, r0, #24
@   0x0802adb8: 2800        cmp	r0, #0
@   0x0802adba: d10f        bne.n	0x2addc
@   0x0802adbc: 1c20        adds	r0, r4, #0
@   0x0802adbe: 2105        movs	r1, #5
@   0x0802adc0: 2203        movs	r2, #3
@   0x0802adc2: f7db        fceb 	bl	0x679c
@   0x0802adc6: 0600        lsls	r0, r0, #24
@   0x0802adc8: 2800        cmp	r0, #0
@   0x0802adca: d007        beq.n	0x2addc
@   0x0802adcc: 1c20        adds	r0, r4, #0
@   0x0802adce: 2105        movs	r1, #5
@   0x0802add0: 2203        movs	r2, #3
@   0x0802add2: f7db        fc77 	bl	0x66c4
@   0x0802add6: 2075        movs	r0, #117	@ 0x75
@   0x0802add8: f7f5        ff4e 	bl	0x20c78
@   0x0802addc: 1430        asrs	r0, r6, #16
@   0x0802adde: 2806        cmp	r0, #6
@   0x0802ade0: d11a        bne.n	0x2ae18
@   0x0802ade2: 2f08        cmp	r7, #8
@   0x0802ade4: d118        bne.n	0x2ae18
@   0x0802ade6: 4c48        ldr	r4, [pc, #288]	@ (0x2af08)
@   0x0802ade8: 1c20        adds	r0, r4, #0
@   0x0802adea: 2108        movs	r1, #8
@   0x0802adec: 2205        movs	r2, #5
@   0x0802adee: f7db        fcd5 	bl	0x679c
@   0x0802adf2: 0600        lsls	r0, r0, #24
@   0x0802adf4: 2800        cmp	r0, #0
@   0x0802adf6: d10f        bne.n	0x2ae18
@   0x0802adf8: 1c20        adds	r0, r4, #0
@   0x0802adfa: 2105        movs	r1, #5
@   0x0802adfc: 2204        movs	r2, #4
@   0x0802adfe: f7db        fccd 	bl	0x679c
@   0x0802ae02: 0600        lsls	r0, r0, #24
@   0x0802ae04: 2800        cmp	r0, #0
@   0x0802ae06: d007        beq.n	0x2ae18
@   0x0802ae08: 1c20        adds	r0, r4, #0
@   0x0802ae0a: 2105        movs	r1, #5
@   0x0802ae0c: 2204        movs	r2, #4
@   0x0802ae0e: f7db        fc59 	bl	0x66c4
@   0x0802ae12: 2075        movs	r0, #117	@ 0x75
@   0x0802ae14: f7f5        ff30 	bl	0x20c78
@   0x0802ae18: 1430        asrs	r0, r6, #16
@   0x0802ae1a: 2805        cmp	r0, #5
@   0x0802ae1c: d11a        bne.n	0x2ae54
@   0x0802ae1e: 2f08        cmp	r7, #8
@   0x0802ae20: d118        bne.n	0x2ae54
@   0x0802ae22: 4c39        ldr	r4, [pc, #228]	@ (0x2af08)
@   0x0802ae24: 1c20        adds	r0, r4, #0
@   0x0802ae26: 2108        movs	r1, #8
@   0x0802ae28: 2204        movs	r2, #4
@   0x0802ae2a: f7db        fcb7 	bl	0x679c
@   0x0802ae2e: 0600        lsls	r0, r0, #24
@   0x0802ae30: 2800        cmp	r0, #0
@   0x0802ae32: d10f        bne.n	0x2ae54
@   0x0802ae34: 1c20        adds	r0, r4, #0
@   0x0802ae36: 2105        movs	r1, #5
@   0x0802ae38: 2205        movs	r2, #5
@   0x0802ae3a: f7db        fcaf 	bl	0x679c
@   0x0802ae3e: 0600        lsls	r0, r0, #24
@   0x0802ae40: 2800        cmp	r0, #0
@   0x0802ae42: d007        beq.n	0x2ae54
@   0x0802ae44: 1c20        adds	r0, r4, #0
@   0x0802ae46: 2105        movs	r1, #5
@   0x0802ae48: 2205        movs	r2, #5
@   0x0802ae4a: f7db        fc3b 	bl	0x66c4
@   0x0802ae4e: 2075        movs	r0, #117	@ 0x75
@   0x0802ae50: f7f5        ff12 	bl	0x20c78
@   0x0802ae54: 1430        asrs	r0, r6, #16
@   0x0802ae56: 2803        cmp	r0, #3
@   0x0802ae58: d13c        bne.n	0x2aed4
@   0x0802ae5a: 0438        lsls	r0, r7, #16
@   0x0802ae5c: 1401        asrs	r1, r0, #16
@   0x0802ae5e: 1c05        adds	r5, r0, #0
@   0x0802ae60: 2906        cmp	r1, #6
@   0x0802ae62: d118        bne.n	0x2ae96
@   0x0802ae64: 4c28        ldr	r4, [pc, #160]	@ (0x2af08)
@   0x0802ae66: 1c20        adds	r0, r4, #0
@   0x0802ae68: 2108        movs	r1, #8
@   0x0802ae6a: 2207        movs	r2, #7
@   0x0802ae6c: f7db        fc96 	bl	0x679c
@   0x0802ae70: 0600        lsls	r0, r0, #24
@   0x0802ae72: 2800        cmp	r0, #0
@   0x0802ae74: d10f        bne.n	0x2ae96
@   0x0802ae76: 1c20        adds	r0, r4, #0
@   0x0802ae78: 2105        movs	r1, #5
@   0x0802ae7a: 2206        movs	r2, #6
@   0x0802ae7c: f7db        fc8e 	bl	0x679c
@   0x0802ae80: 0600        lsls	r0, r0, #24
@   0x0802ae82: 2800        cmp	r0, #0
@   0x0802ae84: d007        beq.n	0x2ae96
@   0x0802ae86: 1c20        adds	r0, r4, #0
@   0x0802ae88: 2105        movs	r1, #5
@   0x0802ae8a: 2206        movs	r2, #6
@   0x0802ae8c: f7db        fc1a 	bl	0x66c4
@   0x0802ae90: 2075        movs	r0, #117	@ 0x75
@   0x0802ae92: f7f5        fef1 	bl	0x20c78
@   0x0802ae96: 1430        asrs	r0, r6, #16
@   0x0802ae98: 2803        cmp	r0, #3
@   0x0802ae9a: d11b        bne.n	0x2aed4
@   0x0802ae9c: 1428        asrs	r0, r5, #16
@   0x0802ae9e: 2805        cmp	r0, #5
@   0x0802aea0: d118        bne.n	0x2aed4
@   0x0802aea2: 4c19        ldr	r4, [pc, #100]	@ (0x2af08)
@   0x0802aea4: 1c20        adds	r0, r4, #0
@   0x0802aea6: 2108        movs	r1, #8
@   0x0802aea8: 2206        movs	r2, #6
@   0x0802aeaa: f7db        fc77 	bl	0x679c
@   0x0802aeae: 0600        lsls	r0, r0, #24
@   0x0802aeb0: 2800        cmp	r0, #0
@   0x0802aeb2: d10f        bne.n	0x2aed4
@   0x0802aeb4: 1c20        adds	r0, r4, #0
@   0x0802aeb6: 2105        movs	r1, #5
@   0x0802aeb8: 2207        movs	r2, #7
@   0x0802aeba: f7db        fc6f 	bl	0x679c
@   0x0802aebe: 0600        lsls	r0, r0, #24
@   0x0802aec0: 2800        cmp	r0, #0
@   0x0802aec2: d007        beq.n	0x2aed4
@   0x0802aec4: 1c20        adds	r0, r4, #0
@   0x0802aec6: 2105        movs	r1, #5
@   0x0802aec8: 2207        movs	r2, #7
@   0x0802aeca: f7db        fbfb 	bl	0x66c4
@   0x0802aece: 2075        movs	r0, #117	@ 0x75
@   0x0802aed0: f7f5        fed2 	bl	0x20c78
@   0x0802aed4: 2400        movs	r4, #0
@   0x0802aed6: 4d0d        ldr	r5, [pc, #52]	@ (0x2af0c)
@   0x0802aed8: 00a0        lsls	r0, r4, #2
@   0x0802aeda: 1940        adds	r0, r0, r5
@   0x0802aedc: 6800        ldr	r0, [r0, #0]
@   0x0802aede: 1ca1        adds	r1, r4, #2
@   0x0802aee0: f7f6        fd6c 	bl	0x219bc
@   0x0802aee4: 1c60        adds	r0, r4, #1
@   0x0802aee6: 0600        lsls	r0, r0, #24
@   0x0802aee8: 0e04        lsrs	r4, r0, #24
@   0x0802aeea: 2c00        cmp	r4, #0
@   0x0802aeec: d0f4        beq.n	0x2aed8
@   0x0802aeee: 2002        movs	r0, #2
@   0x0802aef0: 2102        movs	r1, #2
@   0x0802aef2: f7f6        f877 	bl	0x20fe4
@   0x0802aef6: 2002        movs	r0, #2
@   0x0802aef8: 2102        movs	r1, #2
@   0x0802aefa: f7da        ff09 	bl	0x5d10
@   0x0802aefe: bcf0        pop	{r4, r5, r6, r7}
@   0x0802af00: bc01        pop	{r0}
@   0x0802af02: 4700        bx	r0
@   0x0802af04: 3720        adds	r7, #32
@   0x0802af06: 0300        lsls	r0, r0, #12
@   0x0802af08: 6110        str	r0, [r2, #16]
@   0x0802af0a: 0300        lsls	r0, r0, #12
@   0x0802af0c: 7ed4        ldrb	r4, [r2, #27]
@   0x0802af0e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802ACB4
sub_0802ACB4: @ 0x0802acb4
        .incbin "frog_us_baserom.gba", 0x2acb4, 0x25c
        thumb_func_end sub_0802ACB4
