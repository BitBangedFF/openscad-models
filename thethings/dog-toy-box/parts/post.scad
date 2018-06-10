/**
 * @file post.scad
 * @brief TODO.
 *
 * To use:
 * - use <parts/post.scad>
 *
 */

// modules
use <common/board.scad>
use <../boards/post_board.scad>

// constants
POST_BOARD_OVERRUN = 1.27;
POST_BOARD_LENGTH = 16.51;
POST_BOARD_WIDTH = 5.000625;
POST_BOARD_THICKNESS = 5.000625;

module post_generic(
        board_size = [10, 2, 2],
        cutout_size = [5, 4.5, 1.27],
        cutout_offset = [0, 0, 1],
        tenon_size = [5, 4.5, 1.27],
        tenon_offset_a = [10, 2, 2],
        tenon_offset_b = [10, 2, 2])
{
    aligned_tenon_size_a = [
            tenon_size[0],
            tenon_size[2],
            tenon_size[1]];
    
    aligned_tenon_size_b = [
            tenon_size[2],
            tenon_size[0],
            tenon_size[1]];

    difference()
    {
        post_board(size = board_size);
        
        translate(cutout_offset)
            cube(cutout_size);
        
        translate(tenon_offset_a)
            cube(aligned_tenon_size_a);
        
        translate(tenon_offset_b)
            cube(aligned_tenon_size_b);
    }
}

module post()
{
    cutout_overrun = 0.1;

    board_size = [
            POST_BOARD_LENGTH,
            POST_BOARD_WIDTH,
            POST_BOARD_THICKNESS];

    tenon_offset = (board_size[1] / 2) - (SIDE_BOARD_THICKNESS / 2);

    cutout_size = [
            tenon_offset + cutout_overrun,
            tenon_offset + cutout_overrun,
            BASE_BOARD_THICKNESS];

    cutout_offset = [
            -cutout_overrun,
            -cutout_overrun,
            POST_BOARD_OVERRUN];

    tenon_size = [
            TENON_LENGTH + cutout_overrun,
            TENON_WIDTH,
            SIDE_BOARD_THICKNESS];

    tenon_offset_a = [
            -cutout_overrun,
            tenon_offset,
            POST_BOARD_OVERRUN + TENON_X1_OFFSET];

    tenon_offset_b = [
            tenon_offset,
            -cutout_overrun,
            POST_BOARD_OVERRUN + TENON_X2_OFFSET];

    post_generic(
            board_size,
            cutout_size,
            cutout_offset,
            tenon_size,
            tenon_offset_a,
            tenon_offset_b);
}
