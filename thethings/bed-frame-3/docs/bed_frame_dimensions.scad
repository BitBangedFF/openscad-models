/**
 * @file bed_frame_dimensions.scad
 * @brief TODO.
 *
 */

DOC_SCALING_FACTOR = 30;

include <dimlines/dimlines.scad>
include <titleblocks/titleblock1.scad>
include <../parts/bed_frame.scad>

PART_DETAILS = [
        "Bed Frame  ",        // title
        "Pine/Cherry (wood)", // material
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

PART_LENGTH = SIDE_SUPPORT_BOARD_LENGTH;
PART_WIDTH = END_SUPPORT_BOARD_LENGTH;
PART_THICKNESS = POST_BOARD_LENGTH;

ROTATION2 = [-90, 0, 0];
ROTATION3 = [0, 90, 90];
ROTATION4 = [-65, 25, 10];

ROT2_VIEW = [0, -PART_WIDTH * 0.6, 0];
ROT3_VIEW = [PART_LENGTH * 2.5, -PART_WIDTH * 0.3, 0];
ROT4_VIEW = [PART_LENGTH * 1.8, 50, 0];

DOC_HEIGHT = PART_THICKNESS + 0.5;

DIM_LINE_WIDTH = 0.03 * DOC_SCALING_FACTOR;
DIM_SPACE = 0.1 * DOC_SCALING_FACTOR;
DIM_HEIGHT = 0.01;
DIM_FONTSCALE = DIM_LINE_WIDTH * 0.9;

module sample_part()
{
    offset_t = [
            0,
            0,
            0];

    translate(offset_t)
        bed_frame();
}

module show_samplepart()
{
    sample_part();

    color("Black")
        translate([0, 0, DOC_HEIGHT])
            union()
            {
                // dimensions
                translate([-SUPPORT_BOARD_OVERRUN, PART_WIDTH + DIM_SPACE, 0])
                    dimensions(PART_LENGTH, DIM_LINE_WIDTH);

                // extension lines
                rotate([0, 0, 90])
                union()
                {
                    translate([PART_WIDTH - (2 * SUPPORT_BOARD_OVERRUN) - DIM_SPACE, SUPPORT_BOARD_OVERRUN, 0])
                        line(
                                length = (2 * SUPPORT_BOARD_OVERRUN) + (3 * DIM_SPACE),
                                width = DIM_LINE_WIDTH,
                                height = 0.01,
                                left_arrow = false,
                                right_arrow = false);

                    translate([PART_WIDTH - (2 * SUPPORT_BOARD_OVERRUN) + DIM_SPACE, SUPPORT_BOARD_OVERRUN - PART_LENGTH, 0])
                        line(
                                length = (2 * SUPPORT_BOARD_OVERRUN) + (1 * DIM_SPACE),
                                width = DIM_LINE_WIDTH,
                                height = 0.01,
                                left_arrow = false,
                                right_arrow = false);
                }

                dist_a = (POST_BOARD_THICKNESS / 2) - (SUPPORT_BOARD_THICKNESS / 2);
                dist_b = dist_a - CENTER_SUPPORT_BOARD_OVERRUN + CENTER_SUPPORT_BOARD_LENGTH;
                dist_c = (SIDE_TO_SIDE_DISTANCE / 2) - (CENTER_SUPPORT_BOARD_THICKNESS / 2);

                translate([dist_b, dist_c, 0])
                {
                    leader_line(
                            angle = -60.0,
                            radius = 0,
                            angle_length = 70,
                            horz_line_length = 20,
                            direction = DIM_RIGHT,
                            line_width = DIM_LINE_WIDTH,
                            text = str(CENTER_SUPPORT_BOARD_LENGTH),
                            do_circle = false);
                }
            }


    // right side
    color("Black")
        translate([0, 0, DOC_HEIGHT])
            rotate([0, 0, -90])
                union()
                {
                    translate([-PART_WIDTH + SUPPORT_BOARD_OVERRUN, PART_LENGTH + (DIM_SPACE * 3), DIM_HEIGHT])
                        dimensions(PART_WIDTH, DIM_LINE_WIDTH);
                }

    // extension lines
    color("Black")
        translate([0, 0, DOC_HEIGHT])
            union()
            {
                translate([PART_LENGTH - (2 * SUPPORT_BOARD_OVERRUN) + (4 * DIM_SPACE), PART_WIDTH - SUPPORT_BOARD_OVERRUN, DIM_HEIGHT])
                line(
                        length = (2 * SUPPORT_BOARD_OVERRUN),
                        width = DIM_LINE_WIDTH,
                        height = 0.01,
                        left_arrow = false,
                        right_arrow = false);

                translate([PART_LENGTH - (2 * SUPPORT_BOARD_OVERRUN) + (4 * DIM_SPACE), -SUPPORT_BOARD_OVERRUN, DIM_HEIGHT])
                line(
                        length = (2 * SUPPORT_BOARD_OVERRUN),
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
        translate([POST_BOARD_THICKNESS, (-3 * DIM_SPACE), DIM_HEIGHT])
            dimensions(END_TO_END_DISTANCE - (2 * POST_BOARD_THICKNESS), DIM_LINE_WIDTH);

        // extension lines
        rotate([0, 0, 90])
        union()
        {
            translate([(-4 * DIM_SPACE), -END_TO_END_DISTANCE + POST_BOARD_THICKNESS, DIM_HEIGHT])
                line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);

            translate([(-4 * DIM_SPACE), -POST_BOARD_THICKNESS, DIM_HEIGHT])
                line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);

        }

        translate([0, (-7 * DIM_SPACE), DIM_HEIGHT])
            dimensions(END_TO_END_DISTANCE, DIM_LINE_WIDTH);

        // extension lines
        rotate([0, 0, 90])
        union()
        {
            translate([(-9 * DIM_SPACE), -END_TO_END_DISTANCE, DIM_HEIGHT])
                line(length=DIM_SPACE * 8, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);

            translate([(-9 * DIM_SPACE), 0, DIM_HEIGHT])
                line(length=DIM_SPACE * 8, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);

        }

        // right side
        color("Black")
        rotate([0, 0, -90])
        union()
        {
            translate([-PART_THICKNESS, PART_LENGTH - SUPPORT_BOARD_OVERRUN + (3 * DIM_SPACE), DIM_HEIGHT])
                dimensions(PART_THICKNESS, DIM_LINE_WIDTH, loc=DIM_OUTSIDE);
        }

        // extension lines
        color("Black")
        union()
        {
            translate([PART_LENGTH - SUPPORT_BOARD_OVERRUN + DIM_SPACE, PART_THICKNESS, DIM_HEIGHT])
            line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([PART_LENGTH - SUPPORT_BOARD_OVERRUN + DIM_SPACE, 0, DIM_HEIGHT])
            line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);
        }

        translate([-SUPPORT_BOARD_OVERRUN, POST_BOARD_LENGTH + (7 * DIM_SPACE), DIM_HEIGHT])
            dimensions(SUPPORT_BOARD_OVERRUN, DIM_LINE_WIDTH, loc = DIM_LEFT);

        rotate([0, 0, 90])
        union()
        {
            translate([POST_BOARD_LENGTH + (5 * DIM_SPACE), 0, DIM_HEIGHT])
                line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);

            translate([POST_BOARD_LENGTH + (5 * DIM_SPACE), SUPPORT_BOARD_OVERRUN, DIM_HEIGHT])
                line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);
        }

        translate([-SUPPORT_BOARD_OVERRUN + TAPER_DEPTH, POST_BOARD_LENGTH + (3 * DIM_SPACE), DIM_HEIGHT])
            dimensions(SUPPORT_BOARD_OVERRUN - TAPER_DEPTH, DIM_LINE_WIDTH, loc = DIM_LEFT);

        rotate([0, 0, 90])
        union()
        {
            translate([POST_BOARD_LENGTH + (1 * DIM_SPACE), 0, DIM_HEIGHT])
                line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);

            translate([POST_BOARD_LENGTH + (1 * DIM_SPACE), SUPPORT_BOARD_OVERRUN - TAPER_DEPTH, DIM_HEIGHT])
                line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);
        }

        translate([END_TO_END_DISTANCE - POST_BOARD_THICKNESS, POST_BOARD_LENGTH + (3 * DIM_SPACE), DIM_HEIGHT])
            dimensions(POST_BOARD_THICKNESS, DIM_LINE_WIDTH, loc = DIM_LEFT);

        rotate([0, 0, 90])
        union()
        {
            translate([POST_BOARD_LENGTH + (1 * DIM_SPACE), -END_TO_END_DISTANCE, DIM_HEIGHT])
                line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                    left_arrow=false, right_arrow=false);

            translate([POST_BOARD_LENGTH + (1 * DIM_SPACE), -END_TO_END_DISTANCE + POST_BOARD_THICKNESS, DIM_HEIGHT])
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
        translate([-PART_WIDTH + SUPPORT_BOARD_OVERRUN, PART_THICKNESS + (DIM_SPACE * 3), DIM_HEIGHT])
            dimensions((END_SUPPORT_BOARD_LENGTH / 2) - (CENTER_SUPPORT_BOARD_THICKNESS / 2), DIM_LINE_WIDTH, loc=DIM_CENTER);

        // extension lines
        rotate([0, 0, 90])
        union()
        {
            translate([PART_THICKNESS + DIM_SPACE, PART_WIDTH - SUPPORT_BOARD_OVERRUN, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);

            translate([PART_THICKNESS + DIM_SPACE, -SUPPORT_BOARD_OVERRUN + (END_SUPPORT_BOARD_LENGTH / 2) + (CENTER_SUPPORT_BOARD_THICKNESS / 2), DIM_HEIGHT])
                line(length=DIM_SPACE * 3);
        }

        translate([-PART_WIDTH + SUPPORT_BOARD_OVERRUN, PART_THICKNESS + (DIM_SPACE * 7), DIM_HEIGHT])
            dimensions((END_SUPPORT_BOARD_LENGTH / 2), DIM_LINE_WIDTH, loc=DIM_CENTER);

        // extension lines
        rotate([0, 0, 90])
        union()
        {
            translate([PART_THICKNESS + DIM_SPACE + (4 * DIM_SPACE), PART_WIDTH - SUPPORT_BOARD_OVERRUN, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);

            translate([PART_THICKNESS + DIM_SPACE + (4 * DIM_SPACE), -SUPPORT_BOARD_OVERRUN + (END_SUPPORT_BOARD_LENGTH / 2), DIM_HEIGHT])
                line(length=DIM_SPACE * 3);
        }

        translate([-PART_WIDTH + SUPPORT_BOARD_OVERRUN + (END_SUPPORT_BOARD_LENGTH / 2) - (CENTER_SUPPORT_BOARD_THICKNESS / 2), PART_THICKNESS + (DIM_SPACE * 11), DIM_HEIGHT])
            dimensions(CENTER_SUPPORT_BOARD_THICKNESS, DIM_LINE_WIDTH, loc=DIM_LEFT);

        // extension lines
        rotate([0, 0, 90])
        union()
        {
            translate([PART_THICKNESS + DIM_SPACE + (8 * DIM_SPACE), PART_WIDTH - SUPPORT_BOARD_OVERRUN - (END_SUPPORT_BOARD_LENGTH / 2) + (CENTER_SUPPORT_BOARD_THICKNESS / 2), DIM_HEIGHT])
                line(length=DIM_SPACE * 3);

            translate([PART_THICKNESS + DIM_SPACE + (8 * DIM_SPACE), -SUPPORT_BOARD_OVERRUN + (END_SUPPORT_BOARD_LENGTH / 2) - (CENTER_SUPPORT_BOARD_THICKNESS / 2), DIM_HEIGHT])
                line(length=DIM_SPACE * 3);
        }

        translate([-PART_WIDTH + (2 * SUPPORT_BOARD_OVERRUN), (-7 * DIM_SPACE), DIM_HEIGHT])
            dimensions(SIDE_TO_SIDE_DISTANCE, DIM_LINE_WIDTH, loc=DIM_CENTER);

        // extension lines
        rotate([0, 0, 90])
        union()
        {
            translate([(-9 * DIM_SPACE), PART_WIDTH - (2 * SUPPORT_BOARD_OVERRUN), DIM_HEIGHT])
                line(length=(8 * DIM_SPACE));

            translate([(-9 * DIM_SPACE), 0, DIM_HEIGHT])
                line(length=(8 * DIM_SPACE));
        }

        translate([-PART_WIDTH + (2 * SUPPORT_BOARD_OVERRUN) + POST_BOARD_WIDTH, (-3 * DIM_SPACE), DIM_HEIGHT])
            dimensions(SIDE_TO_SIDE_DISTANCE - (2 * POST_BOARD_WIDTH), DIM_LINE_WIDTH, loc=DIM_CENTER);

        // extension lines
        rotate([0, 0, 90])
        union()
        {
            translate([(-4 * DIM_SPACE), PART_WIDTH - (2 * SUPPORT_BOARD_OVERRUN) - POST_BOARD_WIDTH, DIM_HEIGHT])
                line(length=(3 * DIM_SPACE));

            translate([(-4 * DIM_SPACE), POST_BOARD_WIDTH, DIM_HEIGHT])
                line(length=(3 * DIM_SPACE));
        }

        // right side
        color("Black")
        rotate([0, 0, -90])
        union()
        {
            translate([-PART_THICKNESS, SUPPORT_BOARD_OVERRUN + (DIM_SPACE * 3), DIM_HEIGHT])
                dimensions(SUPPORT_BOARD_WIDTH, DIM_LINE_WIDTH, loc=DIM_OUTSIDE);
        }

        // extension lines
        color("Black")
        union()
        {
            translate([SUPPORT_BOARD_OVERRUN + (DIM_SPACE * 1), PART_THICKNESS, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);

            translate([SUPPORT_BOARD_OVERRUN + (DIM_SPACE * 1), POST_BOARD_LENGTH - SUPPORT_BOARD_WIDTH, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);
        }

        dist_a = SUPPORT_BOARD_WIDTH - TAPER_HEIGHT;
        dist_b = POST_BOARD_LENGTH - dist_a;
        dist_c = SIDE_TO_SIDE_DISTANCE + SUPPORT_BOARD_OVERRUN;
        dist_d = POST_BOARD_LENGTH - SUPPORT_BOARD_WIDTH;

        // left side
        color("Black")
        rotate([0, 0, 90])
        union()
        {
            translate([dist_b, dist_c + (7 * DIM_SPACE), DIM_HEIGHT])
                dimensions(dist_a, DIM_LINE_WIDTH, loc=DIM_LEFT);
        }

        color("Black")
        union()
        {
            translate([-dist_c - (3 * DIM_SPACE) - (5 * DIM_SPACE), POST_BOARD_LENGTH, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);

            translate([-dist_c - (3 * DIM_SPACE) - (5 * DIM_SPACE), dist_b, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);
        }

        color("Black")
        rotate([0, 0, 90])
        union()
        {
            translate([dist_d, dist_c + (3 * DIM_SPACE), DIM_HEIGHT])
                dimensions(TAPER_HEIGHT, DIM_LINE_WIDTH, loc=DIM_LEFT);
        }

        color("Black")
        union()
        {
            translate([-dist_c - (3 * DIM_SPACE) - (1 * DIM_SPACE), dist_b, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);

            translate([-dist_c - (3 * DIM_SPACE) - (1 * DIM_SPACE), dist_d, DIM_HEIGHT])
                line(length=DIM_SPACE * 3);
        }
    }

    translate(ROT4_VIEW)
        rotate(ROTATION4)
            sample_part();

    color("Black")
        translate([PART_LENGTH * 1.7, PART_WIDTH / 1.4, DIM_HEIGHT])
        {
            leader_line(
                    angle = 120.0,
                    radius = 0,
                    angle_length = 20,
                    horz_line_length = 20,
                    direction = DIM_LEFT,
                    line_width = DIM_LINE_WIDTH,
                    text = "SIDE 1",
                    do_circle = false);
        }

    color("Black")
        translate([PART_LENGTH * 2.5, PART_WIDTH / 1.6, DIM_HEIGHT])
        {
            leader_line(
                    angle = 60.0,
                    radius = 0,
                    angle_length = 10,
                    horz_line_length = 20,
                    direction = DIM_RIGHT,
                    line_width = DIM_LINE_WIDTH,
                    text = "END 1",
                    do_circle = false);
        }
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
    translate([-50, -240, DOC_HEIGHT])
        color("Black")
            union()
            {
                draw_frame(
                        length = 770,
                        height = 495,
                        line_width = DIM_LINE_WIDTH * 2);

                color("Black")
                    translate([515, 135, 0])
                        titleblock1();
            }
