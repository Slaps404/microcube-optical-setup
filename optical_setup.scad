// Parametric microcube beamsplitter carrier and compact light-source face.
// Printable parts use modes 0-3. Modes 4-5 are reference assemblies only.

include <vendor/uCube/uCube.scad>

/* [Render] */
render_mode = 4; // [0:beamsplitter_carrier, 1:light_face_body, 2:light_back_cover, 3:optic_cartridge, 4:assembly, 5:exploded_assembly, 6:inspection_assembly]

/* [Microcube interface] */
internal_clearance_mm = 40; // [40:0.5:80]
frame_feature_mm = 7; // [5:0.5:10]
face_gap_mm = 0.4; // [0.2:0.1:0.8]
outer_plate_thickness_mm = 3.5; // [2:0.5:6]
locator_depth_mm = 3.5; // [2:0.5:6]
base_corner_radius_mm = 4; // [2:0.5:8]
locator_clearance_mm = 0.2; // [0.1:0.1:0.6]
locator_corner_radius_mm = 0.8; // [0.4:0.2:2]

/* [Beamsplitter] */
plate_width_mm = 50; // [40:0.1:60]
plate_height_mm = 50; // [40:0.1:60]
plate_thickness_mm = 2.05; // [1:0.05:5]
slot_thickness_mm = 2.1; // [2.05:0.05:3]
plate_side_clearance_mm = 0.3; // [0:0.1:1]
beam_angle_degrees = 45; // [45]
support_width_mm = 3; // [2:0.25:5]

/* [Light source] */
light_aperture_mm = 30; // [20:1:40]
light_cavity_outer_mm = 48; // [42:1:52]
light_cavity_inner_mm = 42; // [38:1:46]
light_nose_inner_mm = 36; // [32:1:38]
led_plane_distance_mm = 18; // [15:1:20]
led_board_size_mm = 40; // [30:1:42]
led_board_thickness_mm = 1.6; // [1:0.1:3]
front_wall_thickness_mm = 1.5; // [1:0.25:3]
optic_sheet_size_mm = 32; // [30:1:38]
optic_sheet_thickness_mm = 0.6; // [0.2:0.1:2]
optic_cartridge_size_mm = 34; // [32:1:36]
optic_cartridge_thickness_mm = 1.2; // [0.8:0.2:2]
back_cover_thickness_mm = 2.5; // [2:0.5:4]
back_cover_screw_radius_mm = 1.1; // [0.8:0.1:1.5]
back_cover_screw_offset_mm = 21; // [18:0.5:22]
cable_notch_radius_mm = 3; // [2:0.5:5]

/* [Preview colors] */
show_light_rays = true;

$fn = 64;
epsilon = 0.02;

face_size_mm = internal_clearance_mm + 2 * frame_feature_mm;
base_size_mm = face_size_mm - 2 * face_gap_mm;
hole_offset_mm = (face_size_mm - frame_feature_mm) / 2;
locator_size_mm = internal_clearance_mm - locator_clearance_mm;
wall_inner_plane_mm = internal_clearance_mm / 2;
cube_outer_size_mm = internal_clearance_mm + 4 * frame_feature_mm;
face_seat_plane_mm = wall_inner_plane_mm + frame_feature_mm;
support_height_mm = frame_feature_mm - locator_depth_mm;
support_length_mm = plate_width_mm + 2 * plate_side_clearance_mm;
support_outer_spacing_mm = slot_thickness_mm / 2 + support_width_mm;
light_body_back_mm = led_plane_distance_mm + led_board_thickness_mm + 1.5;

module rounded_box_xy(width, depth, height, radius, center_z = false) {
    translate([0, 0, center_z ? -height / 2 : 0])
        linear_extrude(height = height)
            offset(r = radius)
                square([width - 2 * radius, depth - 2 * radius], center = true);
}

module face_mount_holes(z_start, height) {
    for (x = [-hole_offset_mm, hole_offset_mm])
        for (y = [-hole_offset_mm, hole_offset_mm])
            translate([x, y, z_start - epsilon])
                cylinder(h = height + 2 * epsilon,
                         r = getattr(defaultScrew, "screwR"));
}

// The outside flange sits beyond the cube face seat. The square locator enters
// only half of the 7 mm face depth, as requested.
module common_face_base(center_opening_mm = 0) {
    difference() {
        union() {
            translate([0, 0, -frame_feature_mm - outer_plate_thickness_mm])
                rounded_box_xy(base_size_mm,
                               base_size_mm,
                               outer_plate_thickness_mm,
                               base_corner_radius_mm);

            translate([0, 0, -frame_feature_mm])
                rounded_box_xy(locator_size_mm,
                               locator_size_mm,
                               locator_depth_mm,
                               locator_corner_radius_mm);
        }

        face_mount_holes(-frame_feature_mm - outer_plate_thickness_mm,
                         outer_plate_thickness_mm + locator_depth_mm);

        if (center_opening_mm > 0)
            translate([0, 0,
                       -frame_feature_mm - outer_plate_thickness_mm - epsilon])
                cylinder(h = frame_feature_mm +
                             outer_plate_thickness_mm + 2 * epsilon,
                         d = center_opening_mm);
    }
}

module beamsplitter_supports() {
    // These two rails begin where the half-depth locator ends and stop exactly
    // at z=0, the cube interior plane. They cannot be seen through a side face.
    translate([0, 0, -support_height_mm])
        rotate([0, 0, beam_angle_degrees]) {
            translate([-support_length_mm / 2,
                       -support_outer_spacing_mm,
                       0])
                cube([support_length_mm,
                      support_width_mm,
                      support_height_mm]);
            translate([-support_length_mm / 2,
                       slot_thickness_mm / 2,
                       0])
                cube([support_length_mm,
                      support_width_mm,
                      support_height_mm]);
        }
}

module beamsplitter_carrier() {
    difference() {
        union() {
            common_face_base();
            beamsplitter_supports();
        }

        // Keep screw bores clear through any overlapping support geometry.
        face_mount_holes(-frame_feature_mm - outer_plate_thickness_mm,
                         frame_feature_mm + outer_plate_thickness_mm);
    }
}

module plate_reference() {
    color([0.32, 0.72, 1.0, 0.42])
        translate([0, 0, -support_height_mm])
            rotate([0, 0, beam_angle_degrees])
                translate([-plate_width_mm / 2,
                           -plate_thickness_mm / 2,
                           0])
                    cube([plate_width_mm,
                          plate_thickness_mm,
                          plate_height_mm]);
}

module back_cover_screw_holes(z_start, height) {
    for (x = [-back_cover_screw_offset_mm, back_cover_screw_offset_mm])
        for (y = [-back_cover_screw_offset_mm, back_cover_screw_offset_mm])
            // The +X/+Y corner is reserved for the cable exit.
            if (!(x > 0 && y > 0))
                translate([x, y, z_start - epsilon])
                    cylinder(h = height + 2 * epsilon,
                             r = back_cover_screw_radius_mm);
}

module cable_corner_notch(z_start, height) {
    // Tangent to two outside walls, creating an open, orientation-independent
    // corner route without choosing a Raspberry Pi mounting direction.
    translate([light_cavity_outer_mm / 2 - cable_notch_radius_mm,
               light_cavity_outer_mm / 2 - cable_notch_radius_mm,
               z_start - epsilon])
        cylinder(h = height + 2 * epsilon,
                 r = cable_notch_radius_mm);
}

module led_board_stops() {
    stop_height = light_body_back_mm -
                  led_plane_distance_mm -
                  led_board_thickness_mm;
    for (x = [-led_board_size_mm / 2 + 2,
               led_board_size_mm / 2 - 2])
        for (y = [-led_board_size_mm / 2 + 2,
                   led_board_size_mm / 2 - 2])
            translate([x - 1.5,
                       y - 1.5,
                       -light_body_back_mm])
                cube([3, 3, stop_height]);
}

module light_face_body() {
    difference() {
        union() {
            difference() {
                union() {
                    common_face_base(center_opening_mm = light_aperture_mm);

                    // The 48 mm board cavity stays outside the official 40 mm
                    // cube opening. Only the 39.8 mm nose passes through the
                    // face recess and ends flush with the cube interior.
                    translate([0, 0, -light_body_back_mm])
                        rounded_box_xy(light_cavity_outer_mm,
                                       light_cavity_outer_mm,
                                       light_body_back_mm - frame_feature_mm,
                                       2.5);
                    translate([0, 0, -frame_feature_mm])
                        rounded_box_xy(locator_size_mm,
                                       locator_size_mm,
                                       frame_feature_mm,
                                       locator_corner_radius_mm);
                }

                // Rear chamber accepts the generic 40 mm board.
                translate([-light_cavity_inner_mm / 2,
                           -light_cavity_inner_mm / 2,
                           -light_body_back_mm - epsilon])
                    cube([light_cavity_inner_mm,
                          light_cavity_inner_mm,
                          light_body_back_mm - frame_feature_mm + epsilon]);

                // Reduced nose clears the official 40 mm cube opening.
                translate([-light_nose_inner_mm / 2,
                           -light_nose_inner_mm / 2,
                           -frame_feature_mm - epsilon])
                    cube([light_nose_inner_mm,
                          light_nose_inner_mm,
                          frame_feature_mm -
                              front_wall_thickness_mm + epsilon]);

                // Thirty millimeter inside-facing optical output.
                translate([0, 0, -front_wall_thickness_mm - epsilon])
                    cylinder(h = front_wall_thickness_mm + 2 * epsilon,
                             d = light_aperture_mm);

                // Flush inside-face pocket for the press-fit optic cartridge.
                translate([-optic_cartridge_size_mm / 2 - 0.15,
                           -optic_cartridge_size_mm / 2 - 0.15,
                           -optic_cartridge_thickness_mm])
                    cube([optic_cartridge_size_mm + 0.3,
                          optic_cartridge_size_mm + 0.3,
                          optic_cartridge_thickness_mm + epsilon]);

                // Small overlap at the top edge provides a pry/fingernail
                // removal point without a tab entering the cube frame.
                translate([0,
                           optic_cartridge_size_mm / 2,
                           -optic_cartridge_thickness_mm - epsilon])
                    cylinder(h = optic_cartridge_thickness_mm + 2 * epsilon,
                             r = 1.5);
            }

            // Four pads locate the generic 40 mm LED board 18 mm behind the
            // output plane. The rear cover clamps it against these pads.
            led_board_stops();
        }

        back_cover_screw_holes(-light_body_back_mm,
                               light_body_back_mm);
        cable_corner_notch(-light_body_back_mm,
                           led_board_thickness_mm + 4);
    }
}

module light_back_cover() {
    difference() {
        translate([0, 0, -back_cover_thickness_mm])
            rounded_box_xy(light_cavity_outer_mm,
                           light_cavity_outer_mm,
                           back_cover_thickness_mm,
                           2.5);

        back_cover_screw_holes(-back_cover_thickness_mm,
                               back_cover_thickness_mm);
        cable_corner_notch(-back_cover_thickness_mm,
                           back_cover_thickness_mm);
    }
}

// Printable frame for a square diffuser, prism-film pair, or another thin
// optical coupon. It loads from the open rear before the LED board/cover.
module optic_cartridge() {
    difference() {
        translate([0, 0, -optic_cartridge_thickness_mm])
            rounded_box_xy(optic_cartridge_size_mm,
                           optic_cartridge_size_mm,
                           optic_cartridge_thickness_mm,
                           1.5);

        translate([0, 0, -optic_cartridge_thickness_mm - epsilon])
            cylinder(h = optic_cartridge_thickness_mm + 2 * epsilon,
                     d = light_aperture_mm);

        // Front recess accepts a 32 mm square diffuser or prism-film coupon.
        translate([-optic_sheet_size_mm / 2 - 0.15,
                   -optic_sheet_size_mm / 2 - 0.15,
                   -optic_sheet_thickness_mm])
            cube([optic_sheet_size_mm + 0.3,
                  optic_sheet_size_mm + 0.3,
                  optic_sheet_thickness_mm + epsilon]);
    }
}

module optic_sheet_reference() {
    color([0.94, 0.96, 1.0, 0.72])
        translate([-optic_sheet_size_mm / 2,
                   -optic_sheet_size_mm / 2,
                   -optic_sheet_thickness_mm])
            cube([optic_sheet_size_mm,
                  optic_sheet_size_mm,
                  optic_sheet_thickness_mm]);
}

module led_board_reference() {
    color([0.90, 0.90, 0.90, 1.0])
        translate([-led_board_size_mm / 2,
                   -led_board_size_mm / 2,
                   -led_plane_distance_mm - led_board_thickness_mm])
            cube([led_board_size_mm,
                  led_board_size_mm,
                  led_board_thickness_mm]);

    color([1.0, 0.84, 0.24, 1.0])
        for (x = [-16, -8, 0, 8, 16])
            for (y = [-16, -8, 0, 8, 16])
                translate([x, y, -led_plane_distance_mm + 0.01])
                    cylinder(h = 0.8, d = 2.4, $fn = 24);
}

module light_reference_stack() {
    optic_cartridge();
    optic_sheet_reference();
    led_board_reference();
    translate([0, 0, -light_body_back_mm])
        light_back_cover();
}

// Transparent frame reference. This is intentionally not an STL part.
module cube_reference() {
    color([0.82, 0.84, 0.80, 0.30])
        uCube(cubeSize = CubeSize(size = internal_clearance_mm,
                                  d = frame_feature_mm,
                                  faceGap = face_gap_mm,
                                  screw = defaultScrew));
}

module wire_cube_reference(size, beam) {
    color([0.72, 0.74, 0.72, 0.55]) {
        for (x = [-size / 2 + beam / 2, size / 2 - beam / 2])
            for (y = [-size / 2 + beam / 2, size / 2 - beam / 2])
                translate([x, y, 0])
                    cube([beam, beam, size], center = true);

        for (x = [-size / 2 + beam / 2, size / 2 - beam / 2])
            for (z = [-size / 2 + beam / 2, size / 2 - beam / 2])
                translate([x, 0, z])
                    cube([beam, size, beam], center = true);

        for (y = [-size / 2 + beam / 2, size / 2 - beam / 2])
            for (z = [-size / 2 + beam / 2, size / 2 - beam / 2])
                translate([0, y, z])
                    cube([size, beam, beam], center = true);
    }
}

module light_beam_reference() {
    if (show_light_rays)
        color([1.0, 0.86, 0.24, 0.12])
            translate([-wall_inner_plane_mm, 0, 0])
                rotate([0, 90, 0])
                    cylinder(h = internal_clearance_mm,
                             d = light_aperture_mm,
                             $fn = 64);
}

module assembly_reference(exploded = false) {
    explode = exploded ? 18 : 0;

    cube_reference();

    // Bottom beamsplitter carrier. Its z=0 plane aligns with the inside floor.
    color([0.95, 0.47, 0.08, 1.0])
        translate([0, 0, -wall_inner_plane_mm - explode])
            beamsplitter_carrier();
    translate([0, 0, -wall_inner_plane_mm - explode])
        plate_reference();

    // Light enters through the left face and travels along +X.
    color([0.20, 0.48, 0.82, 1.0])
        translate([-wall_inner_plane_mm - explode, 0, 0])
            rotate([0, 90, 0])
                light_face_body();
    translate([-wall_inner_plane_mm - explode, 0, 0])
        rotate([0, 90, 0])
            light_reference_stack();

    light_beam_reference();
}

module inspection_reference() {
    // Sparse inner and outer wireframes expose the mirror/support relationship
    // while preserving both the cube envelope and the 52 mm optical opening.
    wire_cube_reference(cube_outer_size_mm, 1.8);
    wire_cube_reference(internal_clearance_mm, 1.2);

    color([0.95, 0.47, 0.08, 1.0])
        translate([0, 0, -wall_inner_plane_mm])
            beamsplitter_carrier();
    translate([0, 0, -wall_inner_plane_mm])
        plate_reference();

    color([0.20, 0.48, 0.82, 1.0])
        translate([-wall_inner_plane_mm, 0, 0])
            rotate([0, 90, 0])
                light_face_body();
    translate([-wall_inner_plane_mm, 0, 0])
        rotate([0, 90, 0])
            light_reference_stack();

    light_beam_reference();
}

if (render_mode == 0)
    beamsplitter_carrier();
else if (render_mode == 1)
    light_face_body();
else if (render_mode == 2)
    light_back_cover();
else if (render_mode == 3)
    optic_cartridge();
else if (render_mode == 4)
    assembly_reference(exploded = false);
else if (render_mode == 5)
    assembly_reference(exploded = true);
else if (render_mode == 6)
    inspection_reference();
