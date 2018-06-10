/**
 * @file side_support.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/side_support.scad>
 *
 */

// modules
use <../boards/side_support_board.scad>

// constants
SIDE_SUPPORT_BOARD_LENGTH =
        END_TO_END_DISTANCE
        + SUPPORT_BOARD_OVERRUN;
SIDE_SUPPORT_BOARD_WIDTH = SUPPORT_BOARD_WIDTH;
SIDE_SUPPORT_BOARD_THICKNESS = SUPPORT_BOARD_THICKNESS;

module side_support_taper_object()
{
    points = [
            [-VISUAL_OVERRUN, -VISUAL_OVERRUN],
            [TAPER_DEPTH, -VISUAL_OVERRUN],
            [-VISUAL_OVERRUN, TAPER_HEIGHT]];

    translate([0, SIDE_SUPPORT_BOARD_THICKNESS + VISUAL_OVERRUN, 0])
        rotate([90, 0, 0])
            linear_extrude(
                    height = SIDE_SUPPORT_BOARD_THICKNESS
                            + (2 * VISUAL_OVERRUN),
                    center = false,
                    convexity = 0,
                    twist = 0)
            {
                polygon(points);
            }
}

module side_support()
{
    board_size = [
            SIDE_SUPPORT_BOARD_LENGTH,
            SIDE_SUPPORT_BOARD_WIDTH,
            SIDE_SUPPORT_BOARD_THICKNESS];

    cutout_size = [
            SUPPORT_BOARD_THICKNESS,
            SUPPORT_BOARD_THICKNESS + (2 * VISUAL_OVERRUN),
            (SUPPORT_BOARD_WIDTH / 2) + VISUAL_OVERRUN];

    cutout_offset_a = [
            SUPPORT_BOARD_OVERRUN
                    + (POST_BOARD_THICKNESS / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            -VISUAL_OVERRUN,
            -VISUAL_OVERRUN];

    cutout_offset_b = [
            SIDE_SUPPORT_BOARD_LENGTH
                    - (POST_BOARD_THICKNESS / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            -VISUAL_OVERRUN,
            -VISUAL_OVERRUN];

    difference()
    {
        side_support_board(board_size);

        side_support_taper_object();

        translate(cutout_offset_a)
            cube(cutout_size);

        translate(cutout_offset_b)
            cube(cutout_size);
    }
}
