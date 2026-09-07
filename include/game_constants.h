#ifndef GUARD_GAME_CONSTANTS_H
#define GUARD_GAME_CONSTANTS_H

/* Game vocabulary for Frogger's Adventures: Temple of the Frog.
 * See docs/game-model.md for the full design. Values marked (binary-confirmed)
 * were verified from the disassembly; element/world ORDER is play-sequence
 * (confirm against the level/world tables as they're decompiled). */

/* Single-direction index, as used by DirToMotion (binary-confirmed: 1..4). */
enum Direction {
    DIR_UP = 1,    /* dy = -1 */
    DIR_DOWN = 2,  /* dy = +1 */
    DIR_LEFT = 3,  /* dx = -1 */
    DIR_RIGHT = 4, /* dx = +1 */
};

/* Direction BITMASK (binary-confirmed: 1/2/4/8), used by the directional
 * hit-test / blocked-direction tests (Entity_ProbeDir) — a DISTINCT encoding
 * from the 1..4 Direction index above. */
enum DirBit {
    DIRBIT_UP = 1 << 0,
    DIRBIT_DOWN = 1 << 1,
    DIRBIT_LEFT = 1 << 2,
    DIRBIT_RIGHT = 1 << 3,
};

/* Worlds, in play order (world-map sequence). */
enum World {
    WORLD_GOBLIN_CAVERNS = 0, /* Fire,  NPC Lumpy (frog)            */
    WORLD_ANCIENT_RUINS,      /* Earth, NPC Zippy (owl)            */
    WORLD_SEA_TOWN,           /* Water, NPC Senior Chief (pelican) */
    WORLD_SKY_CITY,           /* Wind,  NPC Lilly (fairy)          */
    WORLD_TEMPLE,             /* final, Mr. D boss                 */
    NUM_WORLDS,
};

/* The collectible "element": one orb sprite, recolored per world. */
enum Element {
    ELEMENT_FIRE = 0, /* red        */
    ELEMENT_EARTH,    /* brown      */
    ELEMENT_WATER,    /* blue       */
    ELEMENT_WIND,     /* light blue */
    ELEMENT_TEMPLE,   /* green      */
    NUM_ELEMENTS,
};

/* Per-level goals / gates. */
#define LEVEL1_ELEMENT_GOAL     3
#define LEVEL2_ELEMENT_GOAL     5
#define TEMPLE_LEVEL1_COIN_GATE 50
#define TEMPLE_LEVEL2_COIN_GATE 75

/* Grid: one tile is 24 sub-pixel units; entity x/y are sub-pixel coordinates,
 * so coord / 24 = tile index (binary-confirmed: the ubiquitous *24 // /24). */
#define TILE_SIZE           24
#define TILE_TO_SUBPIXEL(n) ((n) * TILE_SIZE)
#define SUBPIXEL_TO_TILE(p) ((p) / TILE_SIZE)

/* Sub-pixel anchor of a tile: x is the tile centre (24/2 - 1), y sits 18 units
 * above it (sprite foot vs. tile origin). Walkers use +11 on both axes. */
#define TILE_CENTER_X(t) (TILE_TO_SUBPIXEL(t) + 11)
#define TILE_ANCHOR_Y(t) (TILE_TO_SUBPIXEL(t) - 7)

/* Playfield clamp: x spans tiles 2..12, y tiles 4..14 (Pos2D_ClampToBounds). */
#define PLAYFIELD_MIN_X TILE_CENTER_X(2)
#define PLAYFIELD_MAX_X TILE_CENTER_X(12)
#define PLAYFIELD_MIN_Y TILE_ANCHOR_Y(4)
#define PLAYFIELD_MAX_Y TILE_ANCHOR_Y(14)

#endif /* GUARD_GAME_CONSTANTS_H */
