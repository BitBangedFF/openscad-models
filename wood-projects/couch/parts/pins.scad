/**
 * @file pins.scad
 * @brief TODO.
 *
 * To use:
 * - include <parts/pins.scad>
 *
 */

// modules
use <../boards/pin_board.scad>

// constants

module pins_front()
{
    long_beam_pin_offset = [
            POST_THICKNESS / 2,
            POST_THICKNESS / 2,
            BASE_HEIGHT
                - BEAM_WIDTH
                + BEAM_WIDTH
                - LONG_BEAM_TENON_WIDTH];

    short_beam_pin_offset = [
            POST_THICKNESS / 2,
            POST_THICKNESS / 2,
            BASE_HEIGHT
                + BEAM_WIDTH];

    translate(long_beam_pin_offset)
        rotate([0, 0, 90])
            pin_board(radius = PIN_BOARD_RADIUS, length = PIN_BOARD_LENGTH);

    translate(short_beam_pin_offset)
        pin_board(radius = PIN_BOARD_RADIUS, length = PIN_BOARD_LENGTH);
}

module pins_rear()
{
    pins_front();
}

module pins_lf()
{
    pins_front();
}

module pins_lr()
{
    offset_lr = [
            0,
            POST_WIDTH + BASE_POST_TO_POST_DEPTH,
            0];

    translate(offset_lr)
        pins_rear();
}

module pins_rf()
{
    offset_rf = [
            POST_THICKNESS + BASE_POST_TO_POST_LENGTH,
            0,
            0];

    translate(offset_rf)
        pins_front();
}

module pins_rr()
{
    offset_rr = [
            POST_THICKNESS + BASE_POST_TO_POST_LENGTH,
            POST_WIDTH + BASE_POST_TO_POST_DEPTH,
            0];

    translate(offset_rr)
        pins_rear();
}

module pins()
{
    pins_lf();
    pins_lr();

    pins_rf();
    pins_rr();
}
