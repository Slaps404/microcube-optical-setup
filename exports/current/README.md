# Current printable STL pack

Generated from `optical_setup.scad` at the repository commit containing these
files. Dimensions are millimeters.

| File | Quantity | Render mode | Purpose |
| --- | ---: | ---: | --- |
| `official_ucube_shell.stl` | 2 | 19 | Optical cube and auxiliary illumination cube |
| `beamsplitter_mounting_face.stl` | 1 | 1 | Bottom 50 mm beamsplitter carrier face |
| `m37_camera_mounting_face.stl` | 1 | 5 | Camera face with male M37 x 0.75 thread |
| `m37_thread_fit_coupon.stl` | 1 optional | 6 | Short thread-fit test before printing the camera face |
| `adjustable_collimator_rail_base.stl` | 1 | 15 | Shared light face and 10 mm rail |
| `adjustable_collimator_barrel_slider.stl` | 1 | 16 | 41.2 mm lens pocket and rail slider |
| `adjustable_led_heatsink_mount.stl` | 1 | 17 | Fixed LED and thermal-stack rail collar |
| `collimator_retaining_ring.stl` | 1 | 11 | Rear lens/spring retaining ring |

Print the thread coupon and fit-critical rail, lens-pocket, and beamsplitter
features as tests before committing to the complete print. M3 insert pockets,
thermal hardware, focal spacing, and several rail anchor dimensions remain
provisional in the OpenSCAD source.
