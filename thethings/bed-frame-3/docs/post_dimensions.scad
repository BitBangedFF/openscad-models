/**
 * @file post_dimensions.scad
 * @brief TODO.
 *
 */

DOC_SCALING_FACTOR = 10;

include <dimlines/dimlines.scad>
include <titleblocks/titleblock1.scad>
include <../parts/bed_frame.scad>

PART_DETAILS = [
        "Post",               // title
        "Cherry (wood)",      // material
        "Planed",             // finish
        " ",                  // weight
        "1"];                 // part no

PART_REVISIONS = [
        ["0.1", "28 FEB 18", "jl"]];

DOC_DETAILS = [
        "1-1",              // drawing number
        "Lambo",            // created by
        " ",                // reviewed by
        "28 FEB 2018"];     // date of issue

ORG_DETAILS = [
        " ",
        "Stuff I Build",
        "units: centimeter (cm)"];

PART_LENGTH = POST_BOARD_LENGTH;
PART_WIDTH = POST_BOARD_WIDTH;
PART_THICKNESS = POST_BOARD_THICKNESS;

ROTATION2 = [-90, 0, 0];
ROTATION3 = [0, 90, 90];
ROTATION4 = [-65, 25, 10];

ROT2_VIEW = [0, -100, 0];
ROT3_VIEW = [150, -125 * 0.5, 0];
ROT4_VIEW = [150, 10, 0];

DOC_HEIGHT = PART_LENGTH / 2 + 5;

DIM_LINE_WIDTH = 0.03 * DOC_SCALING_FACTOR;
DIM_SPACE = 0.1 * DOC_SCALING_FACTOR;
DIM_HEIGHT = 0.01;
DIM_FONTSCALE = DIM_LINE_WIDTH * 0.9;

module show_part()
{
    offset_t = [
            0,
            0,
            0];

    color("SandyBrown")
        translate(offset_t)
            rotate([0, 0, 0])
                post();
}

module show_docs1()
{
    union()
    {
        translate([0, PART_THICKNESS + (3 * DIM_SPACE), 0])
            dimensions(PART_THICKNESS, DIM_LINE_WIDTH);

        rotate([0, 0, 90])
            union()
            {
                translate([PART_THICKNESS + DIM_SPACE, 0, 0])
                    line(
                            length = (3 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);

                translate([PART_THICKNESS + DIM_SPACE, -PART_THICKNESS, 0])
                    line(
                            length = (3 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);
            }

        rotate([0, 0, -90])
            translate([-PART_WIDTH, PART_THICKNESS + (3 * DIM_SPACE), 0])
                dimensions(PART_WIDTH, DIM_LINE_WIDTH);

        translate([PART_THICKNESS + DIM_SPACE, 0, 0])
        {
            line(
                    length = (3 * DIM_SPACE),
                    width = DIM_LINE_WIDTH,
                    height = 0.01,
                    left_arrow = false,
                    right_arrow = false);

            translate([0, PART_WIDTH, 0])
                line(
                        length = (3 * DIM_SPACE),
                        width = DIM_LINE_WIDTH,
                        height = 0.01,
                        left_arrow = false,
                        right_arrow = false);
        }
    }
}

module show_view1()
{
    translate([0, 0, -PART_WIDTH])
        show_part();

    color("Black")
        translate([0, 0, DOC_HEIGHT])
            show_docs1();
}

module show_docs2()
{
    dist_a = SUPPORT_BOARD_THICKNESS;

    dist_b = (dist_a / 2);

    dist_c =
            (POST_BOARD_THICKNESS / 2)
            - (SUPPORT_BOARD_THICKNESS / 2);

    dist_d = ABOVE_GROUND_DISTANCE;

    union()
    {
        translate([dist_c, PART_LENGTH + (3 * DIM_SPACE), 0])
            dimensions(dist_a, DIM_LINE_WIDTH, DIM_LEFT);

        translate([PART_THICKNESS + (3 * DIM_SPACE), dist_d, 0])
            rotate([0, 0, -90])
                dimensions(dist_d, DIM_LINE_WIDTH, DIM_LEFT);

        translate([PART_THICKNESS + DIM_SPACE, 0, 0])
            line(
                    length = (3 * DIM_SPACE),
                    width = DIM_LINE_WIDTH,
                    height = 0.01,
                    left_arrow = false,
                    right_arrow = false);

        translate([PART_THICKNESS + DIM_SPACE, dist_d, 0])
            line(
                    length = (3 * DIM_SPACE),
                    width = DIM_LINE_WIDTH,
                    height = 0.01,
                    left_arrow = false,
                    right_arrow = false);
    }
}

module show_view2()
{
    translate(ROT2_VIEW)
        rotate(ROTATION2)
            show_part();

    color("Black")
        translate(ROT2_VIEW)
            translate([0, 0, DOC_HEIGHT])
                show_docs2();
}

module show_docs3()
{
    dist_a = PART_LENGTH;

    union()
    {
        translate([(3 * DIM_SPACE), dist_a, 0])
            rotate([0, 0, -90])
                dimensions(dist_a, DIM_LINE_WIDTH, DIM_CENTER);

        translate([DIM_SPACE, 0, 0])
            line(
                    length = (3 * DIM_SPACE),
                    width = DIM_LINE_WIDTH,
                    height = 0.01,
                    left_arrow = false,
                    right_arrow = false);

        translate([DIM_SPACE, dist_a, 0])
            line(
                    length = (3 * DIM_SPACE),
                    width = DIM_LINE_WIDTH,
                    height = 0.01,
                    left_arrow = false,
                    right_arrow = false);
    }
}

module show_view3()
{
    translate(ROT3_VIEW)
        rotate(ROTATION3)
            show_part();

    color("Black")
        translate(ROT3_VIEW)
            translate([0, 0, DOC_HEIGHT])
                show_docs3();
}

module show_view4()
{
    translate(ROT4_VIEW)
        rotate(ROTATION4)
            show_part();
}

module show_frame(
        length,
        height,
        line_width = DIM_LINE_WIDTH)
{
    line(length = length, width = line_width);

    translate([0, height, 0])
        line(length = length, width = line_width);

    translate([line_width / 2, line_width / 2, 0])
        rotate([0, 0, 90])
            line(length = height - line_width, width = line_width);

    translate([length - line_width / 2, line_width / 2, 0])
        rotate([0, 0, 90])
            line(length = height - line_width, width = line_width);
}

module show_documentation()
{
    color("Black")
        translate([-50, -150, DOC_HEIGHT])
            color("Black")
                union()
                {
                    show_frame(
                            length = 325,
                            height = 225,
                            line_width = DIM_LINE_WIDTH * 2);

                    color("Black")
                        translate([225, 75, 0])
                            titleblock1();
                }
}

module show_views()
{
    show_view1();
    show_view2();
    show_view3();
    show_view4();
}

show_views();

show_documentation();
