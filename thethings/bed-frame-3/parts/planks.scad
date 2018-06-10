/**
 * @file planks.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/planks.scad>
 *
 */

// modules
use <../boards/plank_board.scad>

// constants
PLANK_BOARD_LENGTH =
        (SIDE_TO_SIDE_DISTANCE - POST_BOARD_WIDTH) / 2;

module planks()
{
    board_size = [
            PLANK_BOARD_LENGTH,
            PLANK_BOARD_WIDTH,
            PLANK_BOARD_THICKNESS];

    ly = SIDE_TO_SIDE_DISTANCE
            - PLANK_BOARD_LENGTH
            - (POST_BOARD_WIDTH / 2);
    ry = (POST_BOARD_WIDTH / 2);
    dist = PLANK_BOARD_WIDTH + PLANK_BOARD_SEP_DISTANCE;

    for(p = [0:PLANK_BOARD_COUNT - 1])
    {
        left_offset = [
                POST_BOARD_THICKNESS
                        + (p * dist),
                ly,
                ABOVE_GROUND_DISTANCE
                        + SUPPORT_BOARD_WIDTH
                        - PLANK_BOARD_THICKNESS];

        right_offset = [
                POST_BOARD_THICKNESS
                        + (p * dist),
                ry,
                ABOVE_GROUND_DISTANCE
                        + SUPPORT_BOARD_WIDTH
                        - PLANK_BOARD_THICKNESS];

        translate(left_offset)
            plank_board(board_size);

        translate(right_offset)
            plank_board(board_size);
    }
}
