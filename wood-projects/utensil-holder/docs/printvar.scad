/**
 * @file printvar.scad
 * @brief TODO.
 *
 * To use:
 * - include <docs/printvar.scad>
 *
 */

// modules
use <common/common_functions.scad>

// constants

module printvar_length(id, value)
{
    echo(
        str(id, " = ", value, " cm = ", cm_to_in(value), " in")
    );
}
