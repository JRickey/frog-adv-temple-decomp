#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* AABB overlap test for two Entity bounding boxes.
 *
 * X range: [x + field_24 - field_28/2,  x + field_24 + field_28/2]
 * Y range: [y + field_26 - field_29,     y + field_26]
 *
 * Returns 1 if the boxes overlap, 0 otherwise.
 */
u32 sub_080097FC(struct Entity *p1, struct Entity *p2)
{
    s32 center1x, half1, left1, right1;
    s32 center1y, top1, bottom1;
    s32 center2x, half2, left2, right2;
    s32 center2y, top2, bottom2;

    if (p1 == NULL)
        return 0;
    if (p2 == NULL)
        return 0;

    /* p1 bounding box */
    center1x = p1->x + p1->field_24;
    half1 = p1->field_28 >> 1;
    left1 = center1x - half1;
    right1 = center1x + half1;

    center1y = p1->y + p1->field_26;
    top1 = center1y - p1->field_29;
    bottom1 = center1y;

    /* p2 bounding box */
    center2x = p2->x + p2->field_24;
    half2 = p2->field_28 >> 1;
    left2 = center2x - half2;
    right2 = center2x + half2;

    center2y = p2->y + p2->field_26;
    top2 = center2y - p2->field_29;
    bottom2 = center2y;

    if (left1 > right2)
        return 0;
    if (right1 < left2)
        return 0;
    if (top1 > bottom2)
        return 0;
    if (bottom1 < top2)
        return 0;

    return 1;
}
