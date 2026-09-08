# ROM identity must not come from a mutable ELF

During the large-function campaign, an active Scene19 trial grew by four bytes.
Its unverified ELF placed EntityParam_Apply at 0x0800a25c and Entity_DispatchBC
at 0x0800a270. Reading address 0x0800a26c from that ELF showed `pop {r0}`,
leading to an incorrect claim that the baserom callback 0x0800a26d entered an
epilogue. This claim was withdrawn before source edits used it.

The immutable baserom places EntityParam_Apply at 0x0800a258 and
Entity_DispatchBC at 0x0800a26c. The latter starts with `push {r4, lr}`.
The callback is the ordinary Thumb pointer to Entity_DispatchBC.

Reproduce the ROM-side observation without relying on any build artifact:

```sh
arm-none-eabi-objdump -D -b binary -m arm -M force-thumb \
  --adjust-vma=0x08000000 --start-address=0x0800a258 \
  --stop-address=0x0800a278 baserom.gba
```

`tools/agent/.function_addresses.json` also records Entity_DispatchBC at
134259308 (0x0800a26c). A current map or ELF is candidate output, not a stable
address index, while any worker is changing or building that checkout.
Use direct baserom disassembly or a snapshot tied to a successful whole-ROM
check. Freeze the candidate ELF identity when comparing candidate output.
