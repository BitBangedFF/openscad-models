// board.scad

module board(size = [10, 5, 1])
{
    // size[0] is always with the grain
    // size[1] is against the grain
    // size[2] is the board thickness
    cube(size = size, center = false);
}
