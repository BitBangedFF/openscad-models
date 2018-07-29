/**
 * @file pin_board.scad
 * @brief TODO.
 *
 */

module pin_board(radius = 1, length = 1)
{
    rotate([0, 90, 0])
        cylinder($fn = 20, h = length, r1 = radius, r2 = radius, center = true);
}
