/**
 * @file base_post.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/post.scad>
 *
 */

// modules
use <../boards/post_board.scad>

// constants

// functions
function base_post_get_board_size() = [
        BASE_POST_LENGTH,
        POST_WIDTH,
        POST_THICKNESS];

function base_post_get_side_arm_tenon_cutout_size() = [
        SIDE_ARM_TENON_WIDTH,
        SIDE_ARM_TENON_DEPTH
            + VISUAL_OVERRUN,
        SIDE_ARM_THICKNESS
            + VISUAL_OVERRUN];

function base_post_get_side_arm_front_tenon_offset() = [
        (SIDE_ARM_WIDTH / 2)
            - (SIDE_ARM_TENON_WIDTH / 2),
        POST_WIDTH
            - SIDE_ARM_TENON_DEPTH,
        BASE_POST_LENGTH
            - SIDE_ARM_THICKNESS];

function base_post_get_side_arm_back_tenon_offset() = [
        (SIDE_ARM_WIDTH / 2)
            - (SIDE_ARM_TENON_WIDTH / 2),
        -VISUAL_OVERRUN,
        BASE_POST_LENGTH
            - SIDE_ARM_THICKNESS];

function base_post_get_lower_short_beam_tenon_size() = [
        BEAM_THICKNESS,
        POST_THICKNESS
            + (2 * VISUAL_OVERRUN),
        SHORT_BEAM_LOWER_TENON_WIDTH];

function base_post_get_lower_short_beam_tenon_offset() = [
        (POST_THICKNESS - BEAM_THICKNESS) / 2,
        -VISUAL_OVERRUN,
        BASE_HEIGHT
            + BEAM_WIDTH
            - SHORT_BEAM_LOWER_TENON_WIDTH];

function base_post_get_lower_long_beam_tenon_size() = [
        POST_THICKNESS
            + (2 * VISUAL_OVERRUN),
        BEAM_THICKNESS,
        LONG_BEAM_TENON_WIDTH];

function base_post_get_lower_long_beam_tenon_offset() = [
        -VISUAL_OVERRUN,
        (POST_THICKNESS - BEAM_THICKNESS) / 2,
        BASE_HEIGHT - LONG_BEAM_TENON_WIDTH];

function base_post_get_upper_long_beam_tenon_size() = [
        POST_THICKNESS
            + (2 * VISUAL_OVERRUN),
        BEAM_THICKNESS,
        LONG_BEAM_TENON_WIDTH
            + VISUAL_OVERRUN];

function base_post_get_upper_long_beam_tenon_offset() = [
        -VISUAL_OVERRUN,
        (POST_THICKNESS - BEAM_THICKNESS) / 2,
        BASE_POST_LENGTH - LONG_BEAM_TENON_WIDTH];

function base_post_get_front_upper_short_beam_tenon_size() = [
        BEAM_THICKNESS,
        POST_WIDTH
            + (2 * VISUAL_OVERRUN),
        SHORT_BEAM_UPPER_FRONT_TENON_WIDTH];

function base_post_get_front_upper_short_beam_tenon_offset() = [
        (POST_THICKNESS - BEAM_THICKNESS) / 2,
        -VISUAL_OVERRUN,
        BASE_POST_LENGTH
            - SIDE_ARM_THICKNESS
            - BEAM_WIDTH];

function base_post_get_back_upper_short_beam_tenon_size() = [
        BEAM_THICKNESS,
        POST_WIDTH
            + (2 * VISUAL_OVERRUN),
        SHORT_BEAM_UPPER_BACK_TENON_WIDTH];

function base_post_get_back_upper_short_beam_tenon_offset() = [
        (POST_THICKNESS - BEAM_THICKNESS) / 2,
        -VISUAL_OVERRUN,
        BASE_POST_LENGTH
            - SIDE_ARM_THICKNESS
            - BEAM_WIDTH];

module base_post_lf()
{
    board_size = base_post_get_board_size();

    tenon_cutout_size = base_post_get_side_arm_tenon_cutout_size();
    tenon_offset_front = base_post_get_side_arm_front_tenon_offset();
    tenon_offset_back = base_post_get_side_arm_back_tenon_offset();

    lower_short_tenon_size = base_post_get_lower_short_beam_tenon_size();
    lower_short_tenon_offset = base_post_get_lower_short_beam_tenon_offset();

    lower_long_tenon_size = base_post_get_lower_long_beam_tenon_size();
    lower_long_tenon_offset = base_post_get_lower_long_beam_tenon_offset();

    front_upper_tenon_size = base_post_get_front_upper_short_beam_tenon_size();
    front_upper_tenon_offset = base_post_get_front_upper_short_beam_tenon_offset();

    difference()
    {
        post_board(board_size);

        translate(tenon_offset_front)
            cube(tenon_cutout_size);

        translate(lower_short_tenon_offset)
            cube(lower_short_tenon_size);

        translate(lower_long_tenon_offset)
            cube(lower_long_tenon_size);

        translate(front_upper_tenon_offset)
            cube(front_upper_tenon_size);
    }
}

module base_post_lr()
{
    board_size = base_post_get_board_size();

    tenon_cutout_size = base_post_get_side_arm_tenon_cutout_size();
    tenon_offset_front = base_post_get_side_arm_front_tenon_offset();
    tenon_offset_back = base_post_get_side_arm_back_tenon_offset();

    lower_short_tenon_size = base_post_get_lower_short_beam_tenon_size();
    lower_short_tenon_offset = base_post_get_lower_short_beam_tenon_offset();

    lower_long_tenon_size = base_post_get_lower_long_beam_tenon_size();
    lower_long_tenon_offset = base_post_get_lower_long_beam_tenon_offset();

    upper_long_tenon_size = base_post_get_upper_long_beam_tenon_size();
    upper_long_tenon_offset = base_post_get_upper_long_beam_tenon_offset();

    back_upper_tenon_size = base_post_get_back_upper_short_beam_tenon_size();
    back_upper_tenon_offset = base_post_get_back_upper_short_beam_tenon_offset();

    difference()
    {
        post_board(board_size);

        translate(tenon_offset_back)
            cube(tenon_cutout_size);

        translate(lower_short_tenon_offset)
            cube(lower_short_tenon_size);

        translate(lower_long_tenon_offset)
            cube(lower_long_tenon_size);

        translate(upper_long_tenon_offset)
            cube(upper_long_tenon_size);

        translate(back_upper_tenon_offset)
            cube(back_upper_tenon_size);
    }
}

module base_post(left = true, front = true)
{
    // check if upper back beam tenon collides with upper left short beam
    z0 = BASE_POST_LENGTH - LONG_BEAM_TENON_WIDTH;
    z1 =
            BASE_POST_LENGTH
            - SIDE_ARM_THICKNESS
            - BEAM_WIDTH
            + SHORT_BEAM_UPPER_BACK_TENON_WIDTH;
    assert(z1 < z0);

    if((left == true) && (front == true))
    {
        base_post_lf();
    }
    else if((left == true) && (front == false))
    {
        base_post_lr();
    }
    else if((left == false) && (front == true))
    {
        //base_post_rf();
        base_post_lf();
    }
    else if((left == false) && (front == false))
    {
        //base_post_rr();
        base_post_lr();
    }
    else
    {
        assert(true != true);
    }
}
