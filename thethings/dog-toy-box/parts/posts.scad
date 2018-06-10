/**
 * @file posts.scad
 * @brief TODO.
 *
 * To use:
 * - use <parts/posts.scad>
 *
 */

// modules

// constants

module posts()
{
    corner_offset_a = [
            (-SIDE_BOARD_LENGTH/2) + BOARD_OVERRUN,
            (-END_BOARD_LENGTH/2) + BOARD_OVERRUN,
            -POST_BOARD_OVERRUN];

    corner_offset_b = [
            (-SIDE_BOARD_LENGTH/2) + BOARD_OVERRUN,
            (END_BOARD_LENGTH/2) - POST_BOARD_WIDTH - BOARD_OVERRUN,
            -POST_BOARD_OVERRUN];

    corner_offset_c = [
            (SIDE_BOARD_LENGTH/2) - POST_BOARD_WIDTH - BOARD_OVERRUN,
            (END_BOARD_LENGTH/2) - POST_BOARD_WIDTH - BOARD_OVERRUN,
            -POST_BOARD_OVERRUN];

    corner_offset_d = [
            (SIDE_BOARD_LENGTH/2) - POST_BOARD_WIDTH - BOARD_OVERRUN,
            (-END_BOARD_LENGTH/2) + BOARD_OVERRUN,
            -POST_BOARD_OVERRUN];

    translate(corner_offset_a)
        translate([POST_BOARD_THICKNESS, POST_BOARD_WIDTH, 0])
            rotate([0, 0, 180])
                post();

    translate(corner_offset_b)
        translate([POST_BOARD_WIDTH, 0, 0])
            rotate([0, 0, 90])
                post();

    translate(corner_offset_c)
        post();

    translate(corner_offset_d)
        translate([0, POST_BOARD_THICKNESS, 0])
            rotate([0, 0, -90])
                post();
}
