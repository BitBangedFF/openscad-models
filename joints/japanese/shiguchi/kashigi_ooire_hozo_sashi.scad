// kashigi_ooire_hozo_sashi.scad

use <common/board.scad>

PIN_RATIO = 1/8;
OFFSET_RATIO = 1/8;
TENON_WIDTH_RATIO = 1/3;

module kashigi_ooire_hozo_sashi_pin(board_size = board_get_default_size())
{
    pin_width = board_size[1] * PIN_RATIO;

    pin_size = [
            board_size[1],
            pin_width,
            pin_width];

    pin_offset = [
            board_size[2]/2 - pin_width/2,
            pin_size[0],
            board_size[2]/2 - pin_width/2];

    translate(pin_offset)
        rotate([0, 0, -90])
            cube(pin_size);
}

module kashigi_ooire_hozo_sashi_tenon(board_size = board_get_default_size())
{
    offsetx = board_size[2] * OFFSET_RATIO;
    tenon_width = board_size[1] * TENON_WIDTH_RATIO;

    cutout_size = [
            board_size[1] - offsetx,
            (board_size[1] - tenon_width)/2,
            board_size[2]];

    slope_points = [
            [-offsetx, 0],
            [-offsetx, -board_size[1]],
            [0, -board_size[1]]];

    difference()
    {
        board(board_size);

        cube(cutout_size);

        translate([0, board_size[1] - tenon_width, 0])
            cube(cutout_size);

        translate([board_size[1], 0, 0])
            rotate([-90, 0, 0])
                linear_extrude(
                        height = cutout_size[1],
                        center = false,
                        convexity = 0,
                        twist = 0)
                    polygon(points = slope_points);

        translate([board_size[1], board_size[1] - tenon_width, 0])
            rotate([-90, 0, 0])
                linear_extrude(
                        height = cutout_size[1] + 0.01,
                        center = false,
                        convexity = 0,
                        twist = 0)
                    polygon(points = slope_points);

        kashigi_ooire_hozo_sashi_pin(board_size);
    }
}

module kashigi_ooire_hozo_sashi_mortise(board_size = board_get_default_size())
{
    offset_center = [
            -board_size[0]/2,
            -board_size[1]/2,
            -board_size[2]/2];

    difference()
    {
        translate([board_size[2]/2, board_size[1]/2, board_size[2]/2])
            rotate([0, 90, 0])
                translate(offset_center)
                    board(board_size);

        kashigi_ooire_hozo_sashi_tenon(board_size);

        kashigi_ooire_hozo_sashi_pin(board_size);
    }
}

module kashigi_ooire_hozo_sashi_example(board_size = board_get_default_size())
{
    translate([2 * board_size[1], 0, 0])
        kashigi_ooire_hozo_sashi_tenon(board_size);

    kashigi_ooire_hozo_sashi_mortise(board_size);

    translate([board_size[1], 0, 0])
        kashigi_ooire_hozo_sashi_pin(board_size);
}

kashigi_ooire_hozo_sashi_example();
