// garden.scad
// units: centimeter

use <common/common_functions.scad>
use <common/board.scad>

WALL_LENGTH_MAJOR = in_to_cm(62);
WALL_LENGTH_MINOR = in_to_cm(25);
WALL_HEIGHT = ft_to_cm(7);
WALL_THICKNESS = 0.1;

WALL_SPACING = in_to_cm(5.0);
POT_SPACING = in_to_cm(5.0);

STAND_LEG_OFFSET = 9.0;

STAND_BOARD_LENGTH = in_to_cm(14.0);
STAND_BOARD_WIDTH = in_to_cm(3.5);
STAND_BOARD_THICKNESS = in_to_cm(1.5);

// 5 gallon fabric pots
POT_DIAMETER = in_to_cm(12.0);
POT_HEIGHT = in_to_cm(10.0);

// side shelves
POST_BOARD_LENGTH = ft_to_cm(5.0);
POST_BOARD_WIDTH = in_to_cm(1.5);
POST_BOARD_THICKNESS = in_to_cm(1.5);

SHELF_BOARD_LENGTH =
        WALL_LENGTH_MINOR
        - (2 * POST_BOARD_WIDTH);
SHELF_BOARD_WIDTH = in_to_cm(6.0);
SHELF_BOARD_THICKNESS = in_to_cm(0.75);

SHELF_HEIGHT_A = ft_to_cm(1.4);
SHELF_HEIGHT_B = ft_to_cm(3.0);

module stand_board()
{
    board_size = [
            STAND_BOARD_LENGTH,
            STAND_BOARD_WIDTH,
            STAND_BOARD_THICKNESS];

    board(board_size);
}

module stand_leg_board()
{
    translate([0, STAND_BOARD_THICKNESS, 0])
        rotate([90, 0, 0])
            stand_board();
}

module stand_base_board()
{
    translate([STAND_BOARD_WIDTH, 0, 0])
        rotate([0, 0, 90])
            stand_board();
}

module stand_legs()
{
    offsetm =
            STAND_BOARD_LENGTH
            - STAND_LEG_OFFSET
            - STAND_BOARD_THICKNESS;

    translate([0, STAND_LEG_OFFSET, 0])
        stand_leg_board();

    translate([0, offsetm, 0])
        stand_leg_board();
}

module stand_base()
{
    for(b = [0:3])
    {
        translate([
                (b * STAND_BOARD_WIDTH),
                0,
                STAND_BOARD_WIDTH])
            stand_base_board();
    }
}

module stand_assembly()
{
    stand_legs();
    stand_base();
}

module pot_assembly()
{
    cylinder(
            h = POT_HEIGHT,
            r1 = POT_DIAMETER / 2,
            r2 = POT_DIAMETER / 2,
            center = false);
}

module stand_and_pot()
{
    offset_pot = [
            STAND_BOARD_LENGTH / 2,
            STAND_BOARD_LENGTH / 2,
            STAND_BOARD_WIDTH + STAND_BOARD_THICKNESS];

    color("SandyBrown")
        stand_assembly();

    color("DimGray")
        translate(offset_pot)
            pot_assembly();
}

module shelf_frame()
{
    vert_board_size = [
            POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    horiz_board_size = [
            WALL_LENGTH_MINOR
                    - (2 * POST_BOARD_WIDTH),
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    translate([WALL_LENGTH_MAJOR, 0, 0])
        rotate([0, -90, 0])
        {
            board(vert_board_size);

            translate([0, WALL_LENGTH_MINOR - POST_BOARD_WIDTH, 0])
                board(vert_board_size);


            translate([(2 * POST_BOARD_THICKNESS), POST_BOARD_WIDTH, 0])
                rotate([0, 0, 90])
                    board(horiz_board_size);

            translate([POST_BOARD_LENGTH - POST_BOARD_THICKNESS, POST_BOARD_WIDTH, 0])
                rotate([0, 0, 90])
                    board(horiz_board_size);
        }
}

module shelf_pot()
{
    board_size_a = [
            SHELF_BOARD_LENGTH,
            SHELF_BOARD_WIDTH,
            SHELF_BOARD_THICKNESS];

    board_size_b = [
            SHELF_BOARD_WIDTH
                    - SHELF_BOARD_THICKNESS,
            SHELF_BOARD_WIDTH,
            SHELF_BOARD_THICKNESS];

    board_size_c = [
            SHELF_BOARD_LENGTH
                    - (2 * SHELF_BOARD_THICKNESS),
            SHELF_BOARD_WIDTH,
            SHELF_BOARD_THICKNESS];

    offset_b0 = [
            SHELF_BOARD_THICKNESS,
            0,
            SHELF_BOARD_THICKNESS];

    offset_b1 = [
            SHELF_BOARD_LENGTH,
            0,
            SHELF_BOARD_THICKNESS];

    offset_c0 = [
            SHELF_BOARD_THICKNESS,
            SHELF_BOARD_THICKNESS,
            0];

    offset_c1 = [
            SHELF_BOARD_THICKNESS,
            SHELF_BOARD_WIDTH,
            0];

    board(board_size_a);

    translate(offset_b0)
        rotate([0, -90, 0])
            board(board_size_b);

    translate(offset_b1)
        rotate([0, -90, 0])
            board(board_size_b);

    translate(offset_c0)
        rotate([90, 0, 0])
            board(board_size_c);

    translate(offset_c1)
        rotate([90, 0, 0])
            board(board_size_c);
}

module shelf()
{
    color("Peru")
        shelf_frame();

    color("SandyBrown")
        translate([WALL_LENGTH_MAJOR, POST_BOARD_WIDTH, 0])
        {
            translate([0, 0, SHELF_HEIGHT_A])
                rotate([0, 0, 90])
                    shelf_pot();

            translate([0, 0, SHELF_HEIGHT_B])
                rotate([0, 0, 90])
                    shelf_pot();
        }
}

module walls()
{
    major_wall_size = [
            WALL_LENGTH_MAJOR,
            WALL_THICKNESS,
            WALL_HEIGHT];

    minor_wall_size = [
            WALL_THICKNESS,
            WALL_LENGTH_MINOR,
            WALL_HEIGHT];

    floor_size = [
            WALL_LENGTH_MAJOR,
            WALL_LENGTH_MINOR,
            WALL_THICKNESS];

    %cube(major_wall_size);

    translate([WALL_LENGTH_MAJOR, 0, 0])
        %cube(minor_wall_size);

    %cube(floor_size);
}

module garden()
{
    offset_pot1 = [
            WALL_LENGTH_MAJOR - STAND_BOARD_LENGTH - WALL_SPACING,
            WALL_SPACING,
            0];

    offset_pot2 = [
            offset_pot1[0] - STAND_BOARD_LENGTH - POT_SPACING,
            WALL_SPACING,
            0];

    offset_pot3 = [
            offset_pot2[0] - STAND_BOARD_LENGTH - POT_SPACING,
            WALL_SPACING,
            0];

    walls();

    translate(offset_pot1)
        stand_and_pot();

    translate(offset_pot2)
        stand_and_pot();

    translate(offset_pot3)
        stand_and_pot();

    shelf();
}

garden();
