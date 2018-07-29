/**
 * @file side_arms.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/side_arms.scad>
 *
* Depends on:
 * - include parts/side_arm.scad
 *
 */

// modules

// constants

module side_arms()
{
    // TODO - remove the 0.01, having some rendering issues
    echo("WARNING - rendering issues, using an offset");
    beam_height = BASE_POST_LENGTH - SIDE_ARM_THICKNESS + 0.01;
    yoffset = POST_WIDTH - SIDE_ARM_TENON_DEPTH;

    left_pos = [
            0,
            yoffset,
            beam_height];

    right_pos = [
            POST_THICKNESS
                + BASE_POST_TO_POST_LENGTH,
            yoffset,
            beam_height];

    translate(left_pos)
        side_arm();

    translate(right_pos)
        side_arm();
}
