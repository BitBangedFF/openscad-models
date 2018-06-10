/**
 * @file pyramid.scad
 * @brief TODO.
 *
 * units: centimeter
 *
 */

// modules
use <common/common_functions.scad>
use <common/board.scad>

// constants
VISUAL_OVERRUN = get_visual_overrun();

RATIO = (1 + sqrt(5)) / 2;

BASE_DIMENSION = ft_to_cm(3.5);

POST_WIDTH = in_to_cm(1.5);
POST_THICKNESS = in_to_cm(1.5);

SIDE_POST_LENGTH = BASE_DIMENSION * RATIO;
BASE_POST_LENGTH = BASE_DIMENSION;

SIDE_HEIGHT = side_height();

BASE_ANGLE = 72.0;
SLOPE_ANGLE = slope_angle();

TOTAL_LENGTH =
    (4 * SIDE_POST_LENGTH)
    + (4 * BASE_POST_LENGTH);

// b = sqrt(c^2 - a^2)
function side_height() =
    sqrt(pow(SIDE_POST_LENGTH, 2) - pow((BASE_DIMENSION / 2), 2));

// angle = acos(adj / hyp)
function slope_angle() =
    acos((BASE_DIMENSION / 2) / SIDE_HEIGHT);

module side_post_board()
{
    board_size = [
            SIDE_POST_LENGTH,
            POST_WIDTH,
            POST_THICKNESS];

    translate([SIDE_POST_LENGTH / 2, 0, 0])
        board(board_size, center = true);
}

module base_post_board()
{
    board_size = [
            BASE_POST_LENGTH,
            POST_WIDTH,
            POST_THICKNESS];

    translate([BASE_POST_LENGTH / 2, 0, 0])
        board(board_size, center = true);
}

module side_post(side_a = true)
{
    angle_a = (180 - (2 * BASE_ANGLE)) / 2;
    angle_b = (180 - (2 * SLOPE_ANGLE)) / 2;
    length = SIDE_POST_LENGTH / 8;

    cutout_a_size = [
            length,
            POST_WIDTH
                + (2 * VISUAL_OVERRUN),
            POST_THICKNESS];

    cutout_b_size = [
            length,
            POST_WIDTH,
            POST_THICKNESS
                + (2 * VISUAL_OVERRUN)];

    cutout_a_offset = [
            SIDE_POST_LENGTH
                + length
                - cutout_a_size[0],
            -(POST_WIDTH / 2)
                - VISUAL_OVERRUN,
            0];

    cutout_b_offset = [
            SIDE_POST_LENGTH
                + length
                - cutout_b_size[0],
            0,
            -POST_THICKNESS / 2
                - VISUAL_OVERRUN];

    difference()
    {
        side_post_board();

        if(side_a == true)
        {
            translate(cutout_a_offset)
                rotate([0, angle_a, 0])
                    translate([-length, 0, 0])
                        cube(cutout_a_size);
        }
        else
        {
            translate(cutout_a_offset)
                rotate([0, -angle_a, 0])
                    translate([-length, 0, -POST_THICKNESS])
                        cube(cutout_a_size);
        }

        translate(cutout_b_offset)
            rotate([0, 0, -angle_b])
                translate([-length, 0, 0])
                    cube(cutout_b_size);
    }
}

module base_assembly()
{
    slope_xy_offset = cos(SLOPE_ANGLE) * (POST_THICKNESS / 2);
    slope_z_offset = sin(SLOPE_ANGLE) * (POST_THICKNESS / 2);
    base_xy_offset = cos(BASE_ANGLE) * (POST_THICKNESS / 2);
    base_z_offset = sin(BASE_ANGLE) * (POST_THICKNESS / 2);

    union()
    {
        translate([0, base_xy_offset, base_z_offset])
            rotate([BASE_ANGLE, 0, 0])
                base_post_board();

        translate([0, BASE_DIMENSION - base_xy_offset, base_z_offset])
            rotate([-BASE_ANGLE, 0, 0])
                base_post_board();

        translate([slope_xy_offset, 0, slope_z_offset])
            rotate([-SLOPE_ANGLE, 0, 90])
                base_post_board();

        translate([BASE_DIMENSION - slope_xy_offset, 0, slope_z_offset])
            rotate([SLOPE_ANGLE, 0, 90])
                base_post_board();
    }
}

module side_assembly()
{
    union()
    {
        rotate([90, 0, 90 - BASE_ANGLE])
            side_post(false);

        translate([0, BASE_DIMENSION, 0])
            rotate([90, 0, -(90 - BASE_ANGLE)])
                side_post(true);
    }
}

module pyramid_assembly()
{
    union()
    {
        base_assembly();

        translate([BASE_DIMENSION, 0, 0])
            rotate([0, -180 + SLOPE_ANGLE, 0])
                side_assembly();

        translate([0, BASE_DIMENSION, 0])
            rotate([0, -180 + SLOPE_ANGLE, 180])
                side_assembly();
    }
}

module pyramid_demo()
{
    color("SandyBrown")
        pyramid_assembly();
}

pyramid_demo();

echo(RATIO = RATIO);
echo(BASE_DIMENSION = BASE_DIMENSION);
echo(BASE_ANGLE = BASE_ANGLE);
echo(SLOPE_ANGLE = SLOPE_ANGLE);
echo(SIDE_POST_LENGTH = SIDE_POST_LENGTH);
echo(BASE_POST_LENGTH = BASE_POST_LENGTH);
echo(SIDE_HEIGHT = SIDE_HEIGHT);
echo(TOTAL_LENGTH = TOTAL_LENGTH);
echo(str("TOTAL_LENGTH(ft) = ", cm_to_ft(TOTAL_LENGTH)));
