/**
 * @file side_arm.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/side_arm.scad>
 *
 */

// modules
use <../boards/side_arm_board.scad>

// constants

module side_arm()
{
    board_size = [
            SIDE_ARM_LENGTH,
            SIDE_ARM_WIDTH,
            SIDE_ARM_THICKNESS];

    tenon_cutout_size = [
            (SIDE_ARM_WIDTH / 2)
                - (SIDE_ARM_TENON_WIDTH / 2)
                + VISUAL_OVERRUN,
            SIDE_ARM_TENON_DEPTH
                + VISUAL_OVERRUN,
            SIDE_ARM_THICKNESS
                + (2 * VISUAL_OVERRUN)];

    offset_a = [
            -VISUAL_OVERRUN,
            -VISUAL_OVERRUN,
            -VISUAL_OVERRUN];

    offset_b = [
            SIDE_ARM_WIDTH
                - tenon_cutout_size[0]
                + VISUAL_OVERRUN,
            -VISUAL_OVERRUN,
            -VISUAL_OVERRUN];

    offset_c = [
            0,
            SIDE_ARM_LENGTH
                - SIDE_ARM_TENON_DEPTH
                + VISUAL_OVERRUN,
            0];

    difference()
    {
        side_arm_board(board_size);

        translate(offset_a)
            cube(tenon_cutout_size);

        translate(offset_b)
            cube(tenon_cutout_size);

        translate(offset_c)
        {
            translate(offset_a)
                cube(tenon_cutout_size);

            translate(offset_b)
                cube(tenon_cutout_size);
        }
    }
}
