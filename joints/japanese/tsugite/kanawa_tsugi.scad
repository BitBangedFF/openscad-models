// kanawa_tsugi.scad

use <common/board.scad>

// ratio of the width
ABC_RATIO = 1/8;
LENGTH_RATIO = 3.5;

function kanawa_tsugi_male_offset(board_size = board_get_default_size())
    = (board_size[0]/2) - (board_size[1]*LENGTH_RATIO)/2 - (board_size[1]*ABC_RATIO);

function kanawa_tsugi_pin_xyoffset(board_size = board_get_default_size())
    = [
            kanawa_tsugi_male_offset(board_size) + (board_size[1]*LENGTH_RATIO)/2 + (board_size[1]*ABC_RATIO)/2,
            board_size[1]/2 - (board_size[1]*ABC_RATIO)/2];

module kanawa_tsugi_female(board_size = board_get_default_size())
{
    // measurements a == b == c
    abc = board_size[1] * ABC_RATIO;
    length = board_size[1] * LENGTH_RATIO;

    base_size = [
            length,
            board_size[1],
            board_size[2]];

    cutoutx_size = [
            length/2 + abc/2,
            board_size[1]/2,
            board_size[2]];

    cutoutz_size = [
            abc,
            board_size[1]/2 - abc,
            board_size[2]/2 - abc/2];

    base_startx = board_size[0]/2 - base_size[0]/2;

    ab_size = [
            abc,
            abc,
            board_size[2]];

    aby_size = [
            abc,
            board_size[1]/2,
            abc];

    cutoutm_size = [
            base_startx - abc,
            board_size[1],
            board_size[2]];

    slope_points = [
            [0, 0],
            [cutoutx_size[0] + abc, -abc/2],
            [cutoutx_size[0] + abc, 0]];

    difference()
    {
        board(board_size);

        translate([base_startx, board_size[1]/2, 0])
            cube(cutoutx_size);

        translate([base_startx - ab_size[0], board_size[1]/2, 0])
            linear_extrude(
                    height = board_size[2],
                    center = false,
                    convexity = 0,
                    twist = 0)
                polygon(points = slope_points);

        translate([base_startx - ab_size[0], board_size[1]/2, 0])
            cube(ab_size);

        translate([base_startx - ab_size[0], board_size[1]/2, board_size[2]/2 - abc/2])
            cube(aby_size);

        translate([base_startx + length/2 + abc/2, board_size[1]/2 + abc/2, 0])
            cube(cutoutx_size);

        translate([base_startx + length/2 - abc/2, board_size[1]/2 + abc/2, 0])
            linear_extrude(
                    height = board_size[2],
                    center = false,
                    convexity = 0,
                    twist = 0)
                polygon(points = slope_points);

        translate([base_startx + length + abc, 0, 0])
            cube(cutoutm_size);

        translate([base_startx + length, 0, 0])
            cube(cutoutz_size);

        translate([base_startx + length, 0, board_size[2]/2 + abc/2])
            cube(cutoutz_size);
    }
}

module kanawa_tsugi_pin(board_size = board_get_default_size())
{
    abc = board_size[1] * ABC_RATIO;

    pin_size = [
            board_size[2],
            abc,
            abc];

    rotate([0, -90, 0])
        translate([0, 0, -pin_size[2]])
            board(pin_size);
}

module kanawa_tsugi_male(board_size = board_get_default_size())
{
    xoffset = kanawa_tsugi_male_offset(board_size);
    pin_xyoffset = kanawa_tsugi_pin_xyoffset(board_size);

    translate([-xoffset, 0, 0])
        difference()
        {
            board(board_size);
            kanawa_tsugi_female(board_size);
            translate([pin_xyoffset[0], pin_xyoffset[1], 0])
                kanawa_tsugi_pin(board_size);
        }
}

module kanawa_tsugi_example(board_size = board_get_default_size())
{
    moffset = kanawa_tsugi_male_offset() + 10;
    pin_xyoffset = kanawa_tsugi_pin_xyoffset(board_size);

    kanawa_tsugi_female(board_size);

    translate([moffset, moffset, 0])
        kanawa_tsugi_male();

    translate([pin_xyoffset[0], pin_xyoffset[1] + moffset/2, 0])
        kanawa_tsugi_pin();
}

kanawa_tsugi_example();
