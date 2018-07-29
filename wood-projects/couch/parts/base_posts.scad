/**
 * @file base_posts.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/base_posts.scad>
 *
 * Depends on:
 * - include parts/base_post.scad
 *
 */

// modules

// constants

module base_posts()
{
    length = POST_THICKNESS + BASE_POST_TO_POST_LENGTH;
    depth = POST_WIDTH + BASE_POST_TO_POST_DEPTH;

    base_post(true, true);

    translate([length, 0, 0])
        base_post(false, true);

    translate([0, depth, 0])
        base_post(true, false);

    translate([length, depth, 0])
        base_post(false, false);

}
