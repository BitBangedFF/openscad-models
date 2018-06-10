/**
 * @file post.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/post.scad>
 *
 */

// modules
use <../boards/post_board.scad>

// constants
POST_BOARD_LENGTH = ABOVE_GROUND_DISTANCE + in_to_cm(5.0);
POST_BOARD_WIDTH = 15.0;
POST_BOARD_THICKNESS = 15.0;

module post()
{
    board_size = [
            POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    side_board_cutout_size = [
            POST_BOARD_THICKNESS
                    + (2 * VISUAL_OVERRUN),
            SUPPORT_BOARD_THICKNESS,
            SUPPORT_BOARD_WIDTH
                    + VISUAL_OVERRUN];

    side_board_cutout_offset = [
            -VISUAL_OVERRUN,
            (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            ABOVE_GROUND_DISTANCE];

    end_board_cutout_size = [
            SUPPORT_BOARD_THICKNESS,
            POST_BOARD_THICKNESS
                    + (2 * VISUAL_OVERRUN),
            SUPPORT_BOARD_WIDTH
                    + VISUAL_OVERRUN];

    end_board_cutout_offset = [
            (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            -VISUAL_OVERRUN,
            ABOVE_GROUND_DISTANCE];

    difference()
    {
        post_board(board_size);

        translate(side_board_cutout_offset)
            cube(side_board_cutout_size);

        translate(end_board_cutout_offset)
            cube(end_board_cutout_size);
    }
}
