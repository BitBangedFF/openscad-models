// shelf.scad
// units: centimeter
// ref https://i.pinimg.com/originals/da/66/4a/da664a588a1fa8e5214f0fcef946b04d.jpg

use <common/board.scad>

TENON_OVERRUN = 1.0;
SHELF_BOARD_GAP = 0.5;
SHELF_INSET = 0.5;

// inside post to post
SHELF_INNER_X_DISTANCE = 30.48;
SHELF_INNER_Y_DISTANCE = 65;

VERT_SUPPORT_BOARD_LENGTH = 182.88;
VERT_SUPPORT_BOARD_WIDTH = 6;
VERT_SUPPORT_BOARD_THICKNESS = 3;

HORIZ_SUPPORT_BOARD_LENGTH =
        SHELF_INNER_X_DISTANCE
        + (2 * VERT_SUPPORT_BOARD_THICKNESS)
        + (2 * TENON_OVERRUN);
HORIZ_SUPPORT_BOARD_WIDTH = 4;
HORIZ_SUPPORT_BOARD_THICKNESS = 2.54;

SHELF_BOARD_LENGTH = 145;
SHELF_BOARD_WIDTH =
        SHELF_INNER_X_DISTANCE
        - (2 * SHELF_BOARD_GAP);
SHELF_BOARD_THICKNESS = 3.81;

VERT_SUPPORT_OFFSETS = [
        5.08,
        45,
        45 + 35,
        45 + (2 * 35),
        45 + (3 * 35)];

module vert_support_board()
{
    board_size = [
            VERT_SUPPORT_BOARD_LENGTH,
            VERT_SUPPORT_BOARD_WIDTH,
            VERT_SUPPORT_BOARD_THICKNESS];
    
    translate([VERT_SUPPORT_BOARD_THICKNESS, 0, 0])
        rotate([0, -90, 0])
            board(board_size);
}

module horiz_support_board()
{
    board_size = [
            HORIZ_SUPPORT_BOARD_LENGTH,
            HORIZ_SUPPORT_BOARD_WIDTH,
            HORIZ_SUPPORT_BOARD_THICKNESS];
    
    offset_m = [
            -TENON_OVERRUN,
            HORIZ_SUPPORT_BOARD_THICKNESS
                    + (VERT_SUPPORT_BOARD_WIDTH/2)
                    - (HORIZ_SUPPORT_BOARD_THICKNESS/2),
            0];
    
    translate(offset_m)
        rotate([90, 0, 0])
            board(board_size);
}

module shelf_board()
{
    board_size = [
            SHELF_BOARD_LENGTH,
            SHELF_BOARD_WIDTH,
            SHELF_BOARD_THICKNESS];
    
    translate([SHELF_BOARD_WIDTH, 0, 0])
        rotate([0, 0, 90])
            board(board_size);
}

module horizontal_supports()
{
    for(z = VERT_SUPPORT_OFFSETS)
    {
        translate([0, 0, z])
            horiz_support_board();
    }
}

module vertical_supports()
{
    offset_x =
            VERT_SUPPORT_BOARD_THICKNESS
            + SHELF_INNER_X_DISTANCE;

    vert_support_board();
    
    translate([offset_x, 0, 0])
        vert_support_board();
}

module vertical_assembly()
{
    offset_y =
            VERT_SUPPORT_BOARD_WIDTH
            + SHELF_INNER_Y_DISTANCE;

    vertical_supports();

    translate([0, offset_y, 0])
        vertical_supports();
}

module horizontal_assembly()
{
    offset_y =
            VERT_SUPPORT_BOARD_WIDTH
            + SHELF_INNER_Y_DISTANCE;

    horizontal_supports();

    translate([0, offset_y, 0])
        horizontal_supports();
}

module shelf_boards_assembly()
{
    mx =
            VERT_SUPPORT_BOARD_WIDTH
            + (SHELF_INNER_Y_DISTANCE / 2);
    
    bx = SHELF_BOARD_LENGTH / 2;
    
    offset_y = mx - bx;

    for(z = VERT_SUPPORT_OFFSETS)
    {
        offset_m = [
                VERT_SUPPORT_BOARD_THICKNESS
                        + SHELF_BOARD_GAP,
                offset_y,
                z + SHELF_BOARD_THICKNESS - SHELF_INSET];

        translate(offset_m)
            shelf_board();
    }
}

module shelf()
{
    color("Peru")
        vertical_assembly();
    
    color("SandyBrown")
        horizontal_assembly();
    
    color("NavajoWhite")
        shelf_boards_assembly();
}

shelf();
