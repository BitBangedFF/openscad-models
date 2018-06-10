// ari_kake.scad

use <common/board.scad>

// ratio of the depth for the tenon thickness
DEPTH_RATIO = 1/3;

DOVETAIL_OFFSET_RATIO = 1/8;

module ari_kake_male(board_size = board_get_default_size())
{
    dovetail_offsetx = board_size[1] * DOVETAIL_OFFSET_RATIO;
    dovetail_thickness = board_size[2] * DEPTH_RATIO;

    cutout_size = [
            board_size[1],
            board_size[1],
            board_size[2] - dovetail_thickness];

    slope_points1 = [
            [0, 0],
            [board_size[1], 0],
            [0, dovetail_offsetx]];

    slope_points2 = [
            [0, 0],
            [board_size[1], 0],
            [0, -dovetail_offsetx]];

    difference()
    {
        board(board_size);

        translate([board_size[0] - cutout_size[0], 0, 0])
            cube(cutout_size);

        translate([board_size[0] - board_size[1], 0, 0])
            linear_extrude(
                    height = board_size[2],
                    center = false,
                    convexity = 0,
                    twist = 0)
                polygon(points = slope_points1);

        translate([board_size[0] - board_size[1], board_size[1], 0])
            linear_extrude(
                    height = board_size[2],
                    center = false,
                    convexity = 0,
                    twist = 0)
                polygon(points = slope_points2);
    }
}

module ari_kake_female(board_size = board_get_default_size())
{
    dovetail_offsetx = board_size[1] * DOVETAIL_OFFSET_RATIO;
    dovetail_thickness = board_size[2] * DEPTH_RATIO;

    points = [
            [0, 0],
            [board_size[1], 0],
            [board_size[1] - dovetail_offsetx, board_size[1]],
            [dovetail_offsetx, board_size[1]]];

    difference()
    {
        board(board_size);

        translate([board_size[0]/2 - board_size[1]/2, 0, board_size[2] - dovetail_thickness])
            linear_extrude(
                    height = dovetail_thickness,
                    center = false,
                    convexity = 0,
                    twist = 0)
                polygon(points = points);
    }
}

module ari_kake_example(board_size = board_get_default_size())
{
    ari_kake_female(board_size);

    translate([board_size[0]/2, board_size[0] - board_size[1], board_size[1]])
        rotate([0, 0, -90])
            translate([-board_size[0]/2, -board_size[1]/2, 0])
                ari_kake_male(board_size);
}

ari_kake_example();
