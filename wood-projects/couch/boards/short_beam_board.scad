/**
 * @file short_beam_board.scad
 * @brief TODO.
 *
 */

use <common/board.scad>

module short_beam_board(size = [9, 6, 3])
{
    rotate([90, 0, 90])
        board(size, center = false);
}
