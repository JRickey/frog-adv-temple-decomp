# Memory map

Symbolic names for ROM/EWRAM/IWRAM/MMIO addresses as they're discovered.
Add an entry the moment a name lands in C or in an asm comment, with one
line of context.

## EWRAM (`0x02000000` — `0x02040000`)

(none named yet)

## IWRAM (`0x03000000` — `0x03008000`)

| Address | Symbol | Purpose | First reference |
|---|---|---|---|
| `0x03003480` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x030034A0` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x030034B0` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x030034B4` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x03003550` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x03003570` | `gStructAt3003570` (placeholder) | 4-byte struct (or larger); `sub_08020B30` sets bits 0+1 of byte[0] and writes 0xCD/0xF5/0xF5 to bytes 1..3. Likely a hardware-config/state block initialized once during Init1. | `sub_08020B30` |
| `0x03005330` | `gGameStuff` (base) | Game-state struct (`include/game.h`) | `src/game/game_mode.c` |
| `0x03005339` | `gGameStuff.mode` | Dispatched by AgbMain switch. Initialized to 4 in AgbMain prologue. | AgbMain @ 0x080002B6 |
| `0x0300533A` | `gGameStuff.pendingMode` | Written by `SetGameMode_NN` helpers. NOT the dispatched mode; purpose TBD (see unknowns.md). | `SetGameMode_06` |
| `0x030035E0` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x03007F00` | `_start_svc_stack` (top) | Supervisor-mode SP | `_start` |
| `0x03007FA0` | `_start_irq_stack` (top) | IRQ-mode SP | `_start` |
| `0x030058A0` | IWRAM IntrMain copy dest | `sub_08000820` DMAs `IntrMain` (from ROM) here and installs that copy as the BIOS IRQ vector. | `sub_08000820` |
| `0x030065E0` | `gpSoundSystem` (pointer-slot) | u32 holding pointer to the sound engine's mutable state block. Writer is `sub_0802D558` (CpuFastSet wrapper) — boot copies the state from ROM. Every consumer dereferences `*(void**)0x030065e0` then accesses fields off the loaded base (slot count, channel state, lock counter at +0xbb, pan-curve LUT, active-sound table at +0xcc). See `subsystems.md` Audio / sound. | `sub_0802D558` (writer), `sub_0802F4B0` and all its callees (readers) |
| `0x03007FFC` | BIOS IRQ vector slot | BIOS reads this to dispatch HW IRQ | `_start` installs `IntrMain` here; later `sub_08000820` retargets it to the IWRAM copy at `0x030058A0` |

## MMIO (`0x04000000` — `0x04000400`)

| Address | Symbol | Purpose | First reference |
|---|---|---|---|
| `0x04000004` | `REG_DISPSTAT` | Display status / IRQ enable bits | `sub_08000820` writes 8 (VBlank-IRQ enable) |
| `0x04000200` | `REG_IE` | IRQ enable mask (low 16 bits of IE_IF word) | `IntrMain`; `sub_08000820` sets to `0x2011` (VBlank + Timer0 + GamePak) |
| `0x04000202` | `REG_IF` | IRQ pending mask | `IntrMain` ack store; `sub_08000820` clears at boot |
| `0x04000204` | (literal) | Used by AgbMain (likely `REG_WAITCNT` or waitcnt-adjacent) | AgbMain literal pool 1 |
| `0x04000208` | `REG_IME` | Master IRQ enable | `sub_08000820` enables |
| `0x040000D4` | `REG_DMA3SAD` | DMA3 source (also struct base for `DmaChannel` at +0/+4/+8) | `sub_08000820` |
| `0x040000D8` | `REG_DMA3DAD` | DMA3 destination | `sub_08000820` |
| `0x040000DC` | `REG_DMA3CNT` | DMA3 control (count + flags) | `sub_08000820` |

## ROM (`0x08000000` — `0x08400000`)

| Address | Symbol | Notes |
|---|---|---|
| `0x080000C0` | `_start` | ARM crt0 entry |
| `0x080000FC` | `IntrEnable` | ARM, 24 bytes |
| `0x08000114` | `IntrDisable` | ARM, 24 bytes |
| `0x0800012C` | `IntrMain` | ARM IRQ dispatcher + shared literal pool |
| `0x0800022C` | (literal) | `IntrMain` pool: `0x03007FFC` |
| `0x08000230` | (literal) | `IntrMain` pool: `0x080002A5` (`AgbMain` thumb ptr) |
| `0x08000234` | (literal) | `IntrMain` pool: `0x08035D9C` (`gIntrTable`) |
| `0x08000238` | (literal) | `IntrMain` pool: `0x082F9010` (state used by `sub_08000240`) |
| `0x0800023C` | (literal) | `IntrMain` pool: `0x0802FFD9` (thumb fn used by `sub_08000240`) |
| `0x08000240` | `sub_08000240` | ARM, IRQ-wait-style helper |
| `0x080002A4` | `AgbMain` | First Thumb fn; 26-entry state-machine dispatcher |
| `0x080002E4` | (data) | `AgbMain` jump table base (26 × 4 bytes) |
| `0x08000430` | `sub_08000430` ("Init1") | Pre-loop boot init; Thumb, 148 bytes. Calls 4 unnamed routines, inits gGameStuff + 6 IWRAM structs, sets `REG_IE=0` and `REG_DISPCNT=0x1F40`. See `subsystems.md`. |
| `0x080004C4` | (TBD) | Next Thumb function after `sub_08000430` |
| `0x0800072C` | `sub_0800072C` (TBD) | Called from `sub_08000430` after `sub_08017364`. Likely subsystem init. |
| `0x08000820` | `sub_08000820` | Init1's "install IRQ handler in IWRAM" routine. DMAs `IntrMain` (ROM, `0x0800012C`) to IWRAM at `0x030058A0`, calls `sub_08033910(3, table_at_0x08035DB4)`, retargets BIOS IRQ vector (`0x03007FFC`) to the IWRAM copy, then enables VBlank IRQ (`REG_IE=0x2011`, `REG_IME=1`, `REG_DISPSTAT=8`). Decompiled in `src/game/sub_08000820.c`. |
| `0x08000884` | `sub_08000884` | Empty stub (`bx lr`). Caller TBD. |
| `0x08000888` | `sub_08000888` | Empty stub (`bx lr`). Caller TBD. |
| `0x08017364` | `sub_08017364` (TBD) | Called from `sub_08000430` after IWRAM-struct init. Likely subsystem init. |
| `0x08020B30` | `sub_08020B30` | Called first thing from `sub_08000430`. Sets bits 0+1 of `(*StructAt3003570)0x03003570`, then writes the byte sequence `0xCD, 0xF5, 0xF5` to bytes 1..3. Decompiled in `src/game/sub_08020_b30.c`. |
| `0x08001478` | `SetGameMode_03` | Writes 3 to `gGameStuff.pendingMode` (offset 10, NOT the dispatched mode at 9) |
| `0x08002444` | `SetGameMode_06` | Writes 6 to `gGameStuff.pendingMode` (offset 10, NOT the dispatched mode at 9) |
| `0x08002760` | `SetGameMode_07` | Writes 7 to `gGameStuff.pendingMode` (offset 10, NOT the dispatched mode at 9) |
| `0x08002A5C` | `SetGameMode_08` | Writes 8 to `gGameStuff.pendingMode` (offset 10, NOT the dispatched mode at 9) |
| `0x08002E04` | `SetGameMode_09` | Writes 9 to `gGameStuff.pendingMode` (offset 10, NOT the dispatched mode at 9) |
| `0x08004074` | `SetGameMode_12` | Writes 12 to `gGameStuff.pendingMode` (offset 10, NOT the dispatched mode at 9) |
| `0x080052C0` | `SetGameMode_15` | Writes 15 to `gGameStuff.pendingMode` (offset 10, NOT the dispatched mode at 9) |
| `0x08035D9C` | `gIntrTable` | IRQ handler dispatch table (indexed by IRQ source × 4) |
| `0x0802FFD8` | (TBD) | Thumb function called by `sub_08000240` |
| `0x082F9010` | (TBD) | State flag read by `sub_08000240` |
| `0x0802F4B0` | `sub_0802F4B0` (TBD; sound mixer VBlank tick) | Called per frame from VBlank IRQ. 462 Thumb instructions across 8 internal updaters + per-channel fade/volume loops + per-active-sound mix loop. State at `*(void**)0x030065E0`. Body still in `asm/disasm_0x0802f4b0.s`; destination C scaffolded at `src/system/sound_mixer.c`. See `subsystems.md` Audio / sound, `unknowns.md` sub_0802F4B0. |
| `0x0802E418` | `sub_0802E418` (sound critical-section lock) | Increments refcount at `(*gpSoundSystem)+0xbb`; on 0→1 transition calls ARM trampoline `sub_08035D8C` (presumed IRQ-disable). Paired with `sub_0802E3F8` (unlock). |
| `0x0802D558` | `sub_0802D558` | Thumb BIOS-SWI-12 (CpuFastSet) wrapper. Used as a memcpy/memset primitive throughout boot. The writer for the SoundSystem pointer at `0x030065E0`. |
