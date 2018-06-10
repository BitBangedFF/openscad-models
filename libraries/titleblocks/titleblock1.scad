/**
 * @file titleblock1.scad
 * @brief TODO.
 *
 * Mostly copied from:
 * http://www.cannymachines.com/entries/9/openscad_dimensioned_drawings
 *
 * Include these:
 * - include <dimlines/dimlines.scad>
 * - include <titleblocks/titleblock1.scad>
 *
 * Define these:
 * PART_DETAILS = [
 *      "My Sample Part",   // title
 *      "Poplar",           // material
 *      "Planed",           // finish
 *      " ",                // weight
 *      "123"];             // part no
 *
 * PART_REVISIONS = [
 *      ["0.1", "2013-4-1", "jl"],
 *      ["0.2", "2013-4-2", "jl"],
 *      ["0.3", "2013-4-3", "jl"],
 *      ["1.0", "2013-4-5", "jl"],
 *      ["1.1", "2013-4-15", "jl"]];
 *
 * DOC_DETAILS = [
 *      "33-2",             // drawing number
 *      "Jon Lamb",         // created by
 *      " ",                // reviewed by
 *      "14 JAN 2018"];     // date of issue
 *
 * ORG_DETAILS = [
 *      "My logo",
 *      "Example Org",
 *      "Org Address, phone"];
 *
 */

module titleblock1_revisionblock(revisions)
{
    DIM_FONTSCALE = DIM_LINE_WIDTH * .7;

    // revision block headings
    row_height = 15;
    revision_width = 100;
    desc_x = 2;
    desc_y = -10;
    desc_size = 1;

    cols = [0, 20, 60, revision_width];
    rows = [0, -row_height, -row_height * 2];

    lines = [
        // horizontal lines
        [cols[0], rows[0], DIM_HORZ, revision_width, 1],
        [cols[0], rows[1], DIM_HORZ, revision_width, 1],
        [cols[0], rows[2], DIM_HORZ, revision_width, 1],
        // vertical lines
        [cols[0], rows[0], DIM_VERT, row_height * 2, 1],
        [cols[1], rows[0], DIM_VERT, row_height, 1],
        [cols[2], rows[0], DIM_VERT, row_height, 1],
        [cols[3], rows[0], DIM_VERT, row_height * 2, 1]];

    descs = [
        [cols[0] + desc_x, rows[0] + desc_y, DIM_HORZ,
                "Rev.", desc_size],
        [cols[1] + desc_x, rows[0] + desc_y, DIM_HORZ,
                "Date", desc_size],
        [cols[2] + desc_x, rows[0] + desc_y, DIM_HORZ,
                "Initials", desc_size],
        [cols[1] + desc_x, rows[1] + desc_y, DIM_HORZ,
                "Revisions", desc_size]];

    details = [];
    num_revisions = len(revisions);

    translate([
            -(revision_width + 40) * DIM_LINE_WIDTH,
            row_height * 2 * DIM_LINE_WIDTH,
            0])
    union()
    {
        titleblock(lines, descs, details);

        for(col = [0: len(cols)])
        {
            translate([cols[col] * DIM_LINE_WIDTH, 0, 0])
            rotate([0, 0, 90])
            line(num_revisions * row_height * DIM_LINE_WIDTH);
        }

        for(row = [0: len(revisions)])
        {
            translate([0, row * row_height * DIM_LINE_WIDTH, 0])
            line(revision_width * DIM_LINE_WIDTH);

            for(col = [0:2])
            {
                translate([
                        (cols[col] + desc_x) * DIM_LINE_WIDTH,
                        ((row + 1) * row_height + desc_y) * DIM_LINE_WIDTH,
                        0])
                scale([DIM_FONTSCALE, DIM_FONTSCALE, DIM_FONTSCALE])
                drawtext(revisions[row][col]);
            }
        }
    }
}

module titleblock1()
{
    row_height = 20;

    cols = [-.5, 100, 154, 270];
    title_width = cols[3];

    rows = [
            0,
            -row_height,
            -row_height * 2,
            -row_height * 3,
            -row_height * 4,
            -row_height * 5,
            -row_height * 6,
            -row_height * 7];

    // spacing tweaks to fit into the blocks
    desc_x = 2; // column offset for start of small text
    desc_y = -5; // row offset for start of small text
    det_x = 15;  // col offset for start of detail text
    det_y = -15;  // row offset for start of detail text
    desc_size = .75; // relative size of description text

    lines = [
            // horizontal lines
            [-.5, 0, DIM_HORZ, title_width, 1],
            [cols[2], rows[1], DIM_HORZ, cols[3] - cols[2] - .5, 1],
            [cols[0], rows[2], DIM_HORZ, cols[1] - cols[0] - .5, 1],
            [cols[0], rows[3], DIM_HORZ, cols[3] - .5, 1],
            [cols[0], rows[4], DIM_HORZ, cols[2] - .5, 1],
            [cols[0], rows[5], DIM_HORZ, cols[3] - .5, 1],
            [cols[0], rows[6], DIM_HORZ, cols[2] - .5, 1],
            [cols[0], rows[7], DIM_HORZ, cols[2] - .5, 1],
            [cols[0], rows[7], DIM_HORZ, title_width, 1],
            // vertical lines
            [cols[0], rows[0], DIM_VERT, -rows[7], 1],
            [cols[1], rows[0], DIM_VERT, -rows[7], 1],
            [cols[2], rows[0], DIM_VERT, -rows[7], 1],
            [cols[3], rows[0], DIM_VERT, -rows[7], 1]];

    part_desc = ["Material", "Finish", "Weight", "Part No."];
    doc_desc = ["Drawing Number",
                    "Created by",
                    "Reviewed by",
                    "Date of issue"];

    descs = [
            // part description
            [cols[0] + desc_x, rows[2] + desc_y, DIM_HORZ, part_desc[0], desc_size],
            [cols[0] + desc_x, rows[3] + desc_y, DIM_HORZ, part_desc[1], desc_size],
            [cols[0] + desc_x, rows[4] + desc_y, DIM_HORZ, part_desc[2], desc_size],
            [cols[0] + desc_x, rows[5] + desc_y, DIM_HORZ, part_desc[3], desc_size],
            // documentation description
            [cols[1] + desc_x, rows[3] + desc_y, DIM_HORZ, doc_desc[0], desc_size],
            [cols[1] + desc_x, rows[4] + desc_y, DIM_HORZ, doc_desc[1], desc_size],
            [cols[1] + desc_x, rows[5] + desc_y, DIM_HORZ, doc_desc[2], desc_size],
            [cols[1] + desc_x, rows[6] + desc_y, DIM_HORZ, doc_desc[3], desc_size]];

    details = [
            [cols[0] + desc_x, rows[0] + det_y, DIM_HORZ, PART_DETAILS[0], 1.5],
            [cols[0] + desc_x, rows[2] + det_y, DIM_HORZ, PART_DETAILS[1], 1],
            [cols[0] + desc_x, rows[3] + det_y, DIM_HORZ, PART_DETAILS[2], 1],
            [cols[0] + desc_x, rows[4] + det_y, DIM_HORZ, PART_DETAILS[3], 1],
            [cols[0] + desc_x, rows[5] + det_y, DIM_HORZ, PART_DETAILS[4], 1],
            [cols[1] + desc_x * 2, rows[3] + det_y, DIM_HORZ, DOC_DETAILS[0], 1],
            [cols[1] + desc_x * 2, rows[4] + det_y, DIM_HORZ, DOC_DETAILS[1], 1],
            [cols[1] + desc_x * 2, rows[5] + det_y, DIM_HORZ, DOC_DETAILS[2], 1],
            [cols[1] + desc_x * 2, rows[6] + det_y, DIM_HORZ, DOC_DETAILS[3], 1],
            // organization details
            [cols[1] + desc_x, rows[1] + det_y, DIM_HORZ, ORG_DETAILS[0], 1.5],
            [cols[2] + desc_x, rows[0] + det_y, DIM_HORZ, ORG_DETAILS[1], 1.5],
            [cols[2] + desc_x, rows[1] + det_y, DIM_HORZ, ORG_DETAILS[2], 1]];

    titleblock(lines, descs, details);

    rotate([0, 0, 90])
    titleblock1_revisionblock(PART_REVISIONS);
}
