// board.scad

BOARD_DEFAULT_LENGTH = 600;
BOARD_DEFAULT_WIDTH = 120;
BOARD_DEFAULT_THICKNESS = 120;

function board_get_default_size()
    = [BOARD_DEFAULT_LENGTH, BOARD_DEFAULT_WIDTH, BOARD_DEFAULT_THICKNESS];

module board(size = board_get_default_size(), center = false)
{
    // size[0] is always with the grain
    // size[1] is against the grain
    // size[2] is the board thickness
    cube(size = size, center = center);
}
