/**
 * @file bed_frame.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/bed_frame.scad>
 *
 */

// modules
use <common/common_functions.scad>

// constants
VISUAL_OVERRUN = get_visual_overrun();

// king size mattress
// - 80 x 76 in
// - 203.2 x 193.04 cm
MATTRESS_LENGTH = in_to_cm(80);
MATTRESS_WIDTH = in_to_cm(76);
MATTRESS_THICKNESS = in_to_cm(6);
MATTRESS_TO_EDGE_DISTANCE = in_to_cm(0.9);

SUPPORT_BOARD_OVERRUN = in_to_cm(6.0);
SUPPORT_BOARD_WIDTH = in_to_cm(10.0);
SUPPORT_BOARD_THICKNESS = 4.6;

ABOVE_GROUND_DISTANCE = in_to_cm(3.0);

// POST_BOARD_THICKNESS - SUPPORT_BOARD_THICKNESS
POST_SUPPORT_COVERAGE = 10.4;

// measured from the posts, excludes support board overrun
END_TO_END_DISTANCE = in_to_cm(85.422);
SIDE_TO_SIDE_DISTANCE = in_to_cm(81.422);

// TODO - scale of the width, use trig angles
TAPER_HEIGHT = SUPPORT_BOARD_WIDTH - in_to_cm(2.0) + VISUAL_OVERRUN;
TAPER_DEPTH = in_to_cm(3) + VISUAL_OVERRUN;

CENTER_SUPPORT_TENON_WIDTH = in_to_cm(4.0);

PLANK_BOARD_WIDTH = 13.8;
PLANK_BOARD_THICKNESS = 3.8;

// each column/half has N support planks
PLANK_BOARD_COUNT = 11;
PLANK_BOARD_SEP_DISTANCE = in_to_cm(1.37);
// 10 @ 2.15 in
//PLANK_BOARD_SEP_DISTANCE = in_to_cm(2.14);

// includes
include <../parts/post.scad>
include <../parts/posts.scad>
include <../parts/side_support.scad>
include <../parts/left_side_support.scad>
include <../parts/right_side_support.scad>
include <../parts/sides.scad>
include <../parts/end_support.scad>
include <../parts/ends.scad>
include <../parts/planks.scad>
include <../parts/center_support.scad>

module bed_frame()
{
    color("Peru")
        posts();

    color("SandyBrown")
        ends();

    color("SandyBrown")
        sides();

    color("SandyBrown")
        center_support_assembly();

    color("BurlyWood")
        planks();
}
