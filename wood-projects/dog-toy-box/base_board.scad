// base_board.scad

use <board.scad>

module base_board(size = [10, 5, 1], proportions = [0.05, 0.5, 0.4], paint = "SaddleBrown")
{
    // 1st proportion is the lenth of the tenon wrt the board width
    // 2nd proportion is the width of the tenon wrt the board width
    // 3rd proportion is the thickness of the tenon wrt the board width
    cutout_size = [
            size[0] * proportions[0],
            size[1]/2 - (size[1]*proportions[1])/2,
            size[2]];

    tenon_cutout_size = [
            cutout_size[0],
            size[1] - (2*cutout_size[1]),
            size[2] - (size[2] * proportions[2])];

    color(paint)
        difference()
        {
            board(size = size);
            cube(size = cutout_size);
            translate([0, size[1] - cutout_size[1], 0])
                cube(size = cutout_size);
            translate([size[0] - cutout_size[0], size[1] - cutout_size[1], 0])
                cube(size = cutout_size);
            translate([size[0] - cutout_size[0], 0, 0])
                cube(size = cutout_size);
            translate([0, cutout_size[1], 0])
                cube(size = tenon_cutout_size);
            translate([size[0] - cutout_size[0], cutout_size[1], 0])
                cube(size = tenon_cutout_size);
        }
}
