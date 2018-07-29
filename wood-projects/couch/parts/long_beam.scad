/**
 * @file long_beam.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/long_beam.scad>
 *
 */

// modules
use <../boards/long_beam_board.scad>

// constants

module long_beam()
{
    board_size = [
            LONG_BEAM_LENGTH,
            BEAM_WIDTH,
            BEAM_THICKNESS];

    tenon_cutout_size = [
            LONG_BEAM_TENON_DEPTH
                + VISUAL_OVERRUN,
            BEAM_THICKNESS
                + (2 * VISUAL_OVERRUN),
            BEAM_WIDTH
                - LONG_BEAM_TENON_WIDTH
                + VISUAL_OVERRUN];

    offset_a = [
            - VISUAL_OVERRUN,
            -VISUAL_OVERRUN,
            -VISUAL_OVERRUN];

    offset_b = [
            LONG_BEAM_LENGTH
                - LONG_BEAM_TENON_DEPTH,
            -VISUAL_OVERRUN,
            -VISUAL_OVERRUN];

    difference()
    {
        long_beam_board(board_size);

        translate(offset_a)
            cube(tenon_cutout_size);

        translate(offset_b)
            cube(tenon_cutout_size);
    }
}
