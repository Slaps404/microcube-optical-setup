# uCube optical setup

Parametric OpenSCAD parts for a 50 mm plate beamsplitter, compact 30 mm
illumination source, and M37 lens mounting face.

## Layout

- `optical_setup.scad`: editable parts and complete assembly demo.
- `vendor/uCube`: official uCube library with the fixes documented in
  `PATCHES.md`.
- `vendor/BOSL2`: pinned thread-geometry dependency.
- `research`: sourced illumination research.
- `exports`: printable STL outputs.
- `previews/current`: curated screenshots for GitHub documentation.

Additional multi-angle QA renders are generated locally under `previews/` and
ignored by Git. Printable STL files are also generated locally under
`exports/` and should be attached to a release when sharing a print version.

## Baseline geometry

The design uses the official 40 mm clear opening, 54 mm face size, 68 mm
overall cube, and standard screw positions. All mounting plates sit on the
official exterior face plane.

The bottom face holds a 50 x 50 x 2.05 mm beamsplitter at 45 degrees. Its two
rails extend through the face recess and stop flush with the visible cube
opening, so they remain hidden in a straight side view.

The default light face now uses a provisional external condenser pod for a
Thorlabs ACL5040U-A-style 50 mm asphere. It keeps the 30 mm cube-side output,
holds the lens by its edge, provides 6 mm LED focus travel, and separates the
printed optical shell from the metal heat spreader and exposed heatsink. The
older compact diffuser chamber remains available in legacy render modes.

All LED board, driver, heat-spreader, heatsink, and fan dimensions are marked
`PROVISIONAL` in `optical_setup.scad`. Replace them with measured hardware
before printing the complete pod. Nominal EFL, BFL, center thickness, and edge
thickness are separate parameters because focal length alone does not locate a
thick aspheric lens mechanically.

The camera face carries a male M37 x 0.75 thread for the lens's female M37
front/filter thread. The configured lens reference is 16 mm focal length with
a 39 mm body. This M37 connection is separate from the lens's standard C-mount
camera-side interface. Demo placement is +Y, but any uFace can be moved to a
different cube side.

## Render modes

Set `render_mode` in `optical_setup.scad`:

- `0`: complete official uCube assembly, normal F5 demo
- `1`: printable beamsplitter bottom face
- `2`: legacy compact light-source face/body
- `3`: legacy compact light-source back cover
- `4`: legacy compact optic cartridge
- `5`: printable M37 camera face
- `6`: printable M37 thread-fit coupon
- `7`: exploded assembly reference
- `8`: wireframe inspection reference
- `9`: printable 50 mm condenser uFace and front lens cell
- `10`: printable condenser spacer and provisional driver rails
- `11`: printable condenser lens retaining ring
- `12`: printable focus-adjustable LED/heatsink carriage
- `13`: assembled condenser light engine reference
- `14`: exploded condenser light engine reference

Modes 0, 7, 8, 13, and 14 contain non-printable references. Export the other
modes separately.

## Measurements to confirm

Print the thread-fit coupon before the full camera face. Confirm the lens is
female M37 x 0.75, then adjust `camera_thread_clearance_mm` if needed. Also test
the 2.1 mm beamsplitter slot, optic-cartridge fit, and official face screw
alignment before printing complete parts.

For the provisional condenser pod, first print only mode 11 and verify the
real lens diameter and edge retention. Then verify the MCPCB, heat-spreader,
heatsink, and driver dimensions before printing modes 9, 10, and 12.
