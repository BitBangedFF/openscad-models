/**
 * @file nesting_box.scad
 * @brief TODO.
 *
 */

module nexting_box_board()
{
    board_size = [
            WALL_BOARD_LENGTH
                    + (2 * WALL_BOARD_THICKNESS),
            WALL_BOARD_WIDTH,
            WALL_BOARD_THICKNESS];

    board(board_size);
}

module nexting_box_end_board()
{
    total_size = NESTING_BOX_HEIGHT;

    count = floor(total_size / WALL_BOARD_WIDTH);

    board_size = [
            count * WALL_BOARD_WIDTH,
            WALL_BOARD_WIDTH,
            WALL_BOARD_THICKNESS];

    board(board_size);
}

module nesting_box_base()
{
    total_size = NESTING_BOX_HEIGHT;

    count = floor(total_size / WALL_BOARD_WIDTH);

    for(b = [0:count - 1])
    {
        translate([-WALL_BOARD_THICKNESS, b * WALL_BOARD_WIDTH, 0])
            nexting_box_board();
    }
}

module nesting_box_side()
{
    total_size = NESTING_BOX_HEIGHT;

    count = floor(total_size / WALL_BOARD_WIDTH);

    side_offset = [
            0,
            count * WALL_BOARD_WIDTH,
            WALL_BOARD_THICKNESS];

    translate(side_offset)
        rotate([90, 0, 0])
            for(b = [0:count - 1])
            {
                translate([-WALL_BOARD_THICKNESS, b * WALL_BOARD_WIDTH, 0])
                    nexting_box_board();
            }
}

module nesting_box_ends()
{
    total_size = NESTING_BOX_HEIGHT;

    count = floor(total_size / WALL_BOARD_WIDTH);

    end_offset = [
            0,
            0,
            WALL_BOARD_THICKNESS];

    dist =
            WALL_BOARD_LENGTH
            - WALL_BOARD_THICKNESS
            + (2 * WALL_BOARD_THICKNESS);

    translate(end_offset)
        rotate([90, 0, 90])
            for(b = [0:count - 1])
            {
                translate([0, b * WALL_BOARD_WIDTH, -WALL_BOARD_THICKNESS])
                {
                    nexting_box_end_board();

                    translate([0, 0, dist])
                        nexting_box_end_board();
                }
            }
}

module nesting_box()
{
    nesting_box_base();

    nesting_box_side();

    nesting_box_ends();
}

module nesting_box_left()
{
    box_offset = [
            POST_BOARD_WIDTH,
            FOUNDATION_BASE_DISTANCE
                    + FOUNDATION_BASE_SIZE
                    + POST_BOARD_WIDTH,
            FRAME_BASE_HEIGHT
                    + POST_BOARD_THICKNESS
                    - WALL_BOARD_THICKNESS];

    translate(box_offset)
        nesting_box();
}

module nesting_box_right()
{
    box_offset = [
            POST_BOARD_WIDTH
                    + WALL_BOARD_LENGTH,
            0,
            FRAME_BASE_HEIGHT
                    + POST_BOARD_THICKNESS
                    - WALL_BOARD_THICKNESS];

    translate(box_offset)
        rotate([0, 0, 180])
            nesting_box();
}
