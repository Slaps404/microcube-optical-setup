# Current printable STL pack

Generated from `optical_setup.scad`. Dimensions are millimeters. Each STL has a
matching SCAD entry file in this folder. The SCAD entry files load the shared
parametric source from the repository, so keep the repository structure intact.

The active Path B illumination cell is a four-part print, listed first below.

| File | Quantity | Render mode | Purpose |
| --- | ---: | ---: | --- |
| `illumination_cell_bottom_u.stl` | 1 | 10 | Cube-facing bottom cell, fused standard uFace, full-depth screw bores, floor, rail, and far wall |
| `illumination_cell_top_u.stl` | 1 | 11 | Cell lid, left wall, right wall, and roof only |
| `lens_sleeve_slider.stl` | 1 | 12 | 41 mm lens-tube sleeve and raised-clamp rail harness |
| `led_post_slider.stl` | 1 | 13 | LED post, bottom-open cable notch, and raised-clamp rail harness |
| `official_ucube_shell.stl` | 1 | 9 | Optical cube shell |
| `beamsplitter_mounting_face.stl` | 1 | 1 | Bottom 50 mm beamsplitter carrier face |
| `m37_camera_mounting_face.stl` | 1 | 5 | Camera face with male M37 x 0.75 thread |
| `m37_thread_fit_coupon.stl` | 1 optional | 6 | Short thread-fit test before printing the camera face |
The earlier `adjustable_*` and `collimator_retaining_ring` files are retained
only as historical exports. Do not print them for the active Path B cell.

## Ender 3 V2 slicer assignments

| Parts | Nozzle | Layer | Orientation and supports |
| --- | ---: | ---: | --- |
| Cell bottom, cube shell | 0.4 mm | 0.20 mm | As exported, automatic build-plate-only supports |
| Cell lid | 0.4 mm | 0.20 mm | Rotate X 180 degrees so the roof is on the bed |
| Beamsplitter face | 0.4 mm | 0.20 mm | As exported, no supports |
| Lens slider | 0.2 mm | 0.10 mm | Rotate Y 90 degrees, 3 mm brim, build-plate-only supports |
| LED slider | 0.2 mm | 0.10 mm | As exported, 3 mm brim, no supports |
| M37 camera face | 0.2 mm | 0.10 mm | As exported, no supports |
| M37 thread coupon | 0.1 mm | 0.05 mm | As exported, 2 mm brim, no supports |

The checked-in PrusaSlicer profiles assume 205 C nozzle, 60 C bed, and three
perimeters. Confirm temperatures against the actual PLA Pro spool. CI-generated
G-code is a smoke test and must not be sent directly to the printer without a
slicer preview and physical first-layer calibration.

Print the thread coupon and fit-critical rail, lens-pocket, and beamsplitter
features as tests before committing to the complete print. M3 insert pockets,
thermal hardware, focal spacing, and several rail anchor dimensions remain
provisional in the OpenSCAD source.
