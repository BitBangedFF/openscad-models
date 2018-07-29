/**
 * @file upper_short_beam.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/upper_short_beam.scad>
 *
* Depends on:
 * - include parts/short_beam.scad
 *
 */

// modules

// constants

module upper_short_beam()
{
    tenon_cutout_a_size = [
            BEAM_THICKNESS
                + (2 * VISUAL_OVERRUN),
            SHORT_BEAM_TENON_DEPTH
                + VISUAL_OVERRUN,
            BEAM_WIDTH
                - SHORT_BEAM_UPPER_FRONT_TENON_WIDTH
                + VISUAL_OVERRUN];

    tenon_cutout_b_size = [
            BEAM_THICKNESS
                + (2 * VISUAL_OVERRUN),
            SHORT_BEAM_TENON_DEPTH
                + VISUAL_OVERRUN,
            BEAM_WIDTH
                - SHORT_BEAM_UPPER_BACK_TENON_WIDTH
                + VISUAL_OVERRUN];

    offset_a = [
            - VISUAL_OVERRUN,
            -VISUAL_OVERRUN,
            SHORT_BEAM_UPPER_FRONT_TENON_WIDTH];

    offset_b = [
            -VISUAL_OVERRUN,
            SHORT_BEAM_LENGTH
                - SHORT_BEAM_TENON_DEPTH,
            SHORT_BEAM_UPPER_BACK_TENON_WIDTH];

    difference()
    {
        short_beam();

        translate(offset_a)
            cube(tenon_cutout_a_size);

        translate(offset_b)
            cube(tenon_cutout_b_size);

        // TESTING
        translate([BEAM_THICKNESS / 2, SHORT_BEAM_LENGTH / 2, -5.5])
            rotate([0, 90, 0])
                linear_extrude(height = BEAM_THICKNESS + (2*VISUAL_OVERRUN), center = true, convexity = 10, twist = 0)
                    //resize([0, 0, BEAM_WIDTH + 2*VISUAL_OVERRUN])
                    scale([1, 3.3, 1])
                        circle(r = 14, $fn = 30);
    }
}
