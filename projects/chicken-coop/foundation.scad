/**
 * @file foundation.scad
 * @brief TODO.
 *
 */

module foundation_base()
{
    base_size = [
            FOUNDATION_BASE_SIZE,
            FOUNDATION_BASE_SIZE,
            FOUNDATION_BASE_HEIGHT];

    translate([0, 0, -FOUNDATION_BASE_HEIGHT/2])
        cube(base_size);
}

module foundation()
{
    dist = FOUNDATION_BASE_DISTANCE + FOUNDATION_BASE_SIZE;

    foundation_base();

    translate([dist, 0, 0])
        foundation_base();

    translate([dist, dist, 0])
        foundation_base();

    translate([0, dist, 0])
        foundation_base();
}
