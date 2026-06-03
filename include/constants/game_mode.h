#ifndef GUARD_CONSTANTS_GAME_MODE_H
#define GUARD_CONSTANTS_GAME_MODE_H

/* Values for gGameStuff.mode (IWRAM 0x03005330 + 9) — the top-level game-state
 * selector, dispatched by AgbMain's switch (src/system/agb_main.c).
 *
 * Flow is hub-and-spoke: GAME_MODE_ROUTER is the central hub. Every screen
 * handler runs and then writes mode back to GAME_MODE_ROUTER. The router
 * forwards to FILE_SELECT / OPTIONS / MENU_07 / ATTRACT based on the menu
 * selection byte gIwram_3480._data[5] (1 -> 5, 2 -> 6, 3 -> 7, 4 -> 24).
 *
 * GAME_MODE_SCENE_08..SCENE_23 are 16 instances of one shared scene-engine
 * template: each runs the same intro -> play -> pause -> clear -> fade ->
 * return-to-hub state machine, parameterized by a scene-type id (= mode - 7)
 * and a ROM config table installed via ModeControl_Init. Their specific
 * screen identities aren't pinned yet — the per-scene graphics installers and
 * config tables are still INCBIN blobs. SCENE_15 is the canonical/primary
 * gameplay scene; SCENE_19 is the timed/scored outlier (not attract-shared).
 *
 * GAME_MODE_MENU_07/25/26/27 are title/menu/file-flow transition sub-machines
 * rather than distinct screens (individual identities low-confidence).
 *
 * See docs/subsystems.md "Game-mode dispatcher" and docs/sibling-map.md for
 * the scene-handler class analysis. The suffix on SCENE_/MENU_ members is the
 * raw mode value, matching the `case N:` labels in AgbMain. The mode field is
 * a u8; these are plain integer constants used as values only (do not retype
 * the field — agbcc would size the enum as int and shift the struct layout).
 */
enum GameMode {
    GAME_MODE_ROUTER = 4,      /* central hub/dispatcher; screens return here */
    GAME_MODE_FILE_SELECT = 5, /* save-slot load / save / erase */
    GAME_MODE_OPTIONS = 6,     /* ON/OFF + language settings menu */
    GAME_MODE_MENU_07 = 7,     /* file/options transition sub-screen */
    GAME_MODE_SCENE_08 = 8,    /* scene-engine instance (scene-type 1) */
    GAME_MODE_SCENE_09 = 9,
    GAME_MODE_SCENE_10 = 10,
    GAME_MODE_SCENE_11 = 11,
    GAME_MODE_SCENE_12 = 12,
    GAME_MODE_SCENE_13 = 13,
    GAME_MODE_SCENE_14 = 14,
    GAME_MODE_SCENE_15 = 15, /* primary gameplay scene (scene-type 8) */
    GAME_MODE_SCENE_16 = 16,
    GAME_MODE_SCENE_17 = 17,
    GAME_MODE_SCENE_18 = 18,
    GAME_MODE_SCENE_19 = 19, /* timed/scored outlier; not attract-shared */
    GAME_MODE_SCENE_20 = 20,
    GAME_MODE_SCENE_21 = 21,
    GAME_MODE_SCENE_22 = 22,
    GAME_MODE_SCENE_23 = 23,
    GAME_MODE_ATTRACT = 24, /* demo; replays gameplay scenes */
    GAME_MODE_MENU_25 = 25, /* title/menu transition sub-machine */
    GAME_MODE_MENU_26 = 26,
    GAME_MODE_MENU_27 = 27,
    GAME_MODE_NO_HANDLER = 28, /* no per-mode case; runs the shared tail only */
    GAME_MODE_WORLD_MAP = 29,  /* overworld world/level select */
};

#endif /* GUARD_CONSTANTS_GAME_MODE_H */
