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

The default light face now connects to a second 68 mm official-uCube cell that
contains a 10 mm square rail. A printed collimator barrel slides along it,
keeping the lens axis centered on the optical cube while allowing the
lens-to-LED distance to be tuned. The rail channel is 10.3 mm square, its
surrounding walls are 5 mm thick, and opposing M3 clamp locations lock the
chosen position. Set `collimator_rail_position_mm` to move the collimator before
printing.

The supplied two-lens assembly measures 41 mm in diameter and 24.1 mm thick
along the light path. It drops into a 41.2 mm barrel bore, seats on a 1 mm
radial front ledge, and is held by the existing spring and removable retaining
ring. The LED and thermal stack use a separate rail collar. The older external
pod and compact diffuser chamber remain available in legacy render modes.

The 41 mm diameter and 24.1 mm axial thickness are measured. The selected LED is
a 3 W, 700 mA 3535 emitter on a 20 mm star MCPCB. Clear aperture, focal data,
board thickness, driver, heat-spreader, heatsink, and fan dimensions remain
`PROVISIONAL` in `optical_setup.scad` until the physical parts are measured.

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
- `9`: printable 41 mm collimator uFace and cartridge cell
- `10`: printable condenser spacer and provisional driver rails
- `11`: printable condenser lens retaining ring
- `12`: printable focus-adjustable LED/heatsink carriage
- `13`: assembled condenser light engine reference
- `14`: exploded condenser light engine reference
- `15`: printable adjustable-rail uFace and rail base
- `16`: printable 41 mm collimator barrel and rail slider
- `17`: printable LED/heatsink rail collar
- `18`: assembled adjustable rail light engine reference
- `19`: printable official uCube shell, print two

Modes 0, 7, 8, 13, 14, and 18 contain non-printable references. Export the
other modes separately.

## Current STL pack

The versioned files in `exports/current` are the individual printable parts
for the default adjustable-rail assembly. Each geometry-checked STL has a
matching part-specific SCAD entry file. See the folder README for quantities
and which dimensions still require a physical fit test.

## Measurements to confirm

Print the thread-fit coupon before the full camera face. Confirm the lens is
female M37 x 0.75, then adjust `camera_thread_clearance_mm` if needed. Also test
the 2.1 mm beamsplitter slot, optic-cartridge fit, and official face screw
alignment before printing complete parts.

For the collimator pod, first print mode 11 and a shallow section of mode 9.
Verify the cartridge slip fit with the real 41 x 24.1 mm assembly. The original
holder uses a flat spring with an approximately 37.44 mm compressed diameter.
It shares the cylindrical bore behind the lens and is compressed axially by the
modeled screw-on rear ring. Its wire measures 1.04 mm and is intentionally formed, so it
must preload a flat annular pressure washer rather than contact or center the
optics directly. Its compressed axial height still needs measurement. Then
verify the MCPCB, heat-spreader, heatsink, and driver dimensions before printing
full modes 9, 10, and 12.

For the adjustable version, test modes 15 through 17 before a final print. The
10.0/10.3 mm rail fit and 5 mm slider walls come from the supplied design
notes. The newer video frames show the rail spanning one additional 68 mm
uCube cell and the 41 mm collimator barely clearing the opened frame. Face
anchor dimensions, slider length, and M3 heat-set insert pockets remain marked
`PROVISIONAL`. Confirm those dimensions and the usable focus range on the
physical cube, then set `collimator_rail_position_mm`.
