// Official uCube beamsplitter and compact illumination module.
// render_mode = 0 is the complete live assembly. Press F5 to preview.

include <vendor/BOSL2/std.scad>
include <vendor/BOSL2/threading.scad>
include <vendor/uCube/uCube.scad>

$fn = 64;
epsilon = 0.02;

/* [Preview] */
render_mode = 7; // [0:complete_assembly, 1:beamsplitter_face, 2:legacy_light_face, 3:legacy_back_cover, 4:legacy_optic_cartridge, 5:camera_face, 6:camera_thread_test, 7:exploded_assembly, 8:inspection_assembly, 9:official_ucube_shell, 10:cell_bottom_u, 11:cell_top_u, 12:lens_sleeve_slider, 13:led_post_slider, 14:cell_assembly, 15:cell_assembly_open]
show_optical_references = true;
camera_preview_detailed_thread = true;
show_auxiliary_illumination_cube = true;
show_legacy_light_chamber = true;

/* [Official uCube] */
// MEASURED on the physical scaled cube: the square through-hole is 45 mm and
// the wider inside-face inset is 59 mm (= size + 2d), which measures ~60 mm by
// hand. Both of those numbers describe the same cube at size=45, d=7.
internal_clearance_mm = 45; // [40:5:45]
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

// Selected LED: Amazon ASIN B0CL726PBP, 3 W 3535 emitter on 20 mm star MCPCB.
selected_led_power_w = 3;
selected_led_forward_voltage_min_v = 3.0;
selected_led_forward_voltage_max_v = 3.4;
selected_led_drive_current_ma = 700;
selected_led_beam_angle_degrees = 120;
selected_led_cct_min_k = 8000;
selected_led_cct_max_k = 10000;
selected_led_package_mm = 3.5;
provisional_led_board_width_mm = 20; // Selected circular/star board envelope
provisional_led_board_height_mm = 20; // Selected circular/star board envelope
provisional_led_board_thickness_mm = 1.6;
provisional_led_emitter_height_mm = 1.4;


/* [Illumination cell]
   Path B: the illumination optics live in their own light-tight box that bolts
   to one uFace pocket of the optical cube, instead of inside a second official
   cube. An official 73 mm cube has 14 mm end walls, leaving only 45 mm of
   interior along the light axis, which cannot hold the 25 mm sleeve plus focus
   travel plus the LED post. Bolting through a uFace keeps official mounting
   compatibility while letting the box be as long as the optics need.

   The box prints as two U shells: a bottom U (mating plate, floor, far wall,
   integral rail) and a top U (both side walls plus the roof) that drops on as
   a lid. Lifting the lid is how the optics are installed and focused, so no
   access slot or cover strip is needed. */
cell_body_length_mm = 80; // [60:1:120] Outward from the cube face
cell_outer_span_mm = 60; // [56:1:73] Square cross-section, matches the 59 mm plate
cell_wall_mm = 4; // [3:0.5:6]
cell_end_wall_mm = 6; // [4:0.5:10]
cell_aperture_mm = 40; // [30:1:44] Light port through the mating plate
cell_seam_clearance_mm = 0.25; // [0.1:0.05:0.5] Lid slip fit
cell_tongue_mm = 2; // [1.5:0.5:3] Light-baffle tongue width
cell_tongue_height_mm = 2; // [1.5:0.5:4]

/* [Lens sleeve, rail, and sliders]
   The two lenses are held on spring clips inside a purchased 40.0 mm lens tube.
   Our sleeve holds that tube: a 1 mm internal lip at the far end stops it, and
   a spring clip retains it. No groove is cut in the sleeve. */
tube_outer_mm = 40; // [40] MEASURED purchased lens tube OD
sleeve_clearance_mm = 1.0; // [0.4:0.1:1.6] Total diametral slip fit
sleeve_wall_mm = 2; // [1.5:0.5:3]
sleeve_depth_mm = 25; // [20:1:32] PROVISIONAL, confirm on the bench
sleeve_lip_mm = 1; // [0.8:0.1:2] Internal tube stop
rail_width_mm = 10.5; // [10.5] MEASURED cube screw-pad width
rail_height_mm = 9; // [7:0.5:12]
harness_slot_clearance_mm = 0.6; // [0.4:0.1:1.0] Total width clearance on the rail
harness_seat_clearance_mm = 1.5; // Rail top to sleeve underside, keeps the bore centered
// The side walls host M3 heat-set inserts end-on, so they must be deeper than
// the insert plus a backing wall. This is why they are not simply 3 mm.
harness_wall_mm = 6; // [6:0.5:9]
harness_length_mm = 16; // [12:1:24] Along the rail
m3_insert_diameter_mm = 4.6; // PROVISIONAL heat-set insert
m3_insert_depth_mm = 5; // PROVISIONAL heat-set insert
m3_clamp_clearance_mm = 3.2; // Set-screw tip path from insert to rail flank
sleeve_setback_mm = 0; // [0:1:30] Preview only, sleeve front from the port
led_gap_mm = 20; // [4:1:34] Preview only, sleeve rear to LED pad
led_star_diameter_mm = 20; // MEASURED star MCPCB envelope
led_post_thickness_mm = 3; // [2.5:0.5:5]
led_cable_notch_mm = 5; // [3:1:8]

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

// Illumination-cell coordinates. X is the light axis and matches the uFace
// local Z convention: X=0 is the visible inner edge of the cube opening, +X
// runs into the cube, and -X runs outward into the cell. Z=0 is the beam axis
// and +Z is up, so the rail sits at negative Z beneath the sleeve.
sleeve_bore_mm = tube_outer_mm + sleeve_clearance_mm;
sleeve_outer_mm = sleeve_bore_mm + 2 * sleeve_wall_mm;

// The rail top sits a fixed clearance below the sleeve underside. This keeps
// the bore exactly on the beam axis, which matters more than rail height.
rail_top_z = -(sleeve_outer_mm / 2) - harness_seat_clearance_mm;
rail_bottom_z = rail_top_z - rail_height_mm;
cell_seam_z = rail_top_z;

cell_floor_top_z = rail_bottom_z;
cell_outer_bottom_z = cell_floor_top_z - cell_wall_mm;
cell_outer_top_z = cell_outer_span_mm / 2;
cell_interior_top_z = cell_outer_top_z - cell_wall_mm;
cell_interior_half_y = cell_outer_span_mm / 2 - cell_wall_mm;

cell_mate_x = -face_outer_depth_mm;
cell_far_outer_x = cell_mate_x - cell_body_length_mm;
cell_interior_far_x = cell_far_outer_x + cell_end_wall_mm;

// The interior stops short of the mating face and gets its own end wall. The
// 59 mm uFace plate only spans Z = +/-29.5, so it cannot close an interior that
// reaches down to the rail floor at Z=-33; relying on it left an open slot.
cell_interior_near_x = cell_mate_x - cell_wall_mm;
cell_interior_length_mm = cell_interior_near_x - cell_interior_far_x;

// The harness foot straddles the rail. Its slot roof sits at the sleeve
// underside, so the rail top clearance above is harness_seat_clearance_mm.
harness_slot_width_mm = rail_width_mm + harness_slot_clearance_mm;
harness_slot_top_z = -(sleeve_outer_mm / 2);
harness_foot_bottom_z = rail_bottom_z + 2;
harness_outer_width_mm = harness_slot_width_mm + 2 * harness_wall_mm;

// The foot must rise just far enough to fuse into the sleeve across its whole
// width. The sleeve is round, so at the foot's outer edge the sleeve underside
// sits higher than at the centerline; solve for that height instead of guessing,
// otherwise the foot floats free at its corners or becomes a tall solid slab.
harness_foot_top_z = -sqrt(pow(sleeve_outer_mm / 2, 2)
                           - pow(harness_outer_width_mm / 2, 2)) + 0.5;
rail_insert_center_z = (rail_top_z + rail_bottom_z) / 2;

// Slider placement. Both sliders clamp anywhere along the rail; these are the
// preview positions only. The LED gap is the adjustable quantity the bench test
// has to settle, so nothing downstream depends on its exact value.
sleeve_front_x = cell_interior_near_x - sleeve_setback_mm;
sleeve_rear_x = sleeve_front_x - sleeve_depth_mm;
led_pad_x = sleeve_rear_x - led_gap_mm;
led_plate_rear_x = led_pad_x - led_post_thickness_mm;

assert(sleeve_outer_mm <= 2 * cell_interior_half_y,
       "The lens sleeve is wider than the illumination cell interior.");
assert(sleeve_outer_mm / 2 <= cell_interior_top_z,
       "The lens sleeve hits the illumination cell roof.");
assert(rail_bottom_z > cell_outer_bottom_z,
       "The rail extends below the illumination cell floor.");
assert(harness_slot_top_z > rail_top_z,
       "The harness slot roof must clear the rail top.");
assert(cell_interior_length_mm
           >= sleeve_depth_mm + harness_wall_mm + led_post_thickness_mm + 10,
       "The illumination cell is too short for the sleeve, post, and travel.");
assert(cell_aperture_mm <= sleeve_bore_mm,
       "The mating-plate light port is wider than the sleeve bore.");
assert(harness_wall_mm >= m3_insert_depth_mm + 1,
       "The harness side walls are too thin to host the M3 heat-set inserts.");

assert(sleeve_front_x <= cell_interior_near_x,
       "The lens sleeve passes through the illumination cell end wall.");
assert(led_plate_rear_x - harness_length_mm / 2 >= cell_interior_far_x,
       "The LED post overruns the far end of the illumination cell.");
assert((sleeve_rear_x + sleeve_depth_mm / 2)
           - (led_plate_rear_x + led_post_thickness_mm / 2)
           >= harness_length_mm,
       "The sleeve and LED post feet collide on the rail at this LED gap.");
assert(sleeve_bore_mm - 2 * sleeve_lip_mm < tube_outer_mm,
       "The retaining lip does not overlap the tube it is meant to stop.");
assert(harness_outer_width_mm <= 2 * cell_interior_half_y,
       "The harness foot is wider than the illumination cell interior.");

echo(str("Cell interior: ", cell_interior_length_mm, " long, ",
         2 * cell_interior_half_y, " wide, ",
         cell_interior_top_z - cell_floor_top_z, " tall"));
echo(str("Sleeve bore/OD: ", sleeve_bore_mm, "/", sleeve_outer_mm,
         " mm; rail ", rail_width_mm, " x ", rail_height_mm,
         " with top at Z=", rail_top_z));
echo(str("Sleeve focus travel: ",
         cell_interior_length_mm - sleeve_depth_mm
             - led_post_thickness_mm - harness_wall_mm, " mm maximum"));

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

// Local Z=0 is the visible inner edge of the official 45 mm cube opening.
// The uFace itself is flush with the outer cube surface at Z=-14 mm.
// The vendor uFace puts its screw-head counterbores on the plate's local +Z.
// Every custom face here builds features toward the cube interior on +Z, so an
// unmirrored uFace opens the counterbores inward and the cap screws cannot
// seat. The Z mirror flips them to the outer cube surface. The plate is
// symmetric in XY, so this changes nothing but the counterbore direction.
// vendor/uCube/Parts/uHolder.scad does the same flip via rotate([180, 0, 0]).
module official_face_at_inside_plane() {
    translate([0, 0,
               -face_outer_depth_mm + face_plate_thickness_mm / 2])
        mirror([0, 0, 1])
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

// ---------------------------------------------------------------------------
// Illumination cell. All modules below use the cell frame described with the
// derived coordinates above: X is the light axis, Z=0 is the beam axis.
// ---------------------------------------------------------------------------

// Outer envelope of the complete box, before the interior is hollowed out.
module cell_outer_box() {
    translate([cell_far_outer_x, -cell_outer_span_mm / 2, cell_outer_bottom_z])
        cube([cell_body_length_mm,
              cell_outer_span_mm,
              cell_outer_top_z - cell_outer_bottom_z]);
}

// Clear interior. Open toward the cube on +X, where the mating plate closes it.
module cell_interior_void() {
    translate([cell_interior_far_x,
               -cell_interior_half_y,
               cell_floor_top_z])
        cube([cell_interior_length_mm,
              2 * cell_interior_half_y,
              cell_interior_top_z - cell_floor_top_z]);
}

// One centered ridge running the full interior length along the light axis.
// Both sliders straddle it and clamp to its flanks with M3 set screws.
module cell_rail() {
    translate([cell_interior_far_x,
               -rail_width_mm / 2,
               rail_bottom_z])
        cube([cell_interior_length_mm,
              rail_width_mm,
              rail_height_mm]);
}

// The official uFace, rotated so its plate normal lies along the light axis.
// This is what bolts the cell into one pocket of the optical cube.
module cell_mating_plate() {
    rotate([0, 90, 0])
        official_face_at_inside_plane();
}

// Complete box as a single solid, before the lid split.
module illumination_cell_solid() {
    difference() {
        union() {
            difference() {
                cell_outer_box();
                cell_interior_void();
            }
            cell_rail();
            cell_mating_plate();
        }

        // Light port through the near end wall and the mating plate.
        translate([cell_interior_near_x - epsilon, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = cell_wall_mm + face_plate_thickness_mm
                             + 2 * epsilon,
                         d = cell_aperture_mm);
    }
}

// Region occupied by the lid: above the seam and between the two end features.
module cell_lid_region(inset = 0) {
    translate([cell_interior_far_x + inset,
               -cell_outer_span_mm,
               cell_seam_z + inset])
        cube([cell_interior_length_mm - 2 * inset,
              2 * cell_outer_span_mm,
              cell_outer_span_mm]);
}

// Tongue centered in each side wall. It rises across the seam so light cannot
// travel straight through the joint. The lid carries the matching groove.
module cell_seam_tongue(clearance = 0) {
    for (side = [-1, 1])
        translate([cell_interior_far_x - clearance,
                   side * (cell_interior_half_y
                           + cell_wall_mm / 2
                           - cell_tongue_mm / 2)
                       - cell_tongue_mm / 2 - clearance,
                   cell_seam_z - epsilon])
            cube([cell_interior_length_mm + 2 * clearance,
                  cell_tongue_mm + 2 * clearance,
                  cell_tongue_height_mm + clearance + epsilon]);
}

// Bottom U: mating plate, floor, far end wall, integral rail, and the lower
// part of both side walls. This is the piece the optics sit in.
module illumination_cell_bottom_u() {
    union() {
        difference() {
            illumination_cell_solid();
            cell_lid_region(inset = 0);
        }
        intersection() {
            cell_seam_tongue();
            illumination_cell_solid();
        }
    }
}

// Top U: both upper side walls plus the roof, dropping on between the mating
// plate and the far wall. The groove receives the bottom U's tongue.
module illumination_cell_top_u() {
    difference() {
        intersection() {
            illumination_cell_solid();
            cell_lid_region(inset = cell_seam_clearance_mm);
        }
        cell_seam_tongue(clearance = cell_seam_clearance_mm);
    }
}

// Shared U-foot. Both sliders use it, so they grip the rail identically. It
// straddles the rail with a slip fit and clamps to the rail flanks with two
// opposing M3 set screws in heat-set inserts.
module harness_foot(length, center_x) {
    difference() {
        translate([center_x - length / 2,
                   -harness_outer_width_mm / 2,
                   harness_foot_bottom_z])
            cube([length,
                  harness_outer_width_mm,
                  harness_foot_top_z - harness_foot_bottom_z]);

        // Rail slot. Its roof sits at the sleeve underside, leaving
        // harness_seat_clearance_mm above the rail so the bore stays centered.
        translate([center_x - length / 2 - epsilon,
                   -harness_slot_width_mm / 2,
                   harness_foot_bottom_z - epsilon])
            cube([length + 2 * epsilon,
                  harness_slot_width_mm,
                  harness_slot_top_z - harness_foot_bottom_z + epsilon]);

        for (side = [-1, 1]) {
            // Heat-set insert pocket, entered from the outside. It starts
            // slightly proud of the face so the opening renders cleanly.
            translate([center_x,
                       side * (harness_outer_width_mm / 2 + epsilon),
                       rail_insert_center_z])
                rotate([side * 90, 0, 0])
                    cylinder(h = m3_insert_depth_mm + epsilon,
                             d = m3_insert_diameter_mm);

            // The screw tip must reach past the insert to press the rail.
            translate([center_x, side * harness_slot_width_mm / 2,
                       rail_insert_center_z])
                rotate([side * 90, 0, 0])
                    cylinder(h = harness_wall_mm + 2 * epsilon,
                             d = m3_clamp_clearance_mm);
        }
    }
}

// Slider 1, one printed part: the sleeve that holds the purchased 40.0 mm lens
// tube, plus its rail foot. The tube seats against a 1 mm internal lip at the
// cube-facing end and is retained by a spring clip loaded from the open rear.
// No groove is cut in the sleeve.
module lens_sleeve_slider() {
    difference() {
        union() {
            translate([sleeve_rear_x, 0, 0])
                rotate([0, 90, 0])
                    cylinder(h = sleeve_depth_mm, d = sleeve_outer_mm);

            harness_foot(length = harness_length_mm,
                         center_x = sleeve_rear_x + sleeve_depth_mm / 2);
        }

        // Tube bore, open at the rear, stopping at the lip.
        translate([sleeve_rear_x - epsilon, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = sleeve_depth_mm - sleeve_lip_mm + epsilon,
                         d = sleeve_bore_mm);

        // Clear aperture through the lip itself.
        translate([sleeve_rear_x - epsilon, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = sleeve_depth_mm + 2 * epsilon,
                         d = sleeve_bore_mm - 2 * sleeve_lip_mm);
    }
}

// Slider 2: a flat post carrying the 20 mm star LED on the beam axis. For the
// first prototype the star is taped or glued to the pad. Capturing the star's
// edges and adding a glued-on heatsink are deliberate v2 changes to this one
// small part, since v1 strobes the LED and needs no secondary heatsink.
module led_post_slider() {
    plate_half = led_star_diameter_mm / 2 + 3;

    difference() {
        union() {
            translate([led_plate_rear_x, -plate_half, harness_foot_bottom_z])
                cube([led_post_thickness_mm,
                      2 * plate_half,
                      plate_half - harness_foot_bottom_z]);

            harness_foot(length = harness_length_mm,
                         center_x = led_plate_rear_x
                                    + led_post_thickness_mm / 2);
        }

        // Cable pass-through, clear of the star footprint above it.
        translate([led_plate_rear_x - epsilon,
                   -led_cable_notch_mm / 2,
                   -led_star_diameter_mm / 2 - 5])
            cube([led_post_thickness_mm + 2 * epsilon,
                  led_cable_notch_mm,
                  4]);
    }
}

// The purchased 40.0 mm lens tube, shown for reference only. The two lenses
// ride inside it on spring clips; we do not model or machine that tube.
module lens_tube_reference() {
    color([0.55, 0.60, 0.65, 0.45])
        translate([sleeve_rear_x + 0.5, 0, 0])
            rotate([0, 90, 0])
                difference() {
                    cylinder(h = sleeve_depth_mm + 6, d = tube_outer_mm);
                    translate([0, 0, -epsilon])
                        cylinder(h = sleeve_depth_mm + 6 + 2 * epsilon,
                                 d = tube_outer_mm - 4);
                }
}

// The cell frame shares global X, so it drops into place with a translation
// only. Cell X=0 is the visible inner edge of the cube opening.
module illumination_cell_transform() {
    translate([-inside_half_mm, 0, 0])
        children();
}

module illumination_cell_assembly(include_lid = true,
                                  include_references = true) {
    color([0.08, 0.35, 0.78])
        illumination_cell_bottom_u();

    if (include_lid)
        color([0.10, 0.50, 0.82, 0.35])
            illumination_cell_top_u();

    color([0.10, 0.68, 0.62])
        lens_sleeve_slider();

    color([0.18, 0.24, 0.34])
        led_post_slider();

    if (include_references)
        lens_tube_reference();
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

    // The Path B illumination cell bolts to the -X uFace pocket and carries
    // both sliders on its integral rail.
    if (show_auxiliary_illumination_cube)
        illumination_cell_transform()
            illumination_cell_assembly(
                include_lid = show_cube,
                include_references = show_references);

    // Orange bottom mounting plate and its recessed beamsplitter rails.
    color([0.95, 0.40, 0.06])
        translate([0, 0, -inside_half_mm])
            beamsplitter_mounting_face();

    // Blue -X light face. The compact legacy chamber is the only illumination
    // geometry currently modeled; render modes 2-4 print its parts.
    if (show_legacy_light_chamber) {
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

        if (show_legacy_light_chamber)
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

    if (show_legacy_light_chamber) {
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

module render_selected_part() {
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
        uCube(cubeSize = cube_spec);
    else if (render_mode == 10)
        illumination_cell_bottom_u();
    else if (render_mode == 11)
        illumination_cell_top_u();
    else if (render_mode == 12)
        lens_sleeve_slider();
    else if (render_mode == 13)
        led_post_slider();
    else if (render_mode == 14)
        illumination_cell_assembly(include_lid = true,
                                   include_references = true);
    else if (render_mode == 15)
        illumination_cell_assembly(include_lid = false,
                                   include_references = true);
}

// Part-specific SCAD entry files set this before including the shared source.
if (is_undef(skip_main_render))
    render_selected_part();
else if (!skip_main_render)
    render_selected_part();
