# uCube optical setup

Parametric OpenSCAD parts for a 50 mm plate beamsplitter, M37 camera interface,
and a focus-adjustable illumination cell. The design is built around the
official uCube library and the measured 45 mm clear opening cube.

## Source of truth

- `optical_setup.scad` is the editable geometry source of truth.
- `DESIGN.md` records the active architecture, measured dimensions, provisional
  dimensions, and required physical tests.
- `exports/current` contains the tracked active printable STL pack. Historical
  `adjustable_*` files remain in that folder but are explicitly excluded in its
  README.

## Layout

- `optical_setup.scad`: all printable parts and assembly previews.
- `vendor/uCube`: official uCube library, with local fixes in `PATCHES.md`.
- `vendor/BOSL2`: pinned M37 thread-geometry dependency.
- `research`: sourced illumination research.
- `exports/current`: tracked printable STLs and their OpenSCAD entry files.
- `slicer`: resolved Ender 3 V2 profiles for 0.4, 0.2, and 0.1 mm nozzles.
- `scripts`: reproducible STL export, mesh checks, and slicer smoke tests.
- `previews/current`: curated images for documentation. Other QA renders under
  `previews/` are ignored by Git.

Initialize dependencies after cloning:

```sh
git submodule update --init --recursive
```

OpenSCAD is required for previews, validation, and STL export. On macOS with
Homebrew:

```sh
brew install openscad
```

## Active design

The optical cube uses the measured uCube geometry:

| Feature | Value |
| --- | --- |
| Clear through-hole | 45 mm |
| Frame feature | 7 mm |
| Overall cube | 73 mm |
| uFace plate | 59 x 59 x 3.5 mm |
| uFace corner screw centers | +/-26 mm |
| Mid-edge cube-to-cube screw centers | +/-29.5 mm |

The bottom uFace holds a 50 x 50 x 2.05 mm plate beamsplitter at 45 degrees.
The camera uFace provides a male M37 x 0.75 thread for the lens's female
front/filter thread. This is separate from the lens's camera-side C-mount.

Illumination uses a custom, light-tight cell bolted to one side uFace, not a
second official cube. The cell is 80 mm long and prints as two U shells: a
bottom shell with the mating plate, floor, far wall, and integral rail; and a
top shell that acts as the removable lid. The lid has five 45-degree-baffled
roof exhaust slots and four low side-intake slots behind an internal shroud.
A tongue-and-groove seam blocks a straight light path.

One centered 10.5 x 9 mm rail carries two independently clamped sliders:

- A 25 mm-deep lens sleeve for a purchased 40.0 mm lens tube. Its 1 mm inner
  lip stops the tube, and a spring clip retains it.
- An LED post for the 20 mm star MCPCB, with a cable pass-through below it.

Both sliders use opposing M3 heat-set-insert clamp screws. Their positions are
set on the bench to tune focus and illumination, rather than assumed from
optical estimates. Each upper feature is offset on its harness to create one
coplanar end face for support-free print orientation without changing the
modeled optical positions.

Modes 2 through 4 are legacy compact-light parts. They remain in the source,
but are not part of the active design.

## Render modes

Set `render_mode` near the top of `optical_setup.scad`.

| Mode | Output |
| --- | --- |
| 0 | Complete optical assembly |
| 1 | Beamsplitter mounting face |
| 2-4 | Legacy compact light chamber parts |
| 5 | M37 camera mounting face |
| 6 | M37 thread-fit coupon |
| 7 | Exploded assembly reference |
| 8 | Inspection assembly reference |
| 9 | Official uCube shell |
| 10 | Illumination cell bottom U shell |
| 11 | Illumination cell top U shell, lid |
| 12 | Lens sleeve slider |
| 13 | LED post slider |
| 14 | Illumination cell assembly, lid on |
| 15 | Illumination cell assembly, lid off |

Modes 0, 7, 8, 14, and 15 are assembly or inspection views, not standalone
print parts. Export the other modes individually.

## Validate before exporting

Run a hard-warning validation before exporting an STL:

```sh
openscad --hardwarnings -o /tmp/optical_setup.csg optical_setup.scad
```

After changing geometry, render and inspect front, back, left, right, top, and
isometric previews. OpenSCAD validity confirms the model can render, not that
printed parts will fit.

Regenerate every active STL, check that each mesh is one connected watertight
surface, and run the Ender 3 V2 slicer smoke tests with:

```sh
scripts/export_printables.sh
scripts/slice_smoke_test.sh
```

GitHub Actions runs both commands and publishes the validated STL pack as a
build artifact. Slicer success catches toolpath and build-volume failures, but
does not replace physical fit coupons or first-layer calibration.

## Physical tests required

Nothing has been printed yet. Test these coupons or fit-critical features before
a full print:

- One custom uFace on the physical cube, confirming outward-facing
  counterbores and fully seated screw heads.
- A rail segment and slider foot, confirming hand-sliding motion and secure
  clamp without rocking.
- A shallow lens sleeve, confirming the 40.0 mm tube slips in with minimal
  play.
- The M37 thread coupon, before the full camera face.
- Short bottom and lid seam sections, confirming the lid seats and blocks
  daylight.
- The 2.1 mm beamsplitter slot.

Several values remain provisional, including the sleeve depth, heat-set insert
dimensions, optical clear aperture and focal data, cable routing, and the final
focus distances. See `DESIGN.md` for the full risk and test record.
