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
- `previews/camera_integrated`: current multi-angle screenshots.

## Baseline geometry

The design uses the official 40 mm clear opening, 54 mm face size, 68 mm
overall cube, and standard screw positions. All mounting plates sit on the
official exterior face plane.

The bottom face holds a 50 x 50 x 2.05 mm beamsplitter at 45 degrees. Its two
rails extend through the face recess and stop flush with the visible cube
opening, so they remain hidden in a straight side view.

The light face provides a 30 mm output, 40 mm LED-board cavity, rear cover,
corner cable notch, and flush diffuser or prism-film cartridge.

The camera face carries a male M37 x 0.75 thread for the lens's female M37
front/filter thread. The configured lens reference is 16 mm focal length with
a 39 mm body. This M37 connection is separate from the lens's standard C-mount
camera-side interface. Demo placement is +Y, but any uFace can be moved to a
different cube side.

## Render modes

Set `render_mode` in `optical_setup.scad`:

- `0`: complete official uCube assembly, normal F5 demo
- `1`: printable beamsplitter bottom face
- `2`: printable light-source face/body
- `3`: printable light-source back cover
- `4`: printable optic cartridge
- `5`: printable M37 camera face
- `6`: printable M37 thread-fit coupon
- `7`: exploded assembly reference
- `8`: wireframe inspection reference

Modes 0, 7, and 8 contain non-printable references. Export modes 1-6
separately.

## Required physical QA

Print the thread-fit coupon before the full camera face. Confirm the lens is
female M37 x 0.75, then adjust `camera_thread_clearance_mm` if needed. Also test
the 2.1 mm beamsplitter slot, optic-cartridge fit, and official face screw
alignment before printing complete parts.
