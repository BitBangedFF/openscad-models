/**
 * @file long_beam_board.scad
 * @brief TODO.
 *
 */

use <common/board.scad>

module long_beam_board(size = [9, 6, 3])
{
    translate([0, size[2], 0])
        rotate([90, 0, 0])
            board(size, center = false);
}
