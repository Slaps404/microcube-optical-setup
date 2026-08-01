# Current printable STL pack

Generated from `optical_setup.scad` at the repository commit containing these
files. Dimensions are millimeters. Each STL has a matching SCAD entry file in
this folder. The SCAD entry files load the shared parametric source from the
repository, so keep the repository folder structure intact.

The active Path B illumination cell is a four-part print, listed first below.

| File | Quantity | Render mode | Purpose |
| --- | ---: | ---: | --- |
| `illumination_cell_bottom_u.stl` | 1 | 10 | Cube-facing bottom cell, fused standard uFace, full-depth screw bores, floor, rail, and far wall |
| `illumination_cell_top_u.stl` | 1 | 11 | Cell lid, left wall, right wall, and roof only |
| `lens_sleeve_slider.stl` | 1 | 12 | 41 mm lens-tube sleeve and raised-clamp rail harness |
| `led_post_slider.stl` | 1 | 13 | LED post, bottom-open cable notch, and raised-clamp rail harness |
| `official_ucube_shell.stl` | 2 | 19 | Optical cube and auxiliary illumination cube |
| `beamsplitter_mounting_face.stl` | 1 | 1 | Bottom 50 mm beamsplitter carrier face |
| `m37_camera_mounting_face.stl` | 1 | 5 | Camera face with male M37 x 0.75 thread |
| `m37_thread_fit_coupon.stl` | 1 optional | 6 | Short thread-fit test before printing the camera face |
| `adjustable_collimator_rail_base.stl` | 1 | 15 | Shared light face and 10 mm rail |
| `adjustable_collimator_barrel_slider.stl` | 1 | 16 | 41.2 mm lens pocket and rail slider |
| `adjustable_led_heatsink_mount.stl` | 1 | 17 | Fixed LED and thermal-stack rail collar |
| `collimator_retaining_ring.stl` | 1 | 11 | Rear lens/spring retaining ring |

The earlier `adjustable_*` and `collimator_retaining_ring` files are retained
only as historical exports. Do not print them for the active Path B cell.

Print the thread coupon and fit-critical rail, lens-pocket, and beamsplitter
features as tests before committing to the complete print. M3 insert pockets,
thermal hardware, focal spacing, and several rail anchor dimensions remain
provisional in the OpenSCAD source.
