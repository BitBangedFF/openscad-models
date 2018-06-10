/**
 * @file sides.scad
 * @brief TODO.
 *
 * To use:
 * - use <parts/sides.scad>
 *
 */

// modules
use <common/board.scad>
use <../boards/side_board.scad>

// constants
SIDE_BOARD_LENGTH = 60.325;
SIDE_BOARD_WIDTH = 14.05;
SIDE_BOARD_THICKNESS = 1.27;

module sides()
{
    board_size = [
            SIDE_BOARD_LENGTH,
            SIDE_BOARD_WIDTH,
            SIDE_BOARD_THICKNESS];

    proportion = [
            (POST_BOARD_WIDTH + BOARD_OVERRUN)/SIDE_BOARD_LENGTH,
            TENON_WIDTH / SIDE_BOARD_WIDTH,
            TENON_X2_OFFSET / SIDE_BOARD_WIDTH];

    yoffset = (END_BOARD_LENGTH/2)
            - BOARD_OVERRUN
            - (POST_BOARD_WIDTH/2)
            + (SIDE_BOARD_THICKNESS/2);

    rotate([0, 0, 180])
        translate([-board_size[0]/2, -yoffset, 0])
            color("BurlyWood")
                side_board(board_size, proportion);

    translate([-board_size[0]/2, -yoffset, 0])
        color("BurlyWood")
            side_board(board_size, proportion);
}
