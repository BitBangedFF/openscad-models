/**
 * @file walls.scad
 * @brief TODO.
 *
 */

module walls_standard_board()
{
    board_size = [
            WALL_BOARD_LENGTH,
            WALL_BOARD_WIDTH,
            WALL_BOARD_THICKNESS];

    translate([0, WALL_BOARD_THICKNESS, 0])
        rotate([90, 0, 0])
            board(board_size);
}

module walls_support_board()
{
    board_size = [
            WALL_SUPPORT_BOARD_LENGTH,
            WALL_SUPPORT_BOARD_WIDTH,
            WALL_SUPPORT_BOARD_THICKNESS];

    translate([WALL_SUPPORT_BOARD_WIDTH, WALL_SUPPORT_BOARD_THICKNESS, 0])
        rotate([90, -90, 0])
            board(board_size);
}

module walls_front_door_board()
{
    hole_height = WALL_DOOR_HEIGHT_BOARD_COUNT * WALL_BOARD_WIDTH;
    hole_width = WALL_DOOR_WIDTH_BOARD_COUNT * WALL_BOARD_WIDTH;

    offset_b = (WALL_BOARD_LENGTH / 2) + (hole_width / 2);

    board_size = [
            (WALL_BOARD_LENGTH / 2)
                    - (hole_width / 2),
            WALL_BOARD_WIDTH,
            WALL_BOARD_THICKNESS];

    translate([0, WALL_BOARD_THICKNESS, 0])
        rotate([90, 0, 0])
        {
            board(board_size);

            translate([offset_b, 0, 0])
                board(board_size);
        }
}

module walls_type_solid()
{
    total_width =
            FRAME_TOP_HEIGHT
            - FRAME_BASE_HEIGHT
            - POST_BOARD_THICKNESS;

    count = floor(total_width / WALL_BOARD_WIDTH);

    for(w = [0:count - 1])
    {
        translate([0, 0, w * WALL_BOARD_WIDTH])
            walls_standard_board();
    }
}

module walls_type_front_door()
{
    assert(WALL_DOOR_HEIGHT_BOARD_COUNT > 0);
    assert(WALL_DOOR_WIDTH_BOARD_COUNT > 0);

    total_width =
            FRAME_TOP_HEIGHT
            - FRAME_BASE_HEIGHT
            - POST_BOARD_THICKNESS;

    count = floor(total_width / WALL_BOARD_WIDTH);

    for(w = [0:count - 1])
    {
        translate([0, 0, w * WALL_BOARD_WIDTH])
            if(w <= (WALL_DOOR_HEIGHT_BOARD_COUNT - 1))
            {
                walls_front_door_board();
            }
            else
            {
                walls_standard_board();
            }
    }
}

module walls_type_nesting_box()
{
    assert((NESTING_BOX_HEIGHT % WALL_BOARD_WIDTH) == 0);

    total_width =
            FRAME_TOP_HEIGHT
            - FRAME_BASE_HEIGHT
            - POST_BOARD_THICKNESS;

    count = floor(total_width / WALL_BOARD_WIDTH);

    for(w = [0:count - 1])
    {
        if((w * WALL_BOARD_WIDTH) >= NESTING_BOX_HEIGHT)
        {
            translate([0, 0, w * WALL_BOARD_WIDTH])
                walls_standard_board();
        }
    }
}

module walls_side_right()
{
    wall_offset = [
            POST_BOARD_THICKNESS,
            POST_BOARD_WIDTH / 2,
            FRAME_BASE_HEIGHT + POST_BOARD_THICKNESS];

    translate(wall_offset)
        walls_type_nesting_box();
}

module walls_side_back()
{
    wall_offset = [
            WALL_BOARD_THICKNESS
                    + FRAME_HORIZ_POST_BOARD_LENGTH
                    - (POST_BOARD_WIDTH / 2),
            POST_BOARD_THICKNESS,
            FRAME_BASE_HEIGHT + POST_BOARD_THICKNESS];

    translate(wall_offset)
        rotate([0, 0, 90])
        {
            walls_type_solid();

            translate([0, WALL_BOARD_THICKNESS, 0])
            {
                walls_support_board();

                translate([WALL_BOARD_LENGTH - WALL_SUPPORT_BOARD_WIDTH, 0, 0])
                    walls_support_board();
            }
        }
}

module walls_side_left()
{
    wall_offset = [
            POST_BOARD_THICKNESS,
            FRAME_HORIZ_POST_BOARD_LENGTH
                    - (POST_BOARD_WIDTH / 2),
            FRAME_BASE_HEIGHT + POST_BOARD_THICKNESS];

    translate(wall_offset)
        walls_type_nesting_box();
}

module walls_side_front()
{
    wall_offset = [
            WALL_BOARD_THICKNESS
                    + (POST_BOARD_WIDTH / 2),
            POST_BOARD_THICKNESS,
            FRAME_BASE_HEIGHT + POST_BOARD_THICKNESS];

    translate(wall_offset)
        rotate([0, 0, 90])
        {
            walls_type_front_door();

            translate([0, -WALL_SUPPORT_BOARD_THICKNESS, 0])
            {
                walls_support_board();

                translate([WALL_BOARD_LENGTH - WALL_SUPPORT_BOARD_WIDTH, 0, 0])
                    walls_support_board();
            }
        }
}

module walls()
{
    walls_side_right();

    walls_side_back();

    walls_side_left();

    //walls_side_front();
}
