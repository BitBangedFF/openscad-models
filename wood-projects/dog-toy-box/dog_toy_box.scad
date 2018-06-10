// dog_toy_box.scad

use <base_board.scad>
use <side_board.scad>
use <end_board.scad>
use <post_board.scad>

BOARD_OVERRUN = 0.1;

SIDE_BOARD_LENGTH = 60.325;
//SIDE_BOARD_WIDTH = 13.97;
SIDE_BOARD_WIDTH = 14.05;
SIDE_BOARD_DEPTH = 1.27;

TENON_LENGTH = 5.10062;
TENON_WIDTH = 4.52125;
TENON_X1_OFFSET = 1.90495;
TENON_X2_OFFSET = 7.5438;

POST_BOARD_OVERRUN = 1.27;
POST_BOARD_LENGTH = SIDE_BOARD_WIDTH + (2*POST_BOARD_OVERRUN);
POST_BOARD_WIDTH = 5.000625;
POST_BOARD_DEPTH = 5.000625;

NUM_BASE_BOARDS = 4;
BASE_BOARD_LENGTH = SIDE_BOARD_LENGTH - POST_BOARD_WIDTH + SIDE_BOARD_DEPTH;
BASE_BOARD_WIDTH = 8.89;
BASE_BOARD_DEPTH = 1.905;
BASE_BOARD_SEP_DIST = 0.001;
BASE_TOTAL_WIDTH =
        (BASE_BOARD_WIDTH*NUM_BASE_BOARDS)
        + (BASE_BOARD_SEP_DIST * (NUM_BASE_BOARDS-1));

//END_BOARD_LENGTH = BASE_TOTAL_WIDTH + POST_BOARD_WIDTH + SIDE_BOARD_DEPTH;
END_BOARD_LENGTH = 42.1306;
END_BOARD_WIDTH = 14.05;
//END_BOARD_WIDTH = 13.97;
END_BOARD_DEPTH = SIDE_BOARD_DEPTH;

module base()
{
    board_size = [
            BASE_BOARD_LENGTH,
            BASE_BOARD_WIDTH,
            BASE_BOARD_DEPTH];

    proportion = [
            (END_BOARD_DEPTH+BOARD_OVERRUN)/BASE_BOARD_LENGTH,
            0.5,
            0.4];

    translate([-board_size[0]/2, -BASE_TOTAL_WIDTH/2, 0])
        for(b=[0:NUM_BASE_BOARDS-1])
        {
            yoffset = b * (BASE_BOARD_WIDTH+BASE_BOARD_SEP_DIST);
            translate([0, yoffset, 0])
                base_board(board_size, proportion);
        }
}

module sides()
{
    board_size = [
            SIDE_BOARD_LENGTH,
            SIDE_BOARD_WIDTH,
            SIDE_BOARD_DEPTH];

    proportion = [
            (POST_BOARD_WIDTH+BOARD_OVERRUN)/SIDE_BOARD_LENGTH,
            TENON_WIDTH / SIDE_BOARD_WIDTH,
            TENON_X2_OFFSET / SIDE_BOARD_WIDTH];

    //yoffset = (BASE_TOTAL_WIDTH/2 + SIDE_BOARD_DEPTH);
    yoffset = (END_BOARD_LENGTH/2)
            - BOARD_OVERRUN
            - (POST_BOARD_WIDTH/2)
            + (SIDE_BOARD_DEPTH/2);

    rotate([0, 0, 180])
        translate([-board_size[0]/2, -yoffset, 0])
            side_board(board_size, proportion);
    translate([-board_size[0]/2, -yoffset, 0])
        side_board(board_size, proportion);
}

module ends()
{
    xoffset = (BASE_BOARD_LENGTH/2) - BOARD_OVERRUN;

    board_size = [
            END_BOARD_LENGTH,
            END_BOARD_WIDTH,
            END_BOARD_DEPTH];

    proportion = [
            (POST_BOARD_WIDTH+BOARD_OVERRUN)/END_BOARD_LENGTH,
            TENON_WIDTH / END_BOARD_WIDTH,
            TENON_X2_OFFSET / END_BOARD_WIDTH];

    difference()
    {
        translate([-xoffset, -board_size[0]/2, 0])
            end_board(board_size, proportion);
        base();
    }

    difference()
    {
        rotate([0, 0, 180])
            translate([-xoffset, -board_size[0]/2, 0])
                end_board(board_size, proportion);
        base();
    }
}

module single_post()
{
    board_size = [
            POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_DEPTH];

    corner_offset_a = [
            (SIDE_BOARD_LENGTH/2) - BOARD_OVERRUN,
            (END_BOARD_LENGTH/2) - BOARD_OVERRUN,
            POST_BOARD_OVERRUN];

    translate(corner_offset_a)
        difference()
        {
            translate([-corner_offset_a[0], -corner_offset_a[1], -corner_offset_a[2]])
                post_board(size = board_size);
            sides();
            ends();
            base();
        }
}

module posts()
{
    board_size = [
            POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_DEPTH];

    corner_offset_a = [
            (SIDE_BOARD_LENGTH/2) - BOARD_OVERRUN,
            END_BOARD_LENGTH/2 - BOARD_OVERRUN,
            POST_BOARD_OVERRUN];

    corner_offset_b = [
            (SIDE_BOARD_LENGTH/2) - BOARD_OVERRUN,
            (-END_BOARD_LENGTH/2) + POST_BOARD_WIDTH + BOARD_OVERRUN,
            POST_BOARD_OVERRUN];

    corner_offset_c = [
            (-SIDE_BOARD_LENGTH/2) + POST_BOARD_WIDTH + BOARD_OVERRUN,
            (-END_BOARD_LENGTH/2) + POST_BOARD_WIDTH + BOARD_OVERRUN,
            POST_BOARD_OVERRUN];

    corner_offset_d = [
            (-SIDE_BOARD_LENGTH/2) + POST_BOARD_WIDTH + BOARD_OVERRUN,
            (END_BOARD_LENGTH/2) - BOARD_OVERRUN,
            POST_BOARD_OVERRUN];

    difference()
    {
        translate([-corner_offset_a[0], -corner_offset_a[1], -corner_offset_a[2]])
            post_board(size = board_size);
        sides();
        ends();
        base();
    }

    difference()
    {
        translate([-corner_offset_a[0], -corner_offset_a[1], -corner_offset_a[2]])
            post_board(size = board_size);
        sides();
        ends();
        base();
    }

    difference()
    {
        translate([-corner_offset_b[0], -corner_offset_b[1], -corner_offset_b[2]])
            post_board(size = board_size);
        sides();
        ends();
        base();
    }

    difference()
    {
        translate([-corner_offset_c[0], -corner_offset_c[1], -corner_offset_c[2]])
            post_board(size = board_size);
        sides();
        ends();
        base();
    }

    difference()
    {
        translate([-corner_offset_d[0], -corner_offset_d[1], -corner_offset_d[2]])
            post_board(size = board_size);
        sides();
        ends();
        base();
    }
}

module dog_toy_box()
{
    base();
    sides();
    ends();
    posts();
}

// results from original model
//
// 'base board' 56.5944 x 8.89 x 1.905
//   - 'tenon xy-offset' = 1.37, 2.5781 (outside edge inward)
//   - 'tenon z-offset' = 0.9525
//   - 'tenon width' = 3.7338
//
// 'side board' 60.325 x 13.97 x 1.27
//   - 'tenon x-offset' = 5.10062
//   - 'tenon large z-offset' = 7.5438
//   - 'tenon small z-offset' = 1.90495
//   - 'tenon width' = 4.52125
//
// 'end board' 42.1306 x 13.97 x 1.27
//   - 'tenon y-offset' = 5.10062
//   - 'tenon large z-offset' = 7.5438
//   - 'tenon small z-offset' = 1.90495
//   - 'tenon width' = 4.52125
//
// 'post board' 16.51 x 5.00063 x 5.00063

dog_toy_box();
