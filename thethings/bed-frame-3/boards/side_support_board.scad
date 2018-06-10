/**
 * @file side_support_board.scad
 * @brief TODO.
 *
 */

use <common/board.scad>

module side_support_board(size = [9, 6, 3])
{
    translate([0, size[2], 0])
        rotate([90, 0, 0])
            board(size);
}
