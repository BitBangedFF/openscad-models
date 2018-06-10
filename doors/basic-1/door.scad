// door.scad
// units: centimeter
// TODO:
// - separate into files/parts
// - move locking assembly to in between?
//
// ref http://www.cannymachines.com/entries/9/openscad_dimensioned_drawings

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

VERT_BAR_OFFSET = DOOR_WIDTH / 8;
HORIZ_BAR_OFFSET = DOOR_HEIGHT / 2;

HANDLE_SHAFT_RADIUS = 2.54 / 2;
HANDLE_SHAFT_LENGTH = 17.78;

HANDLE_GEAR_RADIUS = 5.08 / 2;
HANDLE_GEAR_LENGTH = BAR_THICKNESS;

HANDLE_GRIP_RADIUS = 2.54 / 2;
HANDLE_GRIP_LENGTH = 15;
HANDLE_GRIP_OFFSET_ANGLE = 15;

HANDLE_ARM_RADIUS = 1.27 / 2;
HANDLE_ARM_LENGTH = 15;
HANDLE_ARM_OFFSET_ANGLE = 20;

HANDLE_LEVER_RADIUS = 1.27 / 2;
HANDLE_LEVER_OFFSET_ANGLE = -4.3;
HANDLE_UPPER_LEVER_LENGTH = 31.3;
HANDLE_LOWER_LEVER_LENGTH = 36.4;

SUPPORT_STRAP_BAR_WIDTH = 7.62;
SUPPORT_STRAP_BAR_LENGTH =
        DOOR_WIDTH
        - SUPPORT_STRAP_BAR_WIDTH;
SUPPORT_STRAP_BAR_THICKNESS = 0.3;

SUPPORT_STRAP_BOLT_RADIUS = 1;
SUPPORT_STRAP_BOLT_LENGTH = 10.5;
SUPPORT_STRAP_BOLT_OFFSETS = [
        SUPPORT_STRAP_BAR_WIDTH,
        3 * SUPPORT_STRAP_BAR_WIDTH + 22,
        (3 * SUPPORT_STRAP_BAR_WIDTH) + 22 + 18,
        DOOR_WIDTH - SUPPORT_STRAP_BAR_WIDTH];

VERT_LOCK_BAR_LENGTH = (DOOR_HEIGHT / 3);
VERT_LOCK_BAR_WIDTH = 2.54;
VERT_LOCK_BAR_THICKNESS = BAR_THICKNESS;

HORIZ_LOCK_BAR_LENGTH =
        (DOOR_WIDTH / 2) - LOCK_ENGAGED_DIST;
HORIZ_LOCK_BAR_WIDTH = 2.54;
HORIZ_LOCK_BAR_THICKNESS = BAR_THICKNESS;

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

module vert_lock_bar()
{
    bar_size = [
            VERT_LOCK_BAR_LENGTH,
            VERT_LOCK_BAR_WIDTH,
            VERT_LOCK_BAR_THICKNESS];

    board(bar_size);
}

module horiz_lock_bar()
{
    bar_size = [
            HORIZ_LOCK_BAR_LENGTH,
            HORIZ_LOCK_BAR_WIDTH,
            HORIZ_LOCK_BAR_THICKNESS];

    translate([HORIZ_LOCK_BAR_WIDTH, 0, 0])
        rotate([0, 0, 90])
            board(bar_size);
}

module support_strap_bar()
{
    bar_size = [
            SUPPORT_STRAP_BAR_LENGTH,
            SUPPORT_STRAP_BAR_WIDTH,
            SUPPORT_STRAP_BAR_THICKNESS];

    translate([SUPPORT_STRAP_BAR_WIDTH, 0, 0])
        rotate([0, 0, 90])
            board(bar_size);
}

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
    vbar_size = [
            TOTAL_LENGTH,
            VERT_LOCK_BAR_WIDTH,
            VERT_LOCK_BAR_THICKNESS];

    hbar_size = [
            TOTAL_WIDTH,
            VERT_LOCK_BAR_WIDTH,
            VERT_LOCK_BAR_THICKNESS];

    z0 =
            INSIDE_BOARD_THICKNESS
            - BAR_THICKNESS;

    offset_h = HORIZ_BAR_OFFSET;

    difference()
    {
        for(b = [0 : INSIDE_BOARD_COUNT - 1])
        {
            w = INSIDE_BOARD_WIDTH + VISUAL_SEP_DIST;
            offset_y = b * w;

            translate([0, offset_y, 0])
                inside_board();
        }

        translate([0, VERT_BAR_OFFSET, z0])
            board(vbar_size);

        translate([offset_h, 0, z0])
            rotate([0, 0, 90])
                board(hbar_size);
    }
}

module lock_assembly()
{
    offset_engaged = LOCK_ENGAGED_DIST;

    v0 = [
            -offset_engaged,
            VERT_BAR_OFFSET,
            0];

    v1 = [
            TOTAL_LENGTH
                    - VERT_LOCK_BAR_LENGTH
                    + offset_engaged,
            VERT_BAR_OFFSET,
            0];

    h0 = [
            HORIZ_BAR_OFFSET - HORIZ_LOCK_BAR_WIDTH,
            -offset_engaged,
            0];

    h1 = [
            HORIZ_BAR_OFFSET - HORIZ_LOCK_BAR_WIDTH,
            TOTAL_WIDTH
                    - HORIZ_LOCK_BAR_LENGTH
                    + offset_engaged,
            0];

    translate(v0)
        vert_lock_bar();

    translate(v1)
        vert_lock_bar();

    translate(h0)
        horiz_lock_bar();

    translate(h1)
        horiz_lock_bar();
}

module handle_assembly()
{
    offset_gear = [
            HORIZ_BAR_OFFSET + HANDLE_GEAR_RADIUS,
            VERT_BAR_OFFSET + (VERT_LOCK_BAR_WIDTH/2),
            0];

    offset_shaft = [
            HORIZ_BAR_OFFSET + HANDLE_GEAR_RADIUS,
            VERT_BAR_OFFSET + (VERT_LOCK_BAR_WIDTH/2),
            (-HANDLE_SHAFT_LENGTH / 2)
                    - (INSIDE_BOARD_THICKNESS / 2)];

    offset_grip_outside = [
            HORIZ_BAR_OFFSET
                    + (3 * HANDLE_SHAFT_RADIUS),
            VERT_BAR_OFFSET + (VERT_LOCK_BAR_WIDTH/2),
            (-HANDLE_SHAFT_LENGTH / 2) - (2 * HANDLE_GRIP_RADIUS)];

    offset_grip_inside = [
            HORIZ_BAR_OFFSET
                    + (3 * HANDLE_SHAFT_RADIUS),
            VERT_BAR_OFFSET + (VERT_LOCK_BAR_WIDTH/2),
            (HANDLE_SHAFT_LENGTH / 2) - HANDLE_GRIP_RADIUS];

    offset_arm = [
            HORIZ_BAR_OFFSET
                    + HANDLE_GEAR_RADIUS,
            VERT_BAR_OFFSET + (VERT_LOCK_BAR_WIDTH/2),
            HORIZ_LOCK_BAR_THICKNESS + HANDLE_ARM_RADIUS];

    offset_upper_lever = [
            TOTAL_LENGTH
                    - VERT_LOCK_BAR_LENGTH
                    + LOCK_ENGAGED_DIST,
            VERT_BAR_OFFSET + (VERT_LOCK_BAR_WIDTH/2),
            HORIZ_LOCK_BAR_THICKNESS + HANDLE_ARM_RADIUS];

    offset_lower_lever = [
            VERT_LOCK_BAR_LENGTH - LOCK_ENGAGED_DIST,
            VERT_BAR_OFFSET + (VERT_LOCK_BAR_WIDTH/2),
            HORIZ_LOCK_BAR_THICKNESS + HANDLE_ARM_RADIUS];

    translate(offset_gear)
        cylinder(
                h = HANDLE_GEAR_LENGTH,
                r1 = HANDLE_GEAR_RADIUS,
                r2 = HANDLE_GEAR_RADIUS,
                center = false);

    translate(offset_shaft)
        cylinder(
                h = HANDLE_SHAFT_LENGTH,
                r1 = HANDLE_SHAFT_RADIUS,
                r2 = HANDLE_SHAFT_RADIUS,
                center = false);

    translate(offset_grip_outside)
        rotate([0, -90, -HANDLE_GRIP_OFFSET_ANGLE])
            cylinder(
                    h = HANDLE_GRIP_LENGTH,
                    r1 = HANDLE_GRIP_RADIUS,
                    r2 = HANDLE_GRIP_RADIUS,
                    center = false);

    translate(offset_grip_inside)
        rotate([0, -90, -HANDLE_GRIP_OFFSET_ANGLE])
            cylinder(
                    h = HANDLE_GRIP_LENGTH,
                    r1 = HANDLE_GRIP_RADIUS,
                    r2 = HANDLE_GRIP_RADIUS,
                    center = false);

    translate(offset_arm)
        rotate([0, 0, -HANDLE_ARM_OFFSET_ANGLE])
            translate([-HANDLE_ARM_LENGTH / 2, 0, 0])
                rotate([0, 90, 0])
                    cylinder(
                            h = HANDLE_ARM_LENGTH,
                            r1 = HANDLE_ARM_RADIUS,
                            r2 = HANDLE_ARM_RADIUS,
                            center = false);

    translate(offset_upper_lever)
        rotate([0, 0, -HANDLE_LEVER_OFFSET_ANGLE])
            translate([-HANDLE_UPPER_LEVER_LENGTH, 0, 0])
                rotate([0, 90, 0])
                    cylinder(
                            h = HANDLE_UPPER_LEVER_LENGTH,
                            r1 = HANDLE_LEVER_RADIUS,
                            r2 = HANDLE_LEVER_RADIUS,
                            center = false);

    translate(offset_lower_lever)
        rotate([0, 0, -HANDLE_LEVER_OFFSET_ANGLE])
                rotate([0, 90, 0])
                    cylinder(
                            h = HANDLE_LOWER_LEVER_LENGTH,
                            r1 = HANDLE_LEVER_RADIUS,
                            r2 = HANDLE_LEVER_RADIUS,
                            center = false);
}

module support_straps_assembly()
{
    p0 = [
            SUPPORT_STRAP_BAR_WIDTH,
            SUPPORT_STRAP_BAR_WIDTH / 2,
            TOTAL_BOARD_THICKNESS];

    p1 = [
            SUPPORT_STRAP_BAR_WIDTH,
            SUPPORT_STRAP_BAR_WIDTH / 2,
            -SUPPORT_STRAP_BAR_THICKNESS];

    p2 = [
            TOTAL_LENGTH
                    - (2 * SUPPORT_STRAP_BAR_WIDTH),
            SUPPORT_STRAP_BAR_WIDTH / 2,
            TOTAL_BOARD_THICKNESS];

    p3 = [
            TOTAL_LENGTH
                    - (2 * SUPPORT_STRAP_BAR_WIDTH),
            SUPPORT_STRAP_BAR_WIDTH / 2,
            -SUPPORT_STRAP_BAR_THICKNESS];

    translate(p0)
        support_strap_bar();

    translate(p1)
        support_strap_bar();

    translate(p2)
        support_strap_bar();

    translate(p3)
        support_strap_bar();

    for(y = SUPPORT_STRAP_BOLT_OFFSETS)
    {
        offset_b0 = [
                SUPPORT_STRAP_BAR_WIDTH
                        + (SUPPORT_STRAP_BAR_WIDTH / 2),
                y,
                -SUPPORT_STRAP_BAR_THICKNESS - 1];

        offset_b1 = [
                TOTAL_LENGTH
                    - (2 * SUPPORT_STRAP_BAR_WIDTH)
                    + (SUPPORT_STRAP_BAR_WIDTH / 2),
                y,
                -SUPPORT_STRAP_BAR_THICKNESS - 1];

        translate(offset_b0)
            cylinder(
                    h = SUPPORT_STRAP_BOLT_LENGTH,
                    r1 = SUPPORT_STRAP_BOLT_RADIUS,
                    r2 = SUPPORT_STRAP_BOLT_RADIUS,
                    center = false);

        translate(offset_b1)
            cylinder(
                    h = SUPPORT_STRAP_BOLT_LENGTH,
                    r1 = SUPPORT_STRAP_BOLT_RADIUS,
                    r2 = SUPPORT_STRAP_BOLT_RADIUS,
                    center = false);
    }
}

module door()
{
    color("SaddleBrown")
        outside_board_assembly();

    z0 = OUTSIDE_BOARD_THICKNESS + VISUAL_SEP_DIST;

    color("Sienna")
        translate([0, 0, z0])
            inside_board_assembly();

    z1 =
            TOTAL_BOARD_THICKNESS
            - BAR_THICKNESS
            + VISUAL_SEP_DIST;

    color("DimGray")
        translate([0, 0, z1])
        {
            lock_assembly();
            handle_assembly();
        }

    color("DarkSlateGray")
        support_straps_assembly();
}

door();
