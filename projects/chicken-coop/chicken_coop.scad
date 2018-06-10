/**
 * @file chicken_coop.scad
 * @brief TODO.
 *
 * Units: centimeters
 *
 * roof idea: https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Kasai_sumiyoshi-jinja03s3200crop.jpg/1200px-Kasai_sumiyoshi-jinja03s3200crop.jpg
 *
 * http://s3.amazonaws.com/finehomebuilding.s3.tauntoncloud.com/app/uploads/2016/04/09094233/021224108-1-main.jpg
 *
 */

// modules/functions
use <common/common_functions.scad>
use <common/board.scad>

// constants
POST_BOARD_WIDTH = in_to_cm(4.0);
POST_BOARD_THICKNESS = POST_BOARD_WIDTH;

FOUNDATION_BASE_DISTANCE = ft_to_cm(4.0);
FOUNDATION_BASE_SIZE = in_to_cm(10.0);
FOUNDATION_BASE_HEIGHT = in_to_cm(6.0);

FRAME_VERT_POST_BOARD_LENGTH = ft_to_cm(6.0);
FRAME_HORIZ_POST_BOARD_LENGTH =
        FOUNDATION_BASE_DISTANCE
        + POST_BOARD_WIDTH
        + FOUNDATION_BASE_SIZE;

FRAME_BASE_HEIGHT = ft_to_cm(2.0);
FRAME_TOP_HEIGHT =
        FRAME_VERT_POST_BOARD_LENGTH
        - POST_BOARD_THICKNESS;

WALL_DOOR_HEIGHT_BOARD_COUNT = 2;
WALL_DOOR_WIDTH_BOARD_COUNT = 2;

WALL_BOARD_LENGTH =
        FOUNDATION_BASE_DISTANCE
        + FOUNDATION_BASE_SIZE
        - POST_BOARD_WIDTH;
WALL_BOARD_WIDTH = in_to_cm(8.0);
WALL_BOARD_THICKNESS = in_to_cm(0.5);

WALL_SUPPORT_BOARD_LENGTH =
        FRAME_TOP_HEIGHT
            - FRAME_BASE_HEIGHT
            - POST_BOARD_THICKNESS;
WALL_SUPPORT_BOARD_WIDTH = in_to_cm(1.5);
WALL_SUPPORT_BOARD_THICKNESS = in_to_cm(1.5);

FLOOR_BOARD_LENGTH =
        FOUNDATION_BASE_DISTANCE
        + FOUNDATION_BASE_SIZE
        - POST_BOARD_WIDTH;
FLOOR_BOARD_WIDTH = in_to_cm(6.0);
FLOOR_BOARD_THICKNESS = in_to_cm(0.75);

// must be a multiple of WALL_BOARD_WIDTH
NESTING_BOX_HEIGHT = in_to_cm(16.0);

// height is adjusted with this parameter
ROOF_VERT_POST_BOARD_LENGTH = in_to_cm(8.0);

ROOF_ANGLE = 35.0;
ROOF_CENTER_OFFSET = -20.0;
ROOF_SUPPORT_BEAM_OVERRUN = ft_to_cm(2.6);
ROOF_SUPPORT_BEAM_BOARD_LENGTH =
        (FRAME_HORIZ_POST_BOARD_LENGTH / 2)
        + ROOF_SUPPORT_BEAM_OVERRUN;

ROOF_CROSS_BOARD_OVERRUN = in_to_cm(8.0);
ROOF_CROSS_BOARD_LENGTH =
        FRAME_HORIZ_POST_BOARD_LENGTH
        + (2 * ROOF_CROSS_BOARD_OVERRUN);
ROOF_CROSS_BOARD_WIDTH = in_to_cm(2.0);
ROOF_CROSS_BOARD_THICKNESS = in_to_cm(1.0);

ROOF_CROSS_BOARD_START_OFFSET = in_to_cm(4.0);
ROOF_CROSS_BOARD_COUNT = 5;
ROOF_CROSS_BOARD_SPACING = in_to_cm(10.0);

ROOF_PANEL_LENGTH =
        ROOF_CROSS_BOARD_LENGTH
        - ROOF_CROSS_BOARD_OVERRUN;
ROOF_PANEL_WIDTH =
        ROOF_SUPPORT_BEAM_BOARD_LENGTH
        - (ROOF_CROSS_BOARD_OVERRUN / 2);
ROOF_PANEL_THICKNESS = 1.0;

LADDER_ANGLE = 29.8;
LADDER_BOARD_COUNT = 5;

LADDER_BOARD_LENGTH = ft_to_cm(5.0);
LADDER_BOARD_WIDTH = in_to_cm(2.0);
LADDER_BOARD_THICKNESS = in_to_cm(1.0);

LADDER_CROSS_BOARD_COUNT = 8;
LADDER_CROSS_BOARD_OVERRUN = in_to_cm(2.0);
LADDER_CROSS_BOARD_SPACING = in_to_cm(6.0);

LADDER_CROSS_BOARD_LENGTH =
        (LADDER_BOARD_WIDTH * LADDER_BOARD_COUNT)
        + (2 * LADDER_CROSS_BOARD_OVERRUN);
LADDER_CROSS_BOARD_WIDTH = in_to_cm(2.0);
LADDER_CROSS_BOARD_THICKNESS = in_to_cm(1.0);

// includes
include <foundation.scad>
include <frame.scad>
include <walls.scad>
include <flooring.scad>
include <nesting_box.scad>
include <roof.scad>
include <ladder.scad>

module chicken_coop()
{
    color("SaddleBrown")
        frame();

    color("Peru")
        walls();
    %walls_side_front();

    color("Chocolate")
        flooring();

    color("Peru")
        nesting_box_left();

    color("Peru")
        nesting_box_right();

    roof();

    ladder();
}

module chicken_coop_demo()
{
    foundation_dist =
            (FOUNDATION_BASE_SIZE / 2)
            - (POST_BOARD_THICKNESS / 2);

    foundation_offset = [
            foundation_dist,
            foundation_dist,
            FOUNDATION_BASE_HEIGHT / 2];

    floor_size = [
            2 * FOUNDATION_BASE_DISTANCE,
            2 * FOUNDATION_BASE_DISTANCE,
            0.1];

    floor_offset = [
            -floor_size[0]/6,
            -floor_size[1]/6,
            -floor_size[2]];

    translate(floor_offset)
        %cube(floor_size);

    %foundation();

    translate(foundation_offset)
        chicken_coop();
}

chicken_coop_demo();
