# µCube optical setup

Parametric OpenSCAD parts for a 50 mm plate beamsplitter and a compact,
side-mounted 30 mm illumination source.

## Layout

- `optical_setup.scad`: editable model, printable parts, and assembly previews.
- `research/light-source-reference-designs.md`: sourced optical strategy and
  commercial reference designs.
- `vendor/uCube`: µCube OpenSCAD library, GPL-3.0, with two documented modern
  OpenSCAD compatibility fixes in `PATCHES.md`.
- `exports`: generated printable STL files, intentionally ignored.
- `previews/v2`: current multi-angle design screenshots.

## Baseline dimensions

Both faces use the official 40 mm internal opening, 7 mm frame depth, 54 mm
face outline, and standard four screw locations. The 39.8 mm locator enters
3.5 mm, then the
two beamsplitter supports continue the remaining 3.5 mm and stop flush with the
cube interior. They form a 2.1 mm slot for the 2.05 mm plate without appearing
through a straight side view.

The light face has a 30 mm output, a generic 40 mm LED-board pocket 18 mm behind
the output plane, a rear cover, a corner cable notch, and a flush press-fit
optical cartridge. Each cartridge accepts a 32 mm square, 0.6 mm thick diffuser or prism
film coupon. The three rear-cover screws are separate from the cable corner.

## Render modes

Set `render_mode` in `optical_setup.scad`:

- `0`: beamsplitter carrier
- `1`: light-source face/body
- `2`: light-source back cover
- `3`: swappable optic cartridge
- `4`: complete cube assembly reference
- `5`: exploded assembly reference
- `6`: open wireframe inspection reference

Modes 4-6 contain non-printable references. Export modes 0-3 separately.

## Required physical QA

Before a full print, make a small 2.1 mm slot coupon and a short cartridge-slot
coupon in the production material. Then verify the four face holes and 39.8 mm
locator against the actual µCube. The 40 mm LED board and optical-film thickness
remain generic parameters until real parts are selected and measured.
