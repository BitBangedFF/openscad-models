/**
 * @file lower_short_beam.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/lower_short_beam.scad>
 *
* Depends on:
 * - include parts/short_beam.scad
 *
 */

// modules

// constants

module lower_short_beam()
{
    tenon_cutout_size = [
            BEAM_THICKNESS
                + (2 * VISUAL_OVERRUN),
            SHORT_BEAM_TENON_DEPTH
                + VISUAL_OVERRUN,
            BEAM_WIDTH
                - SHORT_BEAM_LOWER_TENON_WIDTH
                + VISUAL_OVERRUN];

    offset_a = [
            - VISUAL_OVERRUN,
            -VISUAL_OVERRUN,
            -VISUAL_OVERRUN];

    offset_b = [
            -VISUAL_OVERRUN,
            SHORT_BEAM_LENGTH
                - SHORT_BEAM_TENON_DEPTH,
            -VISUAL_OVERRUN];

    difference()
    {
        short_beam();

        translate(offset_a)
            cube(tenon_cutout_size);

        translate(offset_b)
            cube(tenon_cutout_size);

        // TESTING
        translate([BEAM_THICKNESS / 2, SHORT_BEAM_LENGTH / 2, BEAM_WIDTH + 5.5])
            rotate([0, 90, 0])
                linear_extrude(height = BEAM_THICKNESS + (2*VISUAL_OVERRUN), center = true, convexity = 10, twist = 0)
                    //resize([0, 0, BEAM_WIDTH + 2*VISUAL_OVERRUN])
                    scale([1, 3.3, 1])
                        circle(r = 14, $fn = 30);
    }
}
