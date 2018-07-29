/**
 * @file side_arm_board.scad
 * @brief TODO.
 *
 */

use <common/board.scad>

module side_arm_board(size = [12, 4, 4])
{
    translate([size[1], 0, 0])
        rotate([0, 0, 90])
            board(size, center = false);
}
