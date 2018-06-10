/**
 * @file print_vars.scad
 * @brief TODO.
 *
 * To use:
 *
 * Depends on:
 *
 */

// modules

// constants

module print_vars()
{
    echo("-----------------------------------");
    echo(SHELF_BOARD_LENGTH = SHELF_BOARD_LENGTH);
    echo(INCHES = cm_to_in(SHELF_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(SHELF_BOARD_WIDTH = SHELF_BOARD_WIDTH);
    echo(INCHES = cm_to_in(SHELF_BOARD_WIDTH));

    echo("-----------------------------------");
    echo(SHELF_BOARD_THICKNESS = SHELF_BOARD_THICKNESS);
    echo(INCHES = cm_to_in(SHELF_BOARD_THICKNESS));

    echo("-----------------------------------");
    echo(SUPPORT_BOARD_LENGTH = SUPPORT_BOARD_LENGTH);
    echo(INCHES = cm_to_in(SUPPORT_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(SUPPORT_BOARD_WIDTH = SUPPORT_BOARD_WIDTH);
    echo(INCHES = cm_to_in(SUPPORT_BOARD_WIDTH));

    echo("-----------------------------------");
    echo(SUPPORT_BOARD_THICKNESS = SUPPORT_BOARD_THICKNESS);
    echo(INCHES = cm_to_in(SUPPORT_BOARD_THICKNESS));

    echo("-----------------------------------");
    echo(CROSS_BOARD_LENGTH = CROSS_BOARD_LENGTH);
    echo(INCHES = cm_to_in(CROSS_BOARD_LENGTH));

    echo("-----------------------------------");
    echo(CROSS_BOARD_WIDTH = CROSS_BOARD_WIDTH);
    echo(INCHES = cm_to_in(CROSS_BOARD_WIDTH));

    echo("-----------------------------------");
    echo(CROSS_BOARD_THICKNESS = CROSS_BOARD_THICKNESS);
    echo(INCHES = cm_to_in(CROSS_BOARD_THICKNESS));

    echo("-----------------------------------");
    echo(SUPPORT_OFFSET = SUPPORT_OFFSET);
    echo(INCHES = cm_to_in(SUPPORT_OFFSET));

    echo("-----------------------------------");
    echo(SUPPORT_OVERRUN = SUPPORT_OVERRUN);
    echo(INCHES = cm_to_in(SUPPORT_OVERRUN));

    echo("-----------------------------------");
    echo(SUPPORT_TENON_WIDTH = SUPPORT_TENON_WIDTH);
    echo(INCHES = cm_to_in(SUPPORT_TENON_WIDTH));

    echo("-----------------------------------");
}
