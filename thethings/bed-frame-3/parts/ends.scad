/**
 * @file ends.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/ends.scad>
 *
 * Depends on:
 * - include parts/end_support.scad
 *
 */

// modules

// constants

module ends()
{
    offset_a = [
            (POST_BOARD_THICKNESS / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            -SUPPORT_BOARD_OVERRUN,
            ABOVE_GROUND_DISTANCE];

    offset_b = [
            END_TO_END_DISTANCE
                    - (POST_BOARD_THICKNESS / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            -SUPPORT_BOARD_OVERRUN,
            ABOVE_GROUND_DISTANCE];

    translate(offset_a)
        end_support();

    translate(offset_b)
        end_support();
}
