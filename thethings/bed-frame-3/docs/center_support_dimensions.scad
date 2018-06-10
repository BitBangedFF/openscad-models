/**
 * @file center_support_dimensions.scad
 * @brief TODO.
 *
 */

DOC_SCALING_FACTOR = 30;

include <dimlines/dimlines.scad>
include <titleblocks/titleblock1.scad>
include <../parts/bed_frame.scad>

PART_DETAILS = [
        "Center Support",     // title
        "Pine (wood)",        // material
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

PART_LENGTH = CENTER_SUPPORT_BOARD_LENGTH;
PART_WIDTH = CENTER_SUPPORT_BOARD_WIDTH;
PART_THICKNESS = CENTER_SUPPORT_BOARD_THICKNESS;

ROTATION2 = [-90, 0, 0];
ROTATION3 = [0, 90, 90];
ROTATION4 = [-65, 25, 10];

ROT2_VIEW = [0, -237 * 0.7, 0];
ROT3_VIEW = [PART_LENGTH * 1.8, -237 * 0.5, 0];
ROT4_VIEW = [PART_LENGTH * 1.4, 0, 0];

DOC_HEIGHT = PART_THICKNESS + 0.5;

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
                center_support();
}

module show_view1()
{
    translate([0, 0, -PART_WIDTH])
        show_part();

    color("Black")
        translate([0, 0, DOC_HEIGHT])
            union()
            {
                translate([0, PART_THICKNESS + (3 * DIM_SPACE), 0])
                    dimensions(PART_LENGTH, DIM_LINE_WIDTH);

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

                    translate([PART_THICKNESS + DIM_SPACE, -PART_LENGTH, 0])
                        line(
                                length = (3 * DIM_SPACE),
                                width = DIM_LINE_WIDTH,
                                height = 0.01,
                                left_arrow = false,
                                right_arrow = false);
                }
            }
}

module show_docs2()
{
    dist_a =
            (POST_BOARD_THICKNESS / 2)
            - (SIDE_SUPPORT_BOARD_THICKNESS / 2);

    dist_b =
            CENTER_SUPPORT_BOARD_OVERRUN
            + SUPPORT_BOARD_THICKNESS
            + dist_a;

    dist_d = CENTER_SUPPORT_TENON_WIDTH;

    inner_dist =
            PLANK_BOARD_COUNT
            * (PLANK_BOARD_WIDTH + PLANK_BOARD_SEP_DISTANCE)
            - PLANK_BOARD_SEP_DISTANCE;

    dist_c =
            PART_LENGTH
            - dist_b
            - inner_dist;

    dist_e =
            PLANK_BOARD_WIDTH
            + PLANK_BOARD_SEP_DISTANCE;

    union()
    {
        translate([0, PART_WIDTH + (2 * DIM_SPACE), 0])
            dimensions(dist_b, DIM_LINE_WIDTH, DIM_LEFT);

        rotate([0, 0, 90])
            union()
            {
                translate([PART_WIDTH + DIM_SPACE, 0, DIM_HEIGHT])
                    line(
                            length = (2 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);

                translate([PART_WIDTH + DIM_SPACE, -dist_b, DIM_HEIGHT])
                    line(
                            length = (2 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);
            }

        translate([dist_b + (3 * dist_e), PART_WIDTH + (2 * DIM_SPACE), 0])
            dimensions(PLANK_BOARD_WIDTH, DIM_LINE_WIDTH, DIM_LEFT);

        rotate([0, 0, 90])
            union()
            {
                translate([PART_WIDTH + DIM_SPACE, -dist_b - (3 * dist_e), DIM_HEIGHT])
                    line(
                            length = (2 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);

                translate([PART_WIDTH + DIM_SPACE, -dist_b - (3 * dist_e) - PLANK_BOARD_WIDTH, DIM_HEIGHT])
                    line(
                            length = (2 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);
            }

        translate([PART_LENGTH - dist_c, PART_WIDTH + (2 * DIM_SPACE), 0])
            dimensions(dist_c, DIM_LINE_WIDTH, DIM_LEFT);

        rotate([0, 0, 90])
            union()
            {
                translate([PART_WIDTH + DIM_SPACE, -PART_LENGTH + dist_c, DIM_HEIGHT])
                    line(
                            length = (2 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);

                translate([PART_WIDTH + DIM_SPACE, -PART_LENGTH, DIM_HEIGHT])
                    line(
                            length = (2 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);
            }

        translate([dist_b, PART_WIDTH + (5 * DIM_SPACE), 0])
            dimensions(inner_dist, DIM_LINE_WIDTH, DIM_CENTER);

        rotate([0, 0, 90])
            union()
            {
                translate([PART_WIDTH + (4 * DIM_SPACE), -dist_b, DIM_HEIGHT])
                    line(
                            length = (2 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);

                translate([PART_WIDTH + (4 * DIM_SPACE), -dist_b - inner_dist, DIM_HEIGHT])
                    line(
                            length = (2 * DIM_SPACE),
                            width = DIM_LINE_WIDTH,
                            height = 0.01,
                            left_arrow = false,
                            right_arrow = false);
            }

        translate([PART_LENGTH + (2 * DIM_SPACE), PART_WIDTH, 0])
            rotate([0, 0, -90])
                dimensions(dist_d, DIM_LINE_WIDTH, DIM_LEFT);

        union()
        {
            translate([PART_LENGTH + DIM_SPACE, PART_WIDTH, 0])
                line(
                        length = (2 * DIM_SPACE),
                        width = DIM_LINE_WIDTH,
                        height = 0.01,
                        left_arrow = false,
                        right_arrow = false);

            translate([PART_LENGTH + DIM_SPACE, PART_WIDTH - dist_d, 0])
                line(
                        length = (2 * DIM_SPACE),
                        width = DIM_LINE_WIDTH,
                        height = 0.01,
                        left_arrow = false,
                        right_arrow = false);

            translate([dist_b + (4 * dist_e), PART_WIDTH - PLANK_BOARD_THICKNESS, DIM_HEIGHT])
                leader_line(
                        angle = -50.0,
                        radius = 0,
                        angle_length = 40,
                        horz_line_length = 20,
                        direction = DIM_RIGHT,
                        line_width = DIM_LINE_WIDTH,
                        text = str(PLANK_BOARD_THICKNESS),
                        do_circle = false);
        }
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

module show_view3()
{
    translate(ROT3_VIEW)
        rotate(ROTATION3)
            show_part();
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
        translate([-50, -300, DOC_HEIGHT])
            color("Black")
                union()
                {
                    show_frame(
                            length = 650,
                            height = 400,
                            line_width = DIM_LINE_WIDTH * 2);

                    color("Black")
                        translate([395, 135, 0])
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
