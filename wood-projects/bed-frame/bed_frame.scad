// bed_frame.scad
// units: centimeter
// TODO
// - fix multi-line constant style, operator in front
// - joints
// - make parts/files for each module

use <common/board.scad>

// king size mattress is 80 x 76 in
// rounding up a little
MATTRESS_LENGTH = 205;
MATTRESS_WIDTH = 195;

BASE_DEPTH_OFFSET = 5;
GROUND_CLEARANCE_OFFSET = 2;
CROSS_BOARD_LENGTH = 195;
CROSS_SUPPORT_BEAM_OFFSET = GROUND_CLEARANCE_OFFSET + 2.54;

POST_BOARD_WIDTH = 7.62;
POST_BOARD_THICKNESS = 7.62;

END_BOARD_LENGTH = CROSS_BOARD_LENGTH;
END_BOARD_WIDTH = 25.4;
END_BOARD_THICKNESS = 2.54;

SIDE_BOARD_LENGTH =
        MATTRESS_LENGTH
        + (2 * END_BOARD_THICKNESS);
SIDE_BOARD_WIDTH = 25.4;
SIDE_BOARD_THICKNESS = END_BOARD_THICKNESS;

SIDE_SUPPORT_BOARD_LENGTH =
        SIDE_BOARD_LENGTH
        - (2 * END_BOARD_THICKNESS);
SIDE_SUPPORT_BOARD_WIDTH = 8;
SIDE_SUPPORT_BOARD_THICKNESS = 2.54;

SUPPORT_POST_LENGTH =
        SIDE_BOARD_WIDTH
        - BASE_DEPTH_OFFSET
        + GROUND_CLEARANCE_OFFSET;
SUPPORT_POST_WIDTH = POST_BOARD_WIDTH;
SUPPORT_POST_THICKNESS = POST_BOARD_THICKNESS;

SUPPORT_BEAM_LENGTH =
        (SIDE_BOARD_LENGTH/2)
        - (SUPPORT_POST_THICKNESS/2)
        - END_BOARD_THICKNESS;
SUPPORT_BEAM_WIDTH = SUPPORT_POST_WIDTH;
SUPPORT_BEAM_THICKNESS = 2.54;

CROSS_SUPPORT_BEAM_LENGTH =
        (CROSS_BOARD_LENGTH/2)
        - SUPPORT_POST_WIDTH
        - (SUPPORT_POST_WIDTH/2)
        // tenon
        + SUPPORT_POST_WIDTH;
CROSS_SUPPORT_BEAM_WIDTH = 7.62;
CROSS_SUPPORT_BEAM_THICKNESS = 2.54;

BED_SUPPORT_BOARD_COL_CNT = 6;
BED_SUPPORT_BOARD_SEP_DIST = 23;
BED_SUPPORT_BOARD_LENGTH =
        (CROSS_BOARD_LENGTH/2)
        - SIDE_BOARD_THICKNESS;
BED_SUPPORT_BOARD_WIDTH = 15;
BED_SUPPORT_BOARD_THICKNESS = 1.905;

TOTAL_WIDTH = CROSS_BOARD_LENGTH;
        
TOTAL_LENGTH = SIDE_BOARD_LENGTH;

module side_board()
{
    board_size = [
            SIDE_BOARD_LENGTH,
            SIDE_BOARD_WIDTH,
            SIDE_BOARD_THICKNESS];

    translate([0, SIDE_BOARD_THICKNESS, 0])
        rotate([90, 0, 0])
            board(board_size);
}

module side_support_board()
{
    board_size = [
            SIDE_SUPPORT_BOARD_LENGTH,
            SIDE_SUPPORT_BOARD_WIDTH,
            SIDE_SUPPORT_BOARD_THICKNESS];

    translate([0, SIDE_SUPPORT_BOARD_THICKNESS, 0])
        rotate([90, 0, 0])
            board(board_size);
}

module side_supports()
{
    offset_base_depth =
            SIDE_BOARD_WIDTH
            + GROUND_CLEARANCE_OFFSET
            - BASE_DEPTH_OFFSET
            - SIDE_SUPPORT_BOARD_WIDTH;
    
    support_board_offset_a = [
            END_BOARD_THICKNESS,
            SIDE_BOARD_THICKNESS,
            offset_base_depth];
    
    support_board_offset_b = [
            END_BOARD_THICKNESS,
            TOTAL_WIDTH
                    - SIDE_BOARD_THICKNESS
                    - SIDE_SUPPORT_BOARD_THICKNESS,
            offset_base_depth];

    translate(support_board_offset_a)
        side_support_board();
        
    translate(support_board_offset_b)
        side_support_board();
}

module sides()
{    
    offset_a = [
            0,
            0,
            GROUND_CLEARANCE_OFFSET];
    
    offset_b = [
            0,
            TOTAL_WIDTH - SIDE_BOARD_THICKNESS,
            GROUND_CLEARANCE_OFFSET];

    translate(offset_a)
        side_board();
        
    translate(offset_b)
        side_board();
}

module base_support_post_board()
{
    support_board_size = [
            SUPPORT_POST_LENGTH,
            SUPPORT_POST_WIDTH,
            SUPPORT_POST_THICKNESS];
    
    translate([support_board_size[2], 0, 0])
        rotate([0, -90, 0])
            board(support_board_size);
}

module base_support_posts()
{
    center_x = TOTAL_LENGTH/2;
    center_y = TOTAL_WIDTH/2;

    offset_a = [
            END_BOARD_THICKNESS,
            center_y - (SUPPORT_POST_WIDTH/2),
            0];
    
    offset_ar = [
            END_BOARD_THICKNESS,
            TOTAL_WIDTH - SUPPORT_POST_WIDTH - SIDE_BOARD_THICKNESS,
            0];
    
    offset_al = [
            END_BOARD_THICKNESS,
            SIDE_BOARD_THICKNESS,
            0];
    
    offset_b = [
            center_x  - (SUPPORT_POST_THICKNESS/2),
            center_y - (SUPPORT_POST_WIDTH/2),
            0];
    
    offset_br = [
            center_x  - (SUPPORT_POST_THICKNESS/2),
            TOTAL_WIDTH - SUPPORT_POST_WIDTH - SIDE_BOARD_THICKNESS,
            0];
    
    offset_bl = [
            center_x  - (SUPPORT_POST_THICKNESS/2),
            SIDE_BOARD_THICKNESS,
            0];
    
    offset_c = [
            TOTAL_LENGTH
                    - SUPPORT_POST_THICKNESS
                    - END_BOARD_THICKNESS,
            center_y - (SUPPORT_POST_WIDTH/2),
            0];
            
    offset_cr = [
            TOTAL_LENGTH
                    - SUPPORT_POST_THICKNESS
                    - END_BOARD_THICKNESS,
            TOTAL_WIDTH - SUPPORT_POST_WIDTH - SIDE_BOARD_THICKNESS,
            0];
            
    offset_cl = [
            TOTAL_LENGTH
                    - SUPPORT_POST_THICKNESS
                    - END_BOARD_THICKNESS,
            END_BOARD_THICKNESS,
            0];

    translate(offset_a)
        base_support_post_board();
        
    translate(offset_ar)
        base_support_post_board();
        
    translate(offset_al)
        base_support_post_board();
    
    translate(offset_b)
        base_support_post_board();
        
    translate(offset_br)
        base_support_post_board();
        
    translate(offset_bl)
        base_support_post_board();
        
    translate(offset_c)
        base_support_post_board();
        
    translate(offset_cr)
        base_support_post_board();
        
    translate(offset_cl)
        base_support_post_board();
}

module base_support_beams()
{
    board_size = [
            SUPPORT_BEAM_LENGTH,
            SUPPORT_BEAM_WIDTH,
            SUPPORT_BEAM_THICKNESS];
    
    center_x = TOTAL_LENGTH/2;
    center_y = TOTAL_WIDTH/2;

    offset_a = [
            (SUPPORT_POST_THICKNESS/2)
                    + END_BOARD_THICKNESS,
            center_y - (SUPPORT_BEAM_WIDTH/2),
            SUPPORT_POST_LENGTH - SUPPORT_BEAM_THICKNESS];
    
    offset_b = [
            center_x,
            center_y - (SUPPORT_BEAM_WIDTH/2),
            SUPPORT_POST_LENGTH - SUPPORT_BEAM_THICKNESS];
    
    translate(offset_a)
        board(board_size);
    
    translate(offset_b)
        board(board_size);
}

module base_cross_support_beam()
{
    board_size = [
            CROSS_SUPPORT_BEAM_LENGTH,
            CROSS_SUPPORT_BEAM_WIDTH,
            CROSS_SUPPORT_BEAM_THICKNESS];
    
    rotate([0, 0, 90])
        rotate([90, 0, 0])
            board(board_size);
}

module base_cross_supports()
{
    center_x = TOTAL_LENGTH/2;
    center_y = TOTAL_WIDTH/2;

    offset_a = [
            center_x - (CROSS_SUPPORT_BEAM_THICKNESS/2),
            SIDE_BOARD_THICKNESS + (SUPPORT_POST_WIDTH/2),
            CROSS_SUPPORT_BEAM_OFFSET];
    
    offset_b = [
            center_x - (CROSS_SUPPORT_BEAM_THICKNESS/2),
            center_y,
            CROSS_SUPPORT_BEAM_OFFSET];
    
    translate(offset_a)
        base_cross_support_beam();
    
    translate(offset_b)
        base_cross_support_beam();
}

module end_boards()
{
    board_size = [
            END_BOARD_LENGTH,
            END_BOARD_WIDTH,
            END_BOARD_THICKNESS];
    
    offset_a = [
            0,
            0,
            GROUND_CLEARANCE_OFFSET];
    
    offset_b = [
            SIDE_BOARD_LENGTH - END_BOARD_THICKNESS,
            0,
            GROUND_CLEARANCE_OFFSET];
    
    translate(offset_a)
        rotate([0, 0, 90])
            rotate([90, 0, 0])
                board(board_size);
    
    translate(offset_b)
        rotate([0, 0, 90])
            rotate([90, 0, 0])
                board(board_size);
}

module bed_support_board()
{
    board_size = [
            BED_SUPPORT_BOARD_LENGTH,
            BED_SUPPORT_BOARD_WIDTH,
            BED_SUPPORT_BOARD_THICKNESS];
    
    offset_m = [
            BED_SUPPORT_BOARD_WIDTH,
            SIDE_BOARD_THICKNESS,
            SUPPORT_POST_LENGTH];
    
    translate(offset_m)
        rotate([0, 0, 90])
            board(board_size);
}

module bed_support_left_column_boards()
{
    for(b = [0 : BED_SUPPORT_BOARD_COL_CNT - 1])
    {
        xoffset = 
                END_BOARD_THICKNESS
                + (b *
                (BED_SUPPORT_BOARD_WIDTH
                        + BED_SUPPORT_BOARD_SEP_DIST));
        
        translate([xoffset, 0, 0])
            bed_support_board();
    }
}

module bed_support_right_column_boards()
{
    translate([0, TOTAL_WIDTH/2 - SIDE_BOARD_THICKNESS, 0])
        bed_support_left_column_boards();
}

module bed_frame()
{
    color("Sienna")
        side_supports();
    
    color("SaddleBrown")
        sides();
    
    color("Peru")
        base_support_posts();
    
    color("Sienna")
        base_support_beams();
    
    color("Sienna")
        base_cross_supports();
    
    color("SaddleBrown")
        end_boards();

    color("Chocolate")
        bed_support_left_column_boards();
        
    color("Chocolate")
        bed_support_right_column_boards();
}

module mattress()
{
    mattress_size = [
            MATTRESS_LENGTH,
            MATTRESS_WIDTH,
            24];

    offset_m = [
            END_BOARD_THICKNESS,
            SIDE_BOARD_THICKNESS,
            SUPPORT_POST_LENGTH
                    + BED_SUPPORT_BOARD_THICKNESS
                    + 1];

    translate(offset_m)
        cube(mattress_size);
}

length = 150;

color("Gray")
    translate([-length/2, -length/2, -0.1])
        cube([TOTAL_LENGTH + length, TOTAL_WIDTH + length, 0.1]);

bed_frame();

%mattress();
