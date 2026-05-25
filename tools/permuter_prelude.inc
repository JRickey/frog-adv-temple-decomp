.syntax unified
.thumb

.macro glabel label, visibility=global
    .\visibility \label
    .type \label, %function
    \label:
.endm
