@ Adapted from the Metroid Fusion decompilation
@ (https://github.com/metroidret/mf). MIT, Copyright (c) 2025 YohannDR.
@ See LICENSE for full attribution.

.syntax unified
.thumb

.macro glabel label, visibility=global
    .\visibility \label
    .type \label, %function
    \label:
.endm
