/**
 * @file frame.scad
 * @brief TODO.
 *
 */

module frame_vert_post()
{
    board_size = [
            FRAME_VERT_POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    translate([POST_BOARD_THICKNESS, 0, 0])
        rotate([0, -90, 0])
            board(board_size);
}

module frame_horiz_post()
{
    board_size = [
            FRAME_HORIZ_POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    board(board_size);
}

module frame_base_vert_posts()
{
    dist_a =
            + FOUNDATION_BASE_SIZE
            + FOUNDATION_BASE_DISTANCE;

    frame_vert_post();

    translate([dist_a, 0, 0])
        frame_vert_post();

    translate([dist_a, dist_a, 0])
        frame_vert_post();

    translate([0, dist_a, 0])
        frame_vert_post();
}

module frame_base_horiz_posts()
{
    dist_a =
            + FOUNDATION_BASE_SIZE
            + FOUNDATION_BASE_DISTANCE;

    translate([0, 0, FRAME_BASE_HEIGHT])
        frame_horiz_post();

    translate([0, 0, FRAME_TOP_HEIGHT])
        frame_horiz_post();

    translate([0, dist_a, FRAME_BASE_HEIGHT])
        frame_horiz_post();

    translate([0, dist_a, FRAME_TOP_HEIGHT])
        frame_horiz_post();

    translate([POST_BOARD_WIDTH, 0, FRAME_BASE_HEIGHT])
        rotate([0, 0, 90])
            frame_horiz_post();

    translate([POST_BOARD_WIDTH, 0, FRAME_TOP_HEIGHT])
        rotate([0, 0, 90])
            frame_horiz_post();

    translate([POST_BOARD_WIDTH + dist_a, 0, FRAME_BASE_HEIGHT])
        rotate([0, 0, 90])
            frame_horiz_post();

    translate([POST_BOARD_WIDTH + dist_a, 0, FRAME_TOP_HEIGHT])
        rotate([0, 0, 90])
            frame_horiz_post();
}

module frame()
{
    frame_base_vert_posts();

    frame_base_horiz_posts();
}
