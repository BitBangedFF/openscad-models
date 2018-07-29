/**
 * @file couch.scad
 * @brief TODO.
 *
 * units: centimeter
 *
 */

// modules
use <common/common_functions.scad>
use <common/board.scad>

// constants
VISUAL_OVERRUN = get_visual_overrun();
TENON_OVERRUN = 1.0;

BASE_POST_TO_POST_LENGTH = ft_to_cm(10.0);
BASE_POST_TO_POST_DEPTH = ft_to_cm(3.0);
BASE_POST_TO_POST_HEIGHT = ft_to_cm(2.5);
BASE_HEIGHT = in_to_cm(12.0);

POST_WIDTH = in_to_cm(6.0);
POST_THICKNESS = in_to_cm(6.0);

BEAM_WIDTH = in_to_cm(6.0);
BEAM_THICKNESS = in_to_cm(2.0);

PIN_BOARD_LENGTH = POST_WIDTH + (2 * TENON_OVERRUN);
PIN_BOARD_RADIUS = in_to_cm(1.0);

LONG_BEAM_TENON_DEPTH = POST_THICKNESS + TENON_OVERRUN;
LONG_BEAM_TENON_WIDTH = BEAM_WIDTH * (3 / 4);
SHORT_BEAM_TENON_DEPTH = POST_THICKNESS + TENON_OVERRUN;
SHORT_BEAM_LOWER_TENON_WIDTH = BEAM_WIDTH * (2 / 3);
SHORT_BEAM_UPPER_FRONT_TENON_WIDTH = BEAM_WIDTH * (2 / 3);
SHORT_BEAM_UPPER_BACK_TENON_WIDTH = BEAM_WIDTH * (1 / 2);

SIDE_ARM_WIDTH = POST_WIDTH;
SIDE_ARM_THICKNESS = in_to_cm(2.0);
SIDE_ARM_TENON_WIDTH = SIDE_ARM_WIDTH / 3;
// TODO - visual rendering issue
SIDE_ARM_TENON_DEPTH = 0.001 + (POST_THICKNESS - BEAM_THICKNESS) / 2;

SUPPORT_PLANK_SEP_DISTANCE = in_to_cm(6.0);
SUPPORT_PLANK_LENGTH =
        BASE_POST_TO_POST_DEPTH
        + POST_WIDTH
        + BEAM_THICKNESS;
SUPPORT_PLANK_WIDTH = in_to_cm(6.0);
SUPPORT_PLANK_THICKNESS = in_to_cm(1.5);
SUPPORT_PLANK_START_OFFSET = SUPPORT_PLANK_SEP_DISTANCE / 2;
SUPPORT_PLANK_CUTOUT_THICKNESS = SUPPORT_PLANK_THICKNESS / 4;
SUPPORT_PLANK_COUNT = 10;

BASE_POST_LENGTH = BASE_POST_TO_POST_HEIGHT;
LONG_BEAM_LENGTH =
        BASE_POST_TO_POST_LENGTH
        + (2 * POST_THICKNESS)
        + (2 * TENON_OVERRUN);
SHORT_BEAM_LENGTH =
        BASE_POST_TO_POST_DEPTH
        + (2 * POST_WIDTH)
        + (2 * TENON_OVERRUN);
SIDE_ARM_LENGTH =
        BASE_POST_TO_POST_DEPTH
        + (2 * SIDE_ARM_TENON_DEPTH);

// includes
include <parts/base_post.scad>
include <parts/base_posts.scad>
include <parts/support_plank.scad>
include <parts/support_planks.scad>
include <parts/long_beam.scad>
include <parts/short_beam.scad>
include <parts/upper_short_beam.scad>
include <parts/lower_short_beam.scad>
include <parts/side_arm.scad>
include <parts/side_arms.scad>
include <parts/side_support_beams.scad>
include <parts/pins.scad>
include <docs/printvar.scad>

module base_beams_assembly()
{
    assert(POST_THICKNESS == POST_WIDTH);

    height_offset = BASE_HEIGHT - BEAM_WIDTH;
    side_height_offset = BASE_HEIGHT;
    depth_offset = (POST_THICKNESS - BEAM_THICKNESS) / 2;

    front_pos = [
            -TENON_OVERRUN,
            depth_offset,
            height_offset];

    rear_pos = [
            -TENON_OVERRUN,
            depth_offset
                + POST_WIDTH
                + BASE_POST_TO_POST_DEPTH,
            height_offset];

    left_pos = [
            depth_offset,
            -TENON_OVERRUN,
            side_height_offset];

    right_pos = [
            depth_offset
                + POST_THICKNESS
                + BASE_POST_TO_POST_LENGTH,
            -TENON_OVERRUN,
            side_height_offset];

    translate(front_pos)
        long_beam();

    translate(rear_pos)
        long_beam();

    translate(left_pos)
        lower_short_beam();

    translate(right_pos)
        lower_short_beam();
}

module back_assembly()
{
    beam_height = BASE_POST_LENGTH - BEAM_WIDTH;
    beam_depth = (POST_THICKNESS - BEAM_THICKNESS) / 2;

    beam_pos = [
            -TENON_OVERRUN,
            beam_depth
                + POST_WIDTH
                + BASE_POST_TO_POST_DEPTH,
            beam_height];

    translate(beam_pos)
        long_beam();
}

module couch_demo_assembly()
{
    union()
    {
        color("SandyBrown")
            base_posts();

        color("SaddleBrown")
            base_beams_assembly();

        color("SaddleBrown")
            back_assembly();

        color("Sienna")
            side_arms();

        color("SaddleBrown")
            side_support_beams();

        color("Sienna")
            support_planks();
        
        color("Sienna")
            pins();
    }
}

echo(OPENSCAD_VERSION = version());

couch_demo_assembly();

printvar_length("BASE_POST_TO_POST_LENGTH", BASE_POST_TO_POST_LENGTH);
printvar_length("BASE_POST_TO_POST_DEPTH", BASE_POST_TO_POST_DEPTH);
