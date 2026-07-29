// Official uCube beamsplitter and compact illumination module.
// render_mode = 0 is the complete live assembly. Press F5 to preview.

include <vendor/BOSL2/std.scad>
include <vendor/BOSL2/threading.scad>
include <vendor/uCube/uCube.scad>

$fn = 64;
epsilon = 0.02;

/* [Preview] */
render_mode = 0; // [0:complete_assembly, 1:beamsplitter_face, 2:light_face, 3:back_cover, 4:optic_cartridge, 5:camera_face, 6:camera_thread_test, 7:exploded_assembly, 8:inspection_assembly]
show_optical_references = true;

/* [Official uCube] */
internal_clearance_mm = 40; // [40]
frame_feature_mm = 7; // [7]
face_gap_mm = 0.4; // [0.4]
locator_clearance_mm = 0.2; // [0.1:0.1:0.6]

/* [Beamsplitter] */
plate_width_mm = 50; // [45:0.1:50]
plate_height_mm = 50; // [45:0.1:50]
plate_thickness_mm = 2.05; // [1:0.05:3]
plate_slot_mm = 2.1; // [2.05:0.05:3]
plate_angle_degrees = 45; // [45]
support_width_mm = 3; // [2:0.25:5]
support_length_mm = 48; // [44:0.5:48]

/* [Light source] */
light_output_diameter_mm = 30; // [25:1:32]
light_body_outer_mm = 48; // [44:1:50]
light_body_inner_mm = 42; // [38:1:44]
light_body_depth_mm = 14.1; // [12:0.5:20]
light_nose_inner_mm = 36; // [34:1:38]
led_board_size_mm = 40; // [30:1:42]
led_plane_setback_mm = 18; // [12:1:20]

/* [Optic cartridge] */
optic_cartridge_size_mm = 34; // [32:1:36]
optic_cartridge_thickness_mm = 1.2; // [0.8:0.2:2]
optic_sheet_size_mm = 32; // [30:1:33]
optic_sheet_thickness_mm = 0.6; // [0.2:0.1:1]
cartridge_fit_clearance_mm = 0.3; // [0.2:0.1:0.6]
cartridge_stop_mm = 0.5; // [0.4:0.1:1]

/* [Rear cover] */
back_cover_thickness_mm = 2.5; // [2:0.5:4]
cover_screw_offset_mm = 20.5; // [19:0.5:21]
cover_screw_radius_mm = 1.2; // [1:0.1:1.6]
cable_notch_mm = 6; // [4:1:9]

/* [Camera face] */
camera_lens_focal_length_mm = 16; // [16]
camera_lens_body_diameter_mm = 39; // [39]
camera_thread_diameter_mm = 37; // [37]
camera_thread_pitch_mm = 0.75; // [0.75]
camera_thread_clearance_mm = 0.20; // [0.1:0.05:0.4]
camera_thread_boss_length_mm = 8; // [6:0.5:12]
camera_optical_bore_mm = 30; // [26:1:32]
camera_thread_weld_mm = 0.6; // [0.4:0.1:1]
camera_thread_facets = 240; // [120:20:240]
camera_lock_ring_diameter_mm = 42; // [40:1:44]
camera_lock_ring_thickness_mm = 3; // [2:0.5:4]
camera_test_base_diameter_mm = 44; // [42:1:48]
camera_test_base_height_mm = 1; // [1:0.5:2]
camera_test_thread_height_mm = 2; // [2:0.5:4]

cube_spec = CubeSize(
    size = internal_clearance_mm,
    d = frame_feature_mm,
    faceGap = face_gap_mm,
    screw = defaultScrew
);

face_plate_thickness_mm = frame_feature_mm / 2;
face_outline_mm = internal_clearance_mm + 2 * frame_feature_mm - 2 * face_gap_mm;
locator_size_mm = internal_clearance_mm - locator_clearance_mm;
inside_half_mm = internal_clearance_mm / 2;
official_holder_span_mm = internal_clearance_mm + 1.5 * frame_feature_mm;
face_outer_depth_mm = 2 * frame_feature_mm;
face_inner_depth_mm = 1.5 * frame_feature_mm;
face_center_from_origin_mm =
    (internal_clearance_mm + 4 * frame_feature_mm) / 2
        - face_plate_thickness_mm / 2;

assert(plate_slot_mm >= plate_thickness_mm,
       "The beamsplitter slot must be at least as thick as the plate.");
assert(plate_width_mm * cos(plate_angle_degrees) <= internal_clearance_mm,
       "The projected beamsplitter width does not fit the clear cube opening.");
assert(plate_height_mm <= official_holder_span_mm,
       "The beamsplitter is taller than the span between opposing uFaces.");
assert(light_body_inner_mm >= led_board_size_mm,
       "The selected LED board does not fit the light cavity.");
assert(camera_lens_body_diameter_mm >= camera_thread_diameter_mm,
       "The lens body must be at least as wide as its M37 thread.");
assert(camera_optical_bore_mm < camera_thread_diameter_mm - 2,
       "The camera bore leaves too little wall beneath the thread.");

echo(str("uCube clear/face/overall: ", internal_clearance_mm, "/",
         internal_clearance_mm + 2 * frame_feature_mm, "/",
         internal_clearance_mm + 4 * frame_feature_mm, " mm"));
echo(str("Beamsplitter endpoint clearance: ",
         (internal_clearance_mm - plate_width_mm * cos(plate_angle_degrees)) / 2,
         " mm per side"));

// Rounded XY prism, centered in XY and extending upward from Z=0.
module rounded_xy_prism(width, depth, height, radius) {
    hull()
        for (x = [-width / 2 + radius, width / 2 - radius])
            for (y = [-depth / 2 + radius, depth / 2 - radius])
                translate([x, y, 0])
                    cylinder(h = height, r = radius);
}

// Local Z=0 is the visible inner edge of the official 40 mm cube opening.
// The uFace itself is flush with the outer cube surface at Z=-14 mm.
module official_face_at_inside_plane() {
    translate([0, 0,
               -face_outer_depth_mm + face_plate_thickness_mm / 2])
        uFace(cubeSize = cube_spec);
}

module square_locator(solid = true, aperture_mm = 0) {
    difference() {
        translate([-locator_size_mm / 2,
                   -locator_size_mm / 2,
                   -face_inner_depth_mm])
            cube([locator_size_mm,
                  locator_size_mm,
                  face_plate_thickness_mm]);

        if (!solid)
            translate([-aperture_mm / 2,
                       -aperture_mm / 2,
                       -face_inner_depth_mm - epsilon])
                cube([aperture_mm,
                      aperture_mm,
                      face_plate_thickness_mm + 2 * epsilon]);
    }
}

// Printable bottom uFace and the two recessed rails that hold the plate.
// Both rails stop at Z=0, so they are hidden below the clear side opening.
module beamsplitter_mounting_face() {
    union() {
        official_face_at_inside_plane();
        square_locator(solid = true);

        rotate([0, 0, plate_angle_degrees]) {
            // Long rails bridge the official face recess and end flush with
            // the visible inner edge of the cube.
            for (side = [-1, 1])
                translate([-support_length_mm / 2,
                           side * (plate_slot_mm / 2 + support_width_mm / 2)
                               - support_width_mm / 2,
                           -frame_feature_mm])
                    cube([support_length_mm,
                          support_width_mm,
                          frame_feature_mm]);

            // Hidden stop centers the 50 mm plate vertically while leaving
            // its full 40 mm visible portion centered in the cube opening.
            translate([-support_length_mm / 2,
                       -plate_slot_mm / 2,
                       -frame_feature_mm])
                cube([support_length_mm,
                      plate_slot_mm,
                      frame_feature_mm - face_plate_thickness_mm]);
        }
    }
}

module beamsplitter_reference() {
    color([0.45, 0.78, 1.0, 0.42])
        rotate([0, 0, plate_angle_degrees])
            translate([-plate_width_mm / 2,
                       -plate_thickness_mm / 2,
                       -face_plate_thickness_mm])
                cube([plate_width_mm,
                      plate_thickness_mm,
                      plate_height_mm]);
}

module light_face_plate_with_aperture() {
    difference() {
        official_face_at_inside_plane();
        translate([-light_nose_inner_mm / 2,
                   -light_nose_inner_mm / 2,
                   -face_outer_depth_mm - epsilon])
            cube([light_nose_inner_mm,
                  light_nose_inner_mm,
                  face_plate_thickness_mm + 2 * epsilon]);
    }
}

module rear_screw_positions(include_cable_corner = false) {
    for (x = [-cover_screw_offset_mm, cover_screw_offset_mm])
        for (y = [-cover_screw_offset_mm, cover_screw_offset_mm])
            if (include_cable_corner || x < 0 || y < 0)
                translate([x, y, 0]) children();
}

module external_light_chamber() {
    chamber_back_z = -face_inner_depth_mm - light_body_depth_mm;

    difference() {
        union() {
            translate([0, 0, chamber_back_z])
                rounded_xy_prism(light_body_outer_mm,
                                 light_body_outer_mm,
                                 light_body_depth_mm,
                                 2.5);

            rear_screw_positions()
                translate([0, 0, chamber_back_z])
                    cylinder(h = light_body_depth_mm, r = 3.2);
        }

        translate([0, 0, chamber_back_z - epsilon])
            rounded_xy_prism(light_body_inner_mm,
                             light_body_inner_mm,
                             light_body_depth_mm + 2 * epsilon,
                             1.5);

        rear_screw_positions()
            translate([0, 0, chamber_back_z - epsilon])
                cylinder(h = light_body_depth_mm + 2 * epsilon,
                         r = cover_screw_radius_mm);

        // Cable exits through the +X/+Y rear corner. That corner intentionally
        // has no cover screw.
        translate([light_body_outer_mm / 2 - cable_notch_mm,
                   light_body_outer_mm / 2 - cable_notch_mm,
                   chamber_back_z - epsilon])
            cube([cable_notch_mm + epsilon,
                  cable_notch_mm + epsilon,
                  light_body_depth_mm + 2 * epsilon]);
    }
}

module inside_light_nose() {
    pocket_mm = optic_cartridge_size_mm + cartridge_fit_clearance_mm;

    difference() {
        translate([-locator_size_mm / 2,
                   -locator_size_mm / 2,
                   -face_inner_depth_mm])
            cube([locator_size_mm,
                  locator_size_mm,
                  face_inner_depth_mm]);

        // Mixing cavity stops behind a solid ledge. The cartridge seats on
        // that ledge instead of falling through the square pocket.
        translate([-light_nose_inner_mm / 2,
                   -light_nose_inner_mm / 2,
                   -face_inner_depth_mm - epsilon])
            cube([light_nose_inner_mm,
                  light_nose_inner_mm,
                  face_inner_depth_mm
                      - optic_cartridge_thickness_mm
                      - cartridge_stop_mm
                      + epsilon]);

        // Press-fit cartridge pocket at the inside wall.
        translate([-pocket_mm / 2,
                   -pocket_mm / 2,
                   -optic_cartridge_thickness_mm])
            cube([pocket_mm,
                  pocket_mm,
                  optic_cartridge_thickness_mm + epsilon]);

        // Thirty millimeter inside-facing optical output.
        translate([0, 0, -face_inner_depth_mm - epsilon])
            cylinder(h = face_inner_depth_mm + 2 * epsilon,
                     d = light_output_diameter_mm);

        // Small pry notch for removing the flush cartridge.
        translate([0,
                   optic_cartridge_size_mm / 2,
                   -optic_cartridge_thickness_mm - epsilon])
            cylinder(h = optic_cartridge_thickness_mm + 2 * epsilon,
                     r = 2.2);
    }
}

// Printable side uFace, locator, output nose, and external mixing chamber.
module light_source_mounting_face() {
    union() {
        light_face_plate_with_aperture();
        external_light_chamber();
        inside_light_nose();
    }
}

module light_back_cover() {
    difference() {
        translate([0, 0, -back_cover_thickness_mm])
            rounded_xy_prism(light_body_outer_mm,
                             light_body_outer_mm,
                             back_cover_thickness_mm,
                             2.5);

        rear_screw_positions()
            translate([0, 0, -back_cover_thickness_mm - epsilon])
                cylinder(h = back_cover_thickness_mm + 2 * epsilon,
                         r = cover_screw_radius_mm);

        translate([light_body_outer_mm / 2 - cable_notch_mm,
                   light_body_outer_mm / 2 - cable_notch_mm,
                   -back_cover_thickness_mm - epsilon])
            cube([cable_notch_mm + epsilon,
                  cable_notch_mm + epsilon,
                  back_cover_thickness_mm + 2 * epsilon]);
    }
}

module optic_cartridge() {
    difference() {
        translate([0, 0, -optic_cartridge_thickness_mm])
            rounded_xy_prism(optic_cartridge_size_mm,
                             optic_cartridge_size_mm,
                             optic_cartridge_thickness_mm,
                             1);

        translate([0, 0, -optic_cartridge_thickness_mm - epsilon])
            cylinder(h = optic_cartridge_thickness_mm + 2 * epsilon,
                     d = light_output_diameter_mm);

        // Rear recess accepts a square diffuser or crossed-prism film coupon.
        translate([-optic_sheet_size_mm / 2 - 0.15,
                   -optic_sheet_size_mm / 2 - 0.15,
                   -optic_cartridge_thickness_mm - epsilon])
            cube([optic_sheet_size_mm + 0.3,
                  optic_sheet_size_mm + 0.3,
                  optic_sheet_thickness_mm + epsilon]);
    }
}

// Male M37 x 0.75 column used by the supplied Arducam lens face. The lens may
// be C-mount at its camera end, but this printed interface uses its female M37
// front/filter thread.
module m37_threaded_column_solid(base_z,
                                 length = camera_thread_boss_length_mm,
                                 detailed_thread = true) {
    translate([0, 0, base_z - camera_thread_weld_mm]) {
        if (detailed_thread)
            let($fn = camera_thread_facets)
                threaded_rod(
                    d = camera_thread_diameter_mm
                        - camera_thread_clearance_mm,
                    pitch = camera_thread_pitch_mm,
                    l = length + camera_thread_weld_mm,
                    bevel1 = false,
                    bevel2 = false,
                    blunt_start = true,
                    anchor = BOTTOM
                );
        else
            cylinder(h = length + camera_thread_weld_mm,
                     d = camera_thread_diameter_mm
                        - camera_thread_clearance_mm);
    }
}

// Printable official uFace with a continuous optical bore and male M37 thread.
module threaded_camera_mounting_face(detailed_thread = true) {
    face_top_z = face_plate_thickness_mm / 2;

    difference() {
        union() {
            uFace(cubeSize = cube_spec);
            m37_threaded_column_solid(face_top_z,
                                      camera_thread_boss_length_mm,
                                      detailed_thread);
        }

        translate([0, 0, -frame_feature_mm])
            cylinder(h = frame_feature_mm
                         + face_top_z
                         + camera_thread_boss_length_mm
                         + camera_thread_weld_mm
                         + 3,
                     d = camera_optical_bore_mm);
    }
}

module camera_thread_test_stub() {
    difference() {
        union() {
            cylinder(h = camera_test_base_height_mm,
                     d = camera_test_base_diameter_mm);
            m37_threaded_column_solid(camera_test_base_height_mm,
                                      camera_test_thread_height_mm,
                                      true);
        }

        translate([0, 0, -1])
            cylinder(h = camera_test_base_height_mm
                         + camera_test_thread_height_mm
                         + camera_thread_weld_mm
                         + 3,
                     d = camera_optical_bore_mm);
    }
}

module camera_lens_reference() {
    face_top_z = face_plate_thickness_mm / 2;
    thread_engagement_mm = 3.6;
    lens_reference_length_mm = 12;

    color([0.55, 0.55, 0.58, 0.72])
        translate([0, 0, face_top_z + 0.6])
            difference() {
                cylinder(h = camera_lock_ring_thickness_mm,
                         d = camera_lock_ring_diameter_mm);
                translate([0, 0, -epsilon])
                    cylinder(h = camera_lock_ring_thickness_mm + 2 * epsilon,
                             d = camera_thread_diameter_mm + 0.4);
            }

    color([0.26, 0.22, 0.48, 0.62])
        translate([0, 0,
                   face_top_z
                       + camera_thread_boss_length_mm
                       - thread_engagement_mm])
            difference() {
                cylinder(h = lens_reference_length_mm,
                         d = camera_lens_body_diameter_mm);
                translate([0, 0, -epsilon])
                    cylinder(h = lens_reference_length_mm + 2 * epsilon,
                             d = camera_thread_diameter_mm + 0.4);
            }
}

module led_board_reference() {
    color([1.0, 0.72, 0.12, 0.55])
        translate([-led_board_size_mm / 2,
                   -led_board_size_mm / 2,
                   -led_plane_setback_mm - 0.8])
            cube([led_board_size_mm, led_board_size_mm, 1.6]);
}

module optic_sheet_reference() {
    color([0.75, 1.0, 0.95, 0.55])
        translate([-optic_sheet_size_mm / 2,
                   -optic_sheet_size_mm / 2,
                   -optic_sheet_thickness_mm])
            cube([optic_sheet_size_mm,
                  optic_sheet_size_mm,
                  optic_sheet_thickness_mm]);
}

module light_beam_reference() {
    color([1.0, 0.95, 0.55, 0.16])
        cylinder(h = internal_clearance_mm,
                 d = light_output_diameter_mm);
}

module light_face_transform() {
    translate([-inside_half_mm, 0, 0])
        rotate([0, 90, 0])
            children();
}

// Demo placement only. Any compatible uFace can be moved to another cube side.
module camera_face_transform() {
    translate([0, face_center_from_origin_mm, 0])
        rotate([-90, 0, 0])
            children();
}

module complete_assembly(show_cube = true, show_references = true) {
    chamber_back_z = -face_inner_depth_mm - light_body_depth_mm;

    // Background modifier keeps the exact official shell visible in F5 while
    // preventing it from obscuring the two mounting faces.
    if (show_cube)
        %color([0.72, 0.72, 0.72, 0.20])
            uCube(cubeSize = cube_spec);

    // Orange bottom mounting plate and its recessed beamsplitter rails.
    color([0.95, 0.40, 0.06])
        translate([0, 0, -inside_half_mm])
            beamsplitter_mounting_face();

    // Blue side mounting plate and external light-source chamber.
    color([0.08, 0.35, 0.78])
        light_face_transform()
            light_source_mounting_face();

    color([0.05, 0.20, 0.52])
        light_face_transform()
            translate([0, 0, chamber_back_z])
                light_back_cover();

    color([0.10, 0.68, 0.62])
        light_face_transform()
            optic_cartridge();

    // Purple camera uFace on +Y for the demo. This is the reflected-beam side
    // for the shown 45-degree plate orientation.
    color([0.38, 0.20, 0.62])
        camera_face_transform()
            threaded_camera_mounting_face(detailed_thread = false);

    if (show_references) {
        translate([0, 0, -inside_half_mm])
            beamsplitter_reference();

        light_face_transform() {
            led_board_reference();
            optic_sheet_reference();
            light_beam_reference();
        }

        camera_face_transform()
            camera_lens_reference();
    }
}

module exploded_assembly() {
    chamber_back_z = -face_inner_depth_mm - light_body_depth_mm;

    color([0.72, 0.72, 0.72, 0.30])
        uCube(cubeSize = cube_spec);

    color([0.95, 0.40, 0.06])
        translate([0, 0, -48])
            beamsplitter_mounting_face();

    color([0.45, 0.78, 1.0, 0.42])
        translate([0, 0, -42])
            beamsplitter_reference();

    color([0.08, 0.35, 0.78])
        translate([-48, 0, 0])
            rotate([0, 90, 0])
                light_source_mounting_face();

    color([0.05, 0.20, 0.52])
        translate([-58, 0, 0])
            rotate([0, 90, 0])
                translate([0, 0, chamber_back_z])
                    light_back_cover();

    color([0.10, 0.68, 0.62])
        translate([-38, 0, 0])
            rotate([0, 90, 0])
                optic_cartridge();

    color([0.38, 0.20, 0.62])
        translate([0, 48, 0])
            rotate([-90, 0, 0])
                threaded_camera_mounting_face(detailed_thread = false);

    translate([0, 58, 0])
        rotate([-90, 0, 0])
            camera_lens_reference();
}

module wire_cube(size, beam = 0.8) {
    color([0.55, 0.60, 0.62, 0.42]) {
        for (x = [-size / 2 + beam / 2, size / 2 - beam / 2])
            for (y = [-size / 2 + beam / 2, size / 2 - beam / 2])
                translate([x, y, 0]) cube([beam, beam, size], center = true);

        for (x = [-size / 2 + beam / 2, size / 2 - beam / 2])
            for (z = [-size / 2 + beam / 2, size / 2 - beam / 2])
                translate([x, 0, z]) cube([beam, size, beam], center = true);

        for (y = [-size / 2 + beam / 2, size / 2 - beam / 2])
            for (z = [-size / 2 + beam / 2, size / 2 - beam / 2])
                translate([0, y, z]) cube([size, beam, beam], center = true);
    }
}

module inspection_assembly() {
    wire_cube(internal_clearance_mm, 0.65);
    wire_cube(internal_clearance_mm + 4 * frame_feature_mm, 0.8);
    complete_assembly(show_cube = false, show_references = true);
}

if (render_mode == 0)
    complete_assembly(show_cube = true,
                      show_references = show_optical_references);
else if (render_mode == 1)
    beamsplitter_mounting_face();
else if (render_mode == 2)
    light_source_mounting_face();
else if (render_mode == 3)
    light_back_cover();
else if (render_mode == 4)
    optic_cartridge();
else if (render_mode == 5)
    threaded_camera_mounting_face(detailed_thread = true);
else if (render_mode == 6)
    camera_thread_test_stub();
else if (render_mode == 7)
    exploded_assembly();
else if (render_mode == 8)
    inspection_assembly();
