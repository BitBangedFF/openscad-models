/**
 * @file utensil_holder.scad
 * @brief TODO.
 *
 * units: centimeter
 *
 */

/* [Visual] */
VISUAL_OVERRUN = 0.1;

/* [Board Dimensions (units = cm)] */
LENGTH = 45.0;
WIDTH = 33.0;
THICKNESS = 4.5;

/* [Layout] */
BORDER_OFFSET = 2.0;
BARRIER_WIDTH = 2.5;
CUTOUT_LENGTH = 24.5;
CUTOUT_DEPTH = 3.5;
TRAY_WIDTH = 8.0;
KNIFE_CUTOUT_WIDTH = 4.0;
FORK_CUTOUT_WIDTH = 4.0;
SPOON_CUTOUT_WIDTH = 5.5;

include <docs/printvar.scad>

function front_tray_size() = [
        TRAY_WIDTH,
        WIDTH
            - (2 * BORDER_OFFSET)
            - TRAY_WIDTH
            - BARRIER_WIDTH,
        CUTOUT_DEPTH
            + VISUAL_OVERRUN];

function side_tray_size() = [
        LENGTH
            - (2 * BORDER_OFFSET),
        TRAY_WIDTH,
        CUTOUT_DEPTH
            + VISUAL_OVERRUN];

module board()
{
    board_size = [
            LENGTH,
            WIDTH,
            THICKNESS];

    cube(board_size, center = false);
}

module front_tray_cutout()
{
    cutout_size = front_tray_size();

    cube(cutout_size, center = false);
}

module side_tray_cutout()
{
    cutout_size = side_tray_size();

    cube(cutout_size, center = false);
}

module knife_cutout()
{
    cutout_size = [
            CUTOUT_LENGTH,
            KNIFE_CUTOUT_WIDTH,
            CUTOUT_DEPTH
                + VISUAL_OVERRUN];

    cube(cutout_size, center = false);
}

module fork_cutout()
{
    cutout_size = [
            CUTOUT_LENGTH,
            FORK_CUTOUT_WIDTH,
            CUTOUT_DEPTH
                + VISUAL_OVERRUN];

    cube(cutout_size, center = false);
}

module spoon_cutout()
{
    cutout_size = [
            CUTOUT_LENGTH,
            SPOON_CUTOUT_WIDTH,
            CUTOUT_DEPTH
                + VISUAL_OVERRUN];

    cube(cutout_size, center = false);
}

module utensil_holder()
{
    assert(CUTOUT_DEPTH <= THICKNESS);

    z_pos = THICKNESS - CUTOUT_DEPTH;

    front_tray_pos = [
            BORDER_OFFSET,
            WIDTH
                - front_tray_size()[1]
                - BORDER_OFFSET,
            z_pos];

    side_tray_pos = [
            BORDER_OFFSET,
            BORDER_OFFSET,
            z_pos];

    knife_pos = [
            BORDER_OFFSET
                + TRAY_WIDTH
                + BARRIER_WIDTH,
            WIDTH
                - KNIFE_CUTOUT_WIDTH
                - BORDER_OFFSET,
            z_pos];

    fork_pos = [
            knife_pos[0],
            knife_pos[1]
                - FORK_CUTOUT_WIDTH
                - BARRIER_WIDTH,
            z_pos];

    spoon_pos = [
            fork_pos[0],
            fork_pos[1]
                - SPOON_CUTOUT_WIDTH
                - BARRIER_WIDTH,
            z_pos];

    difference()
    {
        board();

        translate(front_tray_pos)
            front_tray_cutout();

        translate(side_tray_pos)
            side_tray_cutout();

        translate(knife_pos)
            knife_cutout();

        translate(fork_pos)
            fork_cutout();

        translate(spoon_pos)
            spoon_cutout();
    }
}

utensil_holder();

front_tray_size = front_tray_size();
side_tray_size = side_tray_size();
printvar_length("FRONT TREY LENGTH", front_tray_size[1]);
printvar_length("SIDE TREY LENGTH", side_tray_size[0]);
