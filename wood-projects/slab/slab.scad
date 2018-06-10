// slab.scad
// units: centimeter

use <common/common_functions.scad>
use <common/board.scad>

SLAB_LENGTH = in_to_cm(100.0);
SLAB_WIDTH = in_to_cm(30.0);
SLAB_THICKNESS = in_to_cm(2.0);

SLAB_RIGHT_BOARD_WIDTH = in_to_cm(10.0);
SLAB_LEFT_EDGE_WIDTH = in_to_cm(10.0);

RIGHT_EDGE_POINTS = [
        [0, SLAB_RIGHT_BOARD_WIDTH],
        [0, 10],
        [1, 9.5],
        [2, 9],
        [3, 8.8],
        [4, 8],
        [5, 8],
        [6, 7.8],
        [7, 7.2],
        [8, 7],
        [9, 6.9],
        [10, 6.8],
        [15, 4],
        [20, 4],
        [30, 2],
        [40, 0.1],
        [100, 1],
        [110, 4],
        [120, 6],
        [150, 2],
        [180, 0.1],
        [190, 1],
        [200, 4],
        [220, 2],
        [SLAB_LENGTH - 10, 0],
        [SLAB_LENGTH - 5, 0],
        [SLAB_LENGTH - 2, 0],
        [SLAB_LENGTH, 4],
        [SLAB_LENGTH, SLAB_RIGHT_BOARD_WIDTH]];

module slab_right_edge()
{
    linear_extrude(
            height = SLAB_THICKNESS,
            center = false,
            convexity = 0,
            twist = 0)
    {
        bounds = [0 : 1 : len(RIGHT_EDGE_POINTS) - 1];

        polygon([for(a = bounds) [RIGHT_EDGE_POINTS[a][0],  RIGHT_EDGE_POINTS[a][1]]]);
    }
}

module slab_left_edge()
{
    board_size = [
            SLAB_LENGTH,
            SLAB_WIDTH - SLAB_RIGHT_BOARD_WIDTH,
            SLAB_THICKNESS];

    board(board_size);
}

module slab()
{
    translate([0, SLAB_RIGHT_BOARD_WIDTH, 0])
        slab_left_edge();

    slab_right_edge();
}

color("Sienna")
    slab();
