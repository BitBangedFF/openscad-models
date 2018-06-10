// ooire_hozo_sashi.scad

use <common/board.scad>

OVERRUN_RATIO = 1/4;
DADO_RATIO = 1/8;
TENON_WIDTH_RATIO = 1/2;

TENON_DEPTH_RATIO = 0.75;

module ooire_hozo_sashi_tenon(board_size = board_get_default_size())
{
    overrun = board_size[1] * OVERRUN_RATIO;
    dado = board_size[1] * DADO_RATIO;
    tenon_width = board_size[1] * TENON_WIDTH_RATIO;
    tenon_depth = board_size[2] * TENON_DEPTH_RATIO;

    cutout_size_a = [
            (board_size[2] - tenon_width)/2,
            board_size[1],
            board_size[2] + overrun - dado];

    cutout_size_b = [
            tenon_width,
            (board_size[2] - tenon_depth)/2,
            cutout_size_a[2]];

    offset_a1 = [
            0,
            0,
            board_size[0] - cutout_size_a[2]];

    offset_a2 = [
            cutout_size_a[0] + tenon_width,
            0,
            board_size[0] - cutout_size_a[2]];

    offset_b1 = [
            cutout_size_a[0],
            0,
            board_size[0] - cutout_size_b[2]];

    offset_b2 = [
            cutout_size_a[0],
            cutout_size_b[1] + tenon_depth,
            board_size[0] - cutout_size_b[2]];

    difference()
    {
        translate([0, 0, board_size[0]])
            rotate([0, 90, 0])
                board(board_size);

        translate(offset_a1)
            cube(cutout_size_a);

        translate(offset_a2)
            cube(cutout_size_a);

        translate(offset_b1)
            cube(cutout_size_b);

        translate(offset_b2)
            cube(cutout_size_b);
    }
}

module ooire_hozo_sashi_mortise(board_size = board_get_default_size())
{
    overrun = board_size[1] * OVERRUN_RATIO;

    offset_tenon = [
            board_size[0]/2 - board_size[1]/2,
            0,
            -board_size[0] + board_size[2] + overrun];

    difference()
    {
        board(board_size);

        translate(offset_tenon)
            ooire_hozo_sashi_tenon(board_size);
    }
}

module ooire_hozo_sashi_example(board_size = board_get_default_size())
{
    translate([board_size[0]/2 - board_size[1]/2, 0, 0])
        ooire_hozo_sashi_tenon(board_size);

    translate([0, 0, board_size[0] + board_size[1]])
        ooire_hozo_sashi_mortise(board_size);
}

ooire_hozo_sashi_example();
