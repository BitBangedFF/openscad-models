/**
 * @file posts.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/posts.scad>
 *
 * Depends on:
 * - include parts/post.scad
 *
 */

// modules

// constants

module posts()
{
    offset_a = [
            0,
            0,
            0];

    offset_b = [
            END_TO_END_DISTANCE
                    - POST_BOARD_THICKNESS,
            0,
            0];

    offset_c = [
            END_TO_END_DISTANCE
                    - POST_BOARD_THICKNESS,
            SIDE_TO_SIDE_DISTANCE
                    - POST_BOARD_WIDTH,
            0];

    offset_d = [
            0,
            SIDE_TO_SIDE_DISTANCE
                    - POST_BOARD_WIDTH,
            0];

    translate(offset_a)
        post();

    translate(offset_b)
        post();

    translate(offset_c)
        post();

    translate(offset_d)
        post();
}
