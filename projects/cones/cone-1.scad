/**
 * @file cone-1.scad
 * @brief TODO.
 *
 * units: centimeter
 *
 * (a / b) = gr = (1 + sqrt(5)) / 2
 *
 * b = base_diameter = (2 * radius)
 *
 */

// modules
use <common/common_functions.scad>

// constants
VISUAL_OVERRUN = get_visual_overrun();
BASE_SIZE = 10.0;
BASE_THICKNESS = 0.4;
WALL_THICKNESS = 0.4;
RATIO = (1 + sqrt(5)) / 2;

R = 3.0;
B = (2 * R);
A = (B * RATIO);
H = sqrt(pow(A, 2) + pow(R, 2));

BASE_CUTOUT_R = R - 0.2;

module cone()
{
    cylinder(
            h = H,
            r1 = R,
            r2 = 0,
            center = false,
            $fn = 80);
}

module base()
{
    base_size = [
            BASE_SIZE,
            BASE_SIZE,
            BASE_THICKNESS];

    base_offset = [
            0,
            0,
            BASE_THICKNESS / 2];

    difference()
    {
        translate(base_offset)
            cube(size = base_size, center = true);

        translate([0, 0, -VISUAL_OVERRUN])
            cylinder(
                    h = BASE_THICKNESS + (2 * VISUAL_OVERRUN),
                    r1 = BASE_CUTOUT_R,
                    r2 = BASE_CUTOUT_R,
                    center = false,
                    $fn = 80);
    }
}

module assembly()
{
    union()
    {
        translate([0, 0, BASE_THICKNESS])
            difference()
            {
                cone();

                translate([0, 0, -WALL_THICKNESS])
                    cone();
            }

        base();
    }
}

assembly();

echo(RATIO = RATIO);
echo(R = R);
echo(H = H);
echo(B = B);
echo(A = A);
echo(str("A / B = ", A / B));
echo(BASE_CUTOUT_R = BASE_CUTOUT_R);
echo(BASE_SIZE = BASE_SIZE);
echo(BASE_THICKNESS = BASE_THICKNESS);
echo(WALL_THICKNESS = WALL_THICKNESS);
