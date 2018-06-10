/**
 * @file assembly.scad
 * @brief TODO.
 *
 */

include <parts/bed_frame.scad>
include <parts/mattress.scad>
include <docs/print_vars.scad>

module demo()
{
    bed_frame();

    %mattress();

    print_vars();
}

demo();
