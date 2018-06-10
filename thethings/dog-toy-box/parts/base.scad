/**
 * @file base.scad
 * @brief TODO.
 *
 * To use:
 * - use <parts/base.scad>
 *
 */

// modules
use <common/board.scad>
use <../boards/base_board.scad>

// constants
NUM_BASE_BOARDS = 4;
BASE_BOARD_SEP_DIST = 0.028;
BASE_BOARD_LENGTH = 56.5944;
BASE_BOARD_WIDTH = 8.89;
BASE_BOARD_THICKNESS = 1.905;
BASE_TOTAL_WIDTH =
        (BASE_BOARD_WIDTH * NUM_BASE_BOARDS)
        + (BASE_BOARD_SEP_DIST * (NUM_BASE_BOARDS - 1));

module base()
{
    board_size = [
            BASE_BOARD_LENGTH,
            BASE_BOARD_WIDTH,
            BASE_BOARD_THICKNESS];

    proportion = [
            (END_BOARD_THICKNESS + BOARD_OVERRUN)/BASE_BOARD_LENGTH,
            0.5,
            0.4];

    translate([-board_size[0]/2, -BASE_TOTAL_WIDTH/2, 0])
        for(b=[0:NUM_BASE_BOARDS - 1])
        {
            yoffset = b * (BASE_BOARD_WIDTH + BASE_BOARD_SEP_DIST);
            translate([0, yoffset, 0])
                color("SaddleBrown")
                    base_board(board_size, proportion);
        }
}
