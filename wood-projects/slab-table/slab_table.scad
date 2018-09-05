/**
 * @file slab_table.scad
 * @brief TODO.
 *
 * units: centimeter
 *
 * TODO:
 * - slab poly instead of square board
 *
 */

/* [Hidden] */
VISUAL_OVERRUN = 0.1;

/* [Configuration] */
UNITS = "cm"; // [cm]
COLOR = true;
TENON_OVERRUN = 0.5;
POST_TENON_CUTOUT_SIZE = 3.0;
SUPPORT_BEAM_TENON_OVERRUN = 10.0;

/* [Board Dimensions] */
SLAB_LENGTH = 254.0;
SLAB_WIDTH = 76.2;
SLAB_THICKNESS = 5.08;
POST_LENGTH = 25.0;
POST_WIDTH = 15.0;
POST_THICKNESS = 15.0;
SUPPORT_BEAM_WIDTH = 10.0;
SUPPORT_BEAM_THICKNESS = 4.6;

/* [Layout] */
// X offset of post center
POST_MAJOR_OFFSET = 40.0;
// Y offset of post center
POST_MINOR_OFFSET = 38.1;
// X distance from post center to post center
POST_MAJOR_DIST = 175.0;
// Y distance from post center to post center
POST_MINOR_DIST = 40.0;
// Z height of the base of the support beams
SUPPORT_BEAM_HEIGHT = 18.0;

use <common/board.scad>

function post_size() = [POST_LENGTH, POST_WIDTH, POST_THICKNESS];

function major_support_beam_size() = [
    POST_THICKNESS
        + POST_MAJOR_DIST
        + (2 * SUPPORT_BEAM_TENON_OVERRUN),
    SUPPORT_BEAM_WIDTH,
    SUPPORT_BEAM_THICKNESS];

function minor_support_beam_size() = [
    POST_MINOR_DIST
        - POST_WIDTH
        + (2 * SUPPORT_BEAM_MINOR_TENON_LENGTH),
    SUPPORT_BEAM_WIDTH,
    SUPPORT_BEAM_THICKNESS];

function slab_size() = [SLAB_LENGTH, SLAB_WIDTH, SLAB_THICKNESS];

module post_board()
{
    translate([POST_THICKNESS, 0, 0])
        rotate([0, -90, 0])
            board(post_size());
}

module post()
{
    assert(POST_TENON_CUTOUT_SIZE >= 0);
    assert(POST_TENON_CUTOUT_SIZE < (POST_WIDTH / 2));

    tenon_depth = SLAB_THICKNESS + TENON_OVERRUN;

    offset_z = POST_LENGTH - tenon_depth;
    offset_y1 = -VISUAL_OVERRUN;
    offset_y2 = POST_WIDTH - POST_TENON_CUTOUT_SIZE;
    offset_x1 = -VISUAL_OVERRUN;
    offset_x2 = POST_THICKNESS - POST_TENON_CUTOUT_SIZE;

    cutout_a = [
            POST_TENON_CUTOUT_SIZE
                + VISUAL_OVERRUN,
            POST_WIDTH
                + (2 * VISUAL_OVERRUN),
            tenon_depth
                + VISUAL_OVERRUN];

    cutout_b = [
            POST_THICKNESS
                + (2 * VISUAL_OVERRUN),
            POST_TENON_CUTOUT_SIZE
                + VISUAL_OVERRUN,
            tenon_depth
                + VISUAL_OVERRUN];

    difference()
    {
        post_board();

        translate([offset_x1, offset_y1, offset_z])
            cube(cutout_a, center = false);
        translate([offset_x2, offset_y1, offset_z])
            cube(cutout_a, center = false);
        translate([offset_x1, offset_y1, offset_z])
            cube(cutout_b, center = false);
        translate([offset_x1, offset_y2, offset_z])
            cube(cutout_b, center = false);
    }
}

module posts_assembly()
{
    assert(POST_MAJOR_DIST >= 0);
    assert(POST_MINOR_DIST >= 0);

    offset_a = [
            -(POST_THICKNESS / 2)
                + POST_MAJOR_OFFSET,
            -(POST_WIDTH / 2)
                + POST_MINOR_OFFSET,
            0];

    offset_b = [
            -(POST_THICKNESS / 2)
                + POST_MAJOR_OFFSET
                + POST_MAJOR_DIST,
            -(POST_WIDTH / 2)
                + POST_MINOR_OFFSET,
            0];

    translate(offset_a)
        post();
    translate(offset_b)
        post();
}

module major_support_beam_board()
{
    translate([0, SUPPORT_BEAM_THICKNESS, 0])
        rotate([90, 0, 0])
            board(major_support_beam_size());
}

module major_support_assembly()
{
    offset_a = [
            -(POST_THICKNESS / 2)
                + POST_MAJOR_OFFSET
                - SUPPORT_BEAM_TENON_OVERRUN,
            POST_MINOR_OFFSET
                - (SUPPORT_BEAM_THICKNESS / 2),
            SUPPORT_BEAM_HEIGHT];

    translate(offset_a)
        major_support_beam_board();
}

module slab_board()
{
    board(slab_size());
}

module slab()
{
    translate([0, 0, POST_LENGTH - SLAB_THICKNESS - TENON_OVERRUN])
        slab_board();
}

module slab_table()
{
    if(COLOR == true)
    {
        color("NavajoWhite")
            slab();
        color("SandyBrown")
            posts_assembly();
        color("SaddleBrown")
            major_support_assembly();
    }
    else
    {
        slab();
        posts_assembly();
        major_support_assembly();
    }
}

slab_table();
