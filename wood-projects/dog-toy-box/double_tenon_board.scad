// double_tenon_board.scad

use <board.scad>

module double_tenon_board(size = [10, 5, 1], proportions = [0.15, 0.3, 0.6], paint = "BurlyWood")
{
    // 2nd proportion is the width of the tenon wrt the board width
    // 3rd proportion is the larger offset (smaller offset is implied)
    loffset = (size[1] * proportions[2]);

    tenon_length = (size[0] * proportions[0]);
    tenon_width = (size[1] * proportions[1]);

    small_cutout_size = [
            tenon_length,
            size[1] - loffset - tenon_width,
            size[2]];

    large_cutout_size = [
            tenon_length,
            loffset,
            size[2]];

    color(paint)
        difference()
        {
            board(size = size);
            cube(size = small_cutout_size);

            translate([size[0] - large_cutout_size[0], 0, 0])
                cube(size = large_cutout_size);

            translate([size[0] - small_cutout_size[0], size[1] - small_cutout_size[1], 0])
                cube(size = small_cutout_size);

            translate([0, size[1] - large_cutout_size[1], 0])
                cube(size = large_cutout_size);
        }
}
