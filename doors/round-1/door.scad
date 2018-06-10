// door.scad
// units: centimeter
// TODO:
// - separate into files/parts

use <common/board.scad>

// door size
// 7' x 3.5' x ? ft
// 84" x 42" x ? in
// 213.36 x 106.68 x ? cm

// 4 x 10.5" == 42"
// 4 x 26.67 == 106.68 cm

// 3 x 14" == 42"
// 3 x 35.56 == 106.68 cm

DOOR_HEIGHT = 213.36;
DOOR_WIDTH = 106.68;
LOCK_ENGAGED_DIST = 5.08;
VISUAL_SEP_DIST = 0.2;
BAR_THICKNESS = 1.27;

HORIZ_LOCK_GEAR_RADIUS = 6;

OUTSIDE_BOARD_COUNT = 4;
OUTSIDE_BOARD_LENGTH = DOOR_HEIGHT;
OUTSIDE_BOARD_WIDTH = 26.67;
OUTSIDE_BOARD_THICKNESS = 3.81;

INSIDE_BOARD_COUNT = 3;
INSIDE_BOARD_LENGTH = DOOR_HEIGHT;
INSIDE_BOARD_WIDTH = 35.56;
INSIDE_BOARD_THICKNESS = 3.81;

TOTAL_LENGTH = DOOR_HEIGHT;
TOTAL_WIDTH =
        DOOR_WIDTH
        + (3 * VISUAL_SEP_DIST);
TOTAL_BOARD_THICKNESS =
        OUTSIDE_BOARD_THICKNESS
        + VISUAL_SEP_DIST
        + INSIDE_BOARD_THICKNESS;

HORIZ_LOCK_BAR_LENGTH = TOTAL_WIDTH * 0.65;
HORIZ_LOCK_BAR_WIDTH = 4;
HORIZ_LOCK_BAR_THICKNESS = 2;

VERT_LOCK_BAR_LENGTH = TOTAL_LENGTH * 0.55;
VERT_LOCK_BAR_WIDTH = 4;
VERT_LOCK_BAR_THICKNESS = 2;

module outside_board()
{
    board_size = [
            OUTSIDE_BOARD_LENGTH,
            OUTSIDE_BOARD_WIDTH,
            OUTSIDE_BOARD_THICKNESS];

    board(board_size);
}

module inside_board()
{
    board_size = [
            INSIDE_BOARD_LENGTH,
            INSIDE_BOARD_WIDTH,
            INSIDE_BOARD_THICKNESS];

    board(board_size);
}

module outside_board_assembly()
{
    for(b = [0 : OUTSIDE_BOARD_COUNT - 1])
    {
        w = OUTSIDE_BOARD_WIDTH + VISUAL_SEP_DIST;
        offset_y = b * w;

        translate([0, offset_y, 0])
            outside_board();
    }
}

module inside_board_assembly()
{
    z0 =
            INSIDE_BOARD_THICKNESS
            - BAR_THICKNESS;

    for(b = [0 : INSIDE_BOARD_COUNT - 1])
    {
        w = INSIDE_BOARD_WIDTH + VISUAL_SEP_DIST;
        offset_y = b * w;

        translate([0, offset_y, 0])
            inside_board();
    }
}

module square_door()
{
    color("SaddleBrown")
        outside_board_assembly();

    z0 = OUTSIDE_BOARD_THICKNESS + VISUAL_SEP_DIST;

    color("Sienna")
        translate([0, 0, z0])
            inside_board_assembly();
}

module test_template(r)
{
    template_size = [
            TOTAL_LENGTH / 3,
            TOTAL_WIDTH + (TOTAL_WIDTH / 4),
            4 * TOTAL_BOARD_THICKNESS];

    template_offset = [
            0,
            -template_size[1] / 2,
            -template_size[2] / 2];

    difference()
    {
        translate(template_offset)
            cube(template_size);

        cylinder(
                h = template_size[2],
                r1 = r,
                r2 = r,
                center = true);
    }
}

module door()
{
    r = TOTAL_WIDTH / 2;

    offset_t = [
            TOTAL_LENGTH - r,
            TOTAL_WIDTH / 2,
            0];

    difference()
    {
        square_door();

        color("SaddleBrown")
            translate(offset_t)
                test_template(r);
    }
}

module horiz_bar()
{
    bar_size = [
            HORIZ_LOCK_BAR_LENGTH,
            HORIZ_LOCK_BAR_WIDTH,
            HORIZ_LOCK_BAR_THICKNESS];

    translate([bar_size[1], 0, 0])
        rotate([0, 0, 90])
            cube(bar_size);
}

module vert_bar()
{
    bar_size = [
            VERT_LOCK_BAR_LENGTH,
            VERT_LOCK_BAR_WIDTH,
            VERT_LOCK_BAR_THICKNESS];

            cube(bar_size);
}

module horiz_lock_bars()
{
    offset_b0 = [
            TOTAL_LENGTH * 0.70,
            -LOCK_ENGAGED_DIST,
            0];

    offset_b1 = [
            (TOTAL_LENGTH * 0.70)
                    - (2 * HORIZ_LOCK_GEAR_RADIUS)
                    - HORIZ_LOCK_BAR_WIDTH,
            TOTAL_WIDTH
                    - HORIZ_LOCK_BAR_LENGTH
                    + LOCK_ENGAGED_DIST,
            0];
    
    offset_b2 = [
            (TOTAL_LENGTH * 0.30),
            -LOCK_ENGAGED_DIST,
            0];
            
    offset_b3 = [
            (TOTAL_LENGTH * 0.30)
                    - (2 * HORIZ_LOCK_GEAR_RADIUS)
                    - HORIZ_LOCK_BAR_WIDTH,
            TOTAL_WIDTH
                    - HORIZ_LOCK_BAR_LENGTH
                    + LOCK_ENGAGED_DIST,
            0];

    translate(offset_b0)
        horiz_bar(size_ba);

    translate(offset_b1)
        horiz_bar(size_ba);
        
    translate(offset_b2)
        horiz_bar(size_ba);
        
    translate(offset_b3)
        horiz_bar(size_ba);
}

module vert_lock_bars()
{
    offset_b0 = [
            (TOTAL_LENGTH / 4)
                    - HORIZ_LOCK_GEAR_RADIUS,
            (TOTAL_WIDTH / 2)
                    + HORIZ_LOCK_GEAR_RADIUS,
            HORIZ_LOCK_BAR_THICKNESS
                    + VISUAL_SEP_DIST
                    + (HORIZ_LOCK_BAR_THICKNESS / 4)];
    
    offset_b1 = [
            (TOTAL_LENGTH / 4)
                    - (2.8 * HORIZ_LOCK_GEAR_RADIUS),
            (TOTAL_WIDTH / 2)
                    - HORIZ_LOCK_GEAR_RADIUS
                    - VERT_LOCK_BAR_WIDTH,
            HORIZ_LOCK_BAR_THICKNESS
                    + VISUAL_SEP_DIST
                    + (HORIZ_LOCK_BAR_THICKNESS / 4)];
    
    translate(offset_b0)
        vert_bar();
    
    translate(offset_b1)
        vert_bar();
}

module horiz_lock_gears()
{
    offset_g01a = [
            (TOTAL_LENGTH * 0.70)
                    - HORIZ_LOCK_GEAR_RADIUS,
            TOTAL_WIDTH / 2,
            -HORIZ_LOCK_BAR_THICKNESS / 8];
    
    offset_g01b = [
            (TOTAL_LENGTH * 0.70)
                    - HORIZ_LOCK_GEAR_RADIUS,
            TOTAL_WIDTH / 2,
            (-HORIZ_LOCK_BAR_THICKNESS / 8)
                    + (HORIZ_LOCK_BAR_THICKNESS / 4)
                    + VISUAL_SEP_DIST
                    + HORIZ_LOCK_BAR_THICKNESS];
            
    offset_g23a = [
            (TOTAL_LENGTH * 0.30)
                    - HORIZ_LOCK_GEAR_RADIUS,
            TOTAL_WIDTH / 2,
            -HORIZ_LOCK_BAR_THICKNESS / 8];
    
    offset_g23b = [
            (TOTAL_LENGTH * 0.30)
                    - HORIZ_LOCK_GEAR_RADIUS,
            TOTAL_WIDTH / 2,
            (-HORIZ_LOCK_BAR_THICKNESS / 8)
                    + (HORIZ_LOCK_BAR_THICKNESS / 4)
                    + VISUAL_SEP_DIST
                    + HORIZ_LOCK_BAR_THICKNESS];

    translate(offset_g01a)
        cylinder(
                h = HORIZ_LOCK_BAR_THICKNESS
                        + (HORIZ_LOCK_BAR_THICKNESS / 4),
                r1 = HORIZ_LOCK_GEAR_RADIUS,
                r2 = HORIZ_LOCK_GEAR_RADIUS,
                center = false);
    
    translate(offset_g01b)
        cylinder(
                h = HORIZ_LOCK_BAR_THICKNESS
                        + (HORIZ_LOCK_BAR_THICKNESS / 4),
                r1 = HORIZ_LOCK_GEAR_RADIUS,
                r2 = HORIZ_LOCK_GEAR_RADIUS,
                center = false);
                
    translate(offset_g23a)
        cylinder(
                h = HORIZ_LOCK_BAR_THICKNESS
                        + (HORIZ_LOCK_BAR_THICKNESS / 4),
                r1 = HORIZ_LOCK_GEAR_RADIUS,
                r2 = HORIZ_LOCK_GEAR_RADIUS,
                center = false);
                
    translate(offset_g23b)
        cylinder(
                h = HORIZ_LOCK_BAR_THICKNESS
                        + (HORIZ_LOCK_BAR_THICKNESS / 4),
                r1 = HORIZ_LOCK_GEAR_RADIUS,
                r2 = HORIZ_LOCK_GEAR_RADIUS,
                center = false);
}

module lock_assembly()
{
    color("Gray")
        horiz_lock_bars();

    color("DimGray")
        horiz_lock_gears();
    
    color("Gray")
        vert_lock_bars();
}

door();

translate([0, 0, 10])
    lock_assembly();
