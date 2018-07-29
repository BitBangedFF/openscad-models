/**
 * @file support_plank.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/support_plank.scad>
 *
 */

// modules
use <../boards/plank_board.scad>

// constants

module support_plank()
{
    board_size = [
            SUPPORT_PLANK_LENGTH,
            SUPPORT_PLANK_WIDTH,
            SUPPORT_PLANK_THICKNESS];

    translate([SUPPORT_PLANK_WIDTH, 0, 0])
        rotate([0, 0, 90])
            board(board_size, center = false);
}
