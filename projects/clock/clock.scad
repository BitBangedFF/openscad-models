/**
 * @file clock.scad
 * @brief TODO.
 *
 * units: centimeter
 *
 */

// modules
use <common/common_functions.scad>

// constants
VISUAL_OVERRUN = get_visual_overrun();

MAIN_BLOCK_LENGTH = 14.0;
MAIN_BLOCK_WIDTH = 14.0;
MAIN_BLOCK_THICKNESS = 5.0;

CENTER_CUTOUT_LENGTH = 5.0;
CENTER_CUTOUT_WIDTH = 5.0;
CENTER_CUTOUT_THICKNESS = MAIN_BLOCK_THICKNESS / 2;

SMALL_TUBE_RADIUS = in_to_cm(0.25) / 2;
LARGE_TUBE_RADIUS = 1.0;

CLOCK_RADIUS = (MAIN_BLOCK_LENGTH / 2) - 2;

module small_tube_cutout()
{
    translate([-VISUAL_OVERRUN, 0, 0])
       rotate([0, 90, 0])
            cylinder(
                    h = MAIN_BLOCK_THICKNESS + (2 * VISUAL_OVERRUN),
                    r1 = SMALL_TUBE_RADIUS,
                    r2 = SMALL_TUBE_RADIUS,
                    center = false,
                    $fn = 80);
}

module large_tube_cutout()
{
    translate([-VISUAL_OVERRUN, 0, 0])
       rotate([0, 90, 0])
            cylinder(
                    h = (MAIN_BLOCK_THICKNESS / 3) + VISUAL_OVERRUN,
                    r1 = LARGE_TUBE_RADIUS,
                    r2 = LARGE_TUBE_RADIUS,
                    center = false,
                    $fn = 80);
}

module tubes_cutout_assembly()
{
    angle_start = 0;
    angle_end = 360;
    angle_step = 360 / 12;

    for(a = [angle_start:angle_step:angle_end])
    {
        cartesian_pos = [
                0,
                (MAIN_BLOCK_WIDTH / 2)
                    + (CLOCK_RADIUS * cos(a)),
                (MAIN_BLOCK_LENGTH / 2)
                    + (CLOCK_RADIUS * sin(a))];

        translate(cartesian_pos)
        {
            small_tube_cutout();

            large_tube_cutout();
        }
    }
}

module center_cutout_assembly()
{
    center_cutout_size = [
            CENTER_CUTOUT_THICKNESS,
            CENTER_CUTOUT_WIDTH,
            CENTER_CUTOUT_LENGTH];

    center_cutout_offset = [
            -VISUAL_OVERRUN,
            (MAIN_BLOCK_WIDTH / 2)
                - (CENTER_CUTOUT_WIDTH / 2),
            (MAIN_BLOCK_LENGTH / 2)
                - (CENTER_CUTOUT_LENGTH / 2)];

    translate(center_cutout_offset)
        cube(size = center_cutout_size, center = false);
}

module main_block()
{
    main_block_size = [
            MAIN_BLOCK_LENGTH,
            MAIN_BLOCK_WIDTH,
            MAIN_BLOCK_THICKNESS];

    translate([MAIN_BLOCK_THICKNESS, 0, 0])
        rotate([0, -90, 0])
            cube(size = main_block_size, center = false);
}

module assembly()
{
    difference()
    {
        main_block();

        tubes_cutout_assembly();

        center_cutout_assembly();
    }
}

color("SaddleBrown")
    assembly();

echo(SMALL_TUBE_RADIUS = SMALL_TUBE_RADIUS);
echo(CLOCK_RADIUS = CLOCK_RADIUS);
