/**
 * @file dog_toy_box.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/dog_toy_box.scad>
 *
 */

// modules
use <../boards/base_board.scad>
use <../boards/side_board.scad>
use <../boards/end_board.scad>
use <../boards/post_board.scad>

// constants
BOARD_OVERRUN = 0.1;

TENON_LENGTH = 5.10062;
TENON_WIDTH = 4.52125;
TENON_X1_OFFSET = 1.90495;
TENON_X2_OFFSET = 7.5438;

// includes
include <../parts/post.scad>
include <../parts/base.scad>
include <../parts/sides.scad>
include <../parts/ends.scad>
include <../parts/posts.scad>

module dog_toy_box()
{
    base();
    sides();
    ends();
    color("Peru")
        posts();
}
