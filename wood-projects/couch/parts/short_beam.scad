/**
 * @file short_beam.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/short_beam.scad>
 *
 */

// modules
use <../boards/short_beam_board.scad>

// constants

module short_beam()
{
    board_size = [
            SHORT_BEAM_LENGTH,
            BEAM_WIDTH,
            BEAM_THICKNESS];

    short_beam_board(board_size);
}
