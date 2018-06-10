/**
 * @file side_board.scad
 * @brief TODO.
 *
 */

use <double_tenon_board.scad>

module side_board(size = [10, 5, 1], proportions = [0.15, 0.3, 0.6])
{
    rotate([90, 0, 0])
        translate([0, 0, -size[2]])
            double_tenon_board(size = size, proportions = proportions);
}
