/**
 * @file post_board.scad
 * @brief TODO.
 *
 */

use <common/board.scad>

module post_board(size = [10, 2, 2])
{
    rotate([0, 90, 0])
        translate([-size[0], 0, 0])
            cube(size = size);
}
