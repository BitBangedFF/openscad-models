/**
 * @file ladder.scad
 * @brief TODO.
 *
 */

module ladder_board()
{
    board_size = [
            LADDER_BOARD_LENGTH,
            LADDER_BOARD_WIDTH,
            LADDER_BOARD_THICKNESS];

    color("Chocolate")
        board(board_size);
}

module ladder_cross_board()
{
    board_size = [
            LADDER_CROSS_BOARD_LENGTH,
            LADDER_CROSS_BOARD_WIDTH,
            LADDER_CROSS_BOARD_THICKNESS];

    color("Peru")
        translate([LADDER_CROSS_BOARD_WIDTH, 0, 0])
            rotate([0, 0, 90])
                board(board_size);
}

module ladder_boards_assembly()
{
    for(b = [0:LADDER_BOARD_COUNT - 1])
    {
        translate([0, b * LADDER_BOARD_WIDTH, 0])
            ladder_board();
    }
}

module ladder_cross_boards_assembly()
{
    for(b = [0:LADDER_CROSS_BOARD_COUNT - 1])
    {
        offset_b = [
                b * (LADDER_CROSS_BOARD_SPACING + LADDER_CROSS_BOARD_WIDTH),
                -LADDER_CROSS_BOARD_OVERRUN,
                LADDER_BOARD_THICKNESS / 2];

        translate(offset_b)
            ladder_cross_board();
    }
}

module ladder_assembly()
{
    ladder_boards_assembly();

    ladder_cross_boards_assembly();
}

module ladder()
{
    ladder_offset = [
            -LADDER_BOARD_LENGTH + 21.0,
            (FRAME_HORIZ_POST_BOARD_LENGTH / 2)
            - ((LADDER_BOARD_COUNT * LADDER_BOARD_WIDTH) / 2),
            -FOUNDATION_BASE_HEIGHT / 2];

    translate(ladder_offset)
        rotate([0, -LADDER_ANGLE, 0])
            ladder_assembly();
}
