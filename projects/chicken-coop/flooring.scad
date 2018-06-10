/**
 * @file flooring.scad
 * @brief TODO.
 *
 */

module flooring_board()
{
    board_size = [
            FLOOR_BOARD_LENGTH,
            FLOOR_BOARD_WIDTH,
            FLOOR_BOARD_THICKNESS];

    board(board_size);
}

module flooring()
{
    assembly_offset = [
            POST_BOARD_THICKNESS,
            POST_BOARD_WIDTH,
            FRAME_BASE_HEIGHT
                    + POST_BOARD_THICKNESS
                    - FLOOR_BOARD_THICKNESS];

    total_width =
            FOUNDATION_BASE_DISTANCE
            + FOUNDATION_BASE_SIZE
            - POST_BOARD_WIDTH;

    count = floor(total_width / FLOOR_BOARD_WIDTH);

    translate(assembly_offset)
    {
        for(b = [0:count - 1])
        {
            translate([0, b * FLOOR_BOARD_WIDTH, 0])
                flooring_board();
        }
    }
}
