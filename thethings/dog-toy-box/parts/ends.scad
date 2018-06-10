/**
 * @file ends.scad
 * @brief TODO.
 *
 * To use:
 * - use <parts/ends.scad>
 *
 */

// modules
use <common/board.scad>
use <../boards/end_board.scad>

// constants
END_BOARD_LENGTH = 42.1306;
END_BOARD_WIDTH = 14.05;
END_BOARD_THICKNESS = 1.27;

module ends()
{
    xoffset = (BASE_BOARD_LENGTH/2) - BOARD_OVERRUN;

    board_size = [
            END_BOARD_LENGTH,
            END_BOARD_WIDTH,
            END_BOARD_THICKNESS];

    proportion = [
            (POST_BOARD_WIDTH + BOARD_OVERRUN)/END_BOARD_LENGTH,
            TENON_WIDTH / END_BOARD_WIDTH,
            TENON_X2_OFFSET / END_BOARD_WIDTH];

    difference()
    {
        translate([-xoffset, -board_size[0]/2, 0])
            color("BurlyWood")
                end_board(board_size, proportion);

        base();
    }

    difference()
    {
        rotate([0, 0, 180])
            translate([-xoffset, -board_size[0]/2, 0])
                color("BurlyWood")
                    end_board(board_size, proportion);

        base();
    }
}
