/**
 * @file end_support.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/end_support.scad>
 *
 */

// modules
use <../boards/end_support_board.scad>

// constants
END_SUPPORT_BOARD_LENGTH =
        SIDE_TO_SIDE_DISTANCE
        + (2 * SUPPORT_BOARD_OVERRUN);
END_SUPPORT_BOARD_WIDTH = SUPPORT_BOARD_WIDTH;
END_SUPPORT_BOARD_THICKNESS = SUPPORT_BOARD_THICKNESS;

module end_support_taper_object()
{
    points = [
            [-VISUAL_OVERRUN, -VISUAL_OVERRUN],
            [TAPER_DEPTH, -VISUAL_OVERRUN],
            [-VISUAL_OVERRUN, TAPER_HEIGHT]];

    translate([-VISUAL_OVERRUN, 0, 0])
        rotate([90, 0, 90])
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

module end_support()
{
    board_size = [
            END_SUPPORT_BOARD_LENGTH,
            END_SUPPORT_BOARD_WIDTH,
            END_SUPPORT_BOARD_THICKNESS];

    end_cutout_size = [
            SUPPORT_BOARD_THICKNESS + 2,
            SUPPORT_BOARD_THICKNESS,
            (SUPPORT_BOARD_WIDTH / 2) + 1];

    center_cutout_size = [
            SUPPORT_BOARD_THICKNESS + 2,
            SUPPORT_BOARD_THICKNESS,
            CENTER_SUPPORT_TENON_WIDTH + 1];

    cutout_offset_a = [
            -1,
            SUPPORT_BOARD_OVERRUN
                    + (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            (SUPPORT_BOARD_WIDTH / 2)];

    cutout_offset_b = [
            -1,
            (END_SUPPORT_BOARD_LENGTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            SUPPORT_BOARD_WIDTH
                    - CENTER_SUPPORT_TENON_WIDTH];

    cutout_offset_c = [
            -1,
            END_SUPPORT_BOARD_LENGTH
                    - cutout_offset_a[1]
                    - SUPPORT_BOARD_THICKNESS,
            (SUPPORT_BOARD_WIDTH / 2)];

    difference()
    {
        end_support_board(board_size);

        end_support_taper_object();

        translate([END_SUPPORT_BOARD_THICKNESS, END_SUPPORT_BOARD_LENGTH, 0])
            rotate([0, 0, 180])
                end_support_taper_object();

        translate(cutout_offset_a)
            cube(end_cutout_size);

        translate(cutout_offset_b)
            cube(center_cutout_size);

        translate(cutout_offset_c)
            cube(end_cutout_size);
    }
}
