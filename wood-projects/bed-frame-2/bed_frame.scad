// bed_frame.scad
// units: centimeter
// TODO
// - joints
// - make parts/files for each module

use <common/board.scad>

// king size mattress
// - 80 x 76 in
// - 203.2 x 193.04 cm
// rounding up a little
MATTRESS_LENGTH = 205;
MATTRESS_WIDTH = 195;

MATTRESS_TO_EDGE_OVERRUN = 15.24/2;
SUPPORT_TO_SIDE_DISTANCE =
        MATTRESS_TO_EDGE_OVERRUN
        + 20;
SUPPORT_TO_END_DISTANCE =
        MATTRESS_TO_EDGE_OVERRUN
        + 20;
SUPPORT_BEAM_BOARD_WIDTH = 10.16;
TOP_BOARD_SEP_DIST = 0.25;

POST_BOARD_LENGTH = 15.24;
POST_BOARD_WIDTH = 15.24;
POST_BOARD_THICKNESS = 15.24;

// TODO - + constant
SIDE_SUPPORT_BEAM_BOARD_LENGTH =
        MATTRESS_LENGTH
        + (2 * MATTRESS_TO_EDGE_OVERRUN);
SIDE_SUPPORT_BEAM_BOARD_WIDTH = SUPPORT_BEAM_BOARD_WIDTH;
SIDE_SUPPORT_BEAM_BOARD_THICKNESS = 2.54;

// TODO - + constant
END_SUPPORT_BEAM_BOARD_LENGTH =
        MATTRESS_WIDTH
        + (2 * MATTRESS_TO_EDGE_OVERRUN);
END_SUPPORT_BEAM_BOARD_WIDTH = SUPPORT_BEAM_BOARD_WIDTH;
END_SUPPORT_BEAM_BOARD_THICKNESS = 2.54;

TOP_BOARD_LENGTH =
        MATTRESS_WIDTH
        + (2 * MATTRESS_TO_EDGE_OVERRUN);
TOP_BOARD_WIDTH = 31.25;
TOP_BOARD_THICKNESS = 3.81;
TOP_BOARD_COUNT = 7;

module top_board()
{
    board_size = [
            TOP_BOARD_LENGTH,
            TOP_BOARD_WIDTH,
            TOP_BOARD_THICKNESS];

    translate([TOP_BOARD_WIDTH, 0, 0])
        rotate([0, 0, 90])
            board(board_size);
}

module post_board()
{
    board_size = [
            POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    translate([POST_BOARD_THICKNESS, 0, 0])
        rotate([0, -90, 0])
            board(board_size);
}

module side_support_beam_board()
{
    board_size = [
            SIDE_SUPPORT_BEAM_BOARD_LENGTH,
            SIDE_SUPPORT_BEAM_BOARD_WIDTH,
            SIDE_SUPPORT_BEAM_BOARD_THICKNESS];

    translate([0, SIDE_SUPPORT_BEAM_BOARD_THICKNESS, 0])
        rotate([90, 0, 0])
            board(board_size);
}

module end_support_beam_board()
{
    board_size = [
            END_SUPPORT_BEAM_BOARD_LENGTH,
            END_SUPPORT_BEAM_BOARD_WIDTH,
            END_SUPPORT_BEAM_BOARD_THICKNESS];

        rotate([90, 0, 90])
            board(board_size);
}

module side_supports()
{
    offset_a = [
            0,
            SUPPORT_TO_SIDE_DISTANCE,
            POST_BOARD_LENGTH - SUPPORT_BEAM_BOARD_WIDTH];

    offset_b = [
            0,
            END_SUPPORT_BEAM_BOARD_LENGTH
                    - SIDE_SUPPORT_BEAM_BOARD_THICKNESS
                    - SUPPORT_TO_SIDE_DISTANCE,
            POST_BOARD_LENGTH - SUPPORT_BEAM_BOARD_WIDTH];

    translate(offset_a)
        side_support_beam_board();

    translate(offset_b)
        side_support_beam_board();
}

module end_supports()
{
    offset_a = [
            SUPPORT_TO_END_DISTANCE,
            0,
            POST_BOARD_LENGTH - SUPPORT_BEAM_BOARD_WIDTH];

    offset_b = [
            SIDE_SUPPORT_BEAM_BOARD_LENGTH
                    - END_SUPPORT_BEAM_BOARD_THICKNESS
                    - SUPPORT_TO_END_DISTANCE,
            0,
            POST_BOARD_LENGTH - SUPPORT_BEAM_BOARD_WIDTH];

    translate(offset_a)
        end_support_beam_board();

    translate(offset_b)
        end_support_beam_board();
}

module support_posts()
{
    offset_a = [
            SUPPORT_TO_END_DISTANCE
                    - (POST_BOARD_THICKNESS/2)
                    + (END_SUPPORT_BEAM_BOARD_THICKNESS/2),
            SUPPORT_TO_SIDE_DISTANCE
                    - (POST_BOARD_WIDTH/2)
                    + (SIDE_SUPPORT_BEAM_BOARD_THICKNESS/2),
            0];

    offset_b = [
            SIDE_SUPPORT_BEAM_BOARD_LENGTH
                    - SUPPORT_TO_END_DISTANCE
                    - (END_SUPPORT_BEAM_BOARD_THICKNESS/2)
                    - (POST_BOARD_THICKNESS/2),
            SUPPORT_TO_SIDE_DISTANCE
                    - (POST_BOARD_WIDTH/2)
                    + (SIDE_SUPPORT_BEAM_BOARD_THICKNESS/2),
            0];

    offset_c = [
            SIDE_SUPPORT_BEAM_BOARD_LENGTH
                    - SUPPORT_TO_END_DISTANCE
                    - (END_SUPPORT_BEAM_BOARD_THICKNESS/2)
                    - (POST_BOARD_THICKNESS/2),
            END_SUPPORT_BEAM_BOARD_LENGTH
                    - SUPPORT_TO_END_DISTANCE
                    - (SIDE_SUPPORT_BEAM_BOARD_THICKNESS/2)
                    - (POST_BOARD_WIDTH/2),
            0];

    offset_d = [
            SUPPORT_TO_END_DISTANCE
                    - (POST_BOARD_THICKNESS/2)
                    + (END_SUPPORT_BEAM_BOARD_THICKNESS/2),
            END_SUPPORT_BEAM_BOARD_LENGTH
                    - SUPPORT_TO_END_DISTANCE
                    - (SIDE_SUPPORT_BEAM_BOARD_THICKNESS/2)
                    - (POST_BOARD_WIDTH/2),
            0];

    translate(offset_a)
        post_board();

    translate(offset_b)
        post_board();

    translate(offset_c)
        post_board();

    translate(offset_d)
        post_board();
}

module top_boards()
{
    for(b = [0 : TOP_BOARD_COUNT - 1])
    {
        xoffset =
                (b * (TOP_BOARD_WIDTH
                        + TOP_BOARD_SEP_DIST));

        translate([xoffset, 0, POST_BOARD_LENGTH])
            top_board();
    }
}

module base()
{
    color("SandyBrown")
        side_supports();

    color("SandyBrown")
        end_supports();

    color("Peru")
        support_posts();
}

module bed_frame()
{
    base();
    
    color("Sienna")
        top_boards();
}

module mattress()
{
    mattress_size = [
            MATTRESS_LENGTH,
            MATTRESS_WIDTH,
            32];

    offset_m = [
            MATTRESS_TO_EDGE_OVERRUN,
            MATTRESS_TO_EDGE_OVERRUN,
            POST_BOARD_LENGTH + 1];

    translate(offset_m)
        cube(mattress_size);
}

module bed_example()
{
    bed_frame();

    %mattress();
}

bed_example();
