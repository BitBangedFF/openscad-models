/**
 * @file shelf.scad
 * @brief TODO.
 *
 * units: centimeter
 *
 */

// modules
use <common/common_functions.scad>
use <common/board.scad>

// constants
VISUAL_OVERRUN = get_visual_overrun();

SUPPORT_OFFSET = in_to_cm(16.0);
SUPPORT_OVERRUN = in_to_cm(0.25);
SUPPORT_TENON_WIDTH = in_to_cm(3.0);

SHELF_BOARD_LENGTH = in_to_cm(99.0);
SHELF_BOARD_WIDTH = in_to_cm(17.0);
SHELF_BOARD_THICKNESS = in_to_cm(2.0);

SUPPORT_BOARD_LENGTH = in_to_cm(20);
SUPPORT_BOARD_WIDTH = in_to_cm(14.0);
SUPPORT_BOARD_THICKNESS = in_to_cm(2.0);

CROSS_BOARD_LENGTH = in_to_cm(10.0);
CROSS_BOARD_WIDTH = in_to_cm(2.0);
CROSS_BOARD_THICKNESS = in_to_cm(2.0);

// includes
include <print_vars.scad>

module shelf_board_support_cutouts()
{
    offset_y =
            (SHELF_BOARD_WIDTH / 2)
            - (SUPPORT_BOARD_WIDTH / 2);

    cutout_size = [
            SUPPORT_BOARD_THICKNESS,
            SUPPORT_TENON_WIDTH,
            SHELF_BOARD_THICKNESS
                    + (2 * VISUAL_OVERRUN)];

    translate([0, offset_y, -VISUAL_OVERRUN])
        cube(cutout_size);

    translate([0, offset_y + SUPPORT_BOARD_WIDTH - SUPPORT_TENON_WIDTH, -VISUAL_OVERRUN])
        cube(cutout_size);
}

module shelf_board()
{
    board_size = [
            SHELF_BOARD_LENGTH,
            SHELF_BOARD_WIDTH,
            SHELF_BOARD_THICKNESS];

    difference()
    {
        board(board_size);

        translate([SUPPORT_OFFSET, 0, 0])
            shelf_board_support_cutouts();

        offset_out = SHELF_BOARD_LENGTH - SUPPORT_BOARD_THICKNESS;
        translate([offset_out - SUPPORT_OFFSET, 0, 0])
            shelf_board_support_cutouts();
    }
}

module support_board_cutout()
{
    cutout_size = [
            SUPPORT_BOARD_THICKNESS
                    + (2 * VISUAL_OVERRUN),
            SUPPORT_BOARD_WIDTH
                    - (2 * SUPPORT_TENON_WIDTH),
            SHELF_BOARD_THICKNESS
                    + SUPPORT_OVERRUN
                    + VISUAL_OVERRUN];

    cutout_offset = [
            -VISUAL_OVERRUN,
            SUPPORT_TENON_WIDTH,
            SUPPORT_BOARD_LENGTH
                    - SHELF_BOARD_THICKNESS
                    - SUPPORT_OVERRUN];

    cross_cutout_size = [
            SUPPORT_BOARD_THICKNESS
                    + (2 * VISUAL_OVERRUN),
            CROSS_BOARD_WIDTH,
            (CROSS_BOARD_THICKNESS / 2)
                    + VISUAL_OVERRUN];

    cross_cutout_offset = [
            -VISUAL_OVERRUN,
            (SUPPORT_BOARD_WIDTH / 2)
                    - (CROSS_BOARD_WIDTH / 2),
            SUPPORT_BOARD_LENGTH
                    - SHELF_BOARD_THICKNESS
                    - SUPPORT_OVERRUN
                    - (CROSS_BOARD_THICKNESS / 2)];

    union()
    {
        translate(cutout_offset)
            cube(cutout_size);

        translate(cross_cutout_offset)
            cube(cross_cutout_size);
    }
}

module support_cross_board()
{
    board_size = [
            CROSS_BOARD_LENGTH,
            CROSS_BOARD_WIDTH,
            CROSS_BOARD_THICKNESS];

    board(board_size);
}

module support_board()
{
    board_size = [
            SUPPORT_BOARD_LENGTH,
            SUPPORT_BOARD_WIDTH,
            SUPPORT_BOARD_THICKNESS];

    difference()
    {
        translate([SUPPORT_BOARD_THICKNESS, 0, 0])
            rotate([0, -90, 0])
                board(board_size);

        support_board_cutout();
    }
}

module support_board_assembly()
{
    cross_offset = [
            -(CROSS_BOARD_LENGTH / 2)
                    + (SUPPORT_BOARD_THICKNESS / 2),
            (SUPPORT_BOARD_WIDTH / 2)
                    - (CROSS_BOARD_WIDTH / 2),
            SUPPORT_BOARD_LENGTH
                    - SHELF_BOARD_THICKNESS
                    - SUPPORT_OVERRUN
                    - CROSS_BOARD_THICKNESS];

    support_board();

    translate(cross_offset)
        support_cross_board();
}

module supports_assembly()
{
    offset_x =
            SHELF_BOARD_LENGTH
            - SUPPORT_BOARD_THICKNESS
            - SUPPORT_OFFSET;

    offset_y =
            (SHELF_BOARD_WIDTH / 2)
            - (SUPPORT_BOARD_WIDTH / 2);

    translate([SUPPORT_OFFSET, offset_y, 0])
        support_board_assembly();

    translate([offset_x, offset_y, 0])
        support_board_assembly();
}

module shelf()
{
    color("SandyBrown")
        translate([0, 0, SUPPORT_BOARD_LENGTH - SHELF_BOARD_THICKNESS - SUPPORT_OVERRUN])
            shelf_board();

    color("Peru")
        supports_assembly();
}

shelf();

print_vars();
