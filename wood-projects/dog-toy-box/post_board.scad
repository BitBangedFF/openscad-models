// post_board.scad

use <board.scad>

module post_board(size = [10, 2, 2], paint = "Peru")
{
    color(paint)
        rotate([0, 90, 0])
            translate([-size[0], 0, 0])
                cube(size = size);
}
