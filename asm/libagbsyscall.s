@ Public SDK BIOS SWI wrappers (libagbsyscall).
@
@ This is the title's libagbsyscall block: a run of thin Thumb thunks around
@ the GBA BIOS SWIs (svc 0..37, 40, 41) plus the sound-driver/music-player
@ entry points. Covers 0x0802D514 - 0x0802D5EC. SDK library code, not game
@ logic — agbcc 2.x has no SWI intrinsic, so `svc N` can only come from
@ hand-written asm. New BIOS/SWI call sites should be added here, not
@ NAKED-decompiled (see docs/subsystems.md "libagbsyscall block").
@
@ Attribution: wrapper names, ordering, and SWI numbers were cross-checked
@ against public agbcc-era decompilation work, especially pret/pokeemerald's
@ libagbsyscall/libagbsyscall.s, and against GBATEK's public BIOS SWI
@ documentation. The instructions below are reconstructed from this ROM's own
@ disassembly; no leaked Konami or Nintendo source was referenced.

        .include "asm/macros.inc"
        .syntax unified

        .macro syscall_func public, legacy
        .global \public
        .type   \public, function
        .thumb
        .thumb_func
\public:
        .global \legacy
        .type   \legacy, function
        .thumb_func
\legacy:
        .endm

        .macro syscall_end public, legacy
        .size   \public, . - \public
        .size   \legacy, . - \legacy
        .endm

        .section .text, "ax", %progbits
        .align 2, 0

        syscall_func SoftResetExram, sub_0802D514
        ldr     r3, _0802D5E4
        movs    r2, #1
        strb    r2, [r3]
        ldr     r1, _0802D5E8
        mov     sp, r1
        svc     #1
        svc     #0
        bx      lr
        syscall_end SoftResetExram, sub_0802D514

        syscall_func RegisterRamReset, sub_0802D524
        svc     #1
        bx      lr
        syscall_end RegisterRamReset, sub_0802D524

        syscall_func IntrWait, sub_0802D528
        movs    r2, #0
        svc     #4
        bx      lr
        syscall_end IntrWait, sub_0802D528

        syscall_func VBlankIntrWait, sub_0802D52E
        movs    r2, #0
        svc     #5
        bx      lr
        syscall_end VBlankIntrWait, sub_0802D52E

        syscall_func Div, sub_0802D534
        svc     #6
        bx      lr
        syscall_end Div, sub_0802D534

        syscall_func DivArm, sub_0802D538
        svc     #7
        bx      lr
        syscall_end DivArm, sub_0802D538

        syscall_func Mod, sub_0802D53C
        svc     #6
        adds    r0, r1, #0
        bx      lr
        syscall_end Mod, sub_0802D53C

        syscall_func ModArm, sub_0802D542
        svc     #7
        adds    r0, r1, #0
        bx      lr
        syscall_end ModArm, sub_0802D542

        syscall_func Sqrt, sub_0802D548
        svc     #8
        bx      lr
        syscall_end Sqrt, sub_0802D548

        syscall_func ArcTan, sub_0802D54C
        svc     #9
        bx      lr
        syscall_end ArcTan, sub_0802D54C

        syscall_func ArcTan2, sub_0802D550
        svc     #10
        bx      lr
        syscall_end ArcTan2, sub_0802D550

        @ Bios_CpuSet: name applied by main's call-graph rename; kept as an
        @ alias until call sites migrate to CpuSet (then drop it).
        syscall_func CpuSet, sub_0802D554
        .global Bios_CpuSet
        .type   Bios_CpuSet, function
        .thumb_func
Bios_CpuSet:
        svc     #11
        bx      lr
        syscall_end CpuSet, sub_0802D554
        .size   Bios_CpuSet, . - Bios_CpuSet

        @ BiosSwiTable: name applied by main's call-graph rename (it is the
        @ CpuFastSet thunk, not a table); kept as an alias until call sites
        @ migrate to CpuFastSet (then drop it).
        syscall_func CpuFastSet, sub_0802D558
        .global BiosSwiTable
        .type   BiosSwiTable, function
        .thumb_func
BiosSwiTable:
        svc     #12
        bx      lr
        syscall_end CpuFastSet, sub_0802D558
        .size   BiosSwiTable, . - BiosSwiTable

        syscall_func BgAffineSet, sub_0802D55C
        svc     #14
        bx      lr
        syscall_end BgAffineSet, sub_0802D55C

        syscall_func ObjAffineSet, sub_0802D560
        svc     #15
        bx      lr
        syscall_end ObjAffineSet, sub_0802D560

        syscall_func BitUnPack, sub_0802D564
        svc     #16
        bx      lr
        syscall_end BitUnPack, sub_0802D564

        syscall_func LZ77UnCompWram, sub_0802D568
        svc     #17
        bx      lr
        syscall_end LZ77UnCompWram, sub_0802D568

        syscall_func LZ77UnCompVramAndGetSize, sub_0802D56C
        push    {r0, r1}
        svc     #18
        pop     {r2}
        ldrb    r3, [r2, #5]
        ldrb    r2, [r2, #6]
        lsls    r2, r2, #8
        adds    r2, r2, r3
        pop     {r3}
        strh    r2, [r3]
        bx      lr
        syscall_end LZ77UnCompVramAndGetSize, sub_0802D56C

        syscall_func HuffUnComp, sub_0802D580
        svc     #19
        bx      lr
        syscall_end HuffUnComp, sub_0802D580

        syscall_func RLUnCompWram, sub_0802D584
        svc     #20
        bx      lr
        syscall_end RLUnCompWram, sub_0802D584

        syscall_func RLUnCompVram, sub_0802D588
        svc     #21
        bx      lr
        syscall_end RLUnCompVram, sub_0802D588

        syscall_func Diff8bitUnFilterWram, sub_0802D58C
        svc     #22
        bx      lr
        syscall_end Diff8bitUnFilterWram, sub_0802D58C

        syscall_func Diff8bitUnFilterVram, sub_0802D590
        svc     #23
        bx      lr
        syscall_end Diff8bitUnFilterVram, sub_0802D590

        syscall_func Diff16bitUnFilter, sub_0802D594
        svc     #24
        bx      lr
        syscall_end Diff16bitUnFilter, sub_0802D594

        syscall_func SoundBiasChange, sub_0802D598
        svc     #25
        bx      lr
        syscall_end SoundBiasChange, sub_0802D598

        syscall_func SoundBiasSet, sub_0802D59C
        movs    r0, #1
        svc     #25
        bx      lr
        syscall_end SoundBiasSet, sub_0802D59C

        syscall_func SoundBiasReset, sub_0802D5A2
        movs    r0, #0
        svc     #25
        bx      lr
        syscall_end SoundBiasReset, sub_0802D5A2

        syscall_func SoundDriverInit, sub_0802D5A8
        svc     #26
        bx      lr
        syscall_end SoundDriverInit, sub_0802D5A8

        syscall_func SoundDriverMode, sub_0802D5AC
        svc     #27
        bx      lr
        syscall_end SoundDriverMode, sub_0802D5AC

        syscall_func SoundDriverMain, sub_0802D5B0
        svc     #28
        bx      lr
        syscall_end SoundDriverMain, sub_0802D5B0

        syscall_func SoundDriverVSync, sub_0802D5B4
        svc     #29
        bx      lr
        syscall_end SoundDriverVSync, sub_0802D5B4

        syscall_func SoundChannelClear, sub_0802D5B8
        svc     #30
        bx      lr
        syscall_end SoundChannelClear, sub_0802D5B8

        syscall_func SoundDriverVSyncOff, sub_0802D5BC
        svc     #40
        bx      lr
        syscall_end SoundDriverVSyncOff, sub_0802D5BC

        syscall_func SoundDriverVSyncOn, sub_0802D5C0
        svc     #41
        bx      lr
        syscall_end SoundDriverVSyncOn, sub_0802D5C0

        syscall_func MidiKey2Freq, sub_0802D5C4
        svc     #31
        bx      lr
        syscall_end MidiKey2Freq, sub_0802D5C4

        syscall_func MusicPlayerOpen, sub_0802D5C8
        svc     #32
        bx      lr
        syscall_end MusicPlayerOpen, sub_0802D5C8

        syscall_func MusicPlayerStart, sub_0802D5CC
        svc     #33
        bx      lr
        syscall_end MusicPlayerStart, sub_0802D5CC

        syscall_func MusicPlayerStop, sub_0802D5D0
        svc     #34
        bx      lr
        syscall_end MusicPlayerStop, sub_0802D5D0

        syscall_func MusicPlayerContinue, sub_0802D5D4
        svc     #35
        bx      lr
        syscall_end MusicPlayerContinue, sub_0802D5D4

        syscall_func MusicPlayerFadeOut, sub_0802D5D8
        svc     #36
        bx      lr
        syscall_end MusicPlayerFadeOut, sub_0802D5D8

        syscall_func MultiBoot, sub_0802D5DC
        movs    r1, #1
        svc     #37
        bx      lr
        syscall_end MultiBoot, sub_0802D5DC

        .hword  0
_0802D5E4:
        .word   0x04000208
_0802D5E8:
        .word   0x03007f00
