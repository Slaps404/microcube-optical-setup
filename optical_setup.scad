// Official uCube beamsplitter and compact illumination module.
// render_mode = 0 is the complete live assembly. Press F5 to preview.

include <vendor/BOSL2/std.scad>
include <vendor/BOSL2/threading.scad>
include <vendor/uCube/uCube.scad>

$fn = 64;
epsilon = 0.02;

/* [Preview] */
render_mode = 16; // [0:complete_assembly, 1:beamsplitter_face, 2:legacy_light_face, 3:legacy_back_cover, 4:legacy_optic_cartridge, 5:camera_face, 6:camera_thread_test, 7:exploded_assembly, 8:inspection_assembly, 9:official_ucube_shell, 10:cell_bottom_u, 11:cell_top_u, 12:lens_sleeve_slider, 13:led_post_slider, 14:cell_assembly, 15:cell_assembly_open, 16:post_mount, 17:post_mount_socket_coupon, 18:condenser_carrier, 19:collector_carrier, 20:led_carrier, 21:carrier_foot_coupon]
show_optical_references = true;
camera_preview_detailed_thread = true;
show_auxiliary_illumination_cube = true;
show_legacy_light_chamber = true;
show_post_mount = true;
show_post_stub = true;
post_stub_length_mm = 260; // [80:10:400] Preview only, length of the T-slot post

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
plate_thickness_mm = 2.5; // [2.5] MEASURED beamsplitter thickness
plate_slot_mm = 2.4; // [2.4] Intentionally undersized for filing to final fit
plate_slot_filing_allowance_mm = 0.1;
plate_slot_interference_mm = plate_thickness_mm - plate_slot_mm;
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
// The enclosure is wider than its standard 59 mm uFace mounting plate. This
// creates clearance around both slider harnesses without moving cube screws.
cell_outer_span_mm = 73; // [60:1:90] Outside width across the cell
cell_wall_mm = 4; // [3:0.5:6]
cell_end_wall_mm = 6; // [4:0.5:10]
cell_aperture_mm = 40; // [30:1:44] Light port through the mating plate
cell_seam_clearance_mm = 0.25; // [0.1:0.05:0.5] Lid slip fit
cell_mount_bridge_depth_mm = 1; // Overlaps the cell wall and uFace by 0.5 mm each

/* [Passive ventilation]
   Short-duration LED use still benefits from passive airflow. Warm air exits
   through roof slots above the LED end while replacement air enters through
   lower slots in one side wall. Internal offset baffles remove the straight
   light path through both slot groups. */
roof_vent_slot_count = 5; // [3:1:7]
roof_vent_slot_length_mm = 20; // [12:1:28] Parallel to the light axis
roof_vent_slot_width_mm = 3; // [2:0.5:5]
roof_vent_slot_pitch_mm = 6; // [5:0.5:9]
side_vent_slot_count = 4; // [2:1:6]
side_vent_slot_width_mm = 3; // [2:0.5:5] Along the light axis
side_vent_slot_height_mm = 12; // [8:1:20] Vertical for support-free wall printing
side_vent_slot_pitch_mm = 6; // [5:0.5:9]
vent_region_from_far_mm = 24; // [18:1:32] Slot-group center from far interior wall
vent_baffle_thickness_mm = 1.2; // [1:0.2:2]
vent_baffle_gap_mm = 5.5; // [2:0.5:6] Balances side-shroud plenum area with intake-slot area
vent_baffle_overlap_mm = 4; // [3:0.5:7] Light-blocking overlap past slot edges
side_intake_positive_y = true;

/* [Lens sleeve, rail, and sliders]
   The two lenses are held on spring clips inside a purchased 40.0 mm lens tube.
   Our sleeve holds that tube: a 1 mm internal lip at the far end stops it, and
   a spring clip in an internal groove retains it. The groove setback is measured
   from the open rear end, opposite the lip. */
tube_outer_mm = 40; // [40] MEASURED purchased lens tube OD
sleeve_clearance_mm = 1.0; // [0.4:0.1:1.6] Total diametral slip fit
sleeve_wall_mm = 2; // [1.5:0.5:3]
sleeve_depth_mm = 25; // [20:1:32] Confirmed against the purchased tube
sleeve_lip_mm = 1; // [0.8:0.1:2] Internal tube stop
sleeve_clip_groove_setback_mm = 5.25; // [5:0.25:5.5] From open rear edge
sleeve_clip_groove_width_mm = 1.25; // [1:0.05:1.5] Axial groove width for the spring
sleeve_clip_groove_radial_depth_mm = 0.5; // [0.25:0.25:1] Recess into sleeve wall
rail_width_mm = 10.5; // [10.5] MEASURED cube screw-pad width
rail_height_mm = 9; // [7:0.5:12]
rail_floor_weld_mm = 0.5; // Rail overlap into the floor for one printable solid
harness_slot_clearance_mm = 0; // [0:0.1:1.4] Nominal zero total width clearance; file as needed
harness_roof_thickness_mm = 1.5; // [1:0.25:3] Solid material above the seated rail
// The harness side runners intentionally rest on the bottom-U floor. The slot
// roof simultaneously rests on the rail top, giving the slider two seating
// datums instead of a floating lower edge.
harness_floor_clearance_mm = 0; // [0:0.05:0.5] Clearance above the bottom-U floor
// The side walls host M3 heat-set inserts end-on. Reuse the official uCube
// screw specification so the cell takes the same inserts as the main cube.
harness_wall_mm = 6; // [6:0.5:9]
lens_harness_length_mm = sleeve_depth_mm; // Full sleeve depth centers its mass over the rail contact
led_harness_length_mm = 16; // [12:1:24] Along the rail
// Shared by both opposing pockets on both the lens and LED slider harnesses.
m3_insert_diameter_mm = 4; // [3.5:0.1:5] Default matches official uCube insert diameter
m3_insert_length_mm = 5; // [3:0.5:8] Default matches official uCube insertH
m3_clamp_clearance_mm = 3.2; // Close M3 clearance leaves a 0.4 mm radial shoulder
m3_clamp_top_margin_mm = 2.0; // Material above clamp passage at rail top
face_mount_clearance_mm = 3.6; // Through-clearance behind each uFace screw
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

/* [Post mount] */
// A blank side uFace that grows into a bracket for a 20 x 20 mm T-slot post.
// It replaces the lab arrangement where the camera lens barrel carries the
// whole optical head. Mounts on the cube face OPPOSITE the illumination cell,
// so the cell's cantilever weight becomes a pitch moment in the plane of the
// gusset rather than roll about the post.
post_mount_standoff_mm = 72; // [50:1:110] Post mating face to cube center
post_section_mm = 20; // [20] 2020 T-slot outside section
post_socket_clearance_mm = 0.2; // [0:0.05:0.8] Total width clearance on the post
post_socket_wall_mm = 4; // [3:0.5:6]
post_socket_depth_mm = 18; // [8:1:20] How far the socket walls wrap the post
post_socket_relief_mm = 1.6; // [1:0.2:2.5] Inside corner relief for post radii
post_backplate_thickness_mm = 6; // [4:0.5:10]
post_backplate_edge_margin_mm = 4; // [3:0.5:8] Material past each head channel
post_mount_weld_mm = 0.5; // Gusset overlap into the uFace for one printable solid
// Holds the weld band inside the plate outline instead of flush with it. Flush
// would sit exactly on the vendor plate's side faces, which is both a
// coincident-face pair and zero clearance to the cube's 0.4 mm face gap.
post_mount_weld_inset_mm = 0.1; // [0:0.05:0.4]
// vendor/uCube/uCube.scad sets capR = 3, so the vendor counterbore opens to
// 6.0 at the outer face and leaves 0.1 mm of plate rim at the corner. Matching
// that diameter exactly is the widest relief that does not breach the rim.
post_mount_screw_relief_mm = 6.0; // Keeps the vendor cap counterbores fully open
post_mount_head_pocket_mm = 3; // [2:0.5:6] Straight head pocket above the seat
post_mount_funnel_mouth_mm = 24; // [14:1:32] Funnel mouth diameter
// A driver on the bolt axis has to clear the gusset before it sees daylight.
// The flare only recedes inboard of the bolt some way up, so the funnel rise is
// DERIVED from where that happens rather than typed in. Typing it in is what
// left a 2.7 mm shelf capping the funnel in the first version of this part, and
// a 4 mm key could not reach the head at all.
m5_driver_clearance_mm = 9; // [6:0.5:13] Straight run a hex key needs on the bolt axis
post_mount_driver_margin_mm = 1.5; // [0:0.5:5] Extra breakout past that run
post_mount_window_radius_mm = 7; // [0:0.5:14] Coved gusset window, 0 disables
post_mount_window_pitch_mm = 17; // [10:0.5:30] Window spacing along Y
post_mount_window_count = 3; // [1:1:5] Windows across the gusset
post_mount_bed_limit_mm = 220; // [150:10:350] Shortest printable bed axis
post_coupon_length_mm = 20; // [12:1:30] Socket fit-coupon length
// Round holes, not slots. The T-nut already slides freely in the post slot, so
// the bracket sets its own height with plain holes and spends no plate material
// or stress-riser risk on travel it does not need.
m5_hole_diameter_mm = 5.5; // [5:0.1:6.5] M5 through-clearance
// Sized for a DIN 125 M5 washer (10.0 mm OD), not just the cap head (8.5 mm).
// The washer takes bolt bearing from 33 mm^2 to 55 mm^2, which is 30 MPa down to
// 18 MPa at 1 kN preload. PLA creeps well below yield under permanent load, so
// that margin is the difference between a joint that holds and one that needs
// re-torquing. Note the throat is a 72-gon: 11 measures 10.99 across the flats,
// so a nominal 10 would NOT pass a 10 mm washer.
m5_head_clearance_mm = 11; // [9:0.5:14] M5 washer + socket cap head clearance
m5_head_cube_margin_mm = 1; // [0:0.5:4] Head clearance past the cube envelope

/* [Extrusion and rail carriers]
   The Koehler retrofit puts the collector and the condenser f1 + f2 = 56 mm
   apart at their principal planes. That does not fit one 25 mm sleeve or one
   40 mm tube, so each optic moves onto its own carrier and the carriers slide
   to set focus.

   Both supplied lenses are 40.0 mm diameter, so ONE cell geometry serves both
   and only the stack length differs. The cell reuses the legacy sleeve
   envelope verbatim (41 mm bore, 45 mm OD, same spring-clip groove). That is
   deliberate: a printed threaded retainer needs a thread major larger than the
   41 mm bore, which forces the OD past 50 mm and out of the printed cell. The
   supplied set already solves retention without that: the lens seats on the
   front lip, the supplied 40/38 divider ring sits behind it as a flat pressure
   washer, and the spring clip loads the divider, never the glass.

   Two feet are provided for the same carriers. carrier_rail_kind picks one:
     0 = straddles a 2020 T-slot extrusion, M5 into T-nuts in the SIDE slots;
     1 = the legacy printed-rail U-foot with two M3 clamp screws, unchanged
         except that it is shorter along X so more of the rail is travel.
   Holes for the extrusion foot sit on the extrusion's vertical centerline,
   which is the height of the side T-slot. */
carrier_rail_kind = 0; // [0:extrusion_2020, 1:printed_rail]
// PROVISIONAL until the two elements are measured out of the supplied set.
collector_lens_thickness_mm = 14; // [4:0.5:30] PROVISIONAL center thickness
condenser_lens_thickness_mm = 18; // [4:0.5:30] PROVISIONAL center thickness
// Supplied divider ring, usable as the pressure washer behind either lens.
carrier_spacer_thickness_mm = 13; // [6:0.5:20] MEASURED, approximate
carrier_spacer_outer_mm = 40; // [40] MEASURED divider OD
carrier_spacer_inner_mm = 38; // [38] MEASURED divider ID
collector_uses_spacer = true;
condenser_uses_spacer = false;
// Front seat. The aperture matches the divider ID so the glass is clamped
// between two identical annular lands instead of being pinched off-center.
carrier_aperture_mm = 38; // [30:0.5:39] Clear aperture through the front lip
carrier_lip_axial_mm = 2; // [1:0.5:4] Axial thickness of that seat
carrier_foot_length_mm = 16; // [10:1:28] Along the light axis, both foot kinds
carrier_coupon_length_mm = 20; // [12:1:30] Foot fit-coupon length
// Extrusion foot only.
carrier_socket_wall_mm = 5; // [4:0.5:8] Straddling side wall
carrier_web_mm = 4; // [3:0.5:8] Solid material between extrusion top and cell
carrier_m5_bearing_wall_mm = 2.5; // [2:0.5:5] Wall left under the washer seat

cube_spec = CubeSize(
    size = internal_clearance_mm,
    d = frame_feature_mm,
    faceGap = face_gap_mm,
    screw = defaultScrew
);

face_plate_thickness_mm = frame_feature_mm / 2;
face_outline_mm = internal_clearance_mm + 2 * frame_feature_mm - 2 * face_gap_mm;
// vendor/uCube/Parts/uCubeCore.scad cuts the four face screws at
// 0.5*(faceSize - d), where faceSize is the full 59 mm face. face_outline_mm is
// the PLATE outline, which is 2*face_gap_mm smaller. Deriving the screw pitch
// from the plate outline instead put every screw passage 0.4 mm per axis off
// the real hole, which is 0.57 mm radially.
face_screw_offset_mm =
    (internal_clearance_mm + 2 * frame_feature_mm - frame_feature_mm) / 2;
locator_size_mm = internal_clearance_mm - locator_clearance_mm;
inside_half_mm = internal_clearance_mm / 2;
official_holder_span_mm = internal_clearance_mm + 1.5 * frame_feature_mm;
face_outer_depth_mm = 2 * frame_feature_mm;
face_inner_depth_mm = 1.5 * frame_feature_mm;
face_center_from_origin_mm =
    (internal_clearance_mm + 4 * frame_feature_mm) / 2
        - face_plate_thickness_mm / 2;

// Post-mount coordinates. Same uFace local frame as every other custom face:
// Z=0 is the visible inner edge of the cube opening and +Z runs into the cube.
// The bracket is the only face that builds toward -Z, away from the cube.
cube_overall_mm = internal_clearance_mm + 4 * frame_feature_mm;
cube_half_mm = cube_overall_mm / 2;
post_mount_face_z = -face_outer_depth_mm;
post_mount_cube_center_z = post_mount_face_z + cube_half_mm;
post_face_z = post_mount_cube_center_z - post_mount_standoff_mm;
post_backplate_inner_z = post_face_z + post_backplate_thickness_mm;
post_mount_gusset_root_z = post_mount_face_z + post_mount_weld_mm;
post_mount_flare_run_mm = post_mount_gusset_root_z - post_backplate_inner_z;

post_socket_inner_mm = post_section_mm + post_socket_clearance_mm;
post_backplate_width_mm = post_socket_inner_mm + 2 * post_socket_wall_mm;

// Bolt placement is set by hex-key access, not by the plate. The T-nut sits in
// the post slot on the cube centerline, so each M5 head faces the cube and a
// driver on the centerline would run straight into it. Pushing both bolts clear
// of the 73 mm cube envelope is the whole reason this plate is tall.
m5_bolt_y = cube_half_mm + m5_head_clearance_mm / 2 + m5_head_cube_margin_mm;
post_backplate_half_height_mm =
    m5_bolt_y + m5_head_clearance_mm / 2 + post_backplate_edge_margin_mm;
// Y that the flare edge gives up per mm travelled back toward the backplate.
post_mount_flare_y_rate =
    (post_backplate_half_height_mm - face_outline_mm / 2)
    / post_mount_flare_run_mm;                                   // 0.747

// Z at which the flare edge has pulled inboard of the driver, so a straight key
// on the bolt axis is finally in open air. The funnel has to reach past this.
post_mount_driver_breakout_z =
    post_mount_gusset_root_z
    - (m5_bolt_y - m5_driver_clearance_mm / 2 - face_outline_mm / 2)
      / post_mount_flare_y_rate;                                 // -24.75
post_mount_funnel_top_z =
    post_mount_driver_breakout_z + post_mount_driver_margin_mm;  // -23.25
post_mount_funnel_rise_mm =
    post_mount_funnel_top_z
    - (post_backplate_inner_z + post_mount_head_pocket_mm);      // 17.25
post_mount_funnel_height_mm =
    post_mount_head_pocket_mm + post_mount_funnel_rise_mm;
post_backplate_height_mm = 2 * post_backplate_half_height_mm;

// Same idea as the M5 funnel, one axis over. The flare gives up X as it runs
// back to the backplate, so an M3 cap driver in a corner counterbore is buried
// until the flare edge has pulled inboard of the relief. Bore the relief that
// far and no further, instead of guessing a depth.
post_mount_flare_x_rate =
    (face_outline_mm / 2 - post_backplate_width_mm / 2)
    / post_mount_flare_run_mm;                                   // 0.5
post_mount_screw_breakout_z =
    post_mount_gusset_root_z
    - (face_outline_mm / 2
       - (face_screw_offset_mm - post_mount_screw_relief_mm / 2))
      / post_mount_flare_x_rate;                                 // -26.2
post_mount_screw_relief_depth_mm =
    post_mount_face_z
    - (post_mount_screw_breakout_z - post_mount_driver_margin_mm); // 13.7

// Printed uFace down: build height runs along -Z, so the gusset flares outward
// in Y as it rises and this angle has to stay inside the overhang limit.
post_mount_flare_angle_deg =
    atan((post_backplate_half_height_mm - face_outline_mm / 2)
         / post_mount_flare_run_mm);
post_mount_locator_top_z = -face_inner_depth_mm + face_plate_thickness_mm;
post_mount_socket_tip_z = post_face_z - post_socket_depth_mm;
post_mount_build_height_mm = post_mount_locator_top_z - post_mount_socket_tip_z;

// Z of the window row. The gusset bends about the Y axis, so its neutral axis
// runs along the mid-plane of the taper: only the centre window actually sits
// on it, and the outer two trade a little stiffness for a lot of mass.
post_mount_window_center_z =
    (post_mount_gusset_root_z + post_backplate_inner_z) / 2;

// Illumination-cell coordinates. X is the light axis and matches the uFace
// local Z convention: X=0 is the visible inner edge of the cube opening, +X
// runs into the cube, and -X runs outward into the cell. Z=0 is the beam axis
// and +Z is up, so the rail sits at negative Z beneath the sleeve.
sleeve_bore_mm = tube_outer_mm + sleeve_clearance_mm;
sleeve_outer_mm = sleeve_bore_mm + 2 * sleeve_wall_mm;
lens_axis_y = 0;
lens_axis_z = 0;
led_axis_y = 0;
led_axis_z = 0;

// The rail top sits below the sleeve underside by a solid roof thickness. The
// harness slot roof shares this exact datum, so the slider seats with no
// vertical play while the sleeve bore remains on the beam axis.
rail_top_z = -(sleeve_outer_mm / 2) - harness_roof_thickness_mm;
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

// The harness foot straddles the rail. Its slot roof rests directly on the
// rail top; harness_roof_thickness_mm is solid material, not empty clearance.
// The side runners rest on the bottom-U floor at the same datum as the rail
// bottom. The slot roof rests directly on the rail top.
harness_slot_width_mm = rail_width_mm + harness_slot_clearance_mm;
harness_slot_top_z = rail_top_z;
harness_foot_bottom_z = cell_floor_top_z + harness_floor_clearance_mm;
harness_outer_width_mm = harness_slot_width_mm + 2 * harness_wall_mm;

// The foot must rise just far enough to fuse into the sleeve across its whole
// width. The sleeve is round, so at the foot's outer edge the sleeve underside
// sits higher than at the centerline; solve for that height instead of guessing,
// otherwise the foot floats free at its corners or becomes a tall solid slab.
harness_foot_top_z = -sqrt(pow(sleeve_outer_mm / 2, 2)
                           - pow(harness_outer_width_mm / 2, 2)) + 0.5;
// Keep the insert and screw passage in the upper half of the rail. The extra
// top margin keeps the screw clear of the rail's printed upper edge while
// leaving enough material below the insert for a secure clamp.
rail_insert_center_z = rail_top_z - m3_clamp_clearance_mm / 2
                       - m3_clamp_top_margin_mm;

// Slider placement. Both sliders clamp anywhere along the rail; these are the
// preview positions only. The LED gap is the adjustable quantity the bench test
// has to settle, so nothing downstream depends on its exact value.
sleeve_front_x = cell_interior_near_x - sleeve_setback_mm;
sleeve_rear_x = sleeve_front_x - sleeve_depth_mm;
led_pad_x = sleeve_rear_x - led_gap_mm;
led_plate_rear_x = led_pad_x - led_post_thickness_mm;

// The lens foot spans the sleeve's full X depth, centering its mass over the
// rail contact while keeping both end faces coplanar for support-free printing.
// The LED foot remains offset toward -X so its front is flush with the pad face.
lens_harness_center_x = sleeve_rear_x + lens_harness_length_mm / 2;
led_harness_center_x = led_pad_x - led_harness_length_mm / 2;

// Stop at the forward edge of the lens harness. Because that harness spans the
// full sleeve depth, the rail now covers the full cell interior length.
rail_near_x = lens_harness_center_x + lens_harness_length_mm / 2;
rail_length_mm = rail_near_x - cell_interior_far_x;

// Fixed vent region near the far/LED end. It does not follow the preview-only
// LED gap because the real LED slider can move anywhere along the rail.
vent_region_center_x = cell_interior_far_x + vent_region_from_far_mm;
roof_vent_group_half_y =
    ((roof_vent_slot_count - 1) * roof_vent_slot_pitch_mm
        + roof_vent_slot_width_mm) / 2;
roof_vent_louver_half_x = roof_vent_slot_length_mm / 2
                          + vent_baffle_overlap_mm;
roof_vent_louver_run_mm = roof_vent_slot_width_mm
                          + vent_baffle_thickness_mm;
roof_vent_baffle_bottom_z = cell_interior_top_z
                             - roof_vent_louver_run_mm;
side_vent_group_center_z = cell_seam_z + 10;
side_vent_group_half_x =
    ((side_vent_slot_count - 1) * side_vent_slot_pitch_mm
        + side_vent_slot_width_mm) / 2;
side_vent_baffle_half_x = side_vent_group_half_x
                          + vent_baffle_overlap_mm;
side_vent_baffle_bottom_z = side_vent_group_center_z
                             - side_vent_slot_height_mm / 2
                             - vent_baffle_thickness_mm;
side_vent_baffle_inner_y = cell_interior_half_y
                            - vent_baffle_gap_mm
                            - vent_baffle_thickness_mm;
side_vent_clear_span_x_mm = 2 * side_vent_baffle_half_x
                            - 2 * vent_baffle_thickness_mm;
side_vent_slot_area_mm2 = side_vent_slot_count
                          * side_vent_slot_width_mm
                          * side_vent_slot_height_mm;
side_vent_plenum_area_mm2 = side_vent_clear_span_x_mm
                            * vent_baffle_gap_mm;

// --- Carrier derived geometry -------------------------------------------
// Carrier local frame: optical axis is the line y = 0, z = 0. Light travels
// +X. The cell's front face (toward the cube) is at x = 0 and the cell body
// runs to -X, so the stack loads from the rear like the legacy sleeve.
carrier_cell_bore_mm = sleeve_bore_mm;
carrier_cell_outer_mm = sleeve_outer_mm;
// Material the clip groove needs behind the stack, measured from the rear edge.
carrier_clip_reserve_mm = sleeve_clip_groove_setback_mm
                          + sleeve_clip_groove_width_mm;
collector_stack_mm = collector_lens_thickness_mm
                     + (collector_uses_spacer ? carrier_spacer_thickness_mm : 0);
condenser_stack_mm = condenser_lens_thickness_mm
                     + (condenser_uses_spacer ? carrier_spacer_thickness_mm : 0);
collector_cell_length_mm = carrier_lip_axial_mm + collector_stack_mm
                           + carrier_clip_reserve_mm;
condenser_cell_length_mm = carrier_lip_axial_mm + condenser_stack_mm
                           + carrier_clip_reserve_mm;

// Extrusion foot. The slot is open downward so the carrier drops onto the rail
// and the M5 bolts pull it sideways onto both T-nuts.
carrier_slot_width_mm = post_section_mm + post_socket_clearance_mm;
carrier_socket_outer_width_mm = carrier_slot_width_mm
                                + 2 * carrier_socket_wall_mm;
carrier_extrusion_top_z = -(carrier_cell_outer_mm / 2) - carrier_web_mm;
carrier_extrusion_bottom_z = carrier_extrusion_top_z - post_section_mm;
// Side T-slot centerline is the extrusion's own vertical centerline.
carrier_m5_center_z = carrier_extrusion_top_z - post_section_mm / 2;
carrier_m5_counterbore_depth_mm = carrier_socket_wall_mm
                                  - carrier_m5_bearing_wall_mm;
// Same weld idiom as harness_foot_top_z: stop the block just inside the cell
// cylinder so the union has real overlap rather than a tangent kiss.
carrier_socket_top_z = -sqrt(pow(carrier_cell_outer_mm / 2, 2)
                             - pow(carrier_socket_outer_width_mm / 2, 2)) + 0.5;

assert(carrier_aperture_mm <= carrier_spacer_inner_mm,
       "The front lip aperture is wider than the supplied divider ID, so the \
two annular lands would not clamp the same ring of glass.");
assert(carrier_aperture_mm < carrier_cell_bore_mm - 2,
       "The front lip has under 1 mm of radial land to seat the lens on.");
assert(carrier_spacer_outer_mm <= carrier_cell_bore_mm,
       "The supplied divider ring does not fit the carrier bore.");
assert(carrier_lip_axial_mm + carrier_clip_reserve_mm
           < min(collector_cell_length_mm, condenser_cell_length_mm),
       "A carrier cell is not long enough to hold its own optic stack.");
assert(carrier_foot_length_mm
           <= min(collector_cell_length_mm, condenser_cell_length_mm),
       "The carrier foot is longer than the shortest cell it welds to, so it \
would hang off the end of the part.");
assert(carrier_socket_outer_width_mm < carrier_cell_outer_mm,
       "The extrusion socket is wider than the cell it welds into, so the \
socket top would stand proud of the cylinder with nothing to weld to.");
assert(carrier_m5_counterbore_depth_mm > 0
           && carrier_m5_bearing_wall_mm >= 2,
       "The M5 washer counterbore leaves under 2 mm of bearing wall, which \
PLA will creep through under permanent preload.");
assert(carrier_m5_center_z - m5_head_clearance_mm / 2
           > carrier_extrusion_bottom_z,
       "The M5 washer pocket breaks out of the bottom of the socket wall.");
assert(carrier_m5_center_z + m5_head_clearance_mm / 2
           < carrier_extrusion_top_z,
       "The M5 washer pocket breaks up through the roof of the straddle slot.");
assert(post_socket_relief_mm < carrier_socket_wall_mm,
       "The inside-corner relief is deeper than the socket wall is thick.");

echo(str("Carrier cells: collector ", collector_cell_length_mm,
         " mm, condenser ", condenser_cell_length_mm,
         " mm; bore/OD ", carrier_cell_bore_mm, "/", carrier_cell_outer_mm,
         " mm, aperture ", carrier_aperture_mm, " mm"));
echo(str("Carrier foot kind ", carrier_rail_kind,
         " (0 = 2020 extrusion, 1 = printed rail), length ",
         carrier_foot_length_mm, " mm; extrusion top Z=",
         carrier_extrusion_top_z, ", M5 centerline Z=", carrier_m5_center_z));

assert(post_mount_flare_run_mm > 0,
       "The post standoff is too short to leave any gusset between the uFace \
and the backplate.");
assert(post_mount_flare_angle_deg <= 45,
       "The post-mount gusset flares past the 45 degree overhang limit, so it \
can no longer print without support.");
assert(post_backplate_width_mm <= face_outline_mm,
       "The post backplate is wider than the uFace, so the gusset would grow \
outward in X and overhang.");
assert(m5_bolt_y - m5_head_clearance_mm / 2 >= cube_half_mm,
       "The M5 bolts sit inside the cube envelope, where a hex key cannot \
reach the heads.");
assert(m5_bolt_y + m5_head_clearance_mm / 2 <= post_backplate_half_height_mm,
       "The M5 head seat breaks out of the end of the backplate.");
assert(post_mount_funnel_mouth_mm > m5_head_clearance_mm
           && post_mount_head_pocket_mm > 0,
       "The head funnel has to flare outward from a real head pocket.");
// Strictly wider, not merely equal. The throat is a 72-sided polygon, so an
// exactly-equal nominal diameter measures about 0.01 mm undersize across the
// flats and the driver binds on facets.
assert(m5_head_clearance_mm >= m5_driver_clearance_mm + 1,
       "The funnel throat is not comfortably wider than the driver it has to \
pass.");
assert(post_mount_funnel_rise_mm > 0,
       "The funnel breaks out of the gusset before the head pocket ends, so the \
head seat has no wall.");
// The check the first version of this part failed. The funnel must reach far
// enough out that the flare edge has receded inboard of the driver, otherwise a
// shelf of gusset caps the funnel and no key reaches the bolt.
// Holds by construction unless post_mount_driver_margin_mm goes negative, which
// is exactly the edit that would silently bring the shelf back.
assert(post_mount_funnel_top_z >= post_mount_driver_breakout_z,
       "A shelf of gusset caps the M5 funnel and blocks the hex key.");
assert(post_mount_funnel_top_z < post_mount_gusset_root_z,
       "The M5 funnel breaks through the uFace instead of out the side of the \
gusset.");
assert(post_mount_screw_relief_depth_mm > post_mount_weld_mm,
       "The M3 cap reliefs do not even clear the weld band, so the gusset caps \
all four vendor counterbores.");
assert(face_screw_offset_mm + post_mount_screw_relief_mm / 2
           <= face_outline_mm / 2,
       "The M3 cap reliefs break out of the edge of the uFace.");
assert(post_backplate_height_mm <= post_mount_bed_limit_mm
           && face_outline_mm <= post_mount_bed_limit_mm
           && post_mount_build_height_mm <= post_mount_bed_limit_mm,
       "The post mount does not fit the print bed.");
assert(post_socket_relief_mm < post_socket_wall_mm,
       "The socket corner relief eats the whole socket wall.");
assert(post_mount_window_radius_mm == 0
           || (post_mount_window_center_z - post_mount_window_radius_mm
                   > post_backplate_inner_z
               && post_mount_window_center_z + post_mount_window_radius_mm
                      < post_mount_gusset_root_z),
       "The gusset window breaks out of the gusset.");
assert(post_mount_window_radius_mm == 0
           || post_mount_window_count == 1
           || post_mount_window_pitch_mm - 2 * post_mount_window_radius_mm >= 3,
       "The gusset windows leave less than a 3 mm rib between them.");
assert(post_mount_window_radius_mm == 0
           || (post_mount_window_count - 1) / 2 * post_mount_window_pitch_mm
                  + post_mount_window_radius_mm + 3
              <= m5_bolt_y - post_mount_funnel_mouth_mm / 2,
       "The outermost gusset window leaves less than a 3 mm rib against the \
M5 head funnel.");

assert(sleeve_outer_mm <= 2 * cell_interior_half_y,
       "The lens sleeve is wider than the illumination cell interior.");
assert(sleeve_outer_mm / 2 <= cell_interior_top_z,
       "The lens sleeve hits the illumination cell roof.");
assert(rail_bottom_z - rail_floor_weld_mm > cell_outer_bottom_z,
       "The rail extends below the illumination cell floor.");
assert(harness_slot_top_z == rail_top_z,
       "The harness slot roof must seat directly on the rail top.");
assert(harness_foot_bottom_z >= cell_floor_top_z
           && harness_foot_bottom_z < harness_slot_top_z,
       "The harness side runners must rest on or above the bottom-U floor.");
assert(harness_slot_width_mm >= rail_width_mm,
       "The harness slot cannot be narrower than the rail.");
assert(cell_interior_length_mm
           >= sleeve_depth_mm + harness_wall_mm + led_post_thickness_mm + 10,
       "The illumination cell is too short for the sleeve, post, and travel.");
assert(cell_aperture_mm <= sleeve_bore_mm,
       "The mating-plate light port is wider than the sleeve bore.");
assert(cell_mount_bridge_depth_mm > 0
           && locator_size_mm <= internal_clearance_mm,
       "The cell mounting bridge must fit inside the cube opening.");
assert(harness_wall_mm >= m3_insert_length_mm + 1,
       "The harness side walls are too thin to host the M3 heat-set inserts.");

assert(sleeve_front_x <= cell_interior_near_x,
       "The lens sleeve passes through the illumination cell end wall.");
assert(led_harness_center_x - led_harness_length_mm / 2 >= cell_interior_far_x,
       "The LED post overruns the far end of the illumination cell.");
assert(lens_harness_center_x - led_harness_center_x
           >= (lens_harness_length_mm + led_harness_length_mm) / 2,
       "The sleeve and LED post feet collide on the rail at this LED gap.");
assert(abs(lens_harness_center_x - lens_harness_length_mm / 2 - sleeve_rear_x)
           < epsilon,
       "The lens sleeve and harness print faces are not flush.");
assert(abs(led_harness_center_x + led_harness_length_mm / 2 - led_pad_x)
           < epsilon,
       "The LED post and harness print faces are not flush.");
assert(sleeve_bore_mm - 2 * sleeve_lip_mm < tube_outer_mm,
       "The retaining lip does not overlap the tube it is meant to stop.");
assert(sleeve_clip_groove_setback_mm + sleeve_clip_groove_width_mm
           < sleeve_depth_mm - sleeve_lip_mm,
       "The spring-clip groove must fit between the open rear and retaining lip.");
assert(sleeve_clip_groove_radial_depth_mm > 0
           && sleeve_clip_groove_radial_depth_mm < sleeve_wall_mm,
       "The spring-clip groove must leave material in the sleeve wall.");
assert(harness_outer_width_mm <= 2 * cell_interior_half_y,
       "The harness foot is wider than the illumination cell interior.");
assert(led_star_diameter_mm <= harness_outer_width_mm,
       "The LED star is wider than its flush harness-width post.");
assert(cell_outer_span_mm >= face_outline_mm,
       "The cell must not be narrower than its standard uFace mount.");
assert(rail_insert_center_z - m3_clamp_clearance_mm / 2 >= rail_bottom_z,
       "The harness clamp passage falls below the rail.");
assert(rail_insert_center_z + m3_clamp_clearance_mm / 2 <= rail_top_z,
       "The harness clamp passage reaches the rail's upper edge.");
assert(rail_insert_center_z + m3_insert_diameter_mm / 2 <= rail_top_z,
       "The heat-set insert pocket reaches the rail's upper edge.");
assert(rail_insert_center_z - m3_insert_diameter_mm / 2 >= harness_foot_bottom_z,
       "The heat-set insert pocket breaks through the harness floor.");
assert(rail_length_mm > max(lens_harness_length_mm, led_harness_length_mm),
       "The rail is too short to support both slider harnesses.");
assert(vent_region_center_x - roof_vent_slot_length_mm / 2
           > cell_interior_far_x
       && vent_region_center_x + roof_vent_slot_length_mm / 2
           < cell_interior_near_x,
       "The roof vents overrun an illumination-cell end wall.");
assert(roof_vent_group_half_y + roof_vent_louver_run_mm / 2
           < cell_interior_half_y,
       "The roof vent louvers overrun an illumination-cell side wall.");
assert(roof_vent_baffle_bottom_z > sleeve_outer_mm / 2,
       "The roof vent baffle collides with the lens sleeve.");
assert(side_vent_baffle_bottom_z > cell_seam_z + cell_seam_clearance_mm,
       "The side vent baffle crosses the removable-lid seam.");
assert(side_vent_group_center_z + side_vent_slot_height_mm / 2
           < cell_interior_top_z,
       "The side intake slots overrun the roof.");
assert(side_vent_baffle_inner_y > sleeve_outer_mm / 2,
       "The side vent baffle collides with the lens sleeve envelope.");
assert(side_vent_plenum_area_mm2 >= side_vent_slot_area_mm2,
       "The side vent plenum chokes the combined intake-slot area.");
assert(lens_axis_y == 0 && lens_axis_z == 0
           && led_axis_y == 0 && led_axis_z == 0,
       "The lens and LED axes must remain on the cube centerline.");

echo(str("Cell interior: ", cell_interior_length_mm, " long, ",
         2 * cell_interior_half_y, " wide, ",
         cell_interior_top_z - cell_floor_top_z, " tall"));
echo(str("Sleeve bore/OD: ", sleeve_bore_mm, "/", sleeve_outer_mm,
         " mm; rail ", rail_width_mm, " x ", rail_height_mm,
         " with top at Z=", rail_top_z));
echo(str("Sleeve clip groove: ", sleeve_clip_groove_setback_mm,
         " mm from open rear, ", sleeve_clip_groove_width_mm,
         " mm wide, ", sleeve_clip_groove_radial_depth_mm,
         " mm radial recess"));
echo(str("Harness rail fit: ", harness_slot_clearance_mm,
         " mm total lateral clearance, ",
         harness_slot_top_z - rail_top_z, " mm vertical clearance, ",
         harness_slot_top_z - harness_foot_bottom_z,
         " mm slot depth with ", harness_floor_clearance_mm,
         " mm floor clearance"));
echo(str("Sleeve focus travel: ",
         cell_interior_length_mm - sleeve_depth_mm
             - led_post_thickness_mm - harness_wall_mm, " mm maximum"));
echo(str("Side intake slot/plenum area: ", side_vent_slot_area_mm2,
         "/", side_vent_plenum_area_mm2, " mm^2"));

assert(plate_slot_interference_mm >= 0
           && plate_slot_interference_mm
              <= plate_slot_filing_allowance_mm + epsilon,
       "The beamsplitter slot exceeds the allowed post-print filing amount.");
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
echo(str("Beamsplitter plate/slot/interference: ", plate_thickness_mm,
         "/", plate_slot_mm, "/", plate_slot_interference_mm, " mm"));
echo(str("Beamsplitter endpoint clearance: ",
         (internal_clearance_mm - plate_width_mm * cos(plate_angle_degrees)) / 2,
         " mm per side"));
echo(str("Post mount envelope: ", face_outline_mm, " x ",
         post_backplate_height_mm, " x ", post_mount_build_height_mm,
         " mm, standoff ", post_mount_standoff_mm, " mm to cube center"));
echo(str("Post mount gusset flare: ", post_mount_flare_angle_deg,
         " deg over a ", post_mount_flare_run_mm, " mm run"));
echo(str("Post socket: ", post_socket_inner_mm, " mm wide, ",
         post_socket_depth_mm, " mm deep, ", post_socket_wall_mm,
         " mm walls"));
echo(str("M5 holes: ", m5_hole_diameter_mm, " mm at Y +/-", m5_bolt_y,
         ", head clears the cube by ",
         m5_bolt_y - m5_head_clearance_mm / 2 - cube_half_mm,
         " mm, funnel ", m5_head_clearance_mm, " to ",
         post_mount_funnel_mouth_mm, " mm over ",
         post_mount_funnel_rise_mm, " mm"));
echo(str("M5 driver access: ", m5_driver_clearance_mm,
         " mm straight run, flare clears the bolt axis at Z=",
         post_mount_driver_breakout_z, ", funnel top at Z=",
         post_mount_funnel_top_z, ", clears the cube by ",
         m5_bolt_y - m5_driver_clearance_mm / 2 - cube_half_mm, " mm"));
echo(str("M3 corner screws: pitch ", face_screw_offset_mm,
         " mm from vendor spec, ", post_mount_screw_relief_mm,
         " mm reliefs bored ", post_mount_screw_relief_depth_mm,
         " mm, flare clears them at Z=", post_mount_screw_breakout_z));

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
               rail_bottom_z - rail_floor_weld_mm])
        cube([rail_length_mm,
              rail_width_mm,
              rail_height_mm + rail_floor_weld_mm]);
}

// The official uFace, rotated so its plate normal lies along the light axis.
// This is what bolts the cell into one pocket of the optical cube.
module cell_mating_plate() {
    // official_face_at_inside_plane() already places the standard uFace from
    // the outer cube surface at -face_outer_depth_mm toward the cube interior.
    // Rotating it about the shared X=0 opening datum therefore needs no second
    // cell_mate_x translation. That duplicate offset put the plate 14 mm into
    // the cell, where it crossed the lens harness instead of entering the cube
    // face slot.
    rotate([0, 90, 0])
        official_face_at_inside_plane();
}

// A short square locator bridges the cell wall and uFace across their shared
// X=cell_mate_x plane. Its 44.2 mm outline uses the same measured clearance as
// the other custom face locators, so it fits the 45 mm cube opening. The light
// port is cut through it later with the rest of the assembled cell solid.
module cell_mating_bridge() {
    translate([cell_mate_x - cell_mount_bridge_depth_mm / 2,
               -locator_size_mm / 2,
               -locator_size_mm / 2])
        cube([cell_mount_bridge_depth_mm,
              locator_size_mm,
              locator_size_mm]);
}

// uFace provides the outer counterbores. These continuations carry the screw
// bores through the attached near wall so every screw remains accessible from
// the cube side after the plate is fused to the cell.
module cell_mating_screw_passages() {
    for (y = [-1, 1])
        for (z = [-1, 1])
            translate([cell_mate_x - cell_wall_mm - epsilon,
                       y * face_screw_offset_mm,
                       z * face_screw_offset_mm])
                rotate([0, 90, 0])
                    cylinder(h = cell_wall_mm + face_plate_thickness_mm
                                 + 2 * epsilon,
                             d = face_mount_clearance_mm);
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
            cell_mating_bridge();
        }

        // Light port through the near end wall and the mating plate.
        translate([cell_interior_near_x - epsilon, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = cell_wall_mm + face_plate_thickness_mm
                             + 2 * epsilon,
                         d = cell_aperture_mm);

        cell_mating_screw_passages();
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

// Bottom U: mating plate, floor, far end wall, integral rail, and the lower
// part of both side walls. This is the piece the optics sit in.
module illumination_cell_bottom_u() {
    difference() {
        illumination_cell_solid();
        cell_lid_region(inset = 0);
    }
}

// Unvented top-U shell used as the base for the removable lid.
module illumination_cell_top_u_shell() {
    intersection() {
        illumination_cell_solid();
        cell_lid_region(inset = cell_seam_clearance_mm);
    }
}

// Five roof exhaust slots, parallel to the light axis and grouped over the
// fixed LED-end region. They open only through the 4 mm roof.
module roof_vent_cutouts() {
    for (index = [0 : roof_vent_slot_count - 1]) {
        slot_y = (index - (roof_vent_slot_count - 1) / 2)
                 * roof_vent_slot_pitch_mm;
        translate([vent_region_center_x - roof_vent_slot_length_mm / 2,
                   slot_y - roof_vent_slot_width_mm / 2,
                   cell_interior_top_z - epsilon])
            cube([roof_vent_slot_length_mm,
                  roof_vent_slot_width_mm,
                  cell_wall_mm + 2 * epsilon]);
    }
}

// Each roof slot gets a 45-degree internal louver. The blade overlaps the slot
// in plan view, removing its direct vertical light path, while growing outward
// from the roof without a horizontal bridge when the lid prints roof-down.
module roof_vent_baffle() {
    for (index = [0 : roof_vent_slot_count - 1]) {
        slot_y = (index - (roof_vent_slot_count - 1) / 2)
                 * roof_vent_slot_pitch_mm;
        hull() {
            translate([vent_region_center_x - roof_vent_louver_half_x,
                       slot_y - roof_vent_louver_run_mm / 2,
                       cell_interior_top_z - epsilon])
                cube([2 * roof_vent_louver_half_x,
                      vent_baffle_thickness_mm,
                      vent_baffle_thickness_mm]);
            translate([vent_region_center_x - roof_vent_louver_half_x,
                       slot_y + roof_vent_louver_run_mm / 2
                           - vent_baffle_thickness_mm,
                       roof_vent_baffle_bottom_z])
                cube([2 * roof_vent_louver_half_x,
                      vent_baffle_thickness_mm,
                      vent_baffle_thickness_mm]);
        }
    }
}

// Four vertical low intake slots in one removable side wall. Their 3 mm width
// avoids a long unsupported bridge when the lid prints roof-down. Positive Y
// is the default; mirroring keeps the handedness selectable.
module positive_y_side_vent_cutouts() {
    for (index = [0 : side_vent_slot_count - 1]) {
        slot_x = vent_region_center_x
                 + (index - (side_vent_slot_count - 1) / 2)
                   * side_vent_slot_pitch_mm;
        translate([slot_x - side_vent_slot_width_mm / 2,
                   cell_interior_half_y - epsilon,
                   side_vent_group_center_z - side_vent_slot_height_mm / 2])
            cube([side_vent_slot_width_mm,
                  cell_wall_mm + 2 * epsilon,
                  side_vent_slot_height_mm]);
    }
}

module side_vent_cutouts() {
    if (side_intake_positive_y)
        positive_y_side_vent_cutouts();
    else
        mirror([0, 1, 0])
            positive_y_side_vent_cutouts();
}

// The inner wall overlaps the side slots on every edge. Two end webs tie it
// back to the lid and leave only the lower edge open, creating a simple
// downward-then-inward labyrinth for incoming air and stray light.
module positive_y_side_vent_baffle() {
    baffle_height = cell_interior_top_z - side_vent_baffle_bottom_z + epsilon;

    translate([vent_region_center_x - side_vent_baffle_half_x,
               side_vent_baffle_inner_y,
               side_vent_baffle_bottom_z])
        cube([2 * side_vent_baffle_half_x,
              vent_baffle_thickness_mm,
              baffle_height]);

    for (end = [-1, 1])
        translate([vent_region_center_x
                       + end * (side_vent_baffle_half_x
                                - vent_baffle_thickness_mm / 2)
                       - vent_baffle_thickness_mm / 2,
                   side_vent_baffle_inner_y,
                   side_vent_baffle_bottom_z])
            cube([vent_baffle_thickness_mm,
                  vent_baffle_gap_mm + vent_baffle_thickness_mm + epsilon,
                  baffle_height]);
}

module side_vent_baffle() {
    if (side_intake_positive_y)
        positive_y_side_vent_baffle();
    else
        mirror([0, 1, 0])
            positive_y_side_vent_baffle();
}

// Top U: both upper side walls and the roof, plus passive light-baffled vents.
// There are no end-wall tabs or cross-pieces.
module illumination_cell_top_u() {
    difference() {
        union() {
            illumination_cell_top_u_shell();
            roof_vent_baffle();
            side_vent_baffle();
        }
        roof_vent_cutouts();
        side_vent_cutouts();
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

        // Rail slot. Its roof sits directly on the rail top. The material above
        // it is the solid harness roof that connects the foot to the slider.
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
                    cylinder(h = m3_insert_length_mm + epsilon,
                             d = m3_insert_diameter_mm);

            // Open the passage from the outside face through its full harness
            // wall, into the rail slot. This keeps each clamp hole reachable
            // after the holder is assembled around the rail.
            translate([center_x,
                       side * (harness_outer_width_mm / 2 + epsilon),
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
module lens_sleeve_slider() {
    difference() {
        union() {
            translate([sleeve_rear_x, 0, 0])
                rotate([0, 90, 0])
                    cylinder(h = sleeve_depth_mm, d = sleeve_outer_mm);

            harness_foot(length = lens_harness_length_mm,
                         center_x = lens_harness_center_x);
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

        // Internal circumferential spring-clip groove. The requested
        // 5-5.5 mm dimension is axial setback from the open rear edge, not
        // radial depth: a 5 mm radial cut would break through this 2 mm wall.
        translate([sleeve_rear_x + sleeve_clip_groove_setback_mm - epsilon,
                   0, 0])
            rotate([0, 90, 0])
                cylinder(h = sleeve_clip_groove_width_mm + 2 * epsilon,
                         d = sleeve_bore_mm
                             + 2 * sleeve_clip_groove_radial_depth_mm);
    }
}

// Slider 2: a flat post carrying the 20 mm star LED on the beam axis. For the
// first prototype the star is taped or glued to the pad. Capturing the star's
// edges and adding a glued-on heatsink are deliberate v2 changes to this one
// small part, since v1 strobes the LED and needs no secondary heatsink.
module led_post_slider() {
    // Match the harness width so the post has no unsupported side overhang.
    // The 20 mm star retains 1.4 mm of support per side.
    plate_half = harness_outer_width_mm / 2;
    cable_notch_bottom_z = harness_foot_top_z - epsilon;
    cable_notch_top_z = -led_star_diameter_mm / 2 - 1;

    difference() {
        union() {
            // The post starts at the top of the harness. This leaves the two
            // clamp screws visible and reachable from either side.
            translate([led_plate_rear_x, -plate_half,
                       harness_foot_top_z - epsilon])
                cube([led_post_thickness_mm,
                      2 * plate_half,
                      plate_half - harness_foot_top_z + epsilon]);

            harness_foot(length = led_harness_length_mm,
                         center_x = led_harness_center_x);
        }

        // Bottom-open cable notch, clear of the star footprint above it. This
        // preserves wire routing without leaving a weak enclosed hole.
        translate([led_plate_rear_x - epsilon,
                   -led_cable_notch_mm / 2,
                   cable_notch_bottom_z])
            cube([led_post_thickness_mm + 2 * epsilon,
                  led_cable_notch_mm,
                  cable_notch_top_z - cable_notch_bottom_z]);
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

// ---------------------------------------------------------------------------
// Post mount
// ---------------------------------------------------------------------------

// Flares the uFace footprint out to the post backplate in one hull. Printed
// uFace down, every layer of this taper is either the same size or supported
// by the layer below, so the whole gusset also acts as the printing support
// for the backplate that overhangs it.
// The reference bracket's coved gussets fill the inside corner of an L, where a
// horizontal plate meets a vertical one. This part has no such corner: the uFace
// and the backplate are parallel, 30 mm apart, and the gusset is the straight
// standoff between them. So the cove becomes the flare itself. A concave arc
// between the same two endpoints, held inside the 45 degree overhang budget, only
// scoops about 1.4 mm out of a 30 mm run, which is below print resolution for the
// stiffness it would buy. The taper carries the moment instead: section modulus
// goes as height squared, and the plate is tallest exactly where the moment peaks.
module post_mount_gusset() {
    hull() {
        translate([0, 0, post_mount_gusset_root_z])
            cube([face_outline_mm, face_outline_mm, epsilon], center = true);
        translate([0, 0, post_backplate_inner_z])
            cube([post_backplate_width_mm, post_backplate_height_mm, epsilon],
                 center = true);
    }
}

// The gusset root overlaps 0.5 mm into the uFace so the two slice as one solid.
// Inside that overlap it is a plain square slab, which quietly re-fills the
// voids the vendor plate cuts for itself: the four mid-edge notches that clear
// the cube's retaining tabs, and the four corner cap counterbores. Clip the
// weld band to vendor-face material so the overlap can only ever add where the
// plate is already solid.
// The gusset root overlaps 0.5 mm into the uFace so the two slice as one solid.
// Two things have to be true inside that overlap. It may only occupy space the
// vendor plate already fills, or it re-fills the four mid-edge notches that
// clear the cube's retaining tabs and the four corner cap counterbores. And it
// may not stand proud of the plate outline: the gusset is already flaring in Y
// by the time it reaches this band, so left alone it puts 0.37 mm out into the
// cube's 0.4 mm face gap.
//
// Written as ONE difference on ONE solid rather than two stacked pieces. The
// stacked form duplicated a face across the whole gusset cross-section at the
// plate plane, which z-fights in OpenCSG preview and drops surfaces out of the
// picture wherever you can see into the part.
module post_mount_gusset_welded() {
    big     = 4 * face_outline_mm;
    band_h  = post_mount_weld_mm + epsilon;
    footprint = face_outline_mm - 2 * post_mount_weld_inset_mm;

    difference() {
        post_mount_gusset();

        // Inside the weld band, delete everything that is not both within the
        // inset plate footprint and inside vendor plate material.
        intersection() {
            translate([0, 0, post_mount_face_z + band_h / 2])
                cube([big, big, band_h], center = true);

            difference() {
                translate([0, 0, post_mount_face_z + big / 2])
                    cube([big, big, big], center = true);
                intersection() {
                    translate([0, 0, post_mount_face_z
                                     + face_plate_thickness_mm / 2])
                        cube([footprint, footprint,
                              face_plate_thickness_mm + 2 * epsilon],
                             center = true);
                    official_face_at_inside_plane();
                }
            }
        }
    }
}

module post_mount_backplate() {
    translate([0, 0, post_face_z + post_backplate_thickness_mm / 2])
        cube([post_backplate_width_mm, post_backplate_height_mm,
              post_backplate_thickness_mm], center = true);
}

// Three-sided socket. The broad flanks set the pose against the extrusion so
// the two M5 bolts only have to supply clamp force, not alignment.
module post_mount_socket_walls(length) {
    for (side = [-1, 1])
        translate([side * (post_socket_inner_mm + post_socket_wall_mm) / 2,
                   0,
                   post_face_z - post_socket_depth_mm / 2])
            cube([post_socket_wall_mm, length, post_socket_depth_mm],
                 center = true);
}

// Extrusion corners are radiused, so relieve the inside corners of the socket
// or the post seats on its own fillets instead of on the mating face.
module post_mount_corner_reliefs(length) {
    for (side = [-1, 1])
        translate([side * post_socket_inner_mm / 2, 0, post_face_z])
            rotate([90, 0, 0])
                cylinder(h = length + 2 * epsilon, r = post_socket_relief_mm,
                         center = true, $fn = 32);
}

// The bolt head seats in a straight 3 mm pocket, then the approach opens into a
// bell so the screw can be started off-axis and a hex key can enter at an angle
// instead of having to arrive dead on the bolt line, which is where the cube is.
// The bell is wider than the gusset is at that height, so it deliberately breaks
// through the outboard edge of the flare: there is no material out there to keep,
// and opening that side lets the screw drop in sideways. Printing uFace down, the
// bell narrows as the print rises, at most 32.5 degrees off vertical where the
// flare is steepest, inside the overhang budget, and the step down to the
// through-hole is a 2.25 mm annular bridge.
module post_mount_head_funnel() {
    steps = 20;
    throat_r = m5_head_clearance_mm / 2;
    mouth_r = post_mount_funnel_mouth_mm / 2;

    rotate_extrude($fn = 72)
        polygon(concat(
            [[0, 0],
             [throat_r, 0],
             [throat_r, post_mount_head_pocket_mm]],
            [for (i = [0 : steps])
                let (t = i / steps)
                    [throat_r + (mouth_r - throat_r) * sin(90 * t),
                     post_mount_head_pocket_mm
                         + post_mount_funnel_rise_mm * t]],
            [[0, post_mount_funnel_height_mm]]));
}

// One M5 through-hole per bolt, then the flared head approach above it.
module post_mount_bolt_features() {
    for (side = [-1, 1])
        translate([0, side * m5_bolt_y, 0]) {
            translate([0, 0, post_face_z - epsilon])
                cylinder(h = post_backplate_thickness_mm + 2 * epsilon,
                         d = m5_hole_diameter_mm, $fn = 48);
            translate([0, 0, post_backplate_inner_z])
                post_mount_head_funnel();
        }
}

// Keeps the vendor cap counterbores open through the 0.5 mm of gusset that
// welds onto the plate, and gives the hex key a straight run out of the part.
module post_mount_screw_passages() {
    for (x = [-1, 1])
        for (y = [-1, 1])
            translate([x * face_screw_offset_mm,
                       y * face_screw_offset_mm,
                       post_mount_face_z - post_mount_screw_relief_depth_mm])
                cylinder(h = post_mount_screw_relief_depth_mm
                             + post_mount_weld_mm + epsilon,
                         d = post_mount_screw_relief_mm, $fn = 32);
}

// A row of round windows through the gusset. Bending stiffness comes from the
// material out at the flare edge, so the middle of the taper is where material
// can leave most cheaply. The windows are bored along X, so printed uFace down
// their axes lie in the build plane and each one bridges its own crown rather
// than needing support.
module post_mount_window() {
    if (post_mount_window_radius_mm > 0)
        for (i = [0 : post_mount_window_count - 1])
            translate([0,
                       (i - (post_mount_window_count - 1) / 2)
                           * post_mount_window_pitch_mm,
                       post_mount_window_center_z])
                rotate([0, 90, 0])
                    cylinder(h = 2 * face_outline_mm,
                             r = post_mount_window_radius_mm,
                             center = true, $fn = 64);
}

module post_mount() {
    difference() {
        union() {
            official_face_at_inside_plane();
            square_locator(solid = true);
            post_mount_gusset_welded();
            post_mount_backplate();
            post_mount_socket_walls(post_backplate_height_mm);
        }

        post_mount_corner_reliefs(post_backplate_height_mm);
        post_mount_bolt_features();
        post_mount_screw_passages();
        post_mount_window();
    }
}

// Short slice of the socket and mating plate. Print this first and check that
// the post slides in with a light hand before committing to the full bracket.
module post_mount_socket_coupon() {
    difference() {
        union() {
            translate([0, 0, post_face_z + post_backplate_thickness_mm / 2])
                cube([post_backplate_width_mm, post_coupon_length_mm,
                      post_backplate_thickness_mm], center = true);
            post_mount_socket_walls(post_coupon_length_mm);
        }

        post_mount_corner_reliefs(post_coupon_length_mm);
        translate([0, 0, post_face_z - epsilon])
            cylinder(h = post_backplate_thickness_mm + 2 * epsilon,
                     d = m5_hole_diameter_mm, $fn = 48);
    }
}

// --- Carriers ------------------------------------------------------------
// Extrusion corners are radiused, so relieve the inside corners of the
// straddle slot or the carrier seats on its own fillets instead of on the
// mating faces. Unlike post_mount's reliefs these run along X, because here
// the slot runs along the light axis rather than across it.
module carrier_corner_reliefs(length, center_x) {
    for (side = [-1, 1])
        translate([center_x,
                   side * carrier_slot_width_mm / 2,
                   carrier_extrusion_top_z])
            rotate([0, 90, 0])
                cylinder(h = length + 2 * epsilon, r = post_socket_relief_mm,
                         center = true, $fn = 32);
}

// Foot A: inverted U over a 2020 extrusion. One M5 per side into a T-nut in
// the side slot. Round holes, not slots: the T-nut already slides freely, so
// the carrier sets its own height and spends no material on travel it does
// not need. The washer counterbore is a 72-gon, matching the reasoning on
// m5_head_clearance_mm, so a nominal 10 mm washer actually passes.
module carrier_extrusion_foot(length, center_x) {
    difference() {
        translate([center_x - length / 2,
                   -carrier_socket_outer_width_mm / 2,
                   carrier_extrusion_bottom_z])
            cube([length,
                  carrier_socket_outer_width_mm,
                  carrier_socket_top_z - carrier_extrusion_bottom_z]);

        // Straddle slot, open downward.
        translate([center_x - length / 2 - epsilon,
                   -carrier_slot_width_mm / 2,
                   carrier_extrusion_bottom_z - epsilon])
            cube([length + 2 * epsilon,
                  carrier_slot_width_mm,
                  post_section_mm + epsilon]);

        carrier_corner_reliefs(length, center_x);

        for (side = [-1, 1]) {
            translate([center_x,
                       side * (carrier_socket_outer_width_mm / 2 + epsilon),
                       carrier_m5_center_z])
                rotate([side * 90, 0, 0])
                    cylinder(h = carrier_socket_wall_mm + 2 * epsilon,
                             d = m5_hole_diameter_mm, $fn = 48);

            translate([center_x,
                       side * (carrier_socket_outer_width_mm / 2 + epsilon),
                       carrier_m5_center_z])
                rotate([side * 90, 0, 0])
                    cylinder(h = carrier_m5_counterbore_depth_mm + epsilon,
                             d = m5_head_clearance_mm, $fn = 72);
        }
    }
}

// Foot B is the legacy printed-rail U-foot, reused unchanged. Its rail datums
// are derived from sleeve_outer_mm, and the carrier cell deliberately keeps
// that same 45 mm OD, so it drops onto the existing rail section with no new
// rail parameters. Only its length along X changes.
module carrier_foot(length, center_x, kind = carrier_rail_kind) {
    if (kind == 0)
        carrier_extrusion_foot(length, center_x);
    else
        harness_foot(length, center_x);
}

// Short slice of whichever foot is selected. Print this first and check the
// fit on the real rail before committing to a full carrier.
module carrier_foot_coupon(kind = carrier_rail_kind) {
    carrier_foot(carrier_coupon_length_mm, 0, kind);
}

// One cell geometry serves both 40.0 mm optics; only cell_length differs.
// Front to rear the bore holds: the seat lip, the lens, the supplied divider
// ring acting as a flat pressure washer, then the spring clip in its groove.
module carrier_optic_cell(cell_length) {
    difference() {
        translate([-cell_length, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = cell_length, d = carrier_cell_outer_mm);

        // Bore, open at the rear, stopping at the lip.
        translate([-cell_length - epsilon, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = cell_length - carrier_lip_axial_mm + epsilon,
                         d = carrier_cell_bore_mm);

        // Clear aperture through the lip itself.
        translate([-cell_length - epsilon, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = cell_length + 2 * epsilon,
                         d = carrier_aperture_mm);

        // Internal circumferential spring-clip groove, same geometry and same
        // reasoning as the legacy sleeve: the dimension is axial setback from
        // the open rear edge, not radial depth.
        translate([-cell_length + sleeve_clip_groove_setback_mm - epsilon,
                   0, 0])
            rotate([0, 90, 0])
                cylinder(h = sleeve_clip_groove_width_mm + 2 * epsilon,
                         d = carrier_cell_bore_mm
                             + 2 * sleeve_clip_groove_radial_depth_mm);
    }
}

module optic_carrier(cell_length, kind = carrier_rail_kind) {
    union() {
        carrier_optic_cell(cell_length);
        carrier_foot(carrier_foot_length_mm, -cell_length / 2, kind);
    }
}

// Carrier A optic: the f = 16 spherical collector, nearest the LED.
module collector_carrier(kind = carrier_rail_kind) {
    optic_carrier(collector_cell_length_mm, kind);
}

// Carrier B optic: the f = 40 aspheric condenser, nearest the cube.
module condenser_carrier(kind = carrier_rail_kind) {
    optic_carrier(condenser_cell_length_mm, kind);
}

// Carrier C: a flat post carrying the 20 mm star LED on the beam axis. Same
// part as led_post_slider, re-footed and rebuilt in the carrier local frame.
// The post starts at the top of the foot so both fasteners stay reachable.
module led_carrier(kind = carrier_rail_kind) {
    plate_half = (kind == 0) ? carrier_socket_outer_width_mm / 2
                             : harness_outer_width_mm / 2;
    foot_top = (kind == 0) ? carrier_socket_top_z : harness_foot_top_z;
    cable_notch_top_z = -led_star_diameter_mm / 2 - 1;

    difference() {
        union() {
            translate([-led_post_thickness_mm, -plate_half,
                       foot_top - epsilon])
                cube([led_post_thickness_mm,
                      2 * plate_half,
                      plate_half - foot_top + epsilon]);

            carrier_foot(carrier_foot_length_mm,
                         -carrier_foot_length_mm / 2, kind);
        }

        // Bottom-open cable notch, clear of the star footprint above it.
        translate([-led_post_thickness_mm - epsilon,
                   -led_cable_notch_mm / 2,
                   foot_top - epsilon])
            cube([led_post_thickness_mm + 2 * epsilon,
                  led_cable_notch_mm,
                  cable_notch_top_z - foot_top + epsilon]);
    }
}

// Mounts on the +X cube face, opposite the illumination cell. Local +Y becomes
// global +Z so the backplate stands vertically along the post.
module post_mount_transform() {
    translate([inside_half_mm, 0, 0])
        rotate([90, 0, 0])
            rotate([0, -90, 0])
                children();
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

    // Grey +X post mount, opposite the illumination cell, plus a stub of the
    // 2020 post so the standoff and the bolt access can be read at a glance.
    if (show_post_mount) {
        color([0.55, 0.57, 0.60])
            post_mount_transform()
                post_mount();

        if (show_post_stub && show_references)
            color([0.30, 0.32, 0.34, 0.45])
                translate([post_mount_standoff_mm + post_section_mm / 2, 0, 0])
                    cube([post_section_mm, post_section_mm,
                          post_stub_length_mm], center = true);
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
    else if (render_mode == 16)
        post_mount();
    else if (render_mode == 17)
        post_mount_socket_coupon();
    else if (render_mode == 18)
        condenser_carrier();
    else if (render_mode == 19)
        collector_carrier();
    else if (render_mode == 20)
        led_carrier();
    else if (render_mode == 21)
        carrier_foot_coupon();
}

// Part-specific SCAD entry files set this before including the shared source.
if (is_undef(skip_main_render))
    render_selected_part();
else if (!skip_main_render)
    render_selected_part();
