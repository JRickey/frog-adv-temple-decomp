@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_UpdateChannelEnvelopesA
Sound_UpdateChannelEnvelopesA:
        .incbin "frog_us_baserom.gba", 0x2ec7c, 0xe0
        thumb_func_end Sound_UpdateChannelEnvelopesA

