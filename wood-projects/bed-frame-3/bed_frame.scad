/**
 * @file bed_frame.scad
 * @brief TODO.
 *
 * units: centimeter
 *
 */

use <common/common_functions.scad>
use <common/board.scad>

// king size mattress
// - 80 x 76 in
// - 203.2 x 193.04 cm
// rounding up a little
MATTRESS_LENGTH = in_to_cm(80);
MATTRESS_WIDTH = in_to_cm(76);
MATTRESS_THICKNESS = in_to_cm(6);
MATTRESS_TO_EDGE_DISTANCE = in_to_cm(0.9);

POST_BOARD_LENGTH = in_to_cm(14.0);
POST_BOARD_WIDTH = 15.0;
POST_BOARD_THICKNESS = 15.0;

SUPPORT_BOARD_OVERRUN = in_to_cm(6.0);
SUPPORT_BOARD_WIDTH = in_to_cm(10.0);
SUPPORT_BOARD_THICKNESS = 4.6;

POST_SUPPORT_COVERAGE =
        POST_BOARD_THICKNESS
        - SUPPORT_BOARD_THICKNESS;

// measured from the posts, excludes support board overrun
END_TO_END_DISTANCE =
        MATTRESS_LENGTH
        + (2 * MATTRESS_TO_EDGE_DISTANCE)
        + (2 * POST_BOARD_THICKNESS)
        - (2 * POST_SUPPORT_COVERAGE);
SIDE_TO_SIDE_DISTANCE =
        MATTRESS_WIDTH
        + (2 * MATTRESS_TO_EDGE_DISTANCE)
        + (2 * POST_BOARD_WIDTH)
        - (2 * POST_SUPPORT_COVERAGE);

// TODO - scale of the width, use trig angles
TAPER_HEIGHT = SUPPORT_BOARD_WIDTH - in_to_cm(2.0) + 0.1;
TAPER_DEPTH = in_to_cm(3) + 0.1;

SIDE_SUPPORT_BOARD_LENGTH =
        END_TO_END_DISTANCE
        + (2 * SUPPORT_BOARD_OVERRUN);
SIDE_SUPPORT_BOARD_WIDTH = SUPPORT_BOARD_WIDTH;
SIDE_SUPPORT_BOARD_THICKNESS = SUPPORT_BOARD_THICKNESS;

END_SUPPORT_BOARD_LENGTH =
        SIDE_TO_SIDE_DISTANCE
        + (2 * SUPPORT_BOARD_OVERRUN);
END_SUPPORT_BOARD_WIDTH = SUPPORT_BOARD_WIDTH;
END_SUPPORT_BOARD_THICKNESS = SUPPORT_BOARD_THICKNESS;

CENTER_SUPPORT_BOARD_OVERRUN = 1.0;
CENTER_SUPPORT_TENON_WIDTH = in_to_cm(4.0);
CENTER_SUPPORT_BOARD_LENGTH =
        END_TO_END_DISTANCE
        - (POST_BOARD_THICKNESS / 2)
        - (SUPPORT_BOARD_THICKNESS / 2)
        + (2 * CENTER_SUPPORT_BOARD_OVERRUN);
CENTER_SUPPORT_BOARD_WIDTH = SUPPORT_BOARD_WIDTH;
CENTER_SUPPORT_BOARD_THICKNESS = SUPPORT_BOARD_THICKNESS;

PLANK_BOARD_LENGTH =
        (SIDE_TO_SIDE_DISTANCE - POST_BOARD_WIDTH) / 2;
PLANK_BOARD_WIDTH = in_to_cm(2.5);
PLANK_BOARD_THICKNESS = in_to_cm(1.0);

// each column has N support planks
PLANK_BOARD_SEP_DISTANCE = in_to_cm(1.94);
PLANK_BOARD_COUNT = 17;

module plank_board()
{
    board_size = [
            PLANK_BOARD_LENGTH,
            PLANK_BOARD_WIDTH,
            PLANK_BOARD_THICKNESS];

    translate([PLANK_BOARD_WIDTH, 0, 0])
        rotate([0, 0, 90])
            board(board_size);
}

module post_board()
{
    board_size = [
            POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    side_board_cutout_size = [
            POST_BOARD_THICKNESS + 2,
            SUPPORT_BOARD_THICKNESS,
            SUPPORT_BOARD_WIDTH + 1];

    side_board_cutout_offset = [
            -1,
            (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            POST_BOARD_LENGTH - SUPPORT_BOARD_WIDTH];

    end_board_cutout_size = [
            SUPPORT_BOARD_THICKNESS,
            POST_BOARD_THICKNESS + 2,
            SUPPORT_BOARD_WIDTH + 1];

    end_board_cutout_offset = [
            (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            -1,
            POST_BOARD_LENGTH - SUPPORT_BOARD_WIDTH];

    difference()
    {
        translate([POST_BOARD_THICKNESS, 0, 0])
            rotate([0, -90, 0])
                board(board_size);

        translate(side_board_cutout_offset)
            cube(side_board_cutout_size);

        translate(end_board_cutout_offset)
            cube(end_board_cutout_size);
    }
}

module taper_shape()
{
    linear_extrude(
            height = SIDE_SUPPORT_BOARD_THICKNESS + 0.2,
            center = false,
            convexity = 0,
            twist = 0)
    {
        polygon([[-0.1, -0.1], [TAPER_DEPTH, -0.1], [-0.1, TAPER_HEIGHT]]);
    }
}

module side_board_taper_shape()
{
    translate([0, SIDE_SUPPORT_BOARD_THICKNESS + 0.1, 0])
        rotate([90, 0, 0])
            taper_shape();
}

module end_board_taper_shape()
{
    translate([-0.1, 0, 0])
        rotate([90, 0, 90])
            taper_shape();
}

module side_support_board()
{
    board_size = [
            SIDE_SUPPORT_BOARD_LENGTH,
            SIDE_SUPPORT_BOARD_WIDTH,
            SIDE_SUPPORT_BOARD_THICKNESS];

    cutout_size = [
            SUPPORT_BOARD_THICKNESS,
            SUPPORT_BOARD_THICKNESS + 2,
            (SUPPORT_BOARD_WIDTH / 2) + 1];

    cutout_offset_a = [
            SUPPORT_BOARD_OVERRUN
                    + (POST_BOARD_THICKNESS / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            -1,
            -1];

    cutout_offset_b = [
            SIDE_SUPPORT_BOARD_LENGTH
                    - cutout_offset_a[0]
                    - SUPPORT_BOARD_THICKNESS,
            -1,
            -1];

    difference()
    {
        translate([0, SIDE_SUPPORT_BOARD_THICKNESS, 0])
            rotate([90, 0, 0])
                board(board_size);

        side_board_taper_shape();

        translate([SIDE_SUPPORT_BOARD_LENGTH, SIDE_SUPPORT_BOARD_THICKNESS, 0])
            rotate([0, 0, 180])
                side_board_taper_shape();

        translate(cutout_offset_a)
            cube(cutout_size);

        translate(cutout_offset_b)
            cube(cutout_size);
    }
}

module left_side_support_board()
{
    plank_dado_size = [
            PLANK_BOARD_WIDTH,
            (SUPPORT_BOARD_THICKNESS / 2) + 1,
            PLANK_BOARD_THICKNESS + 1];

    difference()
    {
        side_support_board();

        // dados to support the planks
        for(p = [0:PLANK_BOARD_COUNT - 1])
        {
            dist = PLANK_BOARD_WIDTH + PLANK_BOARD_SEP_DISTANCE;

            offset_m = [
                    POST_BOARD_THICKNESS
                            + SUPPORT_BOARD_OVERRUN
                            + (p * dist),
                    -1,
                    SUPPORT_BOARD_WIDTH
                            - PLANK_BOARD_THICKNESS];

            translate(offset_m)
                cube(plank_dado_size);
        }
    }
}

module right_side_support_board()
{
    plank_dado_size = [
            PLANK_BOARD_WIDTH,
            (SUPPORT_BOARD_THICKNESS / 2) + 1,
            PLANK_BOARD_THICKNESS + 1];

    difference()
    {
        side_support_board();

        // dados to support the planks
        for(p = [0:PLANK_BOARD_COUNT - 1])
        {
            dist = PLANK_BOARD_WIDTH + PLANK_BOARD_SEP_DISTANCE;

            offset_m = [
                    POST_BOARD_THICKNESS
                            + SUPPORT_BOARD_OVERRUN
                            + (p * dist),
                    (SUPPORT_BOARD_THICKNESS / 2),
                    SUPPORT_BOARD_WIDTH
                            - PLANK_BOARD_THICKNESS];

            translate(offset_m)
                cube(plank_dado_size);
        }
    }
}

module end_support_board()
{
    board_size = [
            END_SUPPORT_BOARD_LENGTH,
            END_SUPPORT_BOARD_WIDTH,
            END_SUPPORT_BOARD_THICKNESS];

    end_cutout_size = [
            SUPPORT_BOARD_THICKNESS + 2,
            SUPPORT_BOARD_THICKNESS,
            (SUPPORT_BOARD_WIDTH / 2) + 1];

    center_cutout_size = [
            SUPPORT_BOARD_THICKNESS + 2,
            SUPPORT_BOARD_THICKNESS,
            CENTER_SUPPORT_TENON_WIDTH + 1];

    cutout_offset_a = [
            -1,
            SUPPORT_BOARD_OVERRUN
                    + (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            (SUPPORT_BOARD_WIDTH / 2)];

    cutout_offset_b = [
            -1,
            (END_SUPPORT_BOARD_LENGTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            SUPPORT_BOARD_WIDTH
                    - CENTER_SUPPORT_TENON_WIDTH];

    cutout_offset_c = [
            -1,
            END_SUPPORT_BOARD_LENGTH
                    - cutout_offset_a[1]
                    - SUPPORT_BOARD_THICKNESS,
            (SUPPORT_BOARD_WIDTH / 2)];

    difference()
    {
        rotate([90, 0, 90])
            board(board_size);

        end_board_taper_shape();

        translate([END_SUPPORT_BOARD_THICKNESS, END_SUPPORT_BOARD_LENGTH, 0])
            rotate([0, 0, 180])
                end_board_taper_shape();

        translate(cutout_offset_a)
            cube(end_cutout_size);

        translate(cutout_offset_b)
            cube(center_cutout_size);

        translate(cutout_offset_c)
            cube(end_cutout_size);
    }
}

module center_support_board()
{
    board_size = [
            CENTER_SUPPORT_BOARD_LENGTH,
            CENTER_SUPPORT_BOARD_WIDTH,
            CENTER_SUPPORT_BOARD_THICKNESS];

    cutout_size = [
            SUPPORT_BOARD_THICKNESS + 1,
            SUPPORT_BOARD_THICKNESS + 2,
            CENTER_SUPPORT_BOARD_WIDTH
                    - CENTER_SUPPORT_TENON_WIDTH
                    + 1];

    plank_dado_size = [
            PLANK_BOARD_WIDTH,
            SUPPORT_BOARD_THICKNESS + 2,
            PLANK_BOARD_THICKNESS + 1];

    cutout_offset_a = [
            -1,
            -1,
            -1];

    cutout_offset_b = [
            CENTER_SUPPORT_BOARD_LENGTH
                    - SUPPORT_BOARD_THICKNESS,
            -1,
            -1];

    difference()
    {
        translate([0, CENTER_SUPPORT_BOARD_THICKNESS, 0])
            rotate([90, 0, 0])
                board(board_size);

        translate(cutout_offset_a)
            cube(cutout_size);

        translate(cutout_offset_b)
            cube(cutout_size);

        // dados to support the planks
        for(p = [0:PLANK_BOARD_COUNT - 1])
        {
            dist = PLANK_BOARD_WIDTH + PLANK_BOARD_SEP_DISTANCE;

            offset_m = [
                    (POST_BOARD_THICKNESS / 2)
                            + (SUPPORT_BOARD_THICKNESS / 2)
                            + CENTER_SUPPORT_BOARD_OVERRUN
                            + (p * dist),
                    -1,
                    SUPPORT_BOARD_WIDTH
                            - PLANK_BOARD_THICKNESS];

            translate(offset_m)
                cube(plank_dado_size);
        }
    }
}

module side_supports()
{
    offset_a = [
            -SUPPORT_BOARD_OVERRUN,
            (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            POST_BOARD_LENGTH - SUPPORT_BOARD_WIDTH];

    offset_b = [
            -SUPPORT_BOARD_OVERRUN,
            SIDE_TO_SIDE_DISTANCE
                    - (POST_BOARD_WIDTH / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            POST_BOARD_LENGTH - SUPPORT_BOARD_WIDTH];

    translate(offset_a)
        right_side_support_board();

    translate(offset_b)
        left_side_support_board();
}

module end_supports()
{
    offset_a = [
            (POST_BOARD_THICKNESS / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            -SUPPORT_BOARD_OVERRUN,
            POST_BOARD_LENGTH - SUPPORT_BOARD_WIDTH];

    offset_b = [
            END_TO_END_DISTANCE
                    - (POST_BOARD_THICKNESS / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            -SUPPORT_BOARD_OVERRUN,
            POST_BOARD_LENGTH - SUPPORT_BOARD_WIDTH];

    translate(offset_a)
        end_support_board();

    translate(offset_b)
        end_support_board();
}

module support_posts()
{
    offset_a = [
            0,
            0,
            0];

    offset_b = [
            END_TO_END_DISTANCE
                    - POST_BOARD_THICKNESS,
            0,
            0];

    offset_c = [
            END_TO_END_DISTANCE
                    - POST_BOARD_THICKNESS,
            SIDE_TO_SIDE_DISTANCE
                    - POST_BOARD_WIDTH,
            0];

    offset_d = [
            0,
            SIDE_TO_SIDE_DISTANCE
                    - POST_BOARD_WIDTH,
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

module center_support_assembly()
{
    board_offset = [
            (POST_BOARD_THICKNESS / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2)
                    - CENTER_SUPPORT_BOARD_OVERRUN,
            (SIDE_TO_SIDE_DISTANCE / 2)
                    - (SUPPORT_BOARD_THICKNESS / 2),
            POST_BOARD_LENGTH - SUPPORT_BOARD_WIDTH];

    translate(board_offset)
        center_support_board();
}

module base_assembly()
{
    color("SandyBrown")
        side_supports();

    color("SandyBrown")
        end_supports();

    color("Peru")
        support_posts();

    color("SandyBrown")
        center_support_assembly();
}

module support_planks()
{
    ly = SIDE_TO_SIDE_DISTANCE
            - PLANK_BOARD_LENGTH
            - (POST_BOARD_WIDTH / 2);
    ry = (POST_BOARD_WIDTH / 2);
    dist = PLANK_BOARD_WIDTH + PLANK_BOARD_SEP_DISTANCE;

    for(p = [0:PLANK_BOARD_COUNT - 1])
    {
        left_offset = [
                POST_BOARD_THICKNESS
                        + (p * dist),
                ly,
                POST_BOARD_LENGTH
                        - PLANK_BOARD_THICKNESS];

        right_offset = [
                POST_BOARD_THICKNESS
                        + (p * dist),
                ry,
                POST_BOARD_LENGTH
                        - PLANK_BOARD_THICKNESS];

        translate(left_offset)
            plank_board();

        translate(right_offset)
            plank_board();
    }
}

module bed_frame()
{
    base_assembly();

    color("BurlyWood")
        support_planks();
}

module mattress()
{
    mattress_size = [
            MATTRESS_LENGTH,
            MATTRESS_WIDTH,
            MATTRESS_THICKNESS];

    offset_m = [
            POST_BOARD_THICKNESS
                    - POST_SUPPORT_COVERAGE
                    + MATTRESS_TO_EDGE_DISTANCE,
            POST_BOARD_WIDTH
                    - POST_SUPPORT_COVERAGE
                    + MATTRESS_TO_EDGE_DISTANCE,
            POST_BOARD_LENGTH + 1];

    translate(offset_m)
        cube(mattress_size);
}

module bed_example()
{
    bed_frame();

    color("Peru")
        translate([83, -197, 0])
            post_board();

    color("SandyBrown")
        translate([68, -192, 50])
            right_side_support_board();

    color("SandyBrown")
        translate([288, -213, 20])
            end_support_board();

    color("SandyBrown")
        translate([70, -98, 35])
            center_support_board();

    %mattress();
}

// TODO - move to a dedicated file, there must be a better way to do this
module print_vars()
{
    echo("-----------------------------------");
    echo(SUPPORT_BOARD_WIDTH = SUPPORT_BOARD_WIDTH);
    echo(INCHES = cm_to_in(SUPPORT_BOARD_WIDTH));

    echo("-----------------------------------");
    echo(SUPPORT_BOARD_THICKNESS = SUPPORT_BOARD_THICKNESS);
    echo(INCHES = cm_to_in(SUPPORT_BOARD_THICKNESS));

    echo("-----------------------------------");
    echo(SIDE_SUPPORT_BOARD_LENGTH = SIDE_SUPPORT_BOARD_LENGTH);
    echo(INCHES = cm_to_in(SIDE_SUPPORT_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(END_SUPPORT_BOARD_LENGTH = END_SUPPORT_BOARD_LENGTH);
    echo(INCHES = cm_to_in(END_SUPPORT_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(END_TO_END_DISTANCE = END_TO_END_DISTANCE);
    echo(INCHES = cm_to_in(END_TO_END_DISTANCE));

    echo("-----------------------------------");
    echo(SIDE_TO_SIDE_DISTANCE = SIDE_TO_SIDE_DISTANCE);
    echo(INCHES = cm_to_in(SIDE_TO_SIDE_DISTANCE));

    echo("-----------------------------------");
    echo(POST_SUPPORT_COVERAGE =POST_SUPPORT_COVERAGE);
    echo(INCHES = cm_to_in(POST_SUPPORT_COVERAGE));

    echo("-----------------------------------");
}

bed_example();
print_vars();
