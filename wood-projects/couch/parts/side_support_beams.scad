/**
 * @file side_support_beams.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/side_support_beams.scad>
 *
* Depends on:
 * - include parts/upper_short_beam.scad
 *
 */

// modules

// constants

module side_support_beams()
{
    height_offset =
            BASE_POST_LENGTH
            - SIDE_ARM_THICKNESS
            - BEAM_WIDTH;
    depth_offset = (POST_THICKNESS - BEAM_THICKNESS) / 2;

    left_pos = [
            depth_offset,
            -TENON_OVERRUN,
            height_offset];

    right_pos = [
            depth_offset
                + POST_THICKNESS
                + BASE_POST_TO_POST_LENGTH,
            -TENON_OVERRUN,
            height_offset];

    translate(left_pos)
        upper_short_beam();

    translate(right_pos)
        upper_short_beam();
}
