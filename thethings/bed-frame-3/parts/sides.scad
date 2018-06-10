/**
 * @file sides.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/sides.scad>
 *
 * Depends on:
 * - include parts/left_side_support.scad
 * - include parts/right_side_support.scad
 *
 */

// modules

// constants

module sides()
{
    offset_a = [
            -SUPPORT_BOARD_OVERRUN,
            (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            ABOVE_GROUND_DISTANCE];

    offset_b = [
            -SUPPORT_BOARD_OVERRUN,
            SIDE_TO_SIDE_DISTANCE
                    - (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            ABOVE_GROUND_DISTANCE];

    translate(offset_a)
        right_side_support();

    translate(offset_b)
        left_side_support();
}
