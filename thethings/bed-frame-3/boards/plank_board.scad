/**
 * @file plank_board.scad
 * @brief TODO.
 *
 */

use <common/board.scad>

module plank_board(size = [9, 6, 3])
{
    translate([size[1], 0, 0])
        rotate([0, 0, 90])
            board(size);
}
