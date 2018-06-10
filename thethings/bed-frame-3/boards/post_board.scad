/**
 * @file post_board.scad
 * @brief TODO.
 *
 */

use <common/board.scad>

module post_board(size = [12, 4, 4])
{
    translate([size[2], 0, 0])
        rotate([0, -90, 0])
            board(size);
}
