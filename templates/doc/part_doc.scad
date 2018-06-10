/**
 * @file post.scad
 * @brief TODO.
 *
 * TODO:
 * - fix spacing and style
 *
 */

DOC_SCALING_FACTOR = 4;

include <dimlines/dimlines.scad>
include <titleblocks/titleblock1.scad>

PART_DETAILS = [
        "Ex Part",          // title
        "Beli (wood)",      // material
        "Planed",           // finish
        " ",                // weight
        "1"];               // part no

PART_REVISIONS = [
        ["0.1", "01 JAN 18", "jl"]];

DOC_DETAILS = [
        "1-1",              // drawing number
        "Lambo",            // created by
        " ",                // reviewed by
        "01 DEC 2017"];     // date of issue

ORG_DETAILS = [
        " ",
        "Stuff I Build",
        " "];

PART_LENGTH = 16.59;
PART_WIDTH = 5.000625;
PART_THICKNESS = 5.000625;

ROTATION2 = [90, 0, 0];
ROTATION3 = [0, 90, 90];
ROTATION4 = [55, 50, 10];

ROT2_VIEW = [0, -10, 0];
ROT3_VIEW = [35, -12, 0];
ROT4_VIEW = [25, 4, 0];

DOC_HEIGHT = PART_THICKNESS + 0.5;

DIM_LINE_WIDTH = 0.025 * DOC_SCALING_FACTOR;
DIM_SPACE = 0.1 * DOC_SCALING_FACTOR;
DIM_HEIGHT = 0.01;
DIM_FONTSCALE = DIM_LINE_WIDTH * 0.6;

module sample_part()
{
    cube([PART_LENGTH, PART_WIDTH, PART_THICKNESS]);
}

module show_samplepart()
{
    sample_part();

    color("Black")
        translate([0, 0, DOC_HEIGHT])
            union()
            {
                // dimensions
                translate([0, PART_WIDTH + DIM_SPACE * 3, 0])
                dimensions(PART_LENGTH, DIM_LINE_WIDTH);

                // extension lines
                rotate([0, 0, 90])
                union()
                {
                    translate([PART_WIDTH + DIM_SPACE, 0, 0])
                        line(
                                length = DIM_SPACE * 3,
                                width = DIM_LINE_WIDTH,
                                height = 0.01,
                                left_arrow = false,
                                right_arrow = false);

                    translate([PART_WIDTH + DIM_SPACE, -PART_LENGTH, 0])
                        line(
                                length = DIM_SPACE * 3,
                                width = DIM_LINE_WIDTH,
                                height = 0.01,
                                left_arrow = false,
                                right_arrow = false);
                }
            }


    // right side
    color("Black")
        translate([0, 0, DOC_HEIGHT])
            rotate([0, 0, -90])
                union()
                {
                    translate([-PART_WIDTH, PART_LENGTH + DIM_SPACE * 3, DIM_HEIGHT])
                    dimensions(PART_WIDTH, DIM_LINE_WIDTH);
                }

    // extension lines
    color("Black")
        translate([0, 0, DOC_HEIGHT])
            union()
            {
                translate([PART_LENGTH + DIM_SPACE , PART_WIDTH, DIM_HEIGHT])
                line(
                        length = DIM_SPACE * 3,
                        width = DIM_LINE_WIDTH,
                        height = 0.01,
                        left_arrow = false,
                        right_arrow = false);

                translate([PART_LENGTH + DIM_SPACE , 0, DIM_HEIGHT])
                line(
                        length = DIM_SPACE * 3,
                        width = DIM_LINE_WIDTH,
                        height = 0.01,
                        left_arrow = false,
                        right_arrow = false);
            }

    // end of initial dimension lines

    // rotate 90 degrees around the y axis
    translate(ROT2_VIEW)
        rotate(ROTATION2)
            sample_part();

    // dimension lines on the top
    color("Black")
    translate(ROT2_VIEW)
    translate([0, 0, DOC_HEIGHT])
    union()
    {
        translate([0, DIM_SPACE * 3, DIM_HEIGHT])
            dimensions(PART_LENGTH, DIM_LINE_WIDTH);

        // extension lines
        rotate([0, 0, 90])
        union()
        {
            translate([DIM_SPACE, -PART_LENGTH, DIM_HEIGHT])
                line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);

            translate([DIM_SPACE, 0, DIM_HEIGHT])
                line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);

        }

        // right side
        color("Black")
        rotate([0, 0, -90])
        union()
        {
            translate([0, PART_LENGTH + DIM_SPACE * 3, DIM_HEIGHT])
                dimensions(PART_THICKNESS, DIM_LINE_WIDTH, loc=DIM_CENTER);
        }

        // extension lines
        color("Black")
        union()
        {
            translate([PART_LENGTH + DIM_SPACE, -PART_THICKNESS, DIM_HEIGHT])
            line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([PART_LENGTH + DIM_SPACE, 0, DIM_HEIGHT])
            line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);
        }
    }

    translate(ROT3_VIEW)
        rotate(ROTATION3)
            sample_part();

    color("Black")
    translate(ROT3_VIEW)
    translate([0, 0, DOC_HEIGHT])
    union()
    {
        translate([-PART_WIDTH, PART_THICKNESS + DIM_SPACE * 3, DIM_HEIGHT])
            dimensions(PART_WIDTH, DIM_LINE_WIDTH, loc=DIM_CENTER);

        // extension lines
        rotate([0, 0, 90])
        union()
        {
            translate([PART_THICKNESS + DIM_SPACE, PART_WIDTH, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);

            translate([PART_THICKNESS + DIM_SPACE, 0, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);
        }

        // right side
        color("Black")
        rotate([0, 0, -90])
        union()
        {
            translate([-PART_THICKNESS, DIM_SPACE * 3, DIM_HEIGHT])
                dimensions(PART_THICKNESS, DIM_LINE_WIDTH, loc=DIM_CENTER);
        }

        // extension lines
        color("Black")
        union()
        {
            translate([DIM_SPACE, PART_THICKNESS, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);

            translate([DIM_SPACE, 0, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);
        }
    }

    translate(ROT4_VIEW)
        rotate(ROTATION4)
            sample_part();
}

module draw_frame(length, height, line_width = DIM_LINE_WIDTH)
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

show_samplepart();

color("Black")
    translate([-7, -28, DOC_HEIGHT])
        color("Black")
            union()
            {
                draw_frame(
                        length = 56,
                        height = 40,
                        line_width = DIM_LINE_WIDTH * 2);

                color("Black")
                    translate([28.8, 14.05, 0])
                        titleblock1();
            }
