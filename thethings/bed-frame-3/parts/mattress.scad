/**
 * @file mattress.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/mattress.scad>
 *
 */

// modules

// constants

module mattress()
{
    mattress_size = [
            MATTRESS_LENGTH,
            MATTRESS_WIDTH,
            MATTRESS_THICKNESS];

    offset_m = [
            POST_BOARD_THICKNESS
                    - POST_SUPPORT_COVERAGE
                    + MATTRESS_TO_EDGE_DISTANCE,
            POST_BOARD_WIDTH
                    - POST_SUPPORT_COVERAGE
                    + MATTRESS_TO_EDGE_DISTANCE,
            ABOVE_GROUND_DISTANCE
                    + SUPPORT_BOARD_WIDTH + 1];

    translate(offset_m)
        cube(mattress_size);
}
