/**
 * @file right_side_support.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/right_side_support.scad>
 *
 * Depends on:
 * - include parts/side_support.scad
 *
 */

// modules

// constants

module right_side_support()
{
    plank_dado_size = [
            PLANK_BOARD_WIDTH,
            (SUPPORT_BOARD_THICKNESS / 2) + 1,
            PLANK_BOARD_THICKNESS + 1];

    difference()
    {
        side_support();

        // dados to support the planks
        for(p = [0:PLANK_BOARD_COUNT - 1])
        {
            dist = PLANK_BOARD_WIDTH + PLANK_BOARD_SEP_DISTANCE;

            offset_m = [
                    POST_BOARD_THICKNESS
                            + SUPPORT_BOARD_OVERRUN
                            + (p * dist),
                    (SUPPORT_BOARD_THICKNESS / 2),
                    SUPPORT_BOARD_WIDTH
                            - PLANK_BOARD_THICKNESS];

            translate(offset_m)
                cube(plank_dado_size);
        }
    }
}
