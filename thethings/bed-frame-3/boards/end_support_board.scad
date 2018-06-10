/**
 * @file end_support_board.scad
 * @brief TODO.
 *
 */

use <common/board.scad>

module end_support_board(size = [9, 6, 3])
{
    rotate([90, 0, 90])
        board(size);
}
