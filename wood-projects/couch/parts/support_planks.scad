/**
 * @file support_planks.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/support_planks.scad>
 *
* Depends on:
 * - include parts/support_plank.scad
 *
 */

// modules
use <../boards/plank_board.scad>

// constants

module support_planks()
{
    assert((SUPPORT_PLANK_COUNT % 2) == 0);

    height_offset = BASE_HEIGHT - SUPPORT_PLANK_CUTOUT_THICKNESS;
    depth_offset =
            (POST_THICKNESS - BEAM_THICKNESS) / 2;

    center =
            (BASE_POST_TO_POST_LENGTH / 2)
            + POST_THICKNESS;

    // move from the center outwards
    for(p = [0:(SUPPORT_PLANK_COUNT / 2) - 1])
    {
        dist = SUPPORT_PLANK_WIDTH + SUPPORT_PLANK_SEP_DISTANCE;

        plank_pos_offset = [
                center
                    + SUPPORT_PLANK_START_OFFSET
                    + (p * dist),
                depth_offset,
                height_offset];

        plank_neg_offset = [
                center
                    - SUPPORT_PLANK_WIDTH
                    - SUPPORT_PLANK_START_OFFSET
                    - (p * dist),
                depth_offset,
                height_offset];

        translate(plank_pos_offset)
            support_plank();

        translate(plank_neg_offset)
            support_plank();
    }
}
