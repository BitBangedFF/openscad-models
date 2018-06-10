/**
 * @file center_support.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/center_support.scad>
 *
 */

// modules
use <../boards/center_support_board.scad>

// constants
CENTER_SUPPORT_BOARD_OVERRUN = 1.0;
CENTER_SUPPORT_BOARD_LENGTH =
        END_TO_END_DISTANCE
        - (POST_BOARD_THICKNESS / 2)
        - (SUPPORT_BOARD_THICKNESS / 2)
        + (2 * CENTER_SUPPORT_BOARD_OVERRUN);
CENTER_SUPPORT_BOARD_WIDTH = SUPPORT_BOARD_WIDTH;
CENTER_SUPPORT_BOARD_THICKNESS = SUPPORT_BOARD_THICKNESS;

module center_support()
{
    board_size = [
            CENTER_SUPPORT_BOARD_LENGTH,
            CENTER_SUPPORT_BOARD_WIDTH,
            CENTER_SUPPORT_BOARD_THICKNESS];

    cutout_size = [
            SUPPORT_BOARD_THICKNESS + 1,
            SUPPORT_BOARD_THICKNESS + 2,
            CENTER_SUPPORT_BOARD_WIDTH
                    - CENTER_SUPPORT_TENON_WIDTH
                    + 1];

    plank_dado_size = [
            PLANK_BOARD_WIDTH,
            SUPPORT_BOARD_THICKNESS + 2,
            PLANK_BOARD_THICKNESS + 1];

    cutout_offset_a = [
            -1,
            -1,
            -1];

    cutout_offset_b = [
            CENTER_SUPPORT_BOARD_LENGTH
                    - SUPPORT_BOARD_THICKNESS,
            -1,
            -1];

    difference()
    {
        center_support_board(board_size);

        translate(cutout_offset_a)
            cube(cutout_size);

        translate(cutout_offset_b)
            cube(cutout_size);

        // dados to support the planks
        for(p = [0:PLANK_BOARD_COUNT - 1])
        {
            dist = PLANK_BOARD_WIDTH + PLANK_BOARD_SEP_DISTANCE;

            offset_m = [
                    (POST_BOARD_THICKNESS / 2)
                            + (SUPPORT_BOARD_THICKNESS / 2)
                            + CENTER_SUPPORT_BOARD_OVERRUN
                            + (p * dist),
                    -1,
                    SUPPORT_BOARD_WIDTH
                            - PLANK_BOARD_THICKNESS];

            translate(offset_m)
                cube(plank_dado_size);
        }
    }
}

module center_support_assembly()
{
    board_offset = [
            (POST_BOARD_THICKNESS / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2)
                    - CENTER_SUPPORT_BOARD_OVERRUN,
            (SIDE_TO_SIDE_DISTANCE / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            ABOVE_GROUND_DISTANCE];

    translate(board_offset)
        center_support();
}
