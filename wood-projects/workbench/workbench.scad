// workbench.scad
// units: centimeter

use <common/board.scad>

LEG_BOARD_LENGTH = 130;
LEG_BOARD_WIDTH = 10;
LEG_BOARD_THICKNESS = LEG_BOARD_WIDTH;

LEG_SEP_DISTANCE_X = 142;

TOP_BOARD_LENGTH = LEG_SEP_DISTANCE_X + (2 * LEG_BOARD_THICKNESS);
TOP_BOARD_WIDTH = 20;
TOP_BOARD_THICKNESS = 5;
TOP_BOARD_SEP_DIST = 0.05;
TOP_BOARD_COUNT = 5;

LEG_SEP_DISTANCE_Y =
        (TOP_BOARD_WIDTH * TOP_BOARD_COUNT)
        + (TOP_BOARD_SEP_DIST * (TOP_BOARD_COUNT - 1))
        - (2 * LEG_BOARD_WIDTH);
        
TOP_TOTAL_WIDTH = LEG_SEP_DISTANCE_Y + (2 * LEG_BOARD_THICKNESS);

EDGE_SUP_BOARD_THICKNESS = 5;
LONG_EDGE_SUP_BOARD_LENGTH = LEG_SEP_DISTANCE_X;
LONG_EDGE_SUP_BOARD_WIDTH = 14;
LONG_EDGE_SUP_BOARD_THICKNESS = EDGE_SUP_BOARD_THICKNESS;

SHORT_EDGE_SUP_BOARD_LENGTH = LEG_SEP_DISTANCE_Y;
SHORT_EDGE_SUP_BOARD_WIDTH = 14;
SHORT_EDGE_SUP_BOARD_THICKNESS = EDGE_SUP_BOARD_THICKNESS;

SUPPORT_BOARD_OVERRUN = 0.5;
BACK_SUPPORT_BOARD_LENGTH =
        LEG_SEP_DISTANCE_X +
        (2 * LEG_BOARD_THICKNESS) +
        (2 * SUPPORT_BOARD_OVERRUN);
BACK_SUPPORT_BOARD_WIDTH = 10;
BACK_SUPPORT_BOARD_THICKNESS = 5;

SIDE_SUPPORT_BOARD_LENGTH =
        LEG_SEP_DISTANCE_Y +
        (2 * LEG_BOARD_WIDTH) +
        (2 * SUPPORT_BOARD_OVERRUN);
SIDE_SUPPORT_BOARD_WIDTH = 10;
SIDE_SUPPORT_BOARD_THICKNESS = 5;

module leg_board()
{
    board_size = [
            LEG_BOARD_LENGTH,
            LEG_BOARD_WIDTH,
            LEG_BOARD_THICKNESS];

    translate([board_size[2]/2, board_size[1]/2, 0])
        rotate([0, -90, 0])
            translate([0, -board_size[1]/2, -board_size[2]/2])
                board(board_size);
}

module top_boards()
{
    board_size = [
            TOP_BOARD_LENGTH,
            TOP_BOARD_WIDTH,
            TOP_BOARD_THICKNESS];

    for(b=[0:TOP_BOARD_COUNT - 1])
    {
        translate([0, b * (TOP_BOARD_WIDTH + TOP_BOARD_SEP_DIST), 0])
            board(board_size);
    }
}

module top_long_edge_support_board()
{
    board_size = [
            LONG_EDGE_SUP_BOARD_LENGTH,
            LONG_EDGE_SUP_BOARD_WIDTH,
            LONG_EDGE_SUP_BOARD_THICKNESS];

    a = (LONG_EDGE_SUP_BOARD_WIDTH - LEG_BOARD_WIDTH);
    b = a * tan(45);
    
    points = [
            [0, 0],
            [b, a],
            [0, a]];

    difference()
    {
        board(board_size);
        
        translate([0, LEG_BOARD_WIDTH, 0])
            linear_extrude(
                    height = board_size[2],
                    center = false,
                    convexity = 0,
                    twist = 0)
                polygon(points);
        
        translate([board_size[0], LEG_BOARD_WIDTH, board_size[2]/2])
            rotate([0, 180, 0])
                translate([0, 0, -board_size[2]/2])
                    linear_extrude(
                            height = board_size[2],
                            center = false,
                            convexity = 0,
                            twist = 0)
                        polygon(points);
    }
}

module top_short_edge_support_board()
{
    board_size = [
            SHORT_EDGE_SUP_BOARD_LENGTH,
            SHORT_EDGE_SUP_BOARD_WIDTH,
            SHORT_EDGE_SUP_BOARD_THICKNESS];

    a = (SHORT_EDGE_SUP_BOARD_WIDTH - LEG_BOARD_THICKNESS);
    b = a * tan(45);
    
    points = [
            [0, 0],
            [b, a],
            [0, a]];

    difference()
    {
        board(board_size);
        
        translate([0, LEG_BOARD_WIDTH, 0])
            linear_extrude(
                    height = board_size[2],
                    center = false,
                    convexity = 0,
                    twist = 0)
                polygon(points);
        
        translate([board_size[0], LEG_BOARD_WIDTH, board_size[2]/2])
            rotate([0, 180, 0])
                translate([0, 0, -board_size[2]/2])
                    linear_extrude(
                            height = board_size[2],
                            center = false,
                            convexity = 0,
                            twist = 0)
                        polygon(points);
    }
}

module top_edge_support_boards()
{
    offset_short = [
            LEG_BOARD_THICKNESS,
            SHORT_EDGE_SUP_BOARD_LENGTH + (2 * LEG_BOARD_WIDTH),
            LONG_EDGE_SUP_BOARD_THICKNESS];
    
    offset_long = [
            LONG_EDGE_SUP_BOARD_LENGTH + (2 * LEG_BOARD_THICKNESS),
            LEG_BOARD_THICKNESS,
            0];
    
    translate([LEG_BOARD_THICKNESS, 0, 0])
        top_long_edge_support_board();
    
    translate(offset_short)
        rotate([180, 0, 0])
            top_long_edge_support_board();
    
    translate([0, SHORT_EDGE_SUP_BOARD_LENGTH + LEG_BOARD_WIDTH, 0])
        rotate([0, 0, -90])
            top_short_edge_support_board();
    
    translate(offset_long)
        rotate([0, 0, 90])
            top_short_edge_support_board();
}

module top_cross_support_board()
{
    board_size = [
            TOP_TOTAL_WIDTH - (2 * LONG_EDGE_SUP_BOARD_WIDTH),
            SHORT_EDGE_SUP_BOARD_WIDTH,
            SHORT_EDGE_SUP_BOARD_THICKNESS];
    
    translate([0, board_size[0] + LONG_EDGE_SUP_BOARD_WIDTH, 0])
        rotate([0, 0, -90])
            board(board_size);
}

module top()
{
    offset_cross_support = [
            TOP_BOARD_LENGTH/2 - SHORT_EDGE_SUP_BOARD_WIDTH/2,
            0,
            LEG_BOARD_LENGTH - EDGE_SUP_BOARD_THICKNESS];

    translate([0, 0, LEG_BOARD_LENGTH])
        top_boards();

    translate([0, 0, LEG_BOARD_LENGTH - EDGE_SUP_BOARD_THICKNESS])
        top_edge_support_boards();
    
    translate(offset_cross_support)
        top_cross_support_board();
}

module legs()
{
    offset_a = [
            LEG_SEP_DISTANCE_X + LEG_BOARD_THICKNESS,
            0,
            0];
    
    offset_b = [
            LEG_SEP_DISTANCE_X + LEG_BOARD_THICKNESS,
            LEG_SEP_DISTANCE_Y + LEG_BOARD_THICKNESS,
            0];
    
    offset_c = [
            0,
            LEG_SEP_DISTANCE_Y + LEG_BOARD_THICKNESS,
            0];

    leg_board();
    
    translate(offset_a)
        leg_board();

    translate(offset_b)
        leg_board();

    translate(offset_c)
        leg_board();
}

module back_support_board()
{
    board_size = [
            BACK_SUPPORT_BOARD_LENGTH,
            BACK_SUPPORT_BOARD_WIDTH,
            BACK_SUPPORT_BOARD_THICKNESS];

    offset_v = LEG_BOARD_WIDTH + LEG_SEP_DISTANCE_Y +
            (LEG_BOARD_THICKNESS/2) - (board_size[2]/2);

    offset_m = [
            -SUPPORT_BOARD_OVERRUN,
            board_size[2] + offset_v,
            LEG_BOARD_LENGTH/2 - board_size[1]/2];

    translate(offset_m)
        rotate([90, 0, 0])
            board(board_size);
}

module side_support_boards()
{
    board_size = [
            SIDE_SUPPORT_BOARD_LENGTH,
            SIDE_SUPPORT_BOARD_WIDTH,
            SIDE_SUPPORT_BOARD_THICKNESS];

    offset_a = [
            LEG_BOARD_THICKNESS/2 - board_size[2]/2,
            -SUPPORT_BOARD_OVERRUN,
            LEG_BOARD_LENGTH/6];
    
    offset_m = (LEG_BOARD_THICKNESS/2) - (board_size[2]/2);
    
    offset_b = [
            LEG_SEP_DISTANCE_X + LEG_BOARD_THICKNESS + offset_m,
            -SUPPORT_BOARD_OVERRUN,
            LEG_BOARD_LENGTH/6];
    
    translate(offset_a)
        rotate([90, 0, 90])
            board(board_size);
    
    translate(offset_b)
        rotate([90, 0, 90])
            board(board_size);
}

module workbench()
{
    legs();
    back_support_board();
    side_support_boards();
    top();
}

workbench();
