/**
 * @file roof.scad
 * @brief TODO.
 *
 */

module roof_vert_post_board()
{
    board_size = [
            ROOF_VERT_POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    color("SaddleBrown")
        translate([POST_BOARD_THICKNESS, 0, 0])
            rotate([0, -90, 0])
                board(board_size);
}

module roof_support_beam_board()
{
    board_size = [
            ROOF_SUPPORT_BEAM_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    color("SaddleBrown")
        translate([POST_BOARD_THICKNESS, 0, 0])
            rotate([0, 0, 90])
                board(board_size);
}

module roof_cross_board()
{
    board_size = [
            ROOF_CROSS_BOARD_LENGTH,
            ROOF_CROSS_BOARD_WIDTH,
            ROOF_CROSS_BOARD_THICKNESS];

    color("Peru")
        board(board_size);
}

module roof_vert_posts()
{
    dist_a =
            + FOUNDATION_BASE_SIZE
            + FOUNDATION_BASE_DISTANCE;

    roof_vert_post_board();

    translate([dist_a, 0, 0])
        roof_vert_post_board();

    translate([dist_a, dist_a, 0])
        roof_vert_post_board();

    translate([0, dist_a, 0])
        roof_vert_post_board();
}

module roof_panel_assembly()
{
    support_offset = [
            FOUNDATION_BASE_SIZE
                    + FOUNDATION_BASE_DISTANCE,
            0,
            0];

    roof_support_beam_board();

    translate(support_offset)
        roof_support_beam_board();

    dist = ROOF_CROSS_BOARD_WIDTH + ROOF_CROSS_BOARD_SPACING;

    for(b = [0:ROOF_CROSS_BOARD_COUNT - 1])
    {
        offset_b = [
                -ROOF_CROSS_BOARD_OVERRUN,
                ROOF_CROSS_BOARD_START_OFFSET
                        + (b * dist),
                POST_BOARD_THICKNESS];

        translate(offset_b)
            roof_cross_board();
    }
}

module roof_assembly()
{
    roof_vert_posts();

    panel_size = [
            ROOF_PANEL_LENGTH,
            ROOF_PANEL_WIDTH,
            ROOF_PANEL_THICKNESS];

    depth =
            ROOF_VERT_POST_BOARD_LENGTH
            + (POST_BOARD_THICKNESS / 2);

    right_offset = [
            0,
            -ROOF_CENTER_OFFSET,
            depth];

    right_panel_offset = [
            -ROOF_CROSS_BOARD_OVERRUN / 2,
            ROOF_CROSS_BOARD_OVERRUN / 2,
            POST_BOARD_THICKNESS
                    + ROOF_CROSS_BOARD_THICKNESS];

    left_offset = [
            FOUNDATION_BASE_SIZE
                    + FOUNDATION_BASE_DISTANCE
                    + POST_BOARD_THICKNESS,
            FRAME_HORIZ_POST_BOARD_LENGTH
                    + ROOF_CENTER_OFFSET,
            depth];

    translate(right_offset)
        rotate([ROOF_ANGLE, 0, 0])
            translate([0, -ROOF_SUPPORT_BEAM_OVERRUN, 0])
            {
                roof_panel_assembly();

                translate(right_panel_offset)
                    %cube(panel_size);
            }

    translate(left_offset)
        rotate([-ROOF_ANGLE, 0, 0])
            translate([0, ROOF_SUPPORT_BEAM_OVERRUN, 0])
                rotate([0, 0, 180])
                {
                    roof_panel_assembly();

                    translate(right_panel_offset)
                        %cube(panel_size);
                }
}

module roof()
{
    roof_offset = [
            0,
            0,
            FRAME_VERT_POST_BOARD_LENGTH];

    translate(roof_offset)
        roof_assembly();
}
