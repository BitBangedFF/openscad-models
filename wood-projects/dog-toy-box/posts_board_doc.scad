
DOC_SCALING_FACTOR = 4;

include <dimlines/dimlines.scad>
include <titleblocks/titleblock1.scad>
use <dog_toy_box.scad>

PART_DETAILS = [
        "End Post / Leg",   // title
        "Beli",             // material
        "Planed",           // finish
        " ",                // weight
        "1"];               // part no

PART_REVISIONS = [
        ["0.1", "01 JAN 18", "jl"]];

DOC_DETAILS = [
        "1-1",              // drawing number
        "Jon Lamb",         // created by
        " ",                // reviewed by
        "01 DEC 2017"];     // date of issue

ORG_DETAILS = [
        " ",
        "Stuff I Build",
        " "];

PART_LENGTH = 16.59;
PART_WIDTH = 5.000625;
PART_HEIGHT = 5.000625;

BASE_BOARD_THICKNESS = 1.905;

TENON_WIDTH = 4.52125;
TENON_THICKNESS = 1.27;
TENON_X1_OFFSET = 1.90495;
TENON_X2_OFFSET = 7.5438;

POST_OVERRUN = 1.27;

TENON_Y1_OFFSET = (PART_WIDTH/2) - (TENON_THICKNESS/2);
TENON_Y2_OFFSET = (PART_WIDTH/2) + (TENON_THICKNESS/2);

TENON_1X1 = POST_OVERRUN + TENON_X1_OFFSET;
TENON_1X2 = TENON_1X1 + TENON_WIDTH;
TENON_2X1 = POST_OVERRUN + 7.5438;
TENON_2X2 = TENON_2X1 + TENON_WIDTH;

BASE_CUTOUT_A_DEPTH = (PART_WIDTH/2) - (TENON_THICKNESS/2);

BASE_BOARD_CUTOUT_XOFFSET = POST_OVERRUN + BASE_BOARD_THICKNESS;

// rotations used for dimensioning
ROTATION2 = [90, 0, 0];
ROTATION3 = [0, 90, 90];
ROTATION4 = [55, 50, 10];

ROT2_VIEW = [0, -10, 0];
ROT3_VIEW = [35, -12, 0];
ROT4_VIEW = [25, 4, 0];

DOC_HEIGHT = PART_HEIGHT + 0.5;

DIM_LINE_WIDTH = 0.025 * DOC_SCALING_FACTOR;
DIM_SPACE = 0.1 * DOC_SCALING_FACTOR;
DIM_HEIGHT = 0.01;
DIM_FONTSCALE = DIM_LINE_WIDTH * 0.6;

module sample_part()
{
    pw = PART_WIDTH;

    translate([0, 0, pw/2])
        rotate([90, 0, 0])
            translate([0, -pw/2, 0])
                rotate([0, 90, 0])
                    single_post();
}

module show_samplepart()
{
    sample_part();

    // upper (actually x) dimensions
    color("Black")
    translate([0, 0, DOC_HEIGHT])
    union() {
        translate([0, PART_WIDTH + DIM_SPACE * 3, 0])
        dimensions(POST_OVERRUN, DIM_LINE_WIDTH, loc=DIM_LEFT);

        translate([POST_OVERRUN, -DIM_SPACE * 3, 0])
        dimensions(BASE_BOARD_THICKNESS, DIM_LINE_WIDTH, loc=DIM_OUTSIDE);

        translate([BASE_BOARD_CUTOUT_XOFFSET, PART_WIDTH + DIM_SPACE * 3, 0])
        dimensions(TENON_2X1 - BASE_BOARD_CUTOUT_XOFFSET, DIM_LINE_WIDTH, loc=DIM_CENTER);

        translate([0, PART_WIDTH + DIM_SPACE * 6, 0])
        dimensions(BASE_BOARD_CUTOUT_XOFFSET, DIM_LINE_WIDTH);

        translate([0, PART_WIDTH + DIM_SPACE * 9, 0])
        dimensions(TENON_2X1, DIM_LINE_WIDTH);

        translate([TENON_2X1, PART_WIDTH + DIM_SPACE * 3, 0])
        dimensions(TENON_WIDTH, DIM_LINE_WIDTH);

        translate([0, PART_WIDTH + DIM_SPACE * 12, 0])
        dimensions(TENON_2X2, DIM_LINE_WIDTH);

        translate([TENON_2X2, PART_WIDTH + DIM_SPACE * 6, 0])
        dimensions(PART_LENGTH - TENON_2X2, DIM_LINE_WIDTH, loc=DIM_OUTSIDE);

        translate([0, PART_WIDTH + DIM_SPACE * 15, 0])
        dimensions(PART_LENGTH, DIM_LINE_WIDTH);

        // extension lines
        rotate([0, 0, 90])
        union() {
            translate([PART_WIDTH + DIM_SPACE, 0, 0])
            line(length=DIM_SPACE * 15, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([PART_WIDTH + DIM_SPACE, -PART_LENGTH, 0])
            line(length=DIM_SPACE * 15, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([PART_WIDTH + DIM_SPACE, -POST_OVERRUN, 0])
            line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH,
                height=.01, left_arrow=false, right_arrow=false);
            
            translate([-DIM_SPACE * 1.5 - DIM_SPACE, -POST_OVERRUN, 0])
            line(length=DIM_SPACE * 2, width=DIM_LINE_WIDTH,
                height=.01, left_arrow=false, right_arrow=false);
            
            translate([-DIM_SPACE * 1.5 - DIM_SPACE, -BASE_BOARD_CUTOUT_XOFFSET, 0])
            line(length=DIM_SPACE * 2, width=DIM_LINE_WIDTH,
                height=.01, left_arrow=false, right_arrow=false);

            translate([PART_WIDTH + DIM_SPACE, -BASE_BOARD_CUTOUT_XOFFSET, 0])
            line(length=DIM_SPACE * 6,
                width=DIM_LINE_WIDTH, height=.01, left_arrow=false,
                right_arrow=false);

            translate([PART_WIDTH + DIM_SPACE, -TENON_2X1, 0])
            line(length=DIM_SPACE * 9,
                width=DIM_LINE_WIDTH, height=.01, left_arrow=false,
                right_arrow=false);

            translate([PART_WIDTH + DIM_SPACE, -TENON_2X2, 0])
            line(length=DIM_SPACE * 12,
                width=DIM_LINE_WIDTH, height=.01, left_arrow=false,
                right_arrow=false);
                }
        }


    // right side
    color("Black")
    translate([0, 0, DOC_HEIGHT])
    rotate([0, 0, -90])
    union() {

        translate([-TENON_Y1_OFFSET, PART_LENGTH + DIM_SPACE * 3, DIM_HEIGHT])
        line(length=TENON_Y1_OFFSET, width=DIM_LINE_WIDTH, height=.01,
            left_arrow=true, right_arrow=true);

        translate([0, PART_LENGTH + DIM_SPACE * 3, DIM_HEIGHT])
        leader_line(angle=0, radius=0, angle_length=0,
                horz_line_length=1.6, line_width=DIM_LINE_WIDTH,
                text=str(TENON_Y1_OFFSET));

        translate([-TENON_Y2_OFFSET, PART_LENGTH + DIM_SPACE * 6, DIM_HEIGHT])
        dimensions(TENON_Y2_OFFSET, DIM_LINE_WIDTH, loc=DIM_OUTSIDE);

        translate([-PART_WIDTH, PART_LENGTH + DIM_SPACE * 9, DIM_HEIGHT])
        dimensions(PART_WIDTH, DIM_LINE_WIDTH);
    }

    // extension lines
    color("Black")
    translate([0, 0, DOC_HEIGHT])
    union() {
        translate([PART_LENGTH + DIM_SPACE , PART_WIDTH, DIM_HEIGHT])
        line(length=DIM_SPACE * 9, width=DIM_LINE_WIDTH, height=.01,
            left_arrow=false, right_arrow=false);

        translate([PART_LENGTH + DIM_SPACE, TENON_Y1_OFFSET, DIM_HEIGHT])
        line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
            left_arrow=false, right_arrow=false);

        translate([PART_LENGTH + DIM_SPACE, TENON_Y2_OFFSET, DIM_HEIGHT])
        line(length=DIM_SPACE * 6, width=DIM_LINE_WIDTH, height=.01,
            left_arrow=false, right_arrow=false);

        translate([PART_LENGTH + DIM_SPACE, 0, DIM_HEIGHT])
        line(length=DIM_SPACE * 9, width=DIM_LINE_WIDTH, height=.01,
            left_arrow=false, right_arrow=false);

    }
    
    // left side
    color("Black")
    translate([0, 0, DOC_HEIGHT])
    rotate([0, 0, 90])
    union() {
        translate([PART_WIDTH - BASE_CUTOUT_A_DEPTH, DIM_SPACE * 2, DIM_HEIGHT])
        dimensions(BASE_CUTOUT_A_DEPTH, DIM_LINE_WIDTH, loc=DIM_LEFT);
        
        // extension lines
        rotate([0, 0, 90])
        union() {
            translate([DIM_SPACE, -PART_WIDTH, 0])
            line(length=DIM_SPACE * 2, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);
            
            translate([DIM_SPACE, -PART_WIDTH + BASE_CUTOUT_A_DEPTH, 0])
            line(length=DIM_SPACE * 2, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);
        }
    }

    // end of initial dimension lines

    // rotate 90 degrees around the y axis
    translate(ROT2_VIEW)
    rotate(ROTATION2)
    sample_part();

    // dimension lines on the TOP
    color("Black")
    translate(ROT2_VIEW)
    translate([0, 0, DOC_HEIGHT])
    union() {
        translate([0, DIM_SPACE * 2, DIM_HEIGHT])
        dimensions(TENON_1X1, DIM_LINE_WIDTH, loc=DIM_LEFT);

        translate([TENON_1X1, DIM_SPACE * 2, 0])
        dimensions(TENON_WIDTH, DIM_LINE_WIDTH);

        translate([0, DIM_SPACE * 5, DIM_HEIGHT])
        dimensions(TENON_1X2, DIM_LINE_WIDTH, loc=DIM_CENTER);

        translate([0, DIM_SPACE * 8, DIM_HEIGHT])
        dimensions(PART_LENGTH / 2, DIM_LINE_WIDTH, loc=DIM_CENTER);

        translate([0, DIM_SPACE * 11, DIM_HEIGHT])
        dimensions(PART_LENGTH, DIM_LINE_WIDTH);

        // extension lines
        rotate([0, 0, 90])
        union() {
            translate([DIM_SPACE, 0, DIM_HEIGHT])
            line(length=DIM_SPACE * 11, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([-PART_HEIGHT / 2, -PART_LENGTH / 2, DIM_HEIGHT])
            line(length=DIM_SPACE * 15, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([DIM_SPACE, -TENON_1X2, DIM_HEIGHT])
            line(length=DIM_SPACE * 5, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([DIM_SPACE, -TENON_1X1, DIM_HEIGHT])
            line(length=DIM_SPACE * 2, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([DIM_SPACE, -PART_LENGTH, DIM_HEIGHT])
            line(length=DIM_SPACE * 11, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

        }

        // right side
        color("Black")
        rotate([0, 0, -90])
        union() {

            translate([0, PART_LENGTH + DIM_SPACE * 6, DIM_HEIGHT])
                dimensions(PART_HEIGHT, DIM_LINE_WIDTH, loc=DIM_CENTER);

            translate([TENON_Y1_OFFSET, PART_LENGTH + DIM_SPACE * 3, DIM_HEIGHT])
                dimensions(TENON_THICKNESS, DIM_LINE_WIDTH, loc=DIM_LEFT);
        }

        // extension lines
        color("Black")
        union() {
            translate([PART_LENGTH + DIM_SPACE, 0, DIM_HEIGHT])
            line(length=DIM_SPACE * 6, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([PART_LENGTH + DIM_SPACE, -TENON_Y1_OFFSET, DIM_HEIGHT])
            line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([PART_LENGTH + DIM_SPACE, -TENON_Y2_OFFSET, DIM_HEIGHT])
            line(length=DIM_SPACE * 3, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);

            translate([PART_LENGTH + DIM_SPACE, -PART_HEIGHT, DIM_HEIGHT])
            line(length=DIM_SPACE * 6, width=DIM_LINE_WIDTH, height=.01,
                left_arrow=false, right_arrow=false);
        }
    }


    translate(ROT3_VIEW)
    rotate(ROTATION3)
    sample_part();

    color("Black")
    translate(ROT3_VIEW)
    translate([0, 0, DOC_HEIGHT])
    union() {

        translate([-PART_WIDTH, PART_HEIGHT + DIM_SPACE * 3, DIM_HEIGHT])
        dimensions(PART_WIDTH, DIM_LINE_WIDTH, loc=DIM_CENTER);


        // extension lines
        rotate([0, 0, 90])
        union() {
            translate([PART_HEIGHT + DIM_SPACE, PART_WIDTH, DIM_HEIGHT])
            line(length=DIM_SPACE * 4);

            translate([PART_HEIGHT + DIM_SPACE, 0, DIM_HEIGHT])
            line(length=DIM_SPACE * 4);
        }


       // right side
        color("Black")
        rotate([0, 0, -90])
        union() {
            translate([-PART_HEIGHT, DIM_SPACE * 6, DIM_HEIGHT])
                dimensions(PART_HEIGHT, DIM_LINE_WIDTH, loc=DIM_CENTER);
        }

        // extension lines
        color("Black")
        union() {
            translate([DIM_SPACE, PART_HEIGHT, DIM_HEIGHT])
            line(length=DIM_SPACE * 6);

            translate([DIM_SPACE, 0, DIM_HEIGHT])
            line(length=DIM_SPACE * 6);

        }

    }

    translate(ROT4_VIEW)
    rotate(ROTATION4)
    sample_part();

}


module draw_frame(length, height, line_width=DIM_LINE_WIDTH) {

    line(length=length, width=line_width);

    translate([0, height, 0])
    line(length=length, width=line_width);

    translate([line_width / 2, line_width / 2, 0])
    rotate([0, 0, 90])
    line(length=height - line_width, width=line_width);

    translate([length - line_width / 2, line_width / 2, 0])
    rotate([0, 0, 90])
    line(length=height - line_width, width=line_width);

}

show_samplepart();
color("Black")
translate([-7, -28, DOC_HEIGHT])
color("Black")
union() {
    draw_frame(
            length=56,
            height=40,
            line_width=DIM_LINE_WIDTH * 2);

    color("Black")
    translate([28.8, 14.05, 0])
    titleblock1();
}

