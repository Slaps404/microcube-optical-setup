// Official uCube beamsplitter and compact illumination module.
// render_mode = 0 is the complete live assembly. Press F5 to preview.

include <vendor/BOSL2/std.scad>
include <vendor/BOSL2/threading.scad>
include <vendor/uCube/uCube.scad>

$fn = 64;
epsilon = 0.02;

/* [Preview] */
render_mode = 0; // [0:complete_assembly, 1:beamsplitter_face, 2:legacy_light_face, 3:legacy_back_cover, 4:legacy_optic_cartridge, 5:camera_face, 6:camera_thread_test, 7:exploded_assembly, 8:inspection_assembly, 9:condenser_face_cell, 10:condenser_spacer, 11:condenser_retainer, 12:led_carriage, 13:complete_light_engine, 14:exploded_light_engine]
show_optical_references = true;
camera_preview_detailed_thread = true;

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

/* [PROVISIONAL condenser light engine]
   These defaults are best guesses for an ACL5040U-A, a 20 mm LED MCPCB,
   a compact LDD-style driver, and low-duty capture lighting. Replace them
   with measured hardware dimensions before printing the complete pod. */
use_condenser_light_engine = true;
condenser_diameter_mm = 50; // [25:0.5:60]
condenser_clear_aperture_mm = 45; // [20:0.5:55]
condenser_efl_mm = 40; // Optical reference only
condenser_bfl_mm = 26; // LED die to plano surface, controls mechanics
condenser_center_thickness_mm = 21; // [5:0.5:30]
condenser_edge_thickness_mm = 2.6; // [1:0.1:8]
condenser_pocket_clearance_mm = 0.4; // [0.2:0.1:0.8]
condenser_front_vertex_setback_mm = 2; // Outside official face plane
condenser_pod_outer_mm = 60; // [56:1:68]
condenser_retainer_thickness_mm = 3; // [2:0.5:5]
condenser_retainer_clearance_mm = 0.3; // [0.2:0.1:0.6]
condenser_retainer_overlap_mm = 2.5; // [1.5:0.5:4]
condenser_focus_travel_mm = 6; // Total axial adjustment
condenser_focus_offset_mm = 0; // [-3:0.25:3]
condenser_carriage_clearance_mm = 0.4; // [0.2:0.1:0.8]
condenser_carriage_thickness_mm = 4; // [3:0.5:6]
condenser_fastener_radius_mm = 1.5; // Provisional M3 clearance

// PROVISIONAL hardware envelopes. Replace after choosing actual parts.
provisional_led_board_width_mm = 20;
provisional_led_board_height_mm = 20;
provisional_led_board_thickness_mm = 1.6;
provisional_led_emitter_height_mm = 1.4;
provisional_heat_spreader_width_mm = 40;
provisional_heat_spreader_height_mm = 40;
provisional_heat_spreader_thickness_mm = 3;
provisional_heatsink_width_mm = 36;
provisional_heatsink_height_mm = 36;
provisional_heatsink_depth_mm = 20;
provisional_driver_length_mm = 22.6;
provisional_driver_width_mm = 9.9;
provisional_driver_height_mm = 8.9;
provisional_driver_clearance_mm = 0.8;
include_provisional_driver_rails = true;
provisional_fan_size_mm = 30;
provisional_fan_thickness_mm = 10;
show_provisional_fan = false;

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

// Condenser coordinates use local Z=0 at the visible inside cube opening.
// Negative Z points outward through the light face.
condenser_face_outer_z = -face_outer_depth_mm;
condenser_lens_vertex_z = condenser_face_outer_z
    - condenser_front_vertex_setback_mm;
condenser_lens_plano_z = condenser_lens_vertex_z
    - condenser_center_thickness_mm;
condenser_lens_edge_front_z = condenser_lens_plano_z
    + condenser_edge_thickness_mm;
condenser_retainer_front_z = condenser_lens_plano_z
    - condenser_retainer_clearance_mm;
condenser_retainer_back_z = condenser_retainer_front_z
    - condenser_retainer_thickness_mm;
condenser_cell_rear_z = condenser_retainer_back_z - 0.6;
condenser_nominal_led_die_z = condenser_lens_plano_z - condenser_bfl_mm;
condenser_led_die_z = condenser_nominal_led_die_z
    - condenser_focus_offset_mm;
condenser_led_board_front_z = condenser_led_die_z
    - provisional_led_emitter_height_mm;
condenser_led_board_back_z = condenser_led_board_front_z
    - provisional_led_board_thickness_mm;
condenser_carriage_back_z = condenser_led_board_back_z
    - condenser_carriage_thickness_mm;
condenser_nominal_carriage_back_z = condenser_lens_plano_z
    - condenser_bfl_mm
    - provisional_led_emitter_height_mm
    - provisional_led_board_thickness_mm
    - condenser_carriage_thickness_mm;
condenser_spacer_rear_z = condenser_nominal_carriage_back_z
    - condenser_focus_travel_mm / 2;
condenser_heat_spreader_back_z = condenser_led_board_back_z
    - provisional_heat_spreader_thickness_mm;
condenser_heatsink_back_z = condenser_heat_spreader_back_z
    - provisional_heatsink_depth_mm;
condenser_carriage_outer_mm = condenser_clear_aperture_mm + 3;
condenser_carriage_size_mm = condenser_carriage_outer_mm
    - condenser_carriage_clearance_mm;

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
assert(condenser_diameter_mm + 2 * 2.5 <= condenser_pod_outer_mm,
       "The condenser pod leaves less than 2.5 mm wall around the lens.");
assert(condenser_clear_aperture_mm <= condenser_diameter_mm,
       "The condenser clear aperture cannot exceed its diameter.");
assert(abs(condenser_focus_offset_mm) <= condenser_focus_travel_mm / 2,
       "The condenser focus offset exceeds the modeled adjustment travel.");
assert(provisional_heat_spreader_width_mm <= condenser_carriage_size_mm,
       "The provisional heat spreader does not fit the LED carriage.");

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

// PROVISIONAL 50 mm condenser light engine. The printed shell locates parts;
// the aluminum heat spreader and heatsink carry LED heat, not the plastic.
module condenser_pod_corner_positions(include_cable_corner = false) {
    offset = condenser_pod_outer_mm / 2 - 5;
    for (x = [-offset, offset])
        for (y = [-offset, offset])
            if (include_cable_corner || x < 0 || y < 0)
                translate([x, y, 0]) children();
}

module condenser_retainer_screw_positions() {
    bolt_radius = (condenser_diameter_mm
                   - 2 * condenser_retainer_overlap_mm
                   + condenser_pod_outer_mm - 4) / 4;
    for (angle = [90, 210, 330])
        rotate([0, 0, angle])
            translate([bolt_radius, 0, 0]) children();
}

module condenser_inside_nose() {
    difference() {
        translate([-locator_size_mm / 2,
                   -locator_size_mm / 2,
                   -face_inner_depth_mm - epsilon])
            cube([locator_size_mm,
                  locator_size_mm,
                  face_inner_depth_mm + epsilon]);

        translate([0, 0, -face_inner_depth_mm - epsilon])
            cylinder(h = face_inner_depth_mm + 2 * epsilon,
                     d = light_output_diameter_mm);
    }
}

// uFace plus the front cell. The 50 mm lens loads from the rear.
module condenser_face_cell() {
    lens_pocket_d = condenser_diameter_mm
        + condenser_pocket_clearance_mm;
    retainer_outer_d = condenser_pod_outer_mm - 4;
    retainer_pocket_d = retainer_outer_d
        + condenser_retainer_clearance_mm;

    difference() {
        union() {
            official_face_at_inside_plane();
            condenser_inside_nose();

            translate([0, 0, condenser_cell_rear_z])
                rounded_xy_prism(condenser_pod_outer_mm,
                                 condenser_pod_outer_mm,
                                 condenser_face_outer_z
                                     - condenser_cell_rear_z
                                     + epsilon,
                                 3);
        }

        // Thirty millimeter port through the official uFace and front lip.
        translate([0, 0, condenser_face_outer_z - epsilon])
            cylinder(h = -condenser_face_outer_z
                         + 2 * epsilon,
                     d = light_output_diameter_mm);

        // Clear optical cavity around the curved face.
        translate([0, 0, condenser_lens_edge_front_z])
            cylinder(h = condenser_lens_vertex_z
                         - condenser_lens_edge_front_z
                         + epsilon,
                     d = condenser_clear_aperture_mm + 1);

        // Close radial fit around the physical lens edge.
        translate([0, 0, condenser_retainer_front_z])
            cylinder(h = condenser_lens_edge_front_z
                         - condenser_retainer_front_z
                         + epsilon,
                     d = lens_pocket_d);

        // Wider rear pocket accepts the removable retaining ring.
        translate([0, 0, condenser_cell_rear_z - epsilon])
            cylinder(h = condenser_retainer_front_z
                         - condenser_cell_rear_z
                         + 2 * epsilon,
                     d = retainer_pocket_d);

        condenser_retainer_screw_positions()
            translate([0, 0, condenser_cell_rear_z - epsilon])
                cylinder(h = condenser_lens_edge_front_z
                             - condenser_cell_rear_z,
                         r = condenser_fastener_radius_mm);

        // Three pod screws leave the +X/+Y corner free for the cable route.
        condenser_pod_corner_positions()
            translate([0, 0, condenser_cell_rear_z - epsilon])
                cylinder(h = 10,
                         r = condenser_fastener_radius_mm);
    }
}

// Rear ring lightly preloads an edge O-ring. It must not touch the optical
// clear aperture or the strongly curved surface.
module condenser_lens_retainer() {
    retainer_outer_d = condenser_pod_outer_mm - 4;
    retainer_inner_d = condenser_diameter_mm
        - 2 * condenser_retainer_overlap_mm;

    difference() {
        cylinder(h = condenser_retainer_thickness_mm,
                 d = retainer_outer_d);
        translate([0, 0, -epsilon])
            cylinder(h = condenser_retainer_thickness_mm + 2 * epsilon,
                     d = retainer_inner_d);
        condenser_retainer_screw_positions()
            translate([0, 0, -epsilon])
                cylinder(h = condenser_retainer_thickness_mm + 2 * epsilon,
                         r = condenser_fastener_radius_mm);
    }
}

module condenser_focus_slot_x(x_position) {
    slot_center_z = condenser_nominal_carriage_back_z
        + condenser_carriage_thickness_mm / 2;
    hull()
        for (z = [slot_center_z - condenser_focus_travel_mm / 2,
                  slot_center_z + condenser_focus_travel_mm / 2])
            translate([x_position, 0, z])
                rotate([0, 90, 0])
                    cylinder(h = 16,
                             r = condenser_fastener_radius_mm,
                             center = true);
}

module provisional_driver_mount_rails() {
    rail_length = provisional_driver_length_mm
        + 2 * provisional_driver_clearance_mm + 4;
    rail_depth = provisional_driver_height_mm
        + provisional_driver_clearance_mm + 2;
    rail_height = provisional_driver_width_mm
        + 2 * provisional_driver_clearance_mm;
    rail_z = condenser_spacer_rear_z + 2;

    // External side rails keep driver heat and wiring out of the optical path.
    translate([-rail_length / 2,
               condenser_pod_outer_mm / 2 - 0.5,
               rail_z])
        cube([rail_length, 2, rail_height]);

    for (x = [-rail_length / 2, rail_length / 2 - 2])
        translate([x,
                   condenser_pod_outer_mm / 2 - 0.5,
                   rail_z])
            cube([2, rail_depth, rail_height]);
}

module condenser_spacer_body() {
    body_height = condenser_cell_rear_z - condenser_spacer_rear_z;

    difference() {
        union() {
            translate([0, 0, condenser_spacer_rear_z])
                rounded_xy_prism(condenser_pod_outer_mm,
                                 condenser_pod_outer_mm,
                                 body_height,
                                 3);
            if (include_provisional_driver_rails)
                provisional_driver_mount_rails();
        }

        // Square cavity accepts the focus-adjustable LED carriage.
        translate([-condenser_carriage_outer_mm / 2,
                   -condenser_carriage_outer_mm / 2,
                   condenser_spacer_rear_z - epsilon])
            cube([condenser_carriage_outer_mm,
                  condenser_carriage_outer_mm,
                  body_height + 2 * epsilon]);

        // Two opposite M3 slots provide the provisional +/-3 mm focus range.
        condenser_focus_slot_x(-condenser_pod_outer_mm / 2);
        condenser_focus_slot_x(condenser_pod_outer_mm / 2);

        condenser_pod_corner_positions()
            translate([0, 0, condenser_spacer_rear_z - epsilon])
                cylinder(h = body_height + 2 * epsilon,
                         r = condenser_fastener_radius_mm);

        // Cable path toward the Raspberry Pi and external driver.
        translate([condenser_carriage_outer_mm / 2 - 0.5,
                   condenser_carriage_outer_mm / 2 - 0.5,
                   condenser_spacer_rear_z - epsilon])
            cube([condenser_pod_outer_mm / 2
                      - condenser_carriage_outer_mm / 2 + 1,
                  condenser_pod_outer_mm / 2
                      - condenser_carriage_outer_mm / 2
                      + provisional_driver_height_mm + 5,
                  body_height + 2 * epsilon]);
    }
}

// Sliding frame clamps a metal heat spreader around its edge. The LED MCPCB
// screws to that metal plate, never directly to the printed carriage.
module condenser_led_carriage() {
    heatsink_passage_mm = provisional_heatsink_width_mm + 0.5;
    spreader_screw_offset = (heatsink_passage_mm
                             + provisional_heat_spreader_width_mm) / 4;

    difference() {
        translate([0, 0, -condenser_carriage_thickness_mm])
            rounded_xy_prism(condenser_carriage_size_mm,
                             condenser_carriage_size_mm,
                             condenser_carriage_thickness_mm,
                             2);

        translate([-heatsink_passage_mm / 2,
                   -heatsink_passage_mm / 2,
                   -condenser_carriage_thickness_mm - epsilon])
            cube([heatsink_passage_mm,
                  heatsink_passage_mm,
                  condenser_carriage_thickness_mm + 2 * epsilon]);

        for (x = [-spreader_screw_offset, spreader_screw_offset])
            for (y = [-spreader_screw_offset, spreader_screw_offset])
                translate([x, y,
                           -condenser_carriage_thickness_mm - epsilon])
                    cylinder(h = condenser_carriage_thickness_mm
                                 + 2 * epsilon,
                             r = 1.1);

        for (x = [-condenser_carriage_size_mm / 2,
                  condenser_carriage_size_mm / 2])
            translate([x, 0, -condenser_carriage_thickness_mm / 2])
                rotate([0, 90, 0])
                    cylinder(h = 6,
                             r = condenser_fastener_radius_mm - 0.15,
                             center = true);
    }
}

// Approximate optical envelope only. The printed cell uses catalog diameter,
// center thickness, and edge thickness rather than this visual surface shape.
module condenser_lens_reference() {
    radius = condenser_diameter_mm / 2;
    sag = condenser_center_thickness_mm - condenser_edge_thickness_mm;
    profile = concat(
        [[0, 0]],
        [for (index = [1:12])
            let(r = radius * index / 12)
                [r, -sag * pow(r / radius, 2)]],
        [[radius, -condenser_center_thickness_mm],
         [0, -condenser_center_thickness_mm]]
    );

    color([0.52, 0.86, 1.0, 0.48])
        translate([0, 0, condenser_lens_vertex_z])
            rotate_extrude($fn = 120)
                polygon(points = profile);
}

module provisional_led_thermal_references() {
    // Metal-core LED board and emitter.
    color([0.95, 0.72, 0.12, 0.82])
        translate([-provisional_led_board_width_mm / 2,
                   -provisional_led_board_height_mm / 2,
                   condenser_led_board_back_z])
            cube([provisional_led_board_width_mm,
                  provisional_led_board_height_mm,
                  provisional_led_board_thickness_mm]);

    color([1.0, 0.96, 0.65, 0.95])
        translate([-1.75, -1.75, condenser_led_board_front_z])
            cube([3.5, 3.5, provisional_led_emitter_height_mm]);

    // Aluminum heat spreader is the required thermal bridge.
    color([0.65, 0.67, 0.70, 0.88])
        translate([-provisional_heat_spreader_width_mm / 2,
                   -provisional_heat_spreader_height_mm / 2,
                   condenser_heat_spreader_back_z])
            cube([provisional_heat_spreader_width_mm,
                  provisional_heat_spreader_height_mm,
                  provisional_heat_spreader_thickness_mm]);

    // Provisional finned sink, kept exposed to room air.
    color([0.32, 0.34, 0.37, 0.92]) {
        translate([-provisional_heatsink_width_mm / 2,
                   -provisional_heatsink_height_mm / 2,
                   condenser_heat_spreader_back_z - 2])
            cube([provisional_heatsink_width_mm,
                  provisional_heatsink_height_mm,
                  2]);
        for (x = [-provisional_heatsink_width_mm / 2:4.5:
                   provisional_heatsink_width_mm / 2 - 1.5])
            translate([x,
                       -provisional_heatsink_height_mm / 2,
                       condenser_heatsink_back_z])
                cube([1.5,
                      provisional_heatsink_height_mm,
                      provisional_heatsink_depth_mm - 2]);
    }

    // Compact LDD-style driver reference in the external side rails.
    color([0.18, 0.55, 0.28, 0.85])
        translate([-provisional_driver_length_mm / 2,
                   condenser_pod_outer_mm / 2 + 2.2,
                   condenser_spacer_rear_z
                       + 2 + provisional_driver_clearance_mm])
            cube([provisional_driver_length_mm,
                  provisional_driver_height_mm,
                  provisional_driver_width_mm]);

    if (show_provisional_fan)
        color([0.10, 0.10, 0.12, 0.76])
            translate([-provisional_fan_size_mm / 2,
                       -provisional_fan_size_mm / 2,
                       condenser_heatsink_back_z
                           - provisional_fan_thickness_mm])
                difference() {
                    cube([provisional_fan_size_mm,
                          provisional_fan_size_mm,
                          provisional_fan_thickness_mm]);
                    translate([provisional_fan_size_mm / 2,
                               provisional_fan_size_mm / 2,
                               -epsilon])
                        cylinder(h = provisional_fan_thickness_mm
                                     + 2 * epsilon,
                                 d = provisional_fan_size_mm - 5);
                }
}

module condenser_light_engine(include_references = true) {
    color([0.08, 0.35, 0.78])
        condenser_face_cell();
    color([0.05, 0.20, 0.52])
        condenser_spacer_body();
    color([0.10, 0.68, 0.62])
        translate([0, 0, condenser_retainer_back_z])
            condenser_lens_retainer();
    color([0.18, 0.24, 0.34])
        translate([0, 0, condenser_led_board_back_z])
            condenser_led_carriage();

    if (include_references) {
        condenser_lens_reference();
        provisional_led_thermal_references();
        light_beam_reference();
    }
}

// Visualization only. Separates the optical, printed, and thermal layers so
// the assembly order can be checked without hiding them inside the shell.
module condenser_light_engine_exploded() {
    gap = 8;
    lens_shift = condenser_cell_rear_z - gap - condenser_lens_vertex_z;
    exploded_lens_plano_z = condenser_lens_plano_z + lens_shift;
    retainer_shift = exploded_lens_plano_z - gap
        - condenser_retainer_front_z;
    exploded_retainer_back_z = condenser_retainer_back_z + retainer_shift;
    spacer_shift = exploded_retainer_back_z - gap - condenser_cell_rear_z;
    exploded_spacer_rear_z = condenser_spacer_rear_z + spacer_shift;
    carriage_shift = exploded_spacer_rear_z - gap
        - condenser_led_board_back_z;

    color([0.08, 0.35, 0.78])
        condenser_face_cell();

    translate([0, 0, lens_shift])
        condenser_lens_reference();

    color([0.10, 0.68, 0.62])
        translate([0, 0, condenser_retainer_back_z + retainer_shift])
            condenser_lens_retainer();

    color([0.05, 0.20, 0.52])
        translate([0, 0, spacer_shift])
            condenser_spacer_body();

    color([0.18, 0.24, 0.34])
        translate([0, 0, condenser_led_board_back_z + carriage_shift])
            condenser_led_carriage();

    translate([0, 0, carriage_shift])
        provisional_led_thermal_references();
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

    // Render the complete official shell in both F5 and F6. Low alpha keeps
    // the internal optics readable without making the frame disappear.
    if (show_cube)
        color([0.72, 0.72, 0.72, 0.24])
            uCube(cubeSize = cube_spec);

    // Orange bottom mounting plate and its recessed beamsplitter rails.
    color([0.95, 0.40, 0.06])
        translate([0, 0, -inside_half_mm])
            beamsplitter_mounting_face();

    // Blue -X light face. The new 50 mm condenser engine is the default;
    // the compact legacy chamber remains available in render modes 2-4.
    if (use_condenser_light_engine)
        light_face_transform()
            condenser_light_engine(include_references = show_references);
    else {
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
    }

    // Purple camera uFace on +Y for the demo. This is the reflected-beam side
    // for the shown 45-degree plate orientation.
    color([0.38, 0.20, 0.62])
        camera_face_transform()
            threaded_camera_mounting_face(
                detailed_thread = camera_preview_detailed_thread);

    if (show_references) {
        translate([0, 0, -inside_half_mm])
            beamsplitter_reference();

        if (!use_condenser_light_engine)
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

    if (use_condenser_light_engine)
        translate([-48, 0, 0])
            rotate([0, 90, 0])
                condenser_light_engine(include_references = true);
    else {
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
    }

    color([0.38, 0.20, 0.62])
        translate([0, 48, 0])
            rotate([-90, 0, 0])
                threaded_camera_mounting_face(
                    detailed_thread = camera_preview_detailed_thread);

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
else if (render_mode == 9)
    condenser_face_cell();
else if (render_mode == 10)
    condenser_spacer_body();
else if (render_mode == 11)
    condenser_lens_retainer();
else if (render_mode == 12)
    condenser_led_carriage();
else if (render_mode == 13)
    condenser_light_engine(include_references = true);
else if (render_mode == 14)
    condenser_light_engine_exploded();
