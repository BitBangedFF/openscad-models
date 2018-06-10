/**
 * @file print_vars.scad
 * @brief TODO.
 *
 * To use:
 * - include <docs/print_vars.scad>
 *
 * Depends on:
 * - include parts/bed_frame.scad
 *
 */

// modules

// constants

module print_vars()
{
    echo("-----------------------------------");
    echo(POST_BOARD_LENGTH = POST_BOARD_LENGTH);
    echo(INCHES = cm_to_in(POST_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(POST_BOARD_WIDTH = POST_BOARD_WIDTH);
    echo(INCHES = cm_to_in(POST_BOARD_WIDTH));

    echo("-----------------------------------");
    echo(SUPPORT_BOARD_WIDTH = SUPPORT_BOARD_WIDTH);
    echo(INCHES = cm_to_in(SUPPORT_BOARD_WIDTH));

    echo("-----------------------------------");
    echo(SUPPORT_BOARD_THICKNESS = SUPPORT_BOARD_THICKNESS);
    echo(INCHES = cm_to_in(SUPPORT_BOARD_THICKNESS));

    echo("-----------------------------------");
    echo(SIDE_SUPPORT_BOARD_LENGTH = SIDE_SUPPORT_BOARD_LENGTH);
    echo(INCHES = cm_to_in(SIDE_SUPPORT_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(END_SUPPORT_BOARD_LENGTH = END_SUPPORT_BOARD_LENGTH);
    echo(INCHES = cm_to_in(END_SUPPORT_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(CENTER_SUPPORT_BOARD_LENGTH = CENTER_SUPPORT_BOARD_LENGTH);
    echo(INCHES = cm_to_in(CENTER_SUPPORT_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(CENTER_SUPPORT_TENON_WIDTH = CENTER_SUPPORT_TENON_WIDTH);
    echo(INCHES = cm_to_in(CENTER_SUPPORT_TENON_WIDTH));

    echo("-----------------------------------");
    echo(END_TO_END_DISTANCE = END_TO_END_DISTANCE);
    echo(INCHES = cm_to_in(END_TO_END_DISTANCE));

    echo("-----------------------------------");
    echo(SIDE_TO_SIDE_DISTANCE = SIDE_TO_SIDE_DISTANCE);
    echo(INCHES = cm_to_in(SIDE_TO_SIDE_DISTANCE));

    echo("-----------------------------------");
    echo(POST_SUPPORT_COVERAGE = POST_SUPPORT_COVERAGE);
    echo(INCHES = cm_to_in(POST_SUPPORT_COVERAGE));

    echo("-----------------------------------");
    echo(PLANK_BOARD_LENGTH = PLANK_BOARD_LENGTH);
    echo(INCHES = cm_to_in(PLANK_BOARD_LENGTH));

    echo("-----------------------------------");
    x2_PLANK_BOARD_LENGTH = PLANK_BOARD_LENGTH * 2;
    echo(x2_PLANK_BOARD_LENGTH = x2_PLANK_BOARD_LENGTH);
    echo(INCHES = cm_to_in(x2_PLANK_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(PLANK_BOARD_WIDTH = PLANK_BOARD_WIDTH);
    echo(INCHES = cm_to_in(PLANK_BOARD_WIDTH));

    echo("-----------------------------------");
    echo(PLANK_BOARD_THICKNESS = PLANK_BOARD_THICKNESS);
    echo(INCHES = cm_to_in(PLANK_BOARD_THICKNESS));

    echo("-----------------------------------");
    echo(PLANK_BOARD_SEP_DISTANCE = PLANK_BOARD_SEP_DISTANCE);
    echo(INCHES = cm_to_in(PLANK_BOARD_SEP_DISTANCE));

    echo("-----------------------------------");
    echo(PLANK_BOARD_COUNT = PLANK_BOARD_COUNT);

    echo("-----------------------------------");
}
