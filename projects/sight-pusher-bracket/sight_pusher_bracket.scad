/**
 * @file sight_pusher_bracket.scad
 * @brief Sight-pusher bracket.
 *
 * units: millimeter
 *
 */

//ECHO: BASE_LENGTH = 58
//ECHO: BASE_WIDTH = 64
//ECHO: THICKNESS = 6
//ECHO: BOLT_HOLE_DIAMETER = 8
//ECHO: BOLT_HOLE_OFFSET_L = 45
//ECHO: BOLT_HOLE_C2C = 44.45
//ECHO: INNER_CUTOUT_LENGTH = 36
//ECHO: INNER_CUTOUT_WIDTH = 30
//ECHO: INNER_CUTOUT_OFFSET_L = 24

use <common/common_functions.scad>
use <roundedcube.scad>

BOLT_HOLE_DIAMETER = 8.0; // 5/16" rouned up
//BOLT_HOLE_DIAMETER = in_to_mm(5.0 / 16.0);

THICKNESS = 6.0;
BASE_LENGTH = 58.0;
BASE_WIDTH = 64.0;

INNER_CUTOUT_OFFSET_L = 24.0;
INNER_CUTOUT_LENGTH = 34.0 + 2; // Extend past the part for the rouned edges
INNER_CUTOUT_WIDTH = 30.0;

// Offset from top, down the length
BOLT_HOLE_OFFSET_L = 45.0;

// 44.45 (1 3/4 inches) bolt hole center-to-center
BOLT_HOLE_C2C = 44.45;

module drill_hole_cyl()
{
    #cylinder(h = THICKNESS + 1, d = BOLT_HOLE_DIAMETER, center = true, $fn = 80);
}

module inner_cutout()
{
    #roundedcube(
        [INNER_CUTOUT_LENGTH, INNER_CUTOUT_WIDTH, THICKNESS + 1],
        center = true,
        radius = 2.0,
        apply_to = "z");
}

module base()
{
    roundedcube(
        [BASE_LENGTH, BASE_WIDTH, THICKNESS],
        center = true,
        radius = 2.0,
        apply_to = "z"
    );
}

module assembly()
{
    difference()
    {
        translate([BASE_LENGTH / 2, 0, 0])
            base();
        
        translate([INNER_CUTOUT_LENGTH / 2, 0, 0])
            translate([INNER_CUTOUT_OFFSET_L, 0, 0])
                inner_cutout();

        translate([BOLT_HOLE_OFFSET_L, BOLT_HOLE_C2C / 2, 0])
            drill_hole_cyl();
        translate([BOLT_HOLE_OFFSET_L, -BOLT_HOLE_C2C / 2, 0])
            drill_hole_cyl();
    }
}

assembly();

echo(BASE_LENGTH = BASE_LENGTH);
echo(BASE_WIDTH = BASE_WIDTH);
echo(THICKNESS = THICKNESS);
echo(BOLT_HOLE_DIAMETER = BOLT_HOLE_DIAMETER);
echo(BOLT_HOLE_OFFSET_L = BOLT_HOLE_OFFSET_L);
echo(BOLT_HOLE_C2C = BOLT_HOLE_C2C);
echo(INNER_CUTOUT_LENGTH = INNER_CUTOUT_LENGTH);
echo(INNER_CUTOUT_WIDTH = INNER_CUTOUT_WIDTH);
echo(INNER_CUTOUT_OFFSET_L = INNER_CUTOUT_OFFSET_L);
