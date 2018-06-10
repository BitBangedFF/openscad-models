/**
 * @file dog_toy_box_doc.scad
 * @brief TODO.
 *
 * TODO:
 * - fix spacing and style
 *
 */

DOC_SCALING_FACTOR = 10;

include <dimlines/dimlines.scad>
include <titleblocks/titleblock1.scad>
include <../parts/dog_toy_box.scad>

PART_DETAILS = [
        "Dog Toy Box",        // title
        "Beli/Poplar (wood)", // material
        "Planed",             // finish
        " ",                  // weight
        "1"];                 // part no

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

PART_LENGTH = SIDE_BOARD_LENGTH;
PART_WIDTH = END_BOARD_LENGTH;
PART_THICKNESS = POST_BOARD_LENGTH;

ROTATION2 = [90, 0, 0];
ROTATION3 = [0, 90, 90];
ROTATION4 = [-60, 30, 10];

ROT2_VIEW = [0, -25, 0];
ROT3_VIEW = [140, -18, 0];
ROT4_VIEW = [100, 8, 0];

DOC_HEIGHT = PART_THICKNESS + 0.5;

DIM_LINE_WIDTH = 0.03 * DOC_SCALING_FACTOR;
DIM_SPACE = 0.1 * DOC_SCALING_FACTOR;
DIM_HEIGHT = 0.01;
DIM_FONTSCALE = DIM_LINE_WIDTH * 0.9;

module sample_part()
{
    offset_t = [
            PART_LENGTH / 2,
            PART_WIDTH / 2,
            POST_BOARD_OVERRUN];
    
    translate(offset_t)
        dog_toy_box();
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
    translate([-14, -PART_WIDTH * 1.6, DOC_HEIGHT])
        color("Black")
            union()
            {
                draw_frame(
                        length = SIDE_BOARD_LENGTH * 3.05,
                        height = SIDE_BOARD_LENGTH * 2,
                        line_width = DIM_LINE_WIDTH * 2);

                color("Black")
                    translate([PART_LENGTH * 1.6, 45, 0])
                        titleblock1();
            }
